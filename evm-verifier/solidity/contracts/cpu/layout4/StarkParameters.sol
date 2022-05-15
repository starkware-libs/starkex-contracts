// ---------- The following code was auto-generated. PLEASE DO NOT EDIT. ----------
// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

import "../../PrimeFieldElement0.sol";

contract StarkParameters is PrimeFieldElement0 {
    uint256 constant internal N_COEFFICIENTS = 134;
    uint256 constant internal N_INTERACTION_ELEMENTS = 6;
    uint256 constant internal MASK_SIZE = 174;
    uint256 constant internal N_ROWS_IN_MASK = 103;
    uint256 constant internal N_COLUMNS_IN_MASK = 10;
    uint256 constant internal N_COLUMNS_IN_TRACE0 = 7;
    uint256 constant internal N_COLUMNS_IN_TRACE1 = 3;
    uint256 constant internal CONSTRAINTS_DEGREE_BOUND = 2;
    uint256 constant internal N_OODS_VALUES = MASK_SIZE + CONSTRAINTS_DEGREE_BOUND;
    uint256 constant internal N_OODS_COEFFICIENTS = N_OODS_VALUES;
    uint256 constant internal MAX_FRI_STEP = 3;

    // ---------- // Air specific constants. ----------
    uint256 constant internal PUBLIC_MEMORY_STEP = 16;
    uint256 constant internal PEDERSEN_BUILTIN_RATIO = 256;
    uint256 constant internal PEDERSEN_BUILTIN_REPETITIONS = 1;
    uint256 constant internal RC_BUILTIN_RATIO = 8;
    uint256 constant internal RC_N_PARTS = 8;
    uint256 constant internal ECDSA_BUILTIN_RATIO = 1024;
    uint256 constant internal ECDSA_BUILTIN_REPETITIONS = 1;
    uint256 constant internal BITWISE__RATIO = 8;
    uint256 constant internal BITWISE__DILUTED_SPACING = 4;
    uint256 constant internal BITWISE__DILUTED_N_BITS = 16;
    uint256 constant internal LAYOUT_CODE = 27700496658166629;
    uint256 constant internal LOG_CPU_COMPONENT_HEIGHT = 4;
}
// ---------- End of auto-generated code. ----------
