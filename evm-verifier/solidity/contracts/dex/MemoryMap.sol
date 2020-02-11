pragma solidity ^0.5.2;

contract MemoryMap {
    /*
      We store the state of the verifer in a contiguous chunk of memory.
      The offsets of the different fields are listed below.
      E.g. The offset of the i'th hash is [mm_hashes + i].
    */
    uint256 constant internal CHANNEL_STATE_SIZE = 3;
    uint256 constant internal MAX_N_QUERIES =  48;
    uint256 constant internal FRI_QUEUE_SIZE = MAX_N_QUERIES;

    uint256 constant internal MAX_SUPPORTED_MAX_FRI_STEP = 4;

    uint256 constant internal MM_EVAL_DOMAIN_SIZE =                          0x0;
    uint256 constant internal MM_BLOW_UP_FACTOR =                            0x1;
    uint256 constant internal MM_LOG_EVAL_DOMAIN_SIZE =                      0x2;
    uint256 constant internal MM_PROOF_OF_WORK_BITS =                        0x3;
    uint256 constant internal MM_EVAL_DOMAIN_GENERATOR =                     0x4;
    uint256 constant internal MM_PUBLIC_INPUT_PTR =                          0x5;
    uint256 constant internal MM_TRACE_COMMITMENT =                          0x6;
    uint256 constant internal MM_OODS_COMMITMENT =                           0x7;
    uint256 constant internal MM_N_UNIQUE_QUERIES =                          0x8;
    uint256 constant internal MM_CHANNEL =                                   0x9; // uint256[3]
    uint256 constant internal MM_MERKLE_QUEUE =                              0xc; // uint256[96]
    uint256 constant internal MM_FRI_QUEUE =                                0x6c; // uint256[144]
    uint256 constant internal MM_FRI_QUERIES_DELIMITER =                    0xfc;
    uint256 constant internal MM_FRI_CTX =                                  0xfd; // uint256[40]
    uint256 constant internal MM_FRI_STEPS_PTR =                           0x125;
    uint256 constant internal MM_FRI_EVAL_POINTS =                         0x126; // uint256[10]
    uint256 constant internal MM_FRI_COMMITMENTS =                         0x130; // uint256[10]
    uint256 constant internal MM_FRI_LAST_LAYER_DEG_BOUND =                0x13a;
    uint256 constant internal MM_FRI_LAST_LAYER_PTR =                      0x13b;
    uint256 constant internal MM_CONSTRAINT_POLY_ARGS_START =              0x13c;
    uint256 constant internal MM_PERIODIC_COLUMN__HASH_POOL_POINTS__X =    0x13c;
    uint256 constant internal MM_PERIODIC_COLUMN__HASH_POOL_POINTS__Y =    0x13d;
    uint256 constant internal MM_PERIODIC_COLUMN__VAULTS_MERKLE_HASH_POINTS__X = 0x13e;
    uint256 constant internal MM_PERIODIC_COLUMN__VAULTS_MERKLE_HASH_POINTS__Y = 0x13f;
    uint256 constant internal MM_PERIODIC_COLUMN__BOUNDARY_BASE =          0x140;
    uint256 constant internal MM_PERIODIC_COLUMN__IS_MODIFICATION =        0x141;
    uint256 constant internal MM_PERIODIC_COLUMN__IS_SETTLEMENT =          0x142;
    uint256 constant internal MM_PERIODIC_COLUMN__BOUNDARY_KEY =           0x143;
    uint256 constant internal MM_PERIODIC_COLUMN__BOUNDARY_TOKEN =         0x144;
    uint256 constant internal MM_PERIODIC_COLUMN__BOUNDARY_AMOUNT0 =       0x145;
    uint256 constant internal MM_PERIODIC_COLUMN__BOUNDARY_AMOUNT1 =       0x146;
    uint256 constant internal MM_PERIODIC_COLUMN__BOUNDARY_VAULT_ID =      0x147;
    uint256 constant internal MM_PERIODIC_COLUMN__SETTLEMENT_MERKLE_HASH_POINTS__X = 0x148;
    uint256 constant internal MM_PERIODIC_COLUMN__SETTLEMENT_MERKLE_HASH_POINTS__Y = 0x149;
    uint256 constant internal MM_PERIODIC_COLUMN__ECDSA_POINTS__X =        0x14a;
    uint256 constant internal MM_PERIODIC_COLUMN__ECDSA_POINTS__Y =        0x14b;
    uint256 constant internal MM_TRACE_LENGTH =                            0x14c;
    uint256 constant internal MM_SHIFT_POINT_X =                           0x14d;
    uint256 constant internal MM_SHIFT_POINT_Y =                           0x14e;
    uint256 constant internal MM_VAULTS_PATH_LENGTH =                      0x14f;
    uint256 constant internal MM_N_MODIFICATIONS =                         0x150;
    uint256 constant internal MM_N_SETTLEMENTS =                           0x151;
    uint256 constant internal MM_AMOUNT_SHIFT =                            0x152;
    uint256 constant internal MM_GLOBAL_EXPIRATION_TIMESTAMP_ELM =         0x153;
    uint256 constant internal MM_SIG_CONFIG_ALPHA =                        0x154;
    uint256 constant internal MM_SIG_CONFIG_BETA =                         0x155;
    uint256 constant internal MM_VAULT_SHIFT =                             0x156;
    uint256 constant internal MM_NONCE_SHIFT =                             0x157;
    uint256 constant internal MM_EXPIRATION_TIMESTAMP_SHIFT =              0x158;
    uint256 constant internal MM_INITIAL_VAULTS_ROOT =                     0x159;
    uint256 constant internal MM_INITIAL_SETTLEMENT_ROOT =                 0x15a;
    uint256 constant internal MM_FINAL_VAULTS_ROOT =                       0x15b;
    uint256 constant internal MM_N_TRANSACTIONS =                          0x15c;
    uint256 constant internal MM_FINAL_SETTLEMENT_ROOT =                   0x15d;
    uint256 constant internal MM_TRACE_GENERATOR =                         0x15e;
    uint256 constant internal MM_OODS_POINT =                              0x15f;
    uint256 constant internal MM_COEFFICIENTS =                            0x160; // uint256[360]
    uint256 constant internal MM_OODS_VALUES =                             0x2c8; // uint256[193]
    uint256 constant internal MM_CONSTRAINT_POLY_ARGS_END =                0x389;
    uint256 constant internal MM_COMPOSITION_OODS_VALUES =                 0x389; // uint256[2]
    uint256 constant internal MM_OODS_EVAL_POINTS =                        0x38b; // uint256[48]
    uint256 constant internal MM_OODS_COEFFICIENTS =                       0x3bb; // uint256[195]
    uint256 constant internal MM_TRACE_QUERY_RESPONSES =                   0x47e; // uint256[864]
    uint256 constant internal MM_COMPOSITION_QUERY_RESPONSES =             0x7de; // uint256[96]
    uint256 constant internal MM_CONTEXT_SIZE =                            0x83e;
}
