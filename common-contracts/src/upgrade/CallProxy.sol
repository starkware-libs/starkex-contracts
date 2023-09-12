// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

import "../interfaces/ContractInitializer.sol";
import "../interfaces/IFactRegistry.sol";
import "../interfaces/ProxySupport.sol";
import "./StorageSlots.sol";
import "../libraries/Common.sol";

/**
  CallProxy is a 'call' based proxy.
  It is a facade to a real implementation,
  only that unlike the Proxy pattern, it uses call and not delegatecall,
  so that the state is recorded on the called contract.

  This contract is expected to be placed behind the regular proxy,
  thus:
  1. Implementation address is stored in a hashed slot (other than proxy's one...).
  2. No state variable is allowed in low address ranges.

  This implementation is intentionally minimal,
  and has no management or governance.
  The assumption is that if a different implementation is needed, it will be performed
  in an upgradeTo a new deployed CallProxy, pointing to a new implementation.
*/
contract CallProxy is StorageSlots, ContractInitializer, ProxySupport {
    using Addresses for address;

    string public constant CALL_PROXY_VERSION = "3.2.0";

    /*
      A single address is expected - the implementation that is call-proxied to.
    */
    function numOfSubContracts() internal pure override returns (uint256) {
        return 1;
    }

    /*
      There is no initialization needed to be done after the processSubContractAddresses state
      thus we return true, to indicate to the ProxySupport that there is no need to get into the
      contract state initalization part.
    */
    function isInitialized() internal view override returns (bool) {
        return true;
    }

    /*
      Gets the implementation address from the ProxySupport initialize(),
      and sets the implementation slot accordingly.
    */
    function processSubContractAddresses(bytes calldata subContractAddresses) internal override {
        address impl = abi.decode(subContractAddresses, (address));
        require(impl.isContract(), "ADDRESS_NOT_CONTRACT");
        setCallProxyImplementation(impl);
    }

    /*
      In CallProxy a normal init flow has no data,
      as the callProxyImplementation was already set by processSubContractAddresses().
    */
    function validateInitData(bytes calldata data) internal pure override {
        require(data.length == 0, "UNEXPECTED_INIT_DATA");
    }

    /*
      Required by ContractInitializer, Called by ProxySupport.
      No processing is needed.
    */
    function initializeContractState(bytes calldata) internal override {}

    /*
      Required by ProxySupport as it inherits Governance.
      Not expected to be called.
    */
    function getGovernanceInfo() internal view override returns (GovernanceInfoStruct storage) {
        revert("NOT_IMPLEMENTED");
    }

    /*
      Returns the call proxy implementation address.
    */
    function callProxyImplementation() public view returns (address _implementation) {
        bytes32 slot = CALL_PROXY_IMPL_SLOT;
        assembly {
            _implementation := sload(slot)
        }
    }

    /*
      Sets the call proxy implementation address.
    */
    function setCallProxyImplementation(address newImplementation) private {
        bytes32 slot = CALL_PROXY_IMPL_SLOT;
        assembly {
            sstore(slot, newImplementation)
        }
    }

    /*
      An explicit isValid entry point, used to make isValid a part of the ABI and visible
      on Etherscan (and alike).
    */
    function isValid(bytes32 fact) external view returns (bool) {
        return IFactRegistry(callProxyImplementation()).isValid(fact);
    }

    /*
      This entry point serves only transactions with empty calldata. (i.e. pure value transfer tx).
      We don't expect to receive such, thus block them.
    */
    receive() external payable {
        revert("CONTRACT_NOT_EXPECTED_TO_RECEIVE");
    }

    /*
      Contract's default function. Pass execution to the implementation contract (using call).
      It returns back to the external caller whatever the implementation called code returns.
    */
    fallback() external payable {
        // NOLINT locked-ether.
        address _implementation = callProxyImplementation();
        require(_implementation != address(0x0), "MISSING_IMPLEMENTATION");
        uint256 value = msg.value;
        assembly {
            // Copy msg.data. We take full control of memory in this inline assembly
            // block because it will not return to Solidity code. We overwrite the
            // Solidity scratch pad at memory position 0.
            calldatacopy(0, 0, calldatasize())

            // Call the implementation.
            // out and outsize are 0 for now, as we don't know the out size yet.
            let result := call(gas(), _implementation, value, 0, calldatasize(), 0, 0)

            // Copy the returned data.
            returndatacopy(0, 0, returndatasize())

            switch result
            // delegatecall returns 0 on error.
            case 0 {
                revert(0, returndatasize())
            }
            default {
                return(0, returndatasize())
            }
        }
    }
}
