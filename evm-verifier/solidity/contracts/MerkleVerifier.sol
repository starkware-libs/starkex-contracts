// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

import "./IMerkleVerifier.sol";

contract MerkleVerifier is IMerkleVerifier {
    // Commitments are masked to 160bit using the following mask to save gas costs.
    uint256 internal constant COMMITMENT_MASK = (
        0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000
    );

    // The size of a commitment. We use 32 bytes (rather than 20 bytes) per commitment as it
    // simplifies the code.
    uint256 internal constant COMMITMENT_SIZE_IN_BYTES = 0x20;

    // The size of two commitments.
    uint256 internal constant TWO_COMMITMENTS_SIZE_IN_BYTES = 0x40;

    // The size of and index in the verifyMerkle queue.
    uint256 internal constant INDEX_SIZE_IN_BYTES = 0x20;

    /*
      Verifies a Merkle tree decommitment for n leaves in a Merkle tree with N leaves.

      The inputs data sits in the queue at queuePtr.
      Each slot in the queue contains a 32 bytes leaf index and a 32 byte leaf value.
      The indices need to be in the range [N..2*N-1] and strictly incrementing.
      Decommitments are read from the channel in the ctx.

      The input data is destroyed during verification.
    */
    function verifyMerkle(
        uint256 channelPtr,
        uint256 queuePtr,
        bytes32 root,
        uint256 n
    ) internal view virtual override returns (bytes32 hash) {
        require(n <= MAX_N_MERKLE_VERIFIER_QUERIES, "TOO_MANY_MERKLE_QUERIES");

        assembly {
            // queuePtr + i * MERKLE_SLOT_SIZE_IN_BYTES gives the i'th index in the queue.
            // hashesPtr + i * MERKLE_SLOT_SIZE_IN_BYTES gives the i'th hash in the queue.
            let hashesPtr := add(queuePtr, INDEX_SIZE_IN_BYTES)
            let queueSize := mul(n, MERKLE_SLOT_SIZE_IN_BYTES)

            // The items are in slots [0, n-1].
            let rdIdx := 0
            let wrIdx := 0 // = n % n.

            // Iterate the queue until we hit the root.
            let index := mload(add(rdIdx, queuePtr))
            let proofPtr := mload(channelPtr)

            // while(index > 1).
            for {

            } gt(index, 1) {

            } {
                let siblingIndex := xor(index, 1)
                // sibblingOffset := COMMITMENT_SIZE_IN_BYTES * lsb(siblingIndex).
                let sibblingOffset := mulmod(
                    siblingIndex,
                    COMMITMENT_SIZE_IN_BYTES,
                    TWO_COMMITMENTS_SIZE_IN_BYTES
                )

                // Store the hash corresponding to index in the correct slot.
                // 0 if index is even and 0x20 if index is odd.
                // The hash of the sibling will be written to the other slot.
                mstore(xor(0x20, sibblingOffset), mload(add(rdIdx, hashesPtr)))
                rdIdx := addmod(rdIdx, MERKLE_SLOT_SIZE_IN_BYTES, queueSize)

                // Inline channel operation:
                // Assume we are going to read a new hash from the proof.
                // If this is not the case add(proofPtr, COMMITMENT_SIZE_IN_BYTES) will be reverted.
                let newHashPtr := proofPtr
                proofPtr := add(proofPtr, COMMITMENT_SIZE_IN_BYTES)

                // Push index/2 into the queue, before reading the next index.
                // The order is important, as otherwise we may try to read from an empty queue (in
                // the case where we are working on one item).
                // wrIdx will be updated after writing the relevant hash to the queue.
                mstore(add(wrIdx, queuePtr), div(index, 2))

                // Load the next index from the queue and check if it is our sibling.
                index := mload(add(rdIdx, queuePtr))
                if eq(index, siblingIndex) {
                    // Take sibling from queue rather than from proof.
                    newHashPtr := add(rdIdx, hashesPtr)
                    // Revert reading from proof.
                    proofPtr := sub(proofPtr, COMMITMENT_SIZE_IN_BYTES)
                    rdIdx := addmod(rdIdx, MERKLE_SLOT_SIZE_IN_BYTES, queueSize)

                    // Index was consumed, read the next one.
                    // Note that the queue can't be empty at this point.
                    // The index of the parent of the current node was already pushed into the
                    // queue, and the parent is never the sibling.
                    index := mload(add(rdIdx, queuePtr))
                }

                mstore(sibblingOffset, mload(newHashPtr))

                // Push the new hash to the end of the queue.
                mstore(
                    add(wrIdx, hashesPtr),
                    and(COMMITMENT_MASK, keccak256(0x00, TWO_COMMITMENTS_SIZE_IN_BYTES))
                )
                wrIdx := addmod(wrIdx, MERKLE_SLOT_SIZE_IN_BYTES, queueSize)
            }
            hash := mload(add(rdIdx, hashesPtr))

            // Update the proof pointer in the context.
            mstore(channelPtr, proofPtr)
        }
        // emit LogBool(hash == root);
        require(hash == root, "INVALID_MERKLE_PROOF");
    }
}
