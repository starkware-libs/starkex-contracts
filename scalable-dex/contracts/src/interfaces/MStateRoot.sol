pragma solidity ^0.5.2;

contract MStateRoot {
    function getVaultRoot()
        public view
        returns (uint256 root);

    function getVaultTreeHeight()
        public view
        returns (uint256 height);
}
