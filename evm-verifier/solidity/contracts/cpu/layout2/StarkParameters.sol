// ---------- The following code was auto-generated. PLEASE DO NOT EDIT. ----------
// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

import "../../PrimeFieldElement0.sol";

contract StarkParameters is PrimeFieldElement0 {
    uint256 constant internal N_COEFFICIENTS = 116;
    uint256 constant internal N_INTERACTION_ELEMENTS = 3;
    uint256 constant internal MASK_SIZE = 128;
    uint256 constant internal N_ROWS_IN_MASK = 79;
    uint256 constant internal N_COLUMNS_IN_MASK = 10;
    uint256 constant internal N_COLUMNS_IN_TRACE0 = 9;
    uint256 constant internal N_COLUMNS_IN_TRACE1 = 1;
    uint256 constant internal CONSTRAINTS_DEGREE_BOUND = 2;
    uint256 constant internal N_OODS_VALUES = MASK_SIZE + CONSTRAINTS_DEGREE_BOUND;
    uint256 constant internal N_OODS_COEFFICIENTS = N_OODS_VALUES;
    uint256 constant internal MAX_FRI_STEP = 3;

    // ---------- // Air specific constants. ----------
    uint256 constant internal PUBLIC_MEMORY_STEP = 8;
    uint256 constant internal PEDERSEN_BUILTIN_RATIO = 32;
    uint256 constant internal PEDERSEN_BUILTIN_REPETITIONS = 1;
    uint256 constant internal RC_BUILTIN_RATIO = 16;
    uint256 constant internal RC_N_PARTS = 8;
    uint256 constant internal ECDSA_BUILTIN_RATIO = 2048;
    uint256 constant internal ECDSA_BUILTIN_REPETITIONS = 1;
    uint256 constant internal LAYOUT_CODE = 2073345364981693374828;
    uint256 constant internal LOG_CPU_COMPONENT_HEIGHT = 4;
}
// ---------- End of auto-generated code. ----------
