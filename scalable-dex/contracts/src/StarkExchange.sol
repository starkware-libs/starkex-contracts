pragma solidity ^0.5.2;

import "./components/ApprovalChain.sol";
import "./components/AvailabilityVerifiers.sol";
import "./components/Freezable.sol";
import "./components/MainGovernance.sol";
import "./components/Operator.sol";
import "./components/Tokens.sol";
import "./components/Users.sol";
import "./components/Verifiers.sol";
import "./interactions/Deposits.sol";
import "./interactions/Escapes.sol";
import "./interactions/FullWithdrawals.sol";
import "./interactions/StateRoot.sol";
import "./interactions/UpdateState.sol";
import "./interactions/Withdrawals.sol";
import "./interfaces/IFactRegistry.sol";
import "./libraries/LibErrors.sol";

contract StarkExchange is
    LibErrors,
    IVerifierActions,
    MainGovernance,
    ApprovalChain,
    AvailabilityVerifiers,
    Operator,
    Freezable,
    Tokens,
    Users,
    StateRoot,
    Deposits,
    Verifiers,
    Withdrawals,
    FullWithdrawals,
    Escapes,
    UpdateState
{
    string constant public VERSION = "0.0.1-alpha";
    string constant INIT_TAG = "INIT_TAG_Starkware.StarkExchange.2019";

    /*
      Determines the key to the intialized mapping.
    */
    function initKey() internal pure returns(bytes32 key){
        key = keccak256(abi.encode(INIT_TAG, VERSION));
    }


    // Mixins are instantiated in the order they are inherited.
    constructor (
        IFactRegistry escapeVerifier,
        uint256 initialSequenceNumber,
        uint256 initialVaultRoot,
        uint256 initialOrderRoot,
        uint256 initialVaultTreeHeight,
        uint256 initialOrderTreeHeight
    )
        public
    {
        // The method internalInitialize is the de-facto initializer.
        // It's called directly from the constructor, to allow compatibility with no-upgradability
        // mode, and called from the initialize() method (after call protection and args decode)
        // to allow upgradability mode.
        internalInitialize(
            escapeVerifier,
            initialSequenceNumber,
            initialVaultRoot,
            initialOrderRoot,
            initialVaultTreeHeight,
            initialOrderTreeHeight
        );
    }

    function internalInitialize(
        IFactRegistry escapeVerifier,
        uint256 initialSequenceNumber,
        uint256 initialVaultRoot,
        uint256 initialOrderRoot,
        uint256 initialVaultTreeHeight,
        uint256 initialOrderTreeHeight
    )
    internal
    {
        initGovernance();
        Operator.initialize();
        StateRoot.initialize(initialSequenceNumber, initialVaultRoot,
            initialOrderRoot, initialVaultTreeHeight, initialOrderTreeHeight);
        Escapes.initialize(escapeVerifier);
    }

    /*
      Called from the proxy, upon upgradeTo.
      If already initialized (determinted by the initKey) - will skip altogether.
      If not init yet && init data is not empty:
      1. extract data to init parameters.
      2. call internalInitializer with those params.
    */
    function initialize(bytes calldata data)
        external
    {
        bytes32 key = initKey();

        // Skip initialize if already been initialized.
        if (initialized[key] == false){
            // If data is empty - skip internalInitializer.
            if (data.length > 0){
                // Ensure data length is exactly the correct size.
                // 192 = sizeof(address) + 5 * sizeof(uint256).
                require(data.length == 192, INCORRECT_INIT_DATA_SIZE);
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
                ) = abi.decode(data,
                    (IFactRegistry, uint256, uint256, uint256, uint256, uint256));

                internalInitialize(
                    escapeVerifier,
                    initialSequenceNumber,
                    initialVaultRoot,
                    initialOrderRoot,
                    initialVaultTreeHeight,
                    initialOrderTreeHeight
                );
            }
            initialized[key] = true;
        }
    }
}
