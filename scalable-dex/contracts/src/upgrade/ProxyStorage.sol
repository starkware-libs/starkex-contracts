pragma solidity ^0.5.2;

import "../components/GovernanceStorage.sol";

/*
  Holds the Proxy-specific state variables.
  This contract is inherited by the GovernanceStorage (and indirectly by MainStorage)
  to prevent collision hazard.
*/
contract ProxyStorage is GovernanceStorage {

    // Stores the hash of the initialization vector of the added implementation.
    // Upon upgradeTo the implementation, the initialization vector is verified
    // to be identical to the one submitted when adding the implementation.
    mapping (address => bytes32) internal initializationHash;

    // The time after which we can switch to the implementation.
    mapping (address => uint256) internal enabledTime;

    // A central storage of the flags whether implementation has been initialized.
    // Note - it can be used flexibly enough to accommodate multiple levels of initialization
    // (i.e. using different key salting schemes for different initialization levels).
    mapping (bytes32 => bool) internal initialized;
}
