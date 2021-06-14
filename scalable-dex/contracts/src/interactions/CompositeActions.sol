// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.11;

import "../interfaces/MDeposits.sol";
import "../interfaces/MUsers.sol";

abstract contract CompositeActions is
    MDeposits,
    MUsers
{
    function registerAndDepositERC20(
        address ethKey,
        uint256 starkKey,
        bytes calldata signature,
        uint256 assetType,
        uint256 vaultId,
        uint256 quantizedAmount)
        external {
        registerUser(ethKey, starkKey, signature);
        depositERC20(starkKey, assetType, vaultId, quantizedAmount);
    }

    function registerAndDepositEth( // NOLINT: locked-ether.
        address ethKey,
        uint256 starkKey,
        bytes calldata signature,
        uint256 assetType,
        uint256 vaultId)
        external payable {
        registerUser(ethKey, starkKey, signature);
        depositEth(starkKey, assetType, vaultId);
    }
}
