// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.11;

/*
  Onchain vaults' lock functionality.
*/
abstract contract MVaultLocks {
    function applyDefaultLock(uint256 assetId, uint256 vaultId) internal virtual;

    function isVaultLocked(
        address ethKey,
        uint256 assetId,
        uint256 vaultId
    ) public virtual view returns (bool);
}
