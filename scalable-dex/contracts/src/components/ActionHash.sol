// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.11;

import "../components/MainStorage.sol";
import "../libraries/LibConstants.sol";

/*
  Calculation action hash for the various forced actions in a generic manner.
*/
contract ActionHash is MainStorage , LibConstants{

    function getActionHash(string memory actionName, bytes memory packedActionParameters)
        internal
        pure
        returns(bytes32 actionHash)
    {
        actionHash = keccak256(abi.encodePacked(actionName, packedActionParameters));
    }

    function setActionHash(bytes32 actionHash, bool premiumCost) internal
    {
        // The rate of forced trade requests is restricted.
        // First restriction is by capping the number of requests in a block.
        // User can override this cap by requesting with a permium flag set,
        // in this case, the gas cost is high (~1M) but no "technical" limit is set.
        // However, the high gas cost creates an obvious limitation due to the block gas limit.
        if (premiumCost) {
            for (uint256 i = 0; i < 22231; i++) {}
        } else {
            require(
                forcedRequestsInBlock[block.number] < MAX_FORCED_ACTIONS_REQS_PER_BLOCK,
                "MAX_REQUESTS_PER_BLOCK_REACHED");
            forcedRequestsInBlock[block.number] += 1;
        }
        forcedActionRequests[actionHash] = block.timestamp;
    }
}
