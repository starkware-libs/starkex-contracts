// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.11;

import "./StarkExStorage.sol";
import "../interfaces/MVaultLocks.sol";
import "../../interfaces/MTokenTransfers.sol";
import "../../interfaces/MTokenAssetData.sol";
import "../../interfaces/MTokenQuantization.sol";

/*
  Onchain vaults deposit and withdrawal functionalities.
*/
abstract contract VaultDepositWithdrawal is
    StarkExStorage,
    MVaultLocks,
    MTokenQuantization,
    MTokenAssetData,
    MTokenTransfers
{
    event LogDepositToVault(
        address ethKey,
        uint256 assetId,
        uint256 vaultId,
        uint256 nonQuantizedAmount,
        uint256 quantizedAmount
    );

    event LogWithdrawalFromVault(
        address ethKey,
        uint256 assetId,
        uint256 vaultId,
        uint256 nonQuantizedAmount,
        uint256 quantizedAmount
    );

    function depositToVault(
        uint256 assetId,
        uint256 vaultId,
        uint256 quantizedAmount
    ) internal {
        require(!isMintableAssetType(assetId), "MINTABLE_ASSET_TYPE");

        // A default withdrawal lock is applied when deposits are made.
        applyDefaultLock(assetId, vaultId);
        // Update the balance.
        vaultsBalances[msg.sender][assetId][vaultId] += quantizedAmount;
        require(vaultsBalances[msg.sender][assetId][vaultId] >= quantizedAmount, "VAULT_OVERFLOW");

        // Transfer the tokens to the contract.
        transferIn(assetId, quantizedAmount);

        // Log event.
        emit LogDepositToVault(
            msg.sender,
            assetId,
            vaultId,
            fromQuantized(assetId, quantizedAmount),
            quantizedAmount
        );
    }

    function getQuantizedVaultBalance(
        address ethKey,
        uint256 assetId,
        uint256 vaultId
    ) public view returns (uint256) {
        return vaultsBalances[ethKey][assetId][vaultId];
    }

    function getVaultBalance(
        address ethKey,
        uint256 assetId,
        uint256 vaultId
    ) external view returns (uint256) {
        return fromQuantized(assetId, getQuantizedVaultBalance(ethKey, assetId, vaultId));
    }

    // NOLINTNEXTLINE: locked-ether.
    function depositEthToVault(uint256 assetId, uint256 vaultId) external payable {
        require(isEther(assetId), "INVALID_ASSET_TYPE");
        uint256 quantizedAmount = toQuantized(assetId, msg.value);
        depositToVault(assetId, vaultId, quantizedAmount);
    }

    function depositERC20ToVault(
        uint256 assetId,
        uint256 vaultId,
        uint256 quantizedAmount
    ) external {
        require(isFungibleAssetType(assetId), "NON_FUNGIBLE_ASSET_TYPE");
        depositToVault(assetId, vaultId, quantizedAmount);
    }

    function withdrawFromVault(
        uint256 assetId,
        uint256 vaultId,
        uint256 quantizedAmount
    ) external {
        require(quantizedAmount > 0, "ZERO_WITHDRAWAL");
        require(!isVaultLocked(msg.sender, assetId, vaultId), "VAULT_IS_LOCKED");
        require(!isMintableAssetType(assetId), "MINTABLE_ASSET_TYPE");
        require(isFungibleAssetType(assetId), "NON_FUNGIBLE_ASSET_TYPE");

        // Make sure the vault contains sufficient funds.
        uint256 vaultBalance = vaultsBalances[msg.sender][assetId][vaultId];
        require(vaultBalance >= quantizedAmount, "INSUFFICIENT_BALANCE");

        // Update the balance.
        vaultsBalances[msg.sender][assetId][vaultId] = vaultBalance - quantizedAmount;

        // Transfer funds.
        transferOut(msg.sender, assetId, quantizedAmount);

        // Log event.
        emit LogWithdrawalFromVault(
            msg.sender,
            assetId,
            vaultId,
            fromQuantized(assetId, quantizedAmount),
            quantizedAmount
        );
    }
}
