pragma solidity ^0.5.2;

import "./ProxyGovernance.sol";
import "./ProxyStorage.sol";

/**
  The Proxy contract implements delegation of calls to other contracts (`implementations`), with
  proper forwarding of return values and revert reasons. This pattern allows retaining the contract
  storage while replacing implementation code.

  The following operations are supported by the proxy contract:

  - :sol:func:`addImplementation`: Defines a new implementation, the data with which it should be initialized and whether this will be the last version of implementation.
  - :sol:func:`upgradeTo`: Once an implementation is added, the governor may upgrade to that implementation only after a safety time period has passed (time lock), the current implementation is not the last version and the implementation is not frozen (see :sol:mod:`FullWithdrawals`).
  - :sol:func:`removeImplementation`: Any announced implementation may be removed. Removing an implementation is especially important once it has been used for an upgrade in order to avoid an additional unwanted revert to an older version.

  The only entity allowed to perform the above operations is the proxy governor
  (see :sol:mod:`ProxyGovernance`).

  Every implementation is required to have an `initialize` function that replaces the constructor
  of a normal contract. Furthermore, the only parameter of this function is an array of bytes
  (`data`) which may be decoded arbitrarily by the `initialize` function. It is up to the
  implementation to ensure that this function cannot be run more than once if so desired.

  When an implementation is added (:sol:func:`addImplementation`) the initialization `data` is also
  announced, allowing users of the contract to analyze the full effect of an upgrade to the new
  implementation. During an :sol:func:`upgradeTo`, the `data` is provided again and only if it is
  identical to the announced `data` is the upgrade performed by pointing the proxy to the new
  implementation and calling its `initialize` function with this `data`.

  It is the responsibility of the implementation not to overwrite any storage belonging to the
  proxy (`ProxyStorage`). In addition, upon upgrade, the new implementation is assumed to be
  backward compatible with previous implementations with respect to the storage used until that
  point.
*/
contract Proxy is ProxyStorage, ProxyGovernance {

    // Emitted when the active implementation is replaced.
    event Upgraded(address indexed implementation);

    // Emitted when an implementation is submitted as an upgrade candidate and a time lock
    // is activated.
    event ImplementationAdded(address indexed implementation, bytes initializer, bool finalize);

    // Emitted when an implementation is removed from the list of upgrade candidates.
    event ImplementationRemoved(address indexed implementation);

    // Emitted when the implementation is finalized.
    event FinalizedImplementation(address indexed implementation);


    // Storage slot with the address of the current implementation.
    // The address of the slot is keccak256("StarkWare2019.implemntation-slot").
    // We need to keep this variable stored outside of the commonly used space,
    // so that it's not overrun by the logical implementaiton (the proxied contract).
    bytes32 internal constant IMPLEMENTATION_SLOT =
    0x177667240aeeea7e35eabe3a35e18306f336219e1386f7710a6bf8783f761b24;

    // This storage slot stores the finalization flag.
    // Once the value stored in this slot is set to non-zero
    // the proxy blocks implementation upgrades.
    // The current implementation is then referred to as Finalized.
    // Web3.solidityKeccak(['string'], ["StarkWare2019.finalization-flag-slot"]).
    bytes32 internal constant FINALIZED_STATE_SLOT =
    0x7d433c6f837e8f93009937c466c82efbb5ba621fae36886d0cac433c5d0aa7d2;

    uint256 public constant UPGRADE_ACTIVATION_DELAY = 28 days;

    constructor ( )
        public
    {
        initGovernance();
    }

    /*
      Returns true if the implementation is frozen.
      If the implementation was not assigned yet, returns false.
    */
    function implementationIsFrozen() private returns (bool) {
        address _implementation = implementation();

        // We can't call low level implementation before it's assigned. (i.e. ZERO).
        if (_implementation == ZERO_ADDRESS) {
            return false;
        }
        // solium-disable-next-line security/no-low-level-calls
        (bool success, bytes memory returndata) = _implementation.delegatecall(
            abi.encodeWithSignature("isFrozen()"));
        require(success, string(returndata));
        return abi.decode(returndata, (bool));
    }

    /*
      This method blocks delegation to initialize().
      Only upgradeTo should be able to delegate call to initialize().
    */
    function initialize(bytes calldata /*data*/)
        external pure
    {
        revert("CANNOT_CALL_INITIALIZE");
    }

    modifier notFinalized()
    {
        require(isNotFinalized(), "IMPLEMENTATION_FINALIZED");
        _;
    }

    /*
      Forbids calling the function if the implementation is frozen.
      This modifier relies on the lower level (logical contract) implementation of isFrozen().
    */
    modifier notFrozen()
    {
        require(implementationIsFrozen() == false, "STATE_IS_FROZEN");
        _;
    }

    /*
      Contract's default function. Delegates execution to the implementation contract.
      It returns back to the external caller whatever the implementation delegated code returns.
    */
    function () external payable {
        address _implementation = implementation();
        require (_implementation != ZERO_ADDRESS, "MISSING_IMPLEMENTATION");

        // solium-disable-next-line security/no-inline-assembly
        assembly {
            // Copy msg.data. We take full control of memory in this inline assembly
            // block because it will not return to Solidity code. We overwrite the
            // Solidity scratch pad at memory position 0.
            calldatacopy(0, 0, calldatasize)

            // Call the implementation.
            // out and outsize are 0 for now, as we don't know the out size yet.
            let result := delegatecall(gas, _implementation, 0, calldatasize, 0, 0)

            // Copy the returned data.
            returndatacopy(0, 0, returndatasize)

            switch result
            // delegatecall returns 0 on error.
            case 0 { revert(0, returndatasize) }
            default { return(0, returndatasize) }
        }
    }

    /*
      Returns the address of the current implementation.
    */
    function implementation() public view returns (address _implementation) {
        bytes32 slot = IMPLEMENTATION_SLOT;
        // solium-disable-next-line security/no-inline-assembly
        assembly {
            _implementation := sload(slot)
        }
    }

    /*
      Sets the implementation address of the proxy.
    */
    function setImplementation(address newImplementation) private {
        bytes32 slot = IMPLEMENTATION_SLOT;
        // solium-disable-next-line security/no-inline-assembly
        assembly {
            sstore(slot, newImplementation)
        }
    }

    /*
      Returns true if the contract is not in the finalized state.
    */
    function isNotFinalized() public view returns (bool notFinal) {
        bytes32 slot = FINALIZED_STATE_SLOT;
        uint256 slotValue;
        // solium-disable-next-line security/no-inline-assembly
        assembly {
            slotValue := sload(slot)
        }
        notFinal = (slotValue == 0);
    }

    /*
      Marks the current implementation as finalized.
    */
    function setFinalizedFlag() private {
        bytes32 slot = FINALIZED_STATE_SLOT;
        // solium-disable-next-line security/no-inline-assembly
        assembly {
            sstore(slot, 0x1)
        }
    }

    /*
      Introduce an implementation and its initialization vector,
      and start the time-lock before it can be upgraded to.
      addImplementation is not blocked when frozen or finalized.
      (upgradeTo API is blocked when finalized or frozen).
    */
    function addImplementation(address newImplementation, bytes calldata data, bool finalize)
        external onlyGovernance {
        require(isContract(newImplementation), "ADDRESS_NOT_CONTRACT");

        bytes32 init_hash = keccak256(abi.encode(data, finalize));
        initializationHash[newImplementation] = init_hash;

        // solium-disable-next-line security/no-block-members
        uint256 activation_time = now + UPGRADE_ACTIVATION_DELAY;

        // First implementation should not have time-lock.
        if (implementation() == ZERO_ADDRESS) {
            // solium-disable-next-line security/no-block-members
            activation_time = now;
        }

        enabledTime[newImplementation] = activation_time;
        emit ImplementationAdded(newImplementation, data, finalize);
    }

    /*
      Removes a candidate implementation.
      Note that it is possible to remove the current implementation. Doing so doesn't affect the
      current implementation, but rather revokes it as a future candidate.
    */
    function removeImplementation(address newImplementation)
        external onlyGovernance {

        // If we have initializer, we set the hash of it.
        uint256 activation_time = enabledTime[newImplementation];

        require(activation_time > 0, "ADDRESS_NOT_UPGRADE_CANDIDATE");

        enabledTime[newImplementation] = 0;

        initializationHash[newImplementation] = 0;
        emit ImplementationRemoved(newImplementation);
    }

    /*
      Upgrades the proxy to a new implementation, with its initialization.
      to upgrade successfully, implementation must have been added time-lock agreeably
      before, and the init vector must be identical ot the one submitted before.

      Upon assignment of new implementation address,
      its initialize will be called with the inititalizing vector (even if empty).
      Therefore, the implementatin MUST must have such a method.
    */
    function upgradeTo(address newImplementation, bytes calldata data, bool finalize)
        external payable onlyGovernance notFinalized notFrozen {
        uint256 activation_time = enabledTime[newImplementation];

        require(activation_time > 0, "ADDRESS_NOT_UPGRADE_CANDIDATE");
        // solium-disable-next-line security/no-block-members
        require(activation_time <= now, "UPGRADE_NOT_ENABLED_YET");

        bytes32 init_vector_hash = initializationHash[newImplementation];
        require(init_vector_hash == keccak256(abi.encode(data, finalize)), "CHANGED_INITIALIZER");
        setImplementation(newImplementation);

        // solium-disable-next-line security/no-low-level-calls
        (bool success, bytes memory returndata) = newImplementation.delegatecall(
            abi.encodeWithSelector(this.initialize.selector, data));
        require(success, string(returndata));

        // Verify that the new implementation is not frozen post initialization.
        (success, returndata) = newImplementation.delegatecall(
            abi.encodeWithSignature("isFrozen()"));
        require(success, "CALL_TO_ISFROZEN_REVERTED");
        require(abi.decode(returndata, (bool)) == false, "NEW_IMPLEMENTATION_FROZEN");

        if (finalize == true) {
            setFinalizedFlag();
            emit FinalizedImplementation(newImplementation);
        }

        emit Upgraded(newImplementation);
    }

    function isContract(address account) internal view returns (bool) {
        uint256 size;
        // solium-disable-next-line security/no-inline-assembly
        assembly {
            size := extcodesize(account)
        }
        return size > 0;
    }
}
