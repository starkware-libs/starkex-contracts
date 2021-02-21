// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.11;

import "../../interfaces/ExternalInitializer.sol";

/*
  This contract is an external initializing contract that modifies the upgradability proxy
  upgrade activation delay.
*/
contract ModifyUpgradeDelayExternalInitializer is ExternalInitializer
{
    function initialize(bytes calldata data) external override {
        require(data.length == 32, "INCORRECT_INIT_DATA_SIZE_32");
        uint256 delayInSeconds;
        (delayInSeconds) = abi.decode(data, (uint256));

        //NOLINTNEXTLINE low-level-calls reentrancy-events.
        (bool success, bytes memory returndata) = address(this).staticcall(
            abi.encodeWithSignature("UPGRADE_DELAY_SLOT()"));

        require(success, "FAILED_LOCATING_DELAY_SLOT");
        bytes32 slot = abi.decode(returndata, (bytes32));

        assembly {
            sstore(slot, delayInSeconds)
        }

        emit LogExternalInitialize(data);
    }
}
