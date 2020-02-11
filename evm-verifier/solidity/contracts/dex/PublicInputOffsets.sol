pragma solidity ^0.5.2;

contract PublicInputOffsets {
    // The following constants are offsets of data expected in the public input.
    uint256 internal constant OFFSET_LOG_BATCH_SIZE = 0;
    uint256 internal constant OFFSET_N_TRANSACTIONS = 1;
    uint256 internal constant OFFSET_GLOBAL_EXPIRATION_TIMESTAMP = 2;
    uint256 internal constant OFFSET_VAULT_INITIAL_ROOT = 3;
    uint256 internal constant OFFSET_VAULT_FINAL_ROOT = 4;
    uint256 internal constant OFFSET_ORDER_INITIAL_ROOT = 5;
    uint256 internal constant OFFSET_ORDER_FINAL_ROOT = 6;
    uint256 internal constant OFFSET_VAULT_TREE_HEIGHT = 7;
    uint256 internal constant OFFSET_ORDER_TREE_HEIGHT = 8;
    uint256 internal constant OFFSET_MODIFICATION_DATA = 9;
    uint256 internal constant APPLICATION_DATA_N_MODIFICATIONS_OFFSET = 0;
    uint256 internal constant APPLICATION_DATA_MODIFICATIONS_OFFSET = 1;

    uint256 internal constant N_WORDS_PER_MODIFICATION = 3;
}
