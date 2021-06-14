// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.11;

abstract contract MStarkExForcedActionState {
    function fullWithdrawActionHash(uint256 starkKey, uint256 vaultId)
        internal
        pure
        virtual
        returns(bytes32);

    function clearFullWithdrawalRequest(uint256 starkKey, uint256 vaultId)
        internal
        virtual;

    // NOLINTNEXTLINE: external-function.
    function getFullWithdrawalRequest(uint256 starkKey, uint256 vaultId)
        public
        view
        virtual
        returns (uint256 res);

    function setFullWithdrawalRequest(uint256 starkKey, uint256 vaultId)
        internal
        virtual;
}
