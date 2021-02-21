// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.11;

import "../components/Escapes.sol";
import "../../components/Freezable.sol";
import "../../components/KeyGetters.sol";
import "../../components/MainGovernance.sol";
import "../../components/Operator.sol";
import "../../interactions/AcceptModifications.sol";
import "../../interactions/StarkExForcedActionState.sol";
import "../../interactions/StateRoot.sol";
import "../../interactions/TokenQuantization.sol";
import "../../interactions/UpdateState.sol";
import "../../interfaces/IFactRegistry.sol";
import "../../interfaces/SubContractor.sol";

contract StarkExState is
    MainGovernance,
    SubContractor,
    Operator,
    Freezable,
    AcceptModifications,
    TokenQuantization,
    StarkExForcedActionState,
    StateRoot,
    Escapes,
    UpdateState,
    KeyGetters
{
    uint256 constant INITIALIZER_SIZE = 7 * 32;  // 1 x address + 6 * uint256 = 224 bytes.

    /*
      Initialization flow:
      1. Extract initialization parameters from data.
      2. Call internalInitializer with those parameters.
    */
    function initialize(bytes calldata data) external virtual override {
        // This initializer sets roots etc. It must not be applied twice.
        // I.e. it can run only when the state is still empty.
        require(vaultRoot == 0, "STATE_ALREADY_INITIALIZED");
        require(vaultTreeHeight == 0, "STATE_ALREADY_INITIALIZED");
        require(orderRoot == 0, "STATE_ALREADY_INITIALIZED");
        require(orderTreeHeight == 0, "STATE_ALREADY_INITIALIZED");

        require(data.length == INITIALIZER_SIZE, "INCORRECT_INIT_DATA_SIZE_224");
        IFactRegistry escapeVerifier;
        uint256 initialSequenceNumber;
        uint256 initialVaultRoot;
        uint256 initialOrderRoot;
        uint256 initialVaultTreeHeight;
        uint256 initialOrderTreeHeight;
        uint256 onchainDataVersionValue;
        (
            escapeVerifier,
            initialSequenceNumber,
            initialVaultRoot,
            initialOrderRoot,
            initialVaultTreeHeight,
            initialOrderTreeHeight,
            onchainDataVersionValue
        ) = abi.decode(data, (IFactRegistry, uint256, uint256, uint256, uint256, uint256, uint256));

        initGovernance();
        Operator.initialize();
        StateRoot.initialize(
            initialSequenceNumber,
            initialVaultRoot,
            initialOrderRoot,
            initialVaultTreeHeight,
            initialOrderTreeHeight
        );
        Escapes.initialize(escapeVerifier);
        onchainDataVersion = onchainDataVersionValue;
    }

    /*
      The call to initializerSize is done from MainDispatcherBase using delegatecall,
      thus the existing state is already accessible.
    */
    function initializerSize() external view virtual override returns (uint256) {
        return INITIALIZER_SIZE;
    }

    function identify() external pure override returns (string memory) {
        return "StarkWare_StarkExState_2020_1";
    }
}
