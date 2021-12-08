// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.11;

import "../../interfaces/ExternalInitializer.sol";

/*
  This contract is an external initializing contract that modifies the upgradability proxy
  upgrade activation delay.
*/
contract ModifyUpgradeDelayExternalInitializer is ExternalInitializer {
    uint256 constant MAX_DELAY = 28 days;

    // Web3.solidityKeccak(['string'], ['StarkWare.Upgradibility.Delay.Slot']).
    bytes32 constant UPGRADE_DELAY_SLOT =
        0xc21dbb3089fcb2c4f4c6a67854ab4db2b0f233ea4b21b21f912d52d18fc5db1f;

    function initialize(bytes calldata data) external override {
        require(data.length == 32, "INCORRECT_INIT_DATA_SIZE_32");
        uint256 delayInSeconds;
        (delayInSeconds) = abi.decode(data, (uint256));
        require(delayInSeconds <= MAX_DELAY, "DELAY_TOO_LONG");

        // To support V1 Proxy - we use the expected slot.
        // For V2+ we query the Proxy to provide a slot.
        bytes32 slot = UPGRADE_DELAY_SLOT;

        //NOLINTNEXTLINE low-level-calls reentrancy-events.
        (bool success, bytes memory returndata) = address(this).staticcall(
            abi.encodeWithSignature("UPGRADE_DELAY_SLOT()")
        );

        if (success) {
            slot = abi.decode(returndata, (bytes32));
        }

        assembly {
            sstore(slot, delayInSeconds)
        }

        emit LogExternalInitialize(data);
    }
}
