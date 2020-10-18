pragma solidity ^0.5.2;

/*
  Interface for generic dispatcher to use,
  which the concrete dispatcher must implement.

  I contains the functions that are specific to the concrete dispatcher instance.

  The interface is implemented as contract, because interface implies all methods external.
*/
contract IDispatcher {

    function getSubContract(bytes4 selector) internal view returns (address);

    function setSubContractAddress(uint256 index, address subContract) internal;

    function getNumSubcontracts() internal pure returns (uint256);

    function validateSubContractIndex(uint256 index, address subContract) internal pure;

    /*
      Ensures initializer can be called. Reverts otherwise.
    */
    function initializationSentinel() internal view;
}
