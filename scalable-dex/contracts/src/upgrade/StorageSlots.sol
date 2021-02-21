// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.11;

/**
  StorageSlots holds the arbitrary storage slots used throughout the Proxy pattern.
  Storage address slots are a mechanism to define an arbitrary location, that will not be
  overlapped by the logical contracts.
*/
contract StorageSlots {
    /*
      Returns the address of the current implementation.
    */
    // NOLINTNEXTLINE external-function.
    function implementation() public view returns(address _implementation) {
        bytes32 slot = IMPLEMENTATION_SLOT;
        assembly {
            _implementation := sload(slot)
        }
    }

    // Storage slot with the address of the current implementation.
    // The address of the slot is keccak256("StarkWare2019.implemntation-slot").
    // We need to keep this variable stored outside of the commonly used space,
    // so that it's not overrun by the logical implementation (the proxied contract).
    bytes32 internal constant IMPLEMENTATION_SLOT =
    0x177667240aeeea7e35eabe3a35e18306f336219e1386f7710a6bf8783f761b24;

    // Storage slot with the address of the call-proxy current implementation.
    // The address of the slot is keccak256("'StarkWare2020.CallProxy.Implemntation.Slot'").
    // We need to keep this variable stored outside of the commonly used space.
    // so that it's not overrun by the logical implementation (the proxied contract).
    bytes32 internal constant CALL_PROXY_IMPL_SLOT =
    0x7184681641399eb4ad2fdb92114857ee6ff239f94ad635a1779978947b8843be;

    // This storage slot stores the finalization flag.
    // Once the value stored in this slot is set to non-zero
    // the proxy blocks implementation upgrades.
    // The current implementation is then referred to as Finalized.
    // Web3.solidityKeccak(['string'], ["StarkWare2019.finalization-flag-slot"]).
    bytes32 internal constant FINALIZED_STATE_SLOT =
    0x7d433c6f837e8f93009937c466c82efbb5ba621fae36886d0cac433c5d0aa7d2;

    // Storage slot to hold the upgrade delay (time-lock).
    // The intention of this slot is to allow modification using an EIC.
    // Web3.solidityKeccak(['string'], ['StarkWare.Upgradibility.Delay.Slot']).
    bytes32 public constant UPGRADE_DELAY_SLOT =
    0xc21dbb3089fcb2c4f4c6a67854ab4db2b0f233ea4b21b21f912d52d18fc5db1f;

    // Storage slot to hold the MainDispatcher init safeguard.
    // Web3.solidityKeccak(['string'], ['StarkWare.MainDispatcher.Init.Safeguard.Slot']).
    bytes32 public constant MAIN_DISPATCHER_SAFEGUARD_SLOT =
    0xf3afa5472f846c7817e22b15110d7b184f2d3d6417baee645a1e963b8fac7e24;
}
