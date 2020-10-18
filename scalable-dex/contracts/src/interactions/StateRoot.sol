pragma solidity ^0.5.2;

import "../interfaces/MStateRoot.sol";
import "../components/MainStorage.sol";

contract StateRoot is MainStorage, MStateRoot
{

    function initialize (
        uint256 initialSequenceNumber,
        uint256 initialVaultRoot,
        uint256 initialOrderRoot,
        uint256 initialVaultTreeHeight,
        uint256 initialOrderTreeHeight
    )
        internal
    {
        sequenceNumber = initialSequenceNumber;
        vaultRoot = initialVaultRoot;
        orderRoot = initialOrderRoot;
        vaultTreeHeight = initialVaultTreeHeight;
        orderTreeHeight = initialOrderTreeHeight;
    }

    function getVaultRoot()
        public view
        returns (uint256 root)
    {
        root = vaultRoot;
    }

    function getVaultTreeHeight()
        public view
        returns (uint256 height) {
        height = vaultTreeHeight;
    }

    function getOrderRoot()
        external view
        returns (uint256 root)
    {
        root = orderRoot;
    }

    function getOrderTreeHeight()
        external view
        returns (uint256 height) {
        height = orderTreeHeight;
    }

    function getSequenceNumber()
        external view
        returns (uint256 seq)
    {
        seq = sequenceNumber;
    }

    function getLastBatchId()
        external view
        returns (uint256 batchId)
    {
        batchId = lastBatchId;
    }
}
