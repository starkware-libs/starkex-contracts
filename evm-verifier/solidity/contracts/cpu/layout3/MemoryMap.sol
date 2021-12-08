// ---------- The following code was auto-generated. PLEASE DO NOT EDIT. ----------
// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.11;

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
    uint256 constant internal MM_TRACE_COMMITMENT =                          0x6; // uint256[2]
    uint256 constant internal MM_OODS_COMMITMENT =                           0x8;
    uint256 constant internal MM_N_UNIQUE_QUERIES =                          0x9;
    uint256 constant internal MM_CHANNEL =                                   0xa; // uint256[3]
    uint256 constant internal MM_MERKLE_QUEUE =                              0xd; // uint256[96]
    uint256 constant internal MM_FRI_QUEUE =                                0x6d; // uint256[144]
    uint256 constant internal MM_FRI_QUERIES_DELIMITER =                    0xfd;
    uint256 constant internal MM_FRI_CTX =                                  0xfe; // uint256[40]
    uint256 constant internal MM_FRI_STEPS_PTR =                           0x126;
    uint256 constant internal MM_FRI_EVAL_POINTS =                         0x127; // uint256[10]
    uint256 constant internal MM_FRI_COMMITMENTS =                         0x131; // uint256[10]
    uint256 constant internal MM_FRI_LAST_LAYER_DEG_BOUND =                0x13b;
    uint256 constant internal MM_FRI_LAST_LAYER_PTR =                      0x13c;
    uint256 constant internal MM_CONSTRAINT_POLY_ARGS_START =              0x13d;
    uint256 constant internal MM_PERIODIC_COLUMN__PEDERSEN__POINTS__X =    0x13d;
    uint256 constant internal MM_PERIODIC_COLUMN__PEDERSEN__POINTS__Y =    0x13e;
    uint256 constant internal MM_PERIODIC_COLUMN__ECDSA__GENERATOR_POINTS__X = 0x13f;
    uint256 constant internal MM_PERIODIC_COLUMN__ECDSA__GENERATOR_POINTS__Y = 0x140;
    uint256 constant internal MM_TRACE_LENGTH =                            0x141;
    uint256 constant internal MM_OFFSET_SIZE =                             0x142;
    uint256 constant internal MM_HALF_OFFSET_SIZE =                        0x143;
    uint256 constant internal MM_INITIAL_AP =                              0x144;
    uint256 constant internal MM_INITIAL_PC =                              0x145;
    uint256 constant internal MM_FINAL_AP =                                0x146;
    uint256 constant internal MM_FINAL_PC =                                0x147;
    uint256 constant internal MM_MEMORY__MULTI_COLUMN_PERM__PERM__INTERACTION_ELM = 0x148;
    uint256 constant internal MM_MEMORY__MULTI_COLUMN_PERM__HASH_INTERACTION_ELM0 = 0x149;
    uint256 constant internal MM_MEMORY__MULTI_COLUMN_PERM__PERM__PUBLIC_MEMORY_PROD = 0x14a;
    uint256 constant internal MM_RC16__PERM__INTERACTION_ELM =             0x14b;
    uint256 constant internal MM_RC16__PERM__PUBLIC_MEMORY_PROD =          0x14c;
    uint256 constant internal MM_RC_MIN =                                  0x14d;
    uint256 constant internal MM_RC_MAX =                                  0x14e;
    uint256 constant internal MM_DILUTED_CHECK__PERMUTATION__INTERACTION_ELM = 0x14f;
    uint256 constant internal MM_DILUTED_CHECK__PERMUTATION__PUBLIC_MEMORY_PROD = 0x150;
    uint256 constant internal MM_DILUTED_CHECK__FIRST_ELM =                0x151;
    uint256 constant internal MM_DILUTED_CHECK__INTERACTION_Z =            0x152;
    uint256 constant internal MM_DILUTED_CHECK__INTERACTION_ALPHA =        0x153;
    uint256 constant internal MM_DILUTED_CHECK__FINAL_CUM_VAL =            0x154;
    uint256 constant internal MM_PEDERSEN__SHIFT_POINT_X =                 0x155;
    uint256 constant internal MM_PEDERSEN__SHIFT_POINT_Y =                 0x156;
    uint256 constant internal MM_INITIAL_PEDERSEN_ADDR =                   0x157;
    uint256 constant internal MM_INITIAL_RC_ADDR =                         0x158;
    uint256 constant internal MM_ECDSA__SIG_CONFIG_ALPHA =                 0x159;
    uint256 constant internal MM_ECDSA__SIG_CONFIG_SHIFT_POINT_X =         0x15a;
    uint256 constant internal MM_ECDSA__SIG_CONFIG_SHIFT_POINT_Y =         0x15b;
    uint256 constant internal MM_ECDSA__SIG_CONFIG_BETA =                  0x15c;
    uint256 constant internal MM_INITIAL_ECDSA_ADDR =                      0x15d;
    uint256 constant internal MM_INITIAL_BITWISE_ADDR =                    0x15e;
    uint256 constant internal MM_TRACE_GENERATOR =                         0x15f;
    uint256 constant internal MM_OODS_POINT =                              0x160;
    uint256 constant internal MM_INTERACTION_ELEMENTS =                    0x161; // uint256[6]
    uint256 constant internal MM_COEFFICIENTS =                            0x167; // uint256[221]
    uint256 constant internal MM_OODS_VALUES =                             0x244; // uint256[291]
    uint256 constant internal MM_CONSTRAINT_POLY_ARGS_END =                0x367;
    uint256 constant internal MM_COMPOSITION_OODS_VALUES =                 0x367; // uint256[2]
    uint256 constant internal MM_OODS_EVAL_POINTS =                        0x369; // uint256[48]
    uint256 constant internal MM_OODS_COEFFICIENTS =                       0x399; // uint256[293]
    uint256 constant internal MM_TRACE_QUERY_RESPONSES =                   0x4be; // uint256[1296]
    uint256 constant internal MM_COMPOSITION_QUERY_RESPONSES =             0x9ce; // uint256[96]
    uint256 constant internal MM_LOG_N_STEPS =                             0xa2e;
    uint256 constant internal MM_N_PUBLIC_MEM_ENTRIES =                    0xa2f;
    uint256 constant internal MM_N_PUBLIC_MEM_PAGES =                      0xa30;
    uint256 constant internal MM_CONTEXT_SIZE =                            0xa31;
}
// ---------- End of auto-generated code. ----------
