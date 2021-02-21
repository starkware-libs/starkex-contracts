// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.11;

abstract contract MStateRoot {
    function getVaultRoot() // NOLINT: external-function.
        public view
        virtual
        returns (uint256 root);

    function getVaultTreeHeight() // NOLINT: external-function.
        public view
        virtual
        returns (uint256 height);
}
