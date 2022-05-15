// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

abstract contract MStateRoot {
    function getValidiumVaultRoot() public view virtual returns (uint256);

    function getValidiumTreeHeight() public view virtual returns (uint256);

    function getRollupVaultRoot() public view virtual returns (uint256);

    function getRollupTreeHeight() public view virtual returns (uint256);
}
