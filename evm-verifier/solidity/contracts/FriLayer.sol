// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

import "./MerkleVerifier.sol";
import "./FriTransform.sol";

/*
  The main component of FRI is the FRI step which takes
  the i-th layer evaluations on a coset c*<g> and produces a single evaluation in layer i+1.

  To this end we have a friCtx that holds the following data:
  evaluations:    holds the evaluations on the coset we are currently working on.
  group:          holds the group <g> in bit reversed order.
  halfInvGroup:   holds the group <g^-1>/<-1> in bit reversed order.
                  (We only need half of the inverse group)

  Note that due to the bit reversed order, a prefix of size 2^k of either group
  or halfInvGroup has the same structure (but for a smaller group).
*/
contract FriLayer is MerkleVerifier, FriTransform {
    event LogGas(string name, uint256 val);

    uint256 internal constant FRI_MAX_STEP_SIZE = 4;
    uint256 internal constant MAX_COSET_SIZE = 2**FRI_MAX_STEP_SIZE;
    // Generator of the group of size MAX_COSET_SIZE: GENERATOR_VAL**((K_MODULUS - 1)/MAX_COSET_SIZE).
    uint256 internal constant FRI_GROUP_GEN =
        0x5ec467b88826aba4537602d514425f3b0bdf467bbf302458337c45f6021e539;

    uint256 internal constant FRI_GROUP_SIZE = 0x20 * MAX_COSET_SIZE;
    uint256 internal constant FRI_CTX_TO_COSET_EVALUATIONS_OFFSET = 0;
    uint256 internal constant FRI_CTX_TO_FRI_GROUP_OFFSET = FRI_GROUP_SIZE;
    uint256 internal constant FRI_CTX_TO_FRI_HALF_INV_GROUP_OFFSET =
        FRI_CTX_TO_FRI_GROUP_OFFSET + FRI_GROUP_SIZE;

    uint256 internal constant FRI_CTX_SIZE =
        FRI_CTX_TO_FRI_HALF_INV_GROUP_OFFSET + (FRI_GROUP_SIZE / 2);

    /*
      Gathers the "cosetSize" elements that belong the coset of the first element in the FRI queue.
      The elements are written to the evaluation section in the fri context i.e.
      friCtx[FRI_CTX_TO_COSET_EVALUATIONS_OFFSET:].

      The coset elements are read either from the FriQueue or from the verifier channel
      depending on whether the required element are in queue or not.

      Returns
        friQueueHead - friQueueHead_ + 0x60  * (# elements that were taken from the queue).
        cosetIdx - the start index of the coset that was gathered.
        cosetOffset - the xInv field element that corresponds to cosetIdx.
    */
    function gatherCosetInputs(
        uint256 channelPtr,
        uint256 friCtx,
        uint256 friQueueHead_,
        uint256 cosetSize
    )
        internal
        pure
        returns (
            uint256 friQueueHead,
            uint256 cosetIdx,
            uint256 cosetOffset
        )
    {
        uint256 evaluationsOnCosetPtr = friCtx + FRI_CTX_TO_COSET_EVALUATIONS_OFFSET;
        uint256 friGroupPtr = friCtx + FRI_CTX_TO_FRI_GROUP_OFFSET;

        friQueueHead = friQueueHead_;
        assembly {
            let queueItemIdx := mload(friQueueHead)
            // The coset index is represented by the most significant bits of the queue item index.
            cosetIdx := and(queueItemIdx, not(sub(cosetSize, 1)))
            let nextCosetIdx := add(cosetIdx, cosetSize)

            // Get the algebraic coset offset:
            // I.e. given c*g^(-k) compute c, where
            //      g is the generator of the coset group.
            //      k is bitReverse(offsetWithinCoset, log2(cosetSize)).
            //
            // To do this we multiply the algebraic coset offset at the top of the queue (c*g^(-k))
            // by the group element that corresponds to the index inside the coset (g^k).
            cosetOffset := mulmod(
                // (c*g^(-k))=
                mload(add(friQueueHead, 0x40)),
                // (g^k)=
                mload(
                    add(
                        friGroupPtr,
                        mul(
                            // offsetWithinCoset=
                            sub(queueItemIdx, cosetIdx),
                            0x20
                        )
                    )
                ),
                K_MODULUS
            )

            let proofPtr := mload(channelPtr)

            for {
                let index := cosetIdx
            } lt(index, nextCosetIdx) {
                index := add(index, 1)
            } {
                // Inline channel operation:
                // Assume we are going to read the next element from the proof.
                // If this is not the case add(proofPtr, 0x20) will be reverted.
                let fieldElementPtr := proofPtr
                proofPtr := add(proofPtr, 0x20)

                // Load the next index from the queue and check if it is our sibling.
                if eq(index, queueItemIdx) {
                    // Take element from the queue rather than from the proof
                    // and convert it back to Montgomery form for Merkle verification.
                    fieldElementPtr := add(friQueueHead, 0x20)

                    // Revert the read from proof.
                    proofPtr := sub(proofPtr, 0x20)

                    // Reading the next index here is safe due to the
                    // delimiter after the queries.
                    friQueueHead := add(friQueueHead, 0x60)
                    queueItemIdx := mload(friQueueHead)
                }

                // Note that we apply the modulo operation to convert the field elements we read
                // from the proof to canonical representation (in the range [0, K_MODULUS - 1]).
                mstore(evaluationsOnCosetPtr, mod(mload(fieldElementPtr), K_MODULUS))
                evaluationsOnCosetPtr := add(evaluationsOnCosetPtr, 0x20)
            }

            mstore(channelPtr, proofPtr)
        }
    }

    /*
      Returns the bit reversal of num assuming it has the given number of bits.
      For example, if we have numberOfBits = 6 and num = (0b)1101 == (0b)001101,
      the function will return (0b)101100.
    */
    function bitReverse(uint256 num, uint256 numberOfBits)
        internal
        pure
        returns (uint256 numReversed)
    {
        assert((numberOfBits == 256) || (num < 2**numberOfBits));
        uint256 n = num;
        uint256 r = 0;
        for (uint256 k = 0; k < numberOfBits; k++) {
            r = (r * 2) | (n % 2);
            n = n / 2;
        }
        return r;
    }

    /*
      Initializes the FRI group and half inv group in the FRI context.
    */
    function initFriGroups(uint256 friCtx) internal view {
        uint256 friGroupPtr = friCtx + FRI_CTX_TO_FRI_GROUP_OFFSET;
        uint256 friHalfInvGroupPtr = friCtx + FRI_CTX_TO_FRI_HALF_INV_GROUP_OFFSET;

        // FRI_GROUP_GEN is the coset generator.
        // Raising it to the (MAX_COSET_SIZE - 1) power gives us the inverse.
        uint256 genFriGroup = FRI_GROUP_GEN;

        uint256 genFriGroupInv = fpow(genFriGroup, (MAX_COSET_SIZE - 1));

        uint256 lastVal = ONE_VAL;
        uint256 lastValInv = ONE_VAL;
        assembly {
            // ctx[mmHalfFriInvGroup + 0] = ONE_VAL;
            mstore(friHalfInvGroupPtr, lastValInv)
            // ctx[mmFriGroup + 0] = ONE_VAL;
            mstore(friGroupPtr, lastVal)
            // ctx[mmFriGroup + 1] = fsub(0, ONE_VAL);
            mstore(add(friGroupPtr, 0x20), sub(K_MODULUS, lastVal))
        }

        // To compute [1, -1 (== g^n/2), g^n/4, -g^n/4, ...]
        // we compute half the elements and derive the rest using negation.
        uint256 halfCosetSize = MAX_COSET_SIZE / 2;
        for (uint256 i = 1; i < halfCosetSize; i++) {
            lastVal = fmul(lastVal, genFriGroup);
            lastValInv = fmul(lastValInv, genFriGroupInv);
            uint256 idx = bitReverse(i, FRI_MAX_STEP_SIZE - 1);

            assembly {
                // ctx[mmHalfFriInvGroup + idx] = lastValInv;
                mstore(add(friHalfInvGroupPtr, mul(idx, 0x20)), lastValInv)
                // ctx[mmFriGroup + 2*idx] = lastVal;
                mstore(add(friGroupPtr, mul(idx, 0x40)), lastVal)
                // ctx[mmFriGroup + 2*idx + 1] = fsub(0, lastVal);
                mstore(add(friGroupPtr, add(mul(idx, 0x40), 0x20)), sub(K_MODULUS, lastVal))
            }
        }
    }

    /*
      Operates on the coset of size friFoldedCosetSize that start at index.

      It produces 3 outputs:
        1. The field elements that result from doing FRI reductions on the coset.
        2. The pointInv elements for the location that corresponds to the first output.
        3. The root of a Merkle tree for the input layer.

      The input is read either from the queue or from the proof depending on data availability.
      Since the function reads from the queue it returns an updated head pointer.
    */
    function doFriSteps(
        uint256 friCtx,
        uint256 friQueueTail,
        uint256 cosetOffset_,
        uint256 friEvalPoint,
        uint256 friCosetSize,
        uint256 index,
        uint256 merkleQueuePtr
    ) internal pure {
        uint256 friValue;

        uint256 evaluationsOnCosetPtr = friCtx + FRI_CTX_TO_COSET_EVALUATIONS_OFFSET;
        uint256 friHalfInvGroupPtr = friCtx + FRI_CTX_TO_FRI_HALF_INV_GROUP_OFFSET;

        // Compare to expected FRI step sizes in order of likelihood, step size 3 being most common.
        if (friCosetSize == 8) {
            (friValue, cosetOffset_) = do3FriSteps(
                friHalfInvGroupPtr,
                evaluationsOnCosetPtr,
                cosetOffset_,
                friEvalPoint
            );
        } else if (friCosetSize == 4) {
            (friValue, cosetOffset_) = do2FriSteps(
                friHalfInvGroupPtr,
                evaluationsOnCosetPtr,
                cosetOffset_,
                friEvalPoint
            );
        } else if (friCosetSize == 16) {
            (friValue, cosetOffset_) = do4FriSteps(
                friHalfInvGroupPtr,
                evaluationsOnCosetPtr,
                cosetOffset_,
                friEvalPoint
            );
        } else {
            require(false, "Only step sizes of 2, 3 or 4 are supported.");
        }

        assembly {
            let indexInNextStep := div(index, friCosetSize)
            mstore(merkleQueuePtr, indexInNextStep)
            mstore(
                add(merkleQueuePtr, 0x20),
                and(COMMITMENT_MASK, keccak256(evaluationsOnCosetPtr, mul(0x20, friCosetSize)))
            )

            mstore(friQueueTail, indexInNextStep)
            mstore(add(friQueueTail, 0x20), friValue)
            mstore(add(friQueueTail, 0x40), cosetOffset_)
        }
    }

    /*
      Computes the FRI step with eta = log2(friCosetSize) for all the live queries.

      friQueuePtr points to an array of triplets:
          (query index, FRI value, FRI inversed point)

      The inputs for the current layer are read from the FRI queue and the inputs
      for the next layer are written to the same queue (overwriting the input).

      The function returns the number of live queries remaining after computing the FRI step.

      The number of live queries decreases whenever multiple query points in the same
      coset are reduced to a single query in the next FRI layer.

      As the function computes the next layer it also collects that data from
      the previous layer for Merkle verification.
    */
    function computeNextLayer(
        uint256 channelPtr,
        uint256 friQueuePtr,
        uint256 merkleQueuePtr,
        uint256 nQueries,
        uint256 friEvalPoint,
        uint256 friCosetSize,
        uint256 friCtx
    ) internal pure returns (uint256 nLiveQueries) {
        uint256 merkleQueueTail = merkleQueuePtr;

        // The inputs are read from the Fri queue and the result is written same queue.
        // The inputs are never overwritten since gatherCosetInputs reads at least one element and
        // doFriSteps writes exactly one element.
        uint256 inputPtr = friQueuePtr;
        uint256 ouputPtr = friQueuePtr;

        uint256 InputEnd = inputPtr + (0x60 * nQueries);

        do {
            uint256 cosetOffset;
            uint256 index;
            (inputPtr, index, cosetOffset) = gatherCosetInputs(
                channelPtr,
                friCtx,
                inputPtr,
                friCosetSize
            );

            doFriSteps(
                friCtx,
                ouputPtr,
                cosetOffset,
                friEvalPoint,
                friCosetSize,
                index,
                merkleQueueTail
            );
            merkleQueueTail += MERKLE_SLOT_SIZE_IN_BYTES;
            ouputPtr += 0x60;
        } while (inputPtr < InputEnd);

        // Return the current number of live queries.
        return (ouputPtr - friQueuePtr) / 0x60;
    }
}
