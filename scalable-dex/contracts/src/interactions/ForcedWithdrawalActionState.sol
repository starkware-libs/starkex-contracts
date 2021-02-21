// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.11;

import "../components/ActionHash.sol";
import "../components/MainStorage.sol";
import "../interfaces/MForcedWithdrawalActionState.sol";

/*
  ForcedWithdrawal specific action hashses.
*/
contract ForcedWithdrawalActionState is
    MainStorage,
    ActionHash,
    MForcedWithdrawalActionState
{
    function forcedWithdrawActionHash(
        uint256 starkKey,
        uint256 vaultId,
        uint256 quantizedAmount)
        internal
        pure
        override
        returns (bytes32)
    {
        return getActionHash("FORCED_WITHDRAWAL", abi.encode(starkKey, vaultId, quantizedAmount));
    }

    function clearForcedWithdrawalRequest(
        uint256 starkKey,
        uint256 vaultId,
        uint256 quantizedAmount)
        internal
        override {
        bytes32 actionHash = forcedWithdrawActionHash(starkKey, vaultId, quantizedAmount);
        require(forcedActionRequests[actionHash] != 0, "NON_EXISTING_ACTION");
        delete forcedActionRequests[actionHash];
    }

    function getForcedWithdrawalRequest(
        uint256 starkKey,
        uint256 vaultId,
        uint256 quantizedAmount)
        public
        view
        override
        returns (uint256)
    {
        // Return request value. Expect zero if the request doesn't exist or has been serviced, and
        // a non-zero value otherwise.
        return forcedActionRequests[forcedWithdrawActionHash(starkKey, vaultId, quantizedAmount)];
    }

    function setForcedWithdrawalRequest(
        uint256 starkKey,
        uint256 vaultId,
        uint256 quantizedAmount,
        bool premiumCost)
        internal
        override {
        setActionHash(forcedWithdrawActionHash(starkKey, vaultId, quantizedAmount), premiumCost);
    }
}
