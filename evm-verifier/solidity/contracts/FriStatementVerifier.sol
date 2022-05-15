// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

import "./MemoryMap.sol";
import "./MemoryAccessUtils.sol";
import "../../FriStatementContract.sol";
import "../../HornerEvaluator.sol";
import "../../VerifierChannel.sol";

/*
  This contract verifies all the FRI layer, one by one, using the FriStatementContract.
  The first layer is computed from decommitments, the last layer is computed by evaluating the
  fully committed polynomial, and the mid-layers are provided in the proof only as hashed data.
*/
abstract contract FriStatementVerifier is
    MemoryMap,
    MemoryAccessUtils,
    VerifierChannel,
    HornerEvaluator
{
    FriStatementContract friStatementContract;

    constructor(address friStatementContractAddress) internal {
        friStatementContract = FriStatementContract(friStatementContractAddress);
    }

    /*
      Fast-forwards the queries and invPoints of the friQueue from before the first layer to after
      the last layer, computes the last FRI layer using horner evaluations, then returns the hash
      of the final FriQueue.
    */
    function computeLastLayerHash(
        uint256[] memory ctx,
        uint256 nPoints,
        uint256 sumOfStepSizes
    ) internal view returns (bytes32 lastLayerHash) {
        uint256 friLastLayerDegBound = ctx[MM_FRI_LAST_LAYER_DEG_BOUND];
        uint256 groupOrderMinusOne = friLastLayerDegBound * ctx[MM_BLOW_UP_FACTOR] - 1;
        uint256 exponent = 1 << sumOfStepSizes;
        uint256 curPointIndex = 0;
        uint256 prevQuery = 0;
        uint256 coefsStart = ctx[MM_FRI_LAST_LAYER_PTR];

        for (uint256 i = 0; i < nPoints; i++) {
            uint256 query = ctx[MM_FRI_QUEUE + 3 * i] >> sumOfStepSizes;
            if (query == prevQuery) {
                continue;
            }
            ctx[MM_FRI_QUEUE + 3 * curPointIndex] = query;
            prevQuery = query;

            uint256 point = fpow(ctx[MM_FRI_QUEUE + 3 * i + 2], exponent);
            ctx[MM_FRI_QUEUE + 3 * curPointIndex + 2] = point;
            // Invert point using inverse(point) == fpow(point, ord(point) - 1).

            point = fpow(point, groupOrderMinusOne);
            ctx[MM_FRI_QUEUE + 3 * curPointIndex + 1] = hornerEval(
                coefsStart,
                point,
                friLastLayerDegBound
            );

            curPointIndex++;
        }

        uint256 friQueue = getPtr(ctx, MM_FRI_QUEUE);
        assembly {
            lastLayerHash := keccak256(friQueue, mul(curPointIndex, 0x60))
        }
    }

    /*
      Verifies that FRI layers consistent with the computed first and last FRI layers
      have been registered in the FriStatementContract.
    */
    function friVerifyLayers(uint256[] memory ctx) internal view virtual {
        uint256 channelPtr = getChannelPtr(ctx);
        uint256 nQueries = ctx[MM_N_UNIQUE_QUERIES];

        // Rather than converting all the values from Montgomery to standard form,
        // we can just pretend that the values are in standard form but all
        // the committed polynomials are multiplied by MontgomeryR.
        //
        // The values in the proof are already multiplied by MontgomeryR,
        // but the inputs from the OODS oracle need to be fixed.
        for (uint256 i = 0; i < nQueries; i++) {
            ctx[MM_FRI_QUEUE + 3 * i + 1] = fmul(ctx[MM_FRI_QUEUE + 3 * i + 1], K_MONTGOMERY_R);
        }

        uint256 friQueue = getPtr(ctx, MM_FRI_QUEUE);
        uint256 inputLayerHash;
        assembly {
            inputLayerHash := keccak256(friQueue, mul(nQueries, 0x60))
        }

        uint256[] memory friStepSizes = getFriStepSizes(ctx);
        uint256 nFriInnerLayers = friStepSizes.length - 1;
        uint256 friStep = 1;
        uint256 sumOfStepSizes = friStepSizes[1];
        uint256[5] memory dataToHash;
        while (friStep < nFriInnerLayers) {
            uint256 outputLayerHash = uint256(readBytes(channelPtr, true));
            dataToHash[0] = ctx[MM_FRI_EVAL_POINTS + friStep];
            dataToHash[1] = friStepSizes[friStep];
            dataToHash[2] = inputLayerHash;
            dataToHash[3] = outputLayerHash;
            dataToHash[4] = ctx[MM_FRI_COMMITMENTS + friStep - 1];

            // Verify statement is registered.
            require( // NOLINT: calls-loop.
                friStatementContract.isValid(keccak256(abi.encodePacked(dataToHash))),
                "INVALIDATED_FRI_STATEMENT"
            );

            inputLayerHash = outputLayerHash;

            friStep++;
            sumOfStepSizes += friStepSizes[friStep];
        }

        dataToHash[0] = ctx[MM_FRI_EVAL_POINTS + friStep];
        dataToHash[1] = friStepSizes[friStep];
        dataToHash[2] = inputLayerHash;
        dataToHash[3] = uint256(computeLastLayerHash(ctx, nQueries, sumOfStepSizes));
        dataToHash[4] = ctx[MM_FRI_COMMITMENTS + friStep - 1];

        require(
            friStatementContract.isValid(keccak256(abi.encodePacked(dataToHash))),
            "INVALIDATED_FRI_STATEMENT"
        );
    }
}
