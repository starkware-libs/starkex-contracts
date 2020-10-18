pragma solidity ^0.5.2;

contract MTokenQuantization {
    function fromQuantized(uint256 presumedAssetType, uint256 quantizedAmount)
        internal
        view
        returns (uint256 amount);

    // NOLINTNEXTLINE: external-function.
    function getQuantum(uint256 presumedAssetType)
        public
        view
        returns (uint256 quantum);

    function toQuantized(uint256 presumedAssetType, uint256 amount)
        internal
        view
        returns (uint256 quantizedAmount);
}
