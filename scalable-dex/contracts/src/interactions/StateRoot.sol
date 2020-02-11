pragma solidity ^0.5.2;

import "../libraries/LibErrors.sol";
import "../interfaces/IFactRegistry.sol";
import "../interfaces/MFreezable.sol";
import "../interactions/FullWithdrawals.sol";
import "../interfaces/MStateRoot.sol";
import "../components/MainStorage.sol";

/*
  Implements IVerifierActions.rootUpdate
  Uses MFreezable.
*/
contract StateRoot is MainStorage, LibErrors, MFreezable, MStateRoot
{
    event LogRootUpdate(
        uint256 sequenceNumber,
        uint256 vaultRoot,
        uint256 orderRoot
    );

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

    /*
      Update state roots. Verify that the old roots and heights match.
    */
    function rootUpdate(
        uint256 oldVaultRoot,
        uint256 newVaultRoot,
        uint256 oldOrderRoot,
        uint256 newOrderRoot,
        uint256 vaultTreeHeightSent,
        uint256 orderTreeHeightSent
    )
        internal
        notFrozen()
    {
        // Assert that the old state is correct.
        require(oldVaultRoot == vaultRoot, VAULT_ROOT_INCORRECT);
        require(oldOrderRoot == orderRoot, ORDER_ROOT_INCORRECT);

        // Assert that heights are correct.
        require(vaultTreeHeight == vaultTreeHeightSent, VAULT_HEIGHT_INCORRECT);
        require(orderTreeHeight == orderTreeHeightSent, ORDER_HEIGHT_INCORRECT);

        // Update state.
        vaultRoot = newVaultRoot;
        orderRoot = newOrderRoot;
        sequenceNumber = sequenceNumber + 1;

        // Log update.
        emit LogRootUpdate(sequenceNumber, vaultRoot, orderRoot);
    }
}
