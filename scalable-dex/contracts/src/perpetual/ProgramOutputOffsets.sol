// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

contract ProgramOutputOffsets {
    // The following constants are offsets of data expected in the program output.
    // The offsets here are of the fixed fields.
    uint256 internal constant PROG_OUT_GENERAL_CONFIG_HASH = 0;
    uint256 internal constant PROG_OUT_DATA_AVAILABILTY_MODE = 1;
    uint256 internal constant PROG_OUT_N_ASSET_CONFIGS = 2;
    uint256 internal constant PROG_OUT_ASSET_CONFIG_HASHES = 3;

    /*
      Additional mandatory fields of a single word:
      - Previous state size         3
      - New state size              4
      - Vault tree height           5
      - Order tree height           6
      - Expiration timestamp        7
      - No. of Modifications        8.
    */
    uint256 internal constant PROG_OUT_N_WORDS_MIN_SIZE = 9;

    uint256 internal constant PROG_OUT_N_WORDS_PER_ASSET_CONFIG = 2;
    uint256 internal constant PROG_OUT_N_WORDS_PER_MODIFICATION = 3;

    uint256 internal constant ASSET_CONFIG_OFFSET_ASSET_ID = 0;
    uint256 internal constant ASSET_CONFIG_OFFSET_CONFIG_HASH = 1;

    uint256 internal constant MODIFICATIONS_OFFSET_STARKKEY = 0;
    uint256 internal constant MODIFICATIONS_OFFSET_POS_ID = 1;
    uint256 internal constant MODIFICATIONS_OFFSET_BIASED_DIFF = 2;

    uint256 internal constant STATE_OFFSET_VAULTS_ROOT = 0;
    uint256 internal constant STATE_OFFSET_VAULTS_HEIGHT = 1;
    uint256 internal constant STATE_OFFSET_ORDERS_ROOT = 2;
    uint256 internal constant STATE_OFFSET_ORDERS_HEIGHT = 3;
    uint256 internal constant STATE_OFFSET_N_FUNDING = 4;
    uint256 internal constant STATE_OFFSET_FUNDING = 5;

    // Data availability mode.
    uint256 internal constant VALIDIUM_MODE = 0;
    uint256 internal constant ROLLUP_MODE = 1;

    // The following constants are offsets of data expected in the application data.
    uint256 internal constant APP_DATA_BATCH_ID_OFFSET = 0;
    uint256 internal constant APP_DATA_PREVIOUS_BATCH_ID_OFFSET = 1;
    uint256 internal constant APP_DATA_N_CONDITIONAL_TRANSFER = 2;
    uint256 internal constant APP_DATA_CONDITIONAL_TRANSFER_DATA_OFFSET = 3;
    uint256 internal constant APP_DATA_N_WORDS_PER_CONDITIONAL_TRANSFER = 2;
}
