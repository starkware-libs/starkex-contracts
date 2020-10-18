pragma solidity ^0.5.2;

contract PublicInputOffsets {
    // The following constants are offsets of data expected in the public input.
    uint256 internal constant PUB_IN_INITIAL_VAULT_ROOT_OFFSET = 0;
    uint256 internal constant PUB_IN_FINAL_VAULT_ROOT_OFFSET = 1;
    uint256 internal constant PUB_IN_INITIAL_ORDER_ROOT_OFFSET = 2;
    uint256 internal constant PUB_IN_FINAL_ORDER_ROOT_OFFSET = 3;
    uint256 internal constant PUB_IN_GLOBAL_EXPIRATION_TIMESTAMP_OFFSET = 4;
    uint256 internal constant PUB_IN_VAULT_TREE_HEIGHT_OFFSET = 5;
    uint256 internal constant PUB_IN_ORDER_TREE_HEIGHT_OFFSET = 6;
    uint256 internal constant PUB_IN_N_MODIFICATIONS_OFFSET = 7;
    uint256 internal constant PUB_IN_N_CONDITIONAL_TRANSFERS_OFFSET = 8;
    uint256 internal constant PUB_IN_TRANSACTIONS_DATA_OFFSET = 9;

    uint256 internal constant PUB_IN_N_WORDS_PER_MODIFICATION = 3;
    uint256 internal constant PUB_IN_N_WORDS_PER_CONDITIONAL_TRANSFER = 1;

    // The following constants are offsets of data expected in the application data.
    uint256 internal constant APP_DATA_BATCH_ID_OFFSET = 0;
    uint256 internal constant APP_DATA_PREVIOUS_BATCH_ID_OFFSET = 1;
    uint256 internal constant APP_DATA_TRANSACTIONS_DATA_OFFSET = 2;

    uint256 internal constant APP_DATA_N_WORDS_PER_CONDITIONAL_TRANSFER = 2;
}
