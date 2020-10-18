pragma solidity ^0.5.2;

contract MStateRoot {
    function getVaultRoot() // NOLINT: external-function.
        public view
        returns (uint256 root);

    function getVaultTreeHeight() // NOLINT: external-function.
        public view
        returns (uint256 height);
}
