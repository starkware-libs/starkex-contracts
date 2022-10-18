// ---------- The following code was auto-generated. PLEASE DO NOT EDIT. ----------
// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

import "../../PrimeFieldElement0.sol";

contract StarkParameters is PrimeFieldElement0 {
    uint256 constant internal N_COEFFICIENTS = 197;
    uint256 constant internal N_INTERACTION_ELEMENTS = 6;
    uint256 constant internal MASK_SIZE = 246;
    uint256 constant internal N_ROWS_IN_MASK = 120;
    uint256 constant internal N_COLUMNS_IN_MASK = 22;
    uint256 constant internal N_COLUMNS_IN_TRACE0 = 21;
    uint256 constant internal N_COLUMNS_IN_TRACE1 = 1;
    uint256 constant internal CONSTRAINTS_DEGREE_BOUND = 2;
    uint256 constant internal N_OODS_VALUES = MASK_SIZE + CONSTRAINTS_DEGREE_BOUND;
    uint256 constant internal N_OODS_COEFFICIENTS = N_OODS_VALUES;

    // ---------- // Air specific constants. ----------
    uint256 constant internal PUBLIC_MEMORY_STEP = 8;
    uint256 constant internal DILUTED_SPACING = 4;
    uint256 constant internal DILUTED_N_BITS = 16;
    uint256 constant internal PEDERSEN_BUILTIN_RATIO = 8;
    uint256 constant internal PEDERSEN_BUILTIN_REPETITIONS = 4;
    uint256 constant internal RC_BUILTIN_RATIO = 8;
    uint256 constant internal RC_N_PARTS = 8;
    uint256 constant internal ECDSA_BUILTIN_RATIO = 512;
    uint256 constant internal ECDSA_BUILTIN_REPETITIONS = 1;
    uint256 constant internal BITWISE__RATIO = 64;
    uint256 constant internal LAYOUT_CODE = 133449663013987685036071398930607862629;
    uint256 constant internal LOG_CPU_COMPONENT_HEIGHT = 4;
}
// ---------- End of auto-generated code. ----------
