// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.11;

import "../components/PerpetualEscapes.sol";
import "../components/UpdatePerpetualState.sol";
import "../components/Configuration.sol";
import "../interactions/ForcedTradeActionState.sol";
import "../interactions/ForcedWithdrawalActionState.sol";
import "../../components/Freezable.sol";
import "../../components/KeyGetters.sol";
import "../../components/MainGovernance.sol";
import "../../components/Operator.sol";
import "../../interactions/AcceptModifications.sol";
import "../../interactions/StateRoot.sol";
import "../../interactions/TokenQuantization.sol";
import "../../interfaces/SubContractor.sol";

contract PerpetualState is
    MainGovernance,
    SubContractor,
    Configuration,
    Operator,
    Freezable,
    AcceptModifications,
    TokenQuantization,
    ForcedTradeActionState,
    ForcedWithdrawalActionState,
    StateRoot,
    PerpetualEscapes,
    UpdatePerpetualState,
    KeyGetters
{
    // Empty state is 8 words (256 bytes) To pass as uint[] we need also head & len fields (64).
    uint256 constant INITIALIZER_SIZE = 384; // Padded address(32), uint(32), Empty state(256+64).

    /*
      Initialization flow:
      1. Extract initialization parameters from data.
      2. Call internalInitializer with those parameters.
    */
    function initialize(bytes calldata data) external override {
        // This initializer sets roots etc. It must not be applied twice.
        // I.e. it can run only when the state is still empty.
        require(sharedStateHash == bytes32(0x0), "STATE_ALREADY_INITIALIZED");
        require(configurationHash[GLOBAL_CONFIG_KEY] == bytes32(0x0), "STATE_ALREADY_INITIALIZED");

        require(data.length == INITIALIZER_SIZE, "INCORRECT_INIT_DATA_SIZE_384");

        (
            address escapeVerifierAddress_,
            uint256 initialSequenceNumber,
            uint256[] memory initialState
        ) = abi.decode(data, (address, uint256, uint256[]));

        initGovernance();
        Configuration.initialize(PERPETUAL_CONFIGURATION_DELAY);
        Operator.initialize();
        StateRoot.initialize(
            initialSequenceNumber,
            initialState[0],
            initialState[2],
            initialState[1],
            initialState[3]
        );
        sharedStateHash = keccak256(abi.encodePacked(initialState));
        PerpetualEscapes.initialize(escapeVerifierAddress_);
    }

    /*
      The call to initializerSize is done from MainDispatcherBase using delegatecall,
      thus the existing state is already accessible.
    */
    function initializerSize() external view override returns (uint256) {
        return INITIALIZER_SIZE;
    }

    function identify() external pure override returns (string memory) {
        return "StarkWare_PerpetualState_2020_1";
    }
}
