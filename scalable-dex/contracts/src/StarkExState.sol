pragma solidity ^0.5.2;

import "./components/Freezable.sol";
import "./components/KeyGetters.sol";
import "./components/MainGovernance.sol";
import "./components/Operator.sol";
import "./interactions/AcceptModifications.sol";
import "./interactions/Escapes.sol";
import "./interactions/StateRoot.sol";
import "./interactions/TokenQuantization.sol";
import "./interactions/UpdateState.sol";
import "./interfaces/IFactRegistry.sol";
import "./interfaces/SubContractor.sol";

contract StarkExState is
    MainGovernance,
    SubContractor,
    Operator,
    Freezable,
    AcceptModifications,
    TokenQuantization,
    StateRoot,
    Escapes,
    UpdateState,
    KeyGetters
{
    uint256 constant INITIALIZER_SIZE = 192;  // 1 x address + 5 * uint256 = 192 bytes.

    /*
      Initialization flow:
      1. Extract initialization parameters from data.
      2. Call internalInitializer with those parameters.
    */
    function initialize(bytes calldata data) external {

        // This initializer sets roots etc. It must not be applied twice.
        // I.e. it can run only when the state is still empty.
        require(vaultRoot == 0, "STATE_ALREADY_INITIALIZED");
        require(vaultTreeHeight == 0, "STATE_ALREADY_INITIALIZED");
        require(orderRoot == 0, "STATE_ALREADY_INITIALIZED");
        require(orderTreeHeight == 0, "STATE_ALREADY_INITIALIZED");

        require(data.length == INITIALIZER_SIZE, "INCORRECT_INIT_DATA_SIZE_192");
        IFactRegistry escapeVerifier;
        uint256 initialSequenceNumber;
        uint256 initialVaultRoot;
        uint256 initialOrderRoot;
        uint256 initialVaultTreeHeight;
        uint256 initialOrderTreeHeight;
        (
            escapeVerifier,
            initialSequenceNumber,
            initialVaultRoot,
            initialOrderRoot,
            initialVaultTreeHeight,
            initialOrderTreeHeight
        ) = abi.decode(data, (IFactRegistry, uint256, uint256, uint256, uint256, uint256));

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
    }

    /*
      The call to initializerSize is done from MainDispatcher using delegatecall,
      thus the existing state is already accessible.
    */
    function initializerSize() external view returns (uint256) {
        return INITIALIZER_SIZE;
    }

    function identify() external pure returns (string memory) {
        return "StarkWare_StarkExState_2020_1";
    }
}
