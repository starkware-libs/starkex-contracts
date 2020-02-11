// ---------- The following code was auto-generated. PLEASE DO NOT EDIT. ----------
pragma solidity ^0.5.2;

import "../PrimeFieldElement0.sol";

contract StarkParameters is PrimeFieldElement0 {
    uint256 constant internal N_COEFFICIENTS = 360;
    uint256 constant internal MASK_SIZE = 193;
    uint256 constant internal N_ROWS_IN_MASK = 126;
    uint256 constant internal N_COLUMNS_IN_MASK = 18;
    uint256 constant internal CONSTRAINTS_DEGREE_BOUND = 2;
    uint256 constant internal N_OODS_VALUES = MASK_SIZE + CONSTRAINTS_DEGREE_BOUND;
    uint256 constant internal N_OODS_COEFFICIENTS = N_OODS_VALUES;
    uint256 constant internal MAX_FRI_STEP = 3;

    // ---------- // Air specific constants. ----------
    uint256 constant internal PERIODIC_HASH_POOL_STEP = 4;
    uint256 constant internal VAULTS_PERIODIC_MERKLE_HASH_STEP = 1;
    uint256 constant internal SETTLEMENT_PERIODIC_MERKLE_HASH_STEP = 1;
    uint256 constant internal ECDSA_POINTS_STEP = 128;
    uint256 constant internal VAULTS_PATH_HEIGHT = 32;
    uint256 constant internal SETTLEMENT_PATH_HEIGHT = 64;
    uint256 constant internal SETTLEMENT_PATH_LENGTH = 63;
    uint256 constant internal RANGE_CHECK_BITS = 63;
    uint256 constant internal EXPIRATION_TIMESTAMP_RANGE_CHECK_BITS = 22;
    uint256 constant internal NONCE_RANGE_CHECK_BITS = 31;
}
// ---------- End of auto-generated code. ----------
