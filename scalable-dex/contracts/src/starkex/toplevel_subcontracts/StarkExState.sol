// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.11;

import "../components/Escapes.sol";
import "../interactions/StarkExForcedActionState.sol";
import "../interactions/UpdateState.sol";
import "../../components/Freezable.sol";
import "../../components/MainGovernance.sol";
import "../../components/Operator.sol";
import "../../interactions/AcceptModifications.sol";
import "../../interactions/StateRoot.sol";
import "../../interactions/TokenQuantization.sol";
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
    UpdateState
{
    uint256 constant INITIALIZER_SIZE = 9 * 32; // 2 * address + 6 * uint256 + 1 * bool = 288 bytes.

    struct InitializationArgStruct {
        address escapeVerifierAddress;
        uint256 sequenceNumber;
        uint256 vaultRoot;
        uint256 orderRoot;
        uint256 vaultTreeHeight;
        uint256 orderTreeHeight;
        uint256 onchainDataVersionValue;
        bool strictVaultBalancePolicy;
        address orderRegistryAddress;
    }

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

        require(data.length == INITIALIZER_SIZE, "INCORRECT_INIT_DATA_SIZE_256");

        // Copies initializer values into initValues.
        InitializationArgStruct memory initValues;
        bytes memory _data = data;
        assembly {initValues := add(32, _data)}

        initGovernance();
        Operator.initialize();
        StateRoot.initialize(
            initValues.sequenceNumber,
            initValues.vaultRoot,
            initValues.orderRoot,
            initValues.vaultTreeHeight,
            initValues.orderTreeHeight
        );
        Escapes.initialize(initValues.escapeVerifierAddress);
        onchainDataVersion = initValues.onchainDataVersionValue;
        strictVaultBalancePolicy = initValues.strictVaultBalancePolicy;
        orderRegistryAddress = initValues.orderRegistryAddress;
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
