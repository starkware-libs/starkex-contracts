// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.11;

import "../components/StarkExStorage.sol";
import "../interfaces/MStarkExForcedActionState.sol";
import "../../components/ActionHash.sol";

/*
  StarkExchange specific action hashses.
*/
contract StarkExForcedActionState is
    StarkExStorage,
    ActionHash,
    MStarkExForcedActionState
{

    function fullWithdrawActionHash(uint256 starkKey, uint256 vaultId)
        internal
        pure
        override
        returns(bytes32)
    {
        return getActionHash("FULL_WITHDRAWAL", abi.encode(starkKey, vaultId));
    }

    /*
      Implemented in the FullWithdrawal contracts.
    */
    function clearFullWithdrawalRequest(
        uint256 starkKey,
        uint256 vaultId
    )
        internal
        virtual
        override
    {
        // Reset escape request.
        delete forcedActionRequests[fullWithdrawActionHash(starkKey, vaultId)];
    }

    function getFullWithdrawalRequest(uint256 starkKey, uint256 vaultId)
        public
        view
        override
        returns (uint256 res)
    {
        // Return request value. Expect zero if the request doesn't exist or has been serviced, and
        // a non-zero value otherwise.
        res = forcedActionRequests[fullWithdrawActionHash(starkKey, vaultId)];
    }

    function setFullWithdrawalRequest(uint256 starkKey, uint256 vaultId)
        internal
        override
    {
        // FullWithdrawal is always at premium cost, hence the `true`.
        setActionHash(fullWithdrawActionHash(starkKey, vaultId), true);
    }
}
