// ---------- The following code was auto-generated. PLEASE DO NOT EDIT. ----------
pragma solidity ^0.5.2;

contract DexConstraintPoly {
    // The Memory map during the execution of this contract is as follows:
    // [0x0, 0x20) - periodic_column/hash_pool_points/x.
    // [0x20, 0x40) - periodic_column/hash_pool_points/y.
    // [0x40, 0x60) - periodic_column/vaults_merkle_hash_points/x.
    // [0x60, 0x80) - periodic_column/vaults_merkle_hash_points/y.
    // [0x80, 0xa0) - periodic_column/boundary_base.
    // [0xa0, 0xc0) - periodic_column/is_modification.
    // [0xc0, 0xe0) - periodic_column/is_settlement.
    // [0xe0, 0x100) - periodic_column/boundary_key.
    // [0x100, 0x120) - periodic_column/boundary_token.
    // [0x120, 0x140) - periodic_column/boundary_amount0.
    // [0x140, 0x160) - periodic_column/boundary_amount1.
    // [0x160, 0x180) - periodic_column/boundary_vault_id.
    // [0x180, 0x1a0) - periodic_column/settlement_merkle_hash_points/x.
    // [0x1a0, 0x1c0) - periodic_column/settlement_merkle_hash_points/y.
    // [0x1c0, 0x1e0) - periodic_column/ecdsa_points/x.
    // [0x1e0, 0x200) - periodic_column/ecdsa_points/y.
    // [0x200, 0x220) - trace_length.
    // [0x220, 0x240) - shift_point.x.
    // [0x240, 0x260) - shift_point.y.
    // [0x260, 0x280) - vaults_path_length.
    // [0x280, 0x2a0) - n_modifications.
    // [0x2a0, 0x2c0) - n_settlements.
    // [0x2c0, 0x2e0) - amount_shift.
    // [0x2e0, 0x300) - global_expiration_timestamp_elm.
    // [0x300, 0x320) - sig_config.alpha.
    // [0x320, 0x340) - sig_config.beta.
    // [0x340, 0x360) - vault_shift.
    // [0x360, 0x380) - nonce_shift.
    // [0x380, 0x3a0) - expiration_timestamp_shift.
    // [0x3a0, 0x3c0) - initial_vaults_root.
    // [0x3c0, 0x3e0) - initial_settlement_root.
    // [0x3e0, 0x400) - final_vaults_root.
    // [0x400, 0x420) - n_transactions.
    // [0x420, 0x440) - final_settlement_root.
    // [0x440, 0x460) - trace_generator.
    // [0x460, 0x480) - oods_point.
    // [0x480, 0x3180) - coefficients.
    // [0x3180, 0x49a0) - oods_values.
    // ----------------------- end of input data - -------------------------
    // [0x49a0, 0x49c0) - composition_degree_bound.
    // [0x49c0, 0x49e0) - intermediate_value/hash_pool/hash/ec_subset_sum/bit.
    // [0x49e0, 0x4a00) - intermediate_value/hash_pool/hash/ec_subset_sum/bit_neg.
    // [0x4a00, 0x4a20) - intermediate_value/vaults_state_transition/merkle_update/side_bit_extraction/bit_0.
    // [0x4a20, 0x4a40) - intermediate_value/vaults_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/bit.
    // [0x4a40, 0x4a60) - intermediate_value/vaults_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/bit_neg.
    // [0x4a60, 0x4a80) - intermediate_value/vaults_state_transition/merkle_update/side_bit_extraction/bit_1.
    // [0x4a80, 0x4aa0) - intermediate_value/vaults_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/bit.
    // [0x4aa0, 0x4ac0) - intermediate_value/vaults_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/bit_neg.
    // [0x4ac0, 0x4ae0) - intermediate_value/vaults_state_transition/merkle_update/prev_authentication/sibling_0.
    // [0x4ae0, 0x4b00) - intermediate_value/vaults_state_transition/merkle_update/new_authentication/sibling_0.
    // [0x4b00, 0x4b20) - intermediate_value/vaults_state_transition/merkle_update/prev_authentication/leaf_0.
    // [0x4b20, 0x4b40) - intermediate_value/vaults_state_transition/merkle_update/new_authentication/leaf_0.
    // [0x4b40, 0x4b60) - intermediate_value/settlement_state_transition/merkle_update/side_bit_extraction/bit_0.
    // [0x4b60, 0x4b80) - intermediate_value/settlement_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/bit.
    // [0x4b80, 0x4ba0) - intermediate_value/settlement_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/bit_neg.
    // [0x4ba0, 0x4bc0) - intermediate_value/settlement_state_transition/merkle_update/side_bit_extraction/bit_1.
    // [0x4bc0, 0x4be0) - intermediate_value/settlement_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/bit.
    // [0x4be0, 0x4c00) - intermediate_value/settlement_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/bit_neg.
    // [0x4c00, 0x4c20) - intermediate_value/settlement_state_transition/merkle_update/prev_authentication/sibling_0.
    // [0x4c20, 0x4c40) - intermediate_value/settlement_state_transition/merkle_update/new_authentication/sibling_0.
    // [0x4c40, 0x4c60) - intermediate_value/settlement_state_transition/merkle_update/prev_authentication/leaf_0.
    // [0x4c60, 0x4c80) - intermediate_value/settlement_state_transition/merkle_update/new_authentication/leaf_0.
    // [0x4c80, 0x4ca0) - intermediate_value/amounts_range_check/bit_0.
    // [0x4ca0, 0x4cc0) - intermediate_value/expiration_timestamp_range_check/bit_0.
    // [0x4cc0, 0x4ce0) - intermediate_value/nonce_range_check/bit_0.
    // [0x4ce0, 0x4d00) - intermediate_value/sig_verify/doubling_key/x_squared.
    // [0x4d00, 0x4d20) - intermediate_value/sig_verify/exponentiate_generator/bit.
    // [0x4d20, 0x4d40) - intermediate_value/sig_verify/exponentiate_generator/bit_neg.
    // [0x4d40, 0x4d60) - intermediate_value/sig_verify/exponentiate_key/bit.
    // [0x4d60, 0x4d80) - intermediate_value/sig_verify/exponentiate_key/bit_neg.
    // [0x4d80, 0x4da0) - intermediate_value/party_a_packed_msg/partial.
    // [0x4da0, 0x4dc0) - intermediate_value/party_b_packed_msg/partial.
    // [0x4dc0, 0x4de0) - intermediate_value/party_b_packed_msg_transfer/partial.
    // [0x4de0, 0x50e0) - expmods.
    // [0x50e0, 0x5460) - denominator_invs.
    // [0x5460, 0x57e0) - denominators.
    // [0x57e0, 0x59a0) - numerators.
    // [0x59a0, 0x5d60) - adjustments.
    // [0x5d60, 0x5e20) - expmod_context.

    function() external {
        uint256 res;
        assembly {
            let PRIME := 0x800000000000011000000000000000000000000000000000000000000000001
            // Copy input from calldata to memory.
            calldatacopy(0x0, 0x0, /*Input data size*/ 0x49a0)
            let point := /*oods_point*/ mload(0x460)
            // Initialize composition_degree_bound to 2 * trace_length.
            mstore(0x49a0, mul(2, /*trace_length*/ mload(0x200)))
            function expmod(base, exponent, modulus) -> res {
              let p := /*expmod_context*/ 0x5d60
              mstore(p, 0x20)                 // Length of Base.
              mstore(add(p, 0x20), 0x20)      // Length of Exponent.
              mstore(add(p, 0x40), 0x20)      // Length of Modulus.
              mstore(add(p, 0x60), base)      // Base.
              mstore(add(p, 0x80), exponent)  // Exponent.
              mstore(add(p, 0xa0), modulus)   // Modulus.
              // Call modexp precompile.
              if iszero(staticcall(not(0), 0x05, p, 0xc0, p, 0x20)) {
                revert(0, 0)
              }
              res := mload(p)
            }

            function degreeAdjustment(compositionPolynomialDegreeBound, constraintDegree, numeratorDegree,
                                       denominatorDegree) -> res {
              res := sub(sub(compositionPolynomialDegreeBound, 1),
                         sub(add(constraintDegree, numeratorDegree), denominatorDegree))
            }

            {
              // Prepare expmods for denominators and numerators.

              // expmods[0] = point^(trace_length / 4).
              mstore(0x4de0, expmod(point, div(/*trace_length*/ mload(0x200), 4), PRIME))

              // expmods[1] = point^(trace_length / 1024).
              mstore(0x4e00, expmod(point, div(/*trace_length*/ mload(0x200), 1024), PRIME))

              // expmods[2] = point^(trace_length / 2048).
              mstore(0x4e20, expmod(point, div(/*trace_length*/ mload(0x200), 2048), PRIME))

              // expmods[3] = point^(trace_length / 4096).
              mstore(0x4e40, expmod(point, div(/*trace_length*/ mload(0x200), 4096), PRIME))

              // expmods[4] = point^(trace_length / 512).
              mstore(0x4e60, expmod(point, div(/*trace_length*/ mload(0x200), 512), PRIME))

              // expmods[5] = point^(trace_length / 16384).
              mstore(0x4e80, expmod(point, div(/*trace_length*/ mload(0x200), 16384), PRIME))

              // expmods[6] = point^trace_length.
              mstore(0x4ea0, expmod(point, /*trace_length*/ mload(0x200), PRIME))

              // expmods[7] = point^(trace_length / 256).
              mstore(0x4ec0, expmod(point, div(/*trace_length*/ mload(0x200), 256), PRIME))

              // expmods[8] = point^(trace_length / 65536).
              mstore(0x4ee0, expmod(point, div(/*trace_length*/ mload(0x200), 65536), PRIME))

              // expmods[9] = point^(trace_length / 32768).
              mstore(0x4f00, expmod(point, div(/*trace_length*/ mload(0x200), 32768), PRIME))

              // expmods[10] = point^(trace_length / 64).
              mstore(0x4f20, expmod(point, div(/*trace_length*/ mload(0x200), 64), PRIME))

              // expmods[11] = point^(trace_length / 128).
              mstore(0x4f40, expmod(point, div(/*trace_length*/ mload(0x200), 128), PRIME))

              // expmods[12] = point^(trace_length / 8192).
              mstore(0x4f60, expmod(point, div(/*trace_length*/ mload(0x200), 8192), PRIME))

              // expmods[13] = trace_generator^(255 * trace_length / 256).
              mstore(0x4f80, expmod(/*trace_generator*/ mload(0x440), div(mul(255, /*trace_length*/ mload(0x200)), 256), PRIME))

              // expmods[14] = trace_generator^(63 * trace_length / 64).
              mstore(0x4fa0, expmod(/*trace_generator*/ mload(0x440), div(mul(63, /*trace_length*/ mload(0x200)), 64), PRIME))

              // expmods[15] = trace_generator^(trace_length / 2).
              mstore(0x4fc0, expmod(/*trace_generator*/ mload(0x440), div(/*trace_length*/ mload(0x200), 2), PRIME))

              // expmods[16] = trace_generator^(31 * trace_length / 32).
              mstore(0x4fe0, expmod(/*trace_generator*/ mload(0x440), div(mul(31, /*trace_length*/ mload(0x200)), 32), PRIME))

              // expmods[17] = trace_generator^(vaults_path_length * trace_length / 32).
              mstore(0x5000, expmod(/*trace_generator*/ mload(0x440), div(mul(/*vaults_path_length*/ mload(0x260), /*trace_length*/ mload(0x200)), 32), PRIME))

              // expmods[18] = trace_generator^(15 * trace_length / 16).
              mstore(0x5020, expmod(/*trace_generator*/ mload(0x440), div(mul(15, /*trace_length*/ mload(0x200)), 16), PRIME))

              // expmods[19] = trace_generator^(11 * trace_length / 16).
              mstore(0x5040, expmod(/*trace_generator*/ mload(0x440), div(mul(11, /*trace_length*/ mload(0x200)), 16), PRIME))

              // expmods[20] = trace_generator^(251 * trace_length / 256).
              mstore(0x5060, expmod(/*trace_generator*/ mload(0x440), div(mul(251, /*trace_length*/ mload(0x200)), 256), PRIME))

              // expmods[21] = trace_generator^(65536 * (n_transactions - 1)).
              mstore(0x5080, expmod(/*trace_generator*/ mload(0x440), mul(65536, sub(/*n_transactions*/ mload(0x400), 1)), PRIME))

              // expmods[22] = trace_generator^(65536 * (trace_length / 65536 - 1) + 49152).
              mstore(0x50a0, expmod(/*trace_generator*/ mload(0x440), add(mul(65536, sub(div(/*trace_length*/ mload(0x200), 65536), 1)), 49152), PRIME))

              // expmods[23] = trace_generator^(65536 * (trace_length / 65536 - 1)).
              mstore(0x50c0, expmod(/*trace_generator*/ mload(0x440), mul(65536, sub(div(/*trace_length*/ mload(0x200), 65536), 1)), PRIME))

            }

            {
              // Prepare denominators for batch inverse.

              // Denominator for constraints: 'hash_pool/hash/ec_subset_sum/booleanity_test', 'hash_pool/hash/ec_subset_sum/add_points/slope', 'hash_pool/hash/ec_subset_sum/add_points/x', 'hash_pool/hash/ec_subset_sum/add_points/y', 'hash_pool/hash/ec_subset_sum/copy_point/x', 'hash_pool/hash/ec_subset_sum/copy_point/y'.
              // denominators[0] = point^(trace_length / 4) - 1.
              mstore(0x5460,
                     addmod(/*point^(trace_length / 4)*/ mload(0x4de0), sub(PRIME, 1), PRIME))

              // Denominator for constraints: 'hash_pool/hash/ec_subset_sum/bit_extraction_end'.
              // denominators[1] = point^(trace_length / 1024) - trace_generator^(63 * trace_length / 64).
              mstore(0x5480,
                     addmod(
                       /*point^(trace_length / 1024)*/ mload(0x4e00),
                       sub(PRIME, /*trace_generator^(63 * trace_length / 64)*/ mload(0x4fa0)),
                       PRIME))

              // Denominator for constraints: 'hash_pool/hash/ec_subset_sum/zeros_tail'.
              // denominators[2] = point^(trace_length / 1024) - trace_generator^(255 * trace_length / 256).
              mstore(0x54a0,
                     addmod(
                       /*point^(trace_length / 1024)*/ mload(0x4e00),
                       sub(PRIME, /*trace_generator^(255 * trace_length / 256)*/ mload(0x4f80)),
                       PRIME))

              // Denominator for constraints: 'hash_pool/hash/copy_point/x', 'hash_pool/hash/copy_point/y', 'nonce_range_check/bit'.
              // denominators[3] = point^(trace_length / 1024) - 1.
              mstore(0x54c0,
                     addmod(/*point^(trace_length / 1024)*/ mload(0x4e00), sub(PRIME, 1), PRIME))

              // Denominator for constraints: 'hash_pool/hash/init/x', 'hash_pool/hash/init/y'.
              // denominators[4] = point^(trace_length / 2048) - 1.
              mstore(0x54e0,
                     addmod(/*point^(trace_length / 2048)*/ mload(0x4e20), sub(PRIME, 1), PRIME))

              // Denominator for constraints: 'hash_pool/output_to_input'.
              // denominators[5] = point^(trace_length / 4096) - 1.
              mstore(0x5500,
                     addmod(/*point^(trace_length / 4096)*/ mload(0x4e40), sub(PRIME, 1), PRIME))

              // Denominator for constraints: 'vaults_state_transition/merkle_update/side_bit_extraction/bit', 'vaults_state_transition/merkle_update/prev_authentication/hashes/init/x', 'vaults_state_transition/merkle_update/prev_authentication/hashes/init/y', 'vaults_state_transition/merkle_update/prev_authentication/copy_prev_to_left', 'vaults_state_transition/merkle_update/prev_authentication/copy_prev_to_right', 'vaults_state_transition/merkle_update/new_authentication/hashes/init/x', 'vaults_state_transition/merkle_update/new_authentication/hashes/init/y', 'vaults_state_transition/merkle_update/new_authentication/copy_prev_to_left', 'vaults_state_transition/merkle_update/new_authentication/copy_prev_to_right', 'vaults_state_transition/merkle_update/same_siblings', 'settlement_state_transition/merkle_update/side_bit_extraction/bit', 'settlement_state_transition/merkle_update/prev_authentication/hashes/init/x', 'settlement_state_transition/merkle_update/prev_authentication/hashes/init/y', 'settlement_state_transition/merkle_update/prev_authentication/copy_prev_to_left', 'settlement_state_transition/merkle_update/prev_authentication/copy_prev_to_right', 'settlement_state_transition/merkle_update/new_authentication/hashes/init/x', 'settlement_state_transition/merkle_update/new_authentication/hashes/init/y', 'settlement_state_transition/merkle_update/new_authentication/copy_prev_to_left', 'settlement_state_transition/merkle_update/new_authentication/copy_prev_to_right', 'settlement_state_transition/merkle_update/same_siblings', 'expiration_timestamp_range_check/bit'.
              // denominators[6] = point^(trace_length / 512) - 1.
              mstore(0x5520,
                     addmod(/*point^(trace_length / 512)*/ mload(0x4e60), sub(PRIME, 1), PRIME))

              // Denominator for constraints: 'vaults_state_transition/merkle_update/side_bit_extraction/zero'.
              // denominators[7] = point^(trace_length / 16384) - trace_generator^(vaults_path_length * trace_length / 32).
              mstore(0x5540,
                     addmod(
                       /*point^(trace_length / 16384)*/ mload(0x4e80),
                       sub(PRIME, /*trace_generator^(vaults_path_length * trace_length / 32)*/ mload(0x5000)),
                       PRIME))

              // Denominator for constraints: 'vaults_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/booleanity_test', 'vaults_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/add_points/slope', 'vaults_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/add_points/x', 'vaults_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/add_points/y', 'vaults_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/copy_point/x', 'vaults_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/copy_point/y', 'vaults_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/booleanity_test', 'vaults_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/add_points/slope', 'vaults_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/add_points/x', 'vaults_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/add_points/y', 'vaults_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/copy_point/x', 'vaults_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/copy_point/y', 'settlement_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/booleanity_test', 'settlement_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/add_points/slope', 'settlement_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/add_points/x', 'settlement_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/add_points/y', 'settlement_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/copy_point/x', 'settlement_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/copy_point/y', 'settlement_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/booleanity_test', 'settlement_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/add_points/slope', 'settlement_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/add_points/x', 'settlement_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/add_points/y', 'settlement_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/copy_point/x', 'settlement_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/copy_point/y'.
              // denominators[8] = point^trace_length - 1.
              mstore(0x5560,
                     addmod(/*point^trace_length*/ mload(0x4ea0), sub(PRIME, 1), PRIME))

              // Denominator for constraints: 'vaults_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/bit_extraction_end', 'vaults_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/bit_extraction_end', 'settlement_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/bit_extraction_end', 'settlement_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/bit_extraction_end'.
              // denominators[9] = point^(trace_length / 256) - trace_generator^(63 * trace_length / 64).
              mstore(0x5580,
                     addmod(
                       /*point^(trace_length / 256)*/ mload(0x4ec0),
                       sub(PRIME, /*trace_generator^(63 * trace_length / 64)*/ mload(0x4fa0)),
                       PRIME))

              // Denominator for constraints: 'vaults_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/zeros_tail', 'vaults_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/zeros_tail', 'settlement_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/zeros_tail', 'settlement_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/zeros_tail'.
              // denominators[10] = point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              mstore(0x55a0,
                     addmod(
                       /*point^(trace_length / 256)*/ mload(0x4ec0),
                       sub(PRIME, /*trace_generator^(255 * trace_length / 256)*/ mload(0x4f80)),
                       PRIME))

              // Denominator for constraints: 'vaults_state_transition/merkle_update/prev_authentication/hashes/copy_point/x', 'vaults_state_transition/merkle_update/prev_authentication/hashes/copy_point/y', 'vaults_state_transition/merkle_update/new_authentication/hashes/copy_point/x', 'vaults_state_transition/merkle_update/new_authentication/hashes/copy_point/y', 'settlement_state_transition/merkle_update/prev_authentication/hashes/copy_point/x', 'settlement_state_transition/merkle_update/prev_authentication/hashes/copy_point/y', 'settlement_state_transition/merkle_update/new_authentication/hashes/copy_point/x', 'settlement_state_transition/merkle_update/new_authentication/hashes/copy_point/y'.
              // denominators[11] = point^(trace_length / 256) - 1.
              mstore(0x55c0,
                     addmod(/*point^(trace_length / 256)*/ mload(0x4ec0), sub(PRIME, 1), PRIME))

              // Denominator for constraints: 'vaults_state_transition/merkle_set_prev_leaf', 'vaults_state_transition/merkle_set_new_leaf', 'amounts_range_check_inputs', 'sig_verify/init_key/x', 'sig_verify/init_key/y', 'sig_verify/r_and_w_nonzero', 'handle_empty_vault/consistency_key_stage0', 'handle_empty_vault/consistency_token_stage0', 'handle_empty_vault/consistency_key_stage1', 'handle_empty_vault/consistency_token_stage1', 'copy_merkle_roots'.
              // denominators[12] = point^(trace_length / 16384) - 1.
              mstore(0x55e0,
                     addmod(/*point^(trace_length / 16384)*/ mload(0x4e80), sub(PRIME, 1), PRIME))

              // Denominator for constraints: 'modification_boundary_key', 'modification_boundary_token', 'modification_boundary_amount0', 'modification_boundary_amount1', 'modification_boundary_vault_id', 'settlement_state_transition/set_prev_root', 'settlement_state_transition/root_consistency', 'settlement_state_transition/set_new_root', 'settlement_state_transition/dont_change_if_modification', 'total_token_a_not_changed', 'total_token_b_not_changed', 'party_a_fulfilled_amount', 'party_b_fulfilled_amount', 'amount_a_range_check_input', 'amount_b_range_check_input', 'ratio_party_a', 'ratio_party_b', 'capacity_party_a', 'capacity_party_b', 'is_transfer/bit', 'is_transfer/modification', 'transfer/party_a_sold', 'transfer/party_b_buy', 'transfer/party_a_sell', 'transfer/party_b_exact_transferred', 'party_a_sig_input_packed', 'party_b_sig_input_packed', 'signatures/party_b_hash_sec_msg', 'signatures/copy_token_b', 'copy_signature_input_party_a', 'copy_signature_input_party_b', 'message_hash_determines_order_id_party_a', 'message_hash_determines_order_id_party_b', 'party_a_public_key_copy', 'handle_empty_vault/consistency_key_change0', 'handle_empty_vault/consistency_token_change0', 'handle_empty_vault/consistency_key_change3', 'handle_empty_vault/consistency_token_change3', 'handle_empty_vault/consistency_key_change1', 'handle_empty_vault/consistency_token_change1', 'handle_empty_vault/consistency_key_change2', 'handle_empty_vault/consistency_token_change2', 'copy_settlement_merkle_roots', 'copy_merkle_roots_modification'.
              // denominators[13] = point^(trace_length / 65536) - 1.
              mstore(0x5600,
                     addmod(/*point^(trace_length / 65536)*/ mload(0x4ee0), sub(PRIME, 1), PRIME))

              // Denominator for constraints: 'settlement_state_transition/merkle_update/side_bit_extraction/zero'.
              // denominators[14] = point^(trace_length / 32768) - trace_generator^(63 * trace_length / 64).
              mstore(0x5620,
                     addmod(
                       /*point^(trace_length / 32768)*/ mload(0x4f00),
                       sub(PRIME, /*trace_generator^(63 * trace_length / 64)*/ mload(0x4fa0)),
                       PRIME))

              // Denominator for constraints: 'settlement_state_transition/merkle_set_prev_leaf', 'settlement_state_transition/merkle_set_new_leaf', 'expiration_timestamp_range_check_input', 'sig_verify/init_gen/x', 'sig_verify/init_gen/y', 'sig_verify/add_results/slope', 'sig_verify/add_results/x', 'sig_verify/add_results/y', 'sig_verify/add_results/x_diff_inv', 'sig_verify/extract_r/slope', 'sig_verify/extract_r/x', 'sig_verify/extract_r/x_diff_inv', 'sig_verify/z_nonzero', 'sig_verify/q_on_curve/x_squared', 'sig_verify/q_on_curve/on_curve'.
              // denominators[15] = point^(trace_length / 32768) - 1.
              mstore(0x5640,
                     addmod(/*point^(trace_length / 32768)*/ mload(0x4f00), sub(PRIME, 1), PRIME))

              // Denominator for constraints: 'amounts_range_check/bit', 'sig_verify/doubling_key/slope', 'sig_verify/doubling_key/x', 'sig_verify/doubling_key/y', 'sig_verify/exponentiate_key/booleanity_test', 'sig_verify/exponentiate_key/add_points/slope', 'sig_verify/exponentiate_key/add_points/x', 'sig_verify/exponentiate_key/add_points/y', 'sig_verify/exponentiate_key/add_points/x_diff_inv', 'sig_verify/exponentiate_key/copy_point/x', 'sig_verify/exponentiate_key/copy_point/y'.
              // denominators[16] = point^(trace_length / 64) - 1.
              mstore(0x5660,
                     addmod(/*point^(trace_length / 64)*/ mload(0x4f20), sub(PRIME, 1), PRIME))

              // Denominator for constraints: 'amounts_range_check/zero'.
              // denominators[17] = point^(trace_length / 4096) - trace_generator^(63 * trace_length / 64).
              mstore(0x5680,
                     addmod(
                       /*point^(trace_length / 4096)*/ mload(0x4e40),
                       sub(PRIME, /*trace_generator^(63 * trace_length / 64)*/ mload(0x4fa0)),
                       PRIME))

              // Denominator for constraints: 'expiration_timestamp_range_check/zero'.
              // denominators[18] = point^(trace_length / 16384) - trace_generator^(11 * trace_length / 16).
              mstore(0x56a0,
                     addmod(
                       /*point^(trace_length / 16384)*/ mload(0x4e80),
                       sub(PRIME, /*trace_generator^(11 * trace_length / 16)*/ mload(0x5040)),
                       PRIME))

              // Denominator for constraints: 'nonce_range_check/zero'.
              // denominators[19] = point^(trace_length / 32768) - trace_generator^(31 * trace_length / 32).
              mstore(0x56c0,
                     addmod(
                       /*point^(trace_length / 32768)*/ mload(0x4f00),
                       sub(PRIME, /*trace_generator^(31 * trace_length / 32)*/ mload(0x4fe0)),
                       PRIME))

              // Denominator for constraints: 'sig_verify/exponentiate_generator/booleanity_test', 'sig_verify/exponentiate_generator/add_points/slope', 'sig_verify/exponentiate_generator/add_points/x', 'sig_verify/exponentiate_generator/add_points/y', 'sig_verify/exponentiate_generator/add_points/x_diff_inv', 'sig_verify/exponentiate_generator/copy_point/x', 'sig_verify/exponentiate_generator/copy_point/y'.
              // denominators[20] = point^(trace_length / 128) - 1.
              mstore(0x56e0,
                     addmod(/*point^(trace_length / 128)*/ mload(0x4f40), sub(PRIME, 1), PRIME))

              // Denominator for constraints: 'sig_verify/exponentiate_generator/bit_extraction_end'.
              // denominators[21] = point^(trace_length / 32768) - trace_generator^(251 * trace_length / 256).
              mstore(0x5700,
                     addmod(
                       /*point^(trace_length / 32768)*/ mload(0x4f00),
                       sub(PRIME, /*trace_generator^(251 * trace_length / 256)*/ mload(0x5060)),
                       PRIME))

              // Denominator for constraints: 'sig_verify/exponentiate_generator/zeros_tail'.
              // denominators[22] = point^(trace_length / 32768) - trace_generator^(255 * trace_length / 256).
              mstore(0x5720,
                     addmod(
                       /*point^(trace_length / 32768)*/ mload(0x4f00),
                       sub(PRIME, /*trace_generator^(255 * trace_length / 256)*/ mload(0x4f80)),
                       PRIME))

              // Denominator for constraints: 'sig_verify/exponentiate_key/bit_extraction_end'.
              // denominators[23] = point^(trace_length / 16384) - trace_generator^(251 * trace_length / 256).
              mstore(0x5740,
                     addmod(
                       /*point^(trace_length / 16384)*/ mload(0x4e80),
                       sub(PRIME, /*trace_generator^(251 * trace_length / 256)*/ mload(0x5060)),
                       PRIME))

              // Denominator for constraints: 'sig_verify/exponentiate_key/zeros_tail'.
              // denominators[24] = point^(trace_length / 16384) - trace_generator^(255 * trace_length / 256).
              mstore(0x5760,
                     addmod(
                       /*point^(trace_length / 16384)*/ mload(0x4e80),
                       sub(PRIME, /*trace_generator^(255 * trace_length / 256)*/ mload(0x4f80)),
                       PRIME))

              // Denominator for constraints: 'handle_empty_vault/vault_empty/empty_vault_booleanity', 'handle_empty_vault/vault_empty/amount_zero_when_empty', 'handle_empty_vault/vault_empty/amount_inv_zero_when_empty', 'handle_empty_vault/vault_empty/empty_when_amount_zero'.
              // denominators[25] = point^(trace_length / 8192) - 1.
              mstore(0x5780,
                     addmod(/*point^(trace_length / 8192)*/ mload(0x4f60), sub(PRIME, 1), PRIME))

              // Denominator for constraints: 'initial_vaults_root', 'initial_settlement_root'.
              // denominators[26] = point - 1.
              mstore(0x57a0,
                     addmod(point, sub(PRIME, 1), PRIME))

              // Denominator for constraints: 'final_vaults_root', 'final_settlement_root'.
              // denominators[27] = point - trace_generator^(65536 * (n_transactions - 1)).
              mstore(0x57c0,
                     addmod(
                       point,
                       sub(PRIME, /*trace_generator^(65536 * (n_transactions - 1))*/ mload(0x5080)),
                       PRIME))

            }

            {
              // Compute the inverses of the denominators into denominatorInvs using batch inverse.

              // Start by computing the cumulative product.
              // Let (d_0, d_1, d_2, ..., d_{n-1}) be the values in denominators. After this loop
              // denominatorInvs will be (1, d_0, d_0 * d_1, ...) and prod will contain the value of
              // d_0 * ... * d_{n-1}.
              // Compute the offset between the partialProducts array and the input values array.
              let productsToValuesOffset := 0x380
              let prod := 1
              let partialProductEndPtr := 0x5460
              for { let partialProductPtr := 0x50e0 }
                  lt(partialProductPtr, partialProductEndPtr)
                  { partialProductPtr := add(partialProductPtr, 0x20) } {
                  mstore(partialProductPtr, prod)
                  // prod *= d_{i}.
                  prod := mulmod(prod,
                                 mload(add(partialProductPtr, productsToValuesOffset)),
                                 PRIME)
              }

              let firstPartialProductPtr := 0x50e0
              // Compute the inverse of the product.
              let prodInv := expmod(prod, sub(PRIME, 2), PRIME)

              if eq(prodInv, 0) {
                  // Solidity generates reverts with reason that look as follows:
                  // 1. 4 bytes with the constant 0x08c379a0 (== Keccak256(b'Error(string)')[:4]).
                  // 2. 32 bytes offset bytes (always 0x20 as far as i can tell).
                  // 3. 32 bytes with the length of the revert reason.
                  // 4. Revert reason string.

                  mstore(0, 0x08c379a000000000000000000000000000000000000000000000000000000000)
                  mstore(0x4, 0x20)
                  mstore(0x24, 0x1e)
                  mstore(0x44, "Batch inverse product is zero.")
                  revert(0, 0x62)
              }

              // Compute the inverses.
              // Loop over denominator_invs in reverse order.
              // currentPartialProductPtr is initialized to one past the end.
              let currentPartialProductPtr := 0x5460
              for { } gt(currentPartialProductPtr, firstPartialProductPtr) { } {
                  currentPartialProductPtr := sub(currentPartialProductPtr, 0x20)
                  // Store 1/d_{i} = (d_0 * ... * d_{i-1}) * 1/(d_0 * ... * d_{i}).
                  mstore(currentPartialProductPtr,
                         mulmod(mload(currentPartialProductPtr), prodInv, PRIME))
                  // Update prodInv to be 1/(d_0 * ... * d_{i-1}) by multiplying by d_i.
                  prodInv := mulmod(prodInv,
                                     mload(add(currentPartialProductPtr, productsToValuesOffset)),
                                     PRIME)
              }
            }

            {
              // Compute numerators and adjustment polynomials.

              // Numerator for constraints 'hash_pool/hash/ec_subset_sum/booleanity_test', 'hash_pool/hash/ec_subset_sum/add_points/slope', 'hash_pool/hash/ec_subset_sum/add_points/x', 'hash_pool/hash/ec_subset_sum/add_points/y', 'hash_pool/hash/ec_subset_sum/copy_point/x', 'hash_pool/hash/ec_subset_sum/copy_point/y'.
              // numerators[0] = point^(trace_length / 1024) - trace_generator^(255 * trace_length / 256).
              mstore(0x57e0,
                     addmod(
                       /*point^(trace_length / 1024)*/ mload(0x4e00),
                       sub(PRIME, /*trace_generator^(255 * trace_length / 256)*/ mload(0x4f80)),
                       PRIME))

              // Numerator for constraints 'hash_pool/hash/copy_point/x', 'hash_pool/hash/copy_point/y'.
              // numerators[1] = point^(trace_length / 2048) - trace_generator^(trace_length / 2).
              mstore(0x5800,
                     addmod(
                       /*point^(trace_length / 2048)*/ mload(0x4e20),
                       sub(PRIME, /*trace_generator^(trace_length / 2)*/ mload(0x4fc0)),
                       PRIME))

              // Numerator for constraints 'vaults_state_transition/merkle_update/side_bit_extraction/bit', 'vaults_state_transition/merkle_update/same_siblings', 'expiration_timestamp_range_check/bit'.
              // numerators[2] = point^(trace_length / 16384) - trace_generator^(31 * trace_length / 32).
              mstore(0x5820,
                     addmod(
                       /*point^(trace_length / 16384)*/ mload(0x4e80),
                       sub(PRIME, /*trace_generator^(31 * trace_length / 32)*/ mload(0x4fe0)),
                       PRIME))

              // Numerator for constraints 'vaults_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/booleanity_test', 'vaults_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/add_points/slope', 'vaults_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/add_points/x', 'vaults_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/add_points/y', 'vaults_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/copy_point/x', 'vaults_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/copy_point/y', 'vaults_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/booleanity_test', 'vaults_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/add_points/slope', 'vaults_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/add_points/x', 'vaults_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/add_points/y', 'vaults_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/copy_point/x', 'vaults_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/copy_point/y', 'settlement_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/booleanity_test', 'settlement_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/add_points/slope', 'settlement_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/add_points/x', 'settlement_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/add_points/y', 'settlement_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/copy_point/x', 'settlement_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/copy_point/y', 'settlement_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/booleanity_test', 'settlement_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/add_points/slope', 'settlement_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/add_points/x', 'settlement_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/add_points/y', 'settlement_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/copy_point/x', 'settlement_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/copy_point/y'.
              // numerators[3] = point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              mstore(0x5840,
                     addmod(
                       /*point^(trace_length / 256)*/ mload(0x4ec0),
                       sub(PRIME, /*trace_generator^(255 * trace_length / 256)*/ mload(0x4f80)),
                       PRIME))

              // Numerator for constraints 'vaults_state_transition/merkle_update/prev_authentication/hashes/copy_point/x', 'vaults_state_transition/merkle_update/prev_authentication/hashes/copy_point/y', 'vaults_state_transition/merkle_update/new_authentication/hashes/copy_point/x', 'vaults_state_transition/merkle_update/new_authentication/hashes/copy_point/y', 'settlement_state_transition/merkle_update/prev_authentication/hashes/copy_point/x', 'settlement_state_transition/merkle_update/prev_authentication/hashes/copy_point/y', 'settlement_state_transition/merkle_update/new_authentication/hashes/copy_point/x', 'settlement_state_transition/merkle_update/new_authentication/hashes/copy_point/y'.
              // numerators[4] = point^(trace_length / 512) - trace_generator^(trace_length / 2).
              mstore(0x5860,
                     addmod(
                       /*point^(trace_length / 512)*/ mload(0x4e60),
                       sub(PRIME, /*trace_generator^(trace_length / 2)*/ mload(0x4fc0)),
                       PRIME))

              // Numerator for constraints 'vaults_state_transition/merkle_update/prev_authentication/copy_prev_to_left', 'vaults_state_transition/merkle_update/prev_authentication/copy_prev_to_right', 'vaults_state_transition/merkle_update/new_authentication/copy_prev_to_left', 'vaults_state_transition/merkle_update/new_authentication/copy_prev_to_right'.
              // numerators[5] = (point^(trace_length / 16384) - trace_generator^(31 * trace_length / 32)) * (point^(trace_length / 16384) - trace_generator^(15 * trace_length / 16)).
              mstore(0x5880,
                     mulmod(
                       addmod(
                         /*point^(trace_length / 16384)*/ mload(0x4e80),
                         sub(PRIME, /*trace_generator^(31 * trace_length / 32)*/ mload(0x4fe0)),
                         PRIME),
                       addmod(
                         /*point^(trace_length / 16384)*/ mload(0x4e80),
                         sub(PRIME, /*trace_generator^(15 * trace_length / 16)*/ mload(0x5020)),
                         PRIME),
                       PRIME))

              // Numerator for constraints 'settlement_state_transition/merkle_update/side_bit_extraction/bit', 'settlement_state_transition/merkle_update/same_siblings'.
              // numerators[6] = point^(trace_length / 32768) - trace_generator^(63 * trace_length / 64).
              mstore(0x58a0,
                     addmod(
                       /*point^(trace_length / 32768)*/ mload(0x4f00),
                       sub(PRIME, /*trace_generator^(63 * trace_length / 64)*/ mload(0x4fa0)),
                       PRIME))

              // Numerator for constraints 'settlement_state_transition/merkle_update/prev_authentication/copy_prev_to_left', 'settlement_state_transition/merkle_update/prev_authentication/copy_prev_to_right', 'settlement_state_transition/merkle_update/new_authentication/copy_prev_to_left', 'settlement_state_transition/merkle_update/new_authentication/copy_prev_to_right'.
              // numerators[7] = (point^(trace_length / 32768) - trace_generator^(63 * trace_length / 64)) * (point^(trace_length / 32768) - trace_generator^(31 * trace_length / 32)).
              mstore(0x58c0,
                     mulmod(
                       addmod(
                         /*point^(trace_length / 32768)*/ mload(0x4f00),
                         sub(PRIME, /*trace_generator^(63 * trace_length / 64)*/ mload(0x4fa0)),
                         PRIME),
                       addmod(
                         /*point^(trace_length / 32768)*/ mload(0x4f00),
                         sub(PRIME, /*trace_generator^(31 * trace_length / 32)*/ mload(0x4fe0)),
                         PRIME),
                       PRIME))

              // Numerator for constraints 'amounts_range_check/bit'.
              // numerators[8] = point^(trace_length / 4096) - trace_generator^(63 * trace_length / 64).
              mstore(0x58e0,
                     addmod(
                       /*point^(trace_length / 4096)*/ mload(0x4e40),
                       sub(PRIME, /*trace_generator^(63 * trace_length / 64)*/ mload(0x4fa0)),
                       PRIME))

              // Numerator for constraints 'nonce_range_check/bit'.
              // numerators[9] = point^(trace_length / 32768) - trace_generator^(31 * trace_length / 32).
              mstore(0x5900,
                     addmod(
                       /*point^(trace_length / 32768)*/ mload(0x4f00),
                       sub(PRIME, /*trace_generator^(31 * trace_length / 32)*/ mload(0x4fe0)),
                       PRIME))

              // Numerator for constraints 'sig_verify/doubling_key/slope', 'sig_verify/doubling_key/x', 'sig_verify/doubling_key/y', 'sig_verify/exponentiate_key/booleanity_test', 'sig_verify/exponentiate_key/add_points/slope', 'sig_verify/exponentiate_key/add_points/x', 'sig_verify/exponentiate_key/add_points/y', 'sig_verify/exponentiate_key/add_points/x_diff_inv', 'sig_verify/exponentiate_key/copy_point/x', 'sig_verify/exponentiate_key/copy_point/y'.
              // numerators[10] = point^(trace_length / 16384) - trace_generator^(255 * trace_length / 256).
              mstore(0x5920,
                     addmod(
                       /*point^(trace_length / 16384)*/ mload(0x4e80),
                       sub(PRIME, /*trace_generator^(255 * trace_length / 256)*/ mload(0x4f80)),
                       PRIME))

              // Numerator for constraints 'sig_verify/exponentiate_generator/booleanity_test', 'sig_verify/exponentiate_generator/add_points/slope', 'sig_verify/exponentiate_generator/add_points/x', 'sig_verify/exponentiate_generator/add_points/y', 'sig_verify/exponentiate_generator/add_points/x_diff_inv', 'sig_verify/exponentiate_generator/copy_point/x', 'sig_verify/exponentiate_generator/copy_point/y'.
              // numerators[11] = point^(trace_length / 32768) - trace_generator^(255 * trace_length / 256).
              mstore(0x5940,
                     addmod(
                       /*point^(trace_length / 32768)*/ mload(0x4f00),
                       sub(PRIME, /*trace_generator^(255 * trace_length / 256)*/ mload(0x4f80)),
                       PRIME))

              // Numerator for constraints 'copy_merkle_roots'.
              // numerators[12] = point - trace_generator^(65536 * (trace_length / 65536 - 1) + 49152).
              mstore(0x5960,
                     addmod(
                       point,
                       sub(
                         PRIME,
                         /*trace_generator^(65536 * (trace_length / 65536 - 1) + 49152)*/ mload(0x50a0)),
                       PRIME))

              // Numerator for constraints 'copy_settlement_merkle_roots'.
              // numerators[13] = point - trace_generator^(65536 * (trace_length / 65536 - 1)).
              mstore(0x5980,
                     addmod(
                       point,
                       sub(PRIME, /*trace_generator^(65536 * (trace_length / 65536 - 1))*/ mload(0x50c0)),
                       PRIME))

              // Adjustment polynomial for constraints 'hash_pool/hash/ec_subset_sum/booleanity_test', 'hash_pool/hash/ec_subset_sum/add_points/slope', 'hash_pool/hash/ec_subset_sum/add_points/x', 'hash_pool/hash/ec_subset_sum/add_points/y', 'hash_pool/hash/ec_subset_sum/copy_point/x', 'hash_pool/hash/ec_subset_sum/copy_point/y'.
              // adjustments[0] = point^degreeAdjustment(composition_degree_bound, 2 * (trace_length - 1), trace_length / 1024, trace_length / 4).
              mstore(0x59a0,
                     expmod(point, degreeAdjustment(/*composition_degree_bound*/ mload(0x49a0), mul(2, sub(/*trace_length*/ mload(0x200), 1)), div(/*trace_length*/ mload(0x200), 1024), div(/*trace_length*/ mload(0x200), 4)), PRIME))

              // Adjustment polynomial for constraints 'hash_pool/hash/ec_subset_sum/bit_extraction_end', 'hash_pool/hash/ec_subset_sum/zeros_tail'.
              // adjustments[1] = point^degreeAdjustment(composition_degree_bound, trace_length - 1, 0, trace_length / 1024).
              mstore(0x59c0,
                     expmod(point, degreeAdjustment(/*composition_degree_bound*/ mload(0x49a0), sub(/*trace_length*/ mload(0x200), 1), 0, div(/*trace_length*/ mload(0x200), 1024)), PRIME))

              // Adjustment polynomial for constraints 'hash_pool/hash/copy_point/x', 'hash_pool/hash/copy_point/y'.
              // adjustments[2] = point^degreeAdjustment(composition_degree_bound, trace_length - 1, trace_length / 2048, trace_length / 1024).
              mstore(0x59e0,
                     expmod(point, degreeAdjustment(/*composition_degree_bound*/ mload(0x49a0), sub(/*trace_length*/ mload(0x200), 1), div(/*trace_length*/ mload(0x200), 2048), div(/*trace_length*/ mload(0x200), 1024)), PRIME))

              // Adjustment polynomial for constraints 'hash_pool/hash/init/x', 'hash_pool/hash/init/y'.
              // adjustments[3] = point^degreeAdjustment(composition_degree_bound, trace_length - 1, 0, trace_length / 2048).
              mstore(0x5a00,
                     expmod(point, degreeAdjustment(/*composition_degree_bound*/ mload(0x49a0), sub(/*trace_length*/ mload(0x200), 1), 0, div(/*trace_length*/ mload(0x200), 2048)), PRIME))

              // Adjustment polynomial for constraints 'hash_pool/output_to_input', 'amounts_range_check/zero'.
              // adjustments[4] = point^degreeAdjustment(composition_degree_bound, trace_length - 1, 0, trace_length / 4096).
              mstore(0x5a20,
                     expmod(point, degreeAdjustment(/*composition_degree_bound*/ mload(0x49a0), sub(/*trace_length*/ mload(0x200), 1), 0, div(/*trace_length*/ mload(0x200), 4096)), PRIME))

              // Adjustment polynomial for constraints 'vaults_state_transition/merkle_update/side_bit_extraction/bit', 'vaults_state_transition/merkle_update/same_siblings', 'expiration_timestamp_range_check/bit'.
              // adjustments[5] = point^degreeAdjustment(composition_degree_bound, 2 * (trace_length - 1), trace_length / 16384, trace_length / 512).
              mstore(0x5a40,
                     expmod(point, degreeAdjustment(/*composition_degree_bound*/ mload(0x49a0), mul(2, sub(/*trace_length*/ mload(0x200), 1)), div(/*trace_length*/ mload(0x200), 16384), div(/*trace_length*/ mload(0x200), 512)), PRIME))

              // Adjustment polynomial for constraints 'vaults_state_transition/merkle_update/side_bit_extraction/zero', 'amounts_range_check_inputs', 'expiration_timestamp_range_check/zero', 'sig_verify/exponentiate_key/bit_extraction_end', 'sig_verify/exponentiate_key/zeros_tail', 'sig_verify/init_key/x', 'sig_verify/init_key/y'.
              // adjustments[6] = point^degreeAdjustment(composition_degree_bound, trace_length - 1, 0, trace_length / 16384).
              mstore(0x5a60,
                     expmod(point, degreeAdjustment(/*composition_degree_bound*/ mload(0x49a0), sub(/*trace_length*/ mload(0x200), 1), 0, div(/*trace_length*/ mload(0x200), 16384)), PRIME))

              // Adjustment polynomial for constraints 'vaults_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/booleanity_test', 'vaults_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/add_points/slope', 'vaults_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/add_points/x', 'vaults_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/add_points/y', 'vaults_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/copy_point/x', 'vaults_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/copy_point/y', 'vaults_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/booleanity_test', 'vaults_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/add_points/slope', 'vaults_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/add_points/x', 'vaults_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/add_points/y', 'vaults_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/copy_point/x', 'vaults_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/copy_point/y', 'settlement_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/booleanity_test', 'settlement_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/add_points/slope', 'settlement_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/add_points/x', 'settlement_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/add_points/y', 'settlement_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/copy_point/x', 'settlement_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/copy_point/y', 'settlement_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/booleanity_test', 'settlement_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/add_points/slope', 'settlement_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/add_points/x', 'settlement_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/add_points/y', 'settlement_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/copy_point/x', 'settlement_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/copy_point/y'.
              // adjustments[7] = point^degreeAdjustment(composition_degree_bound, 2 * (trace_length - 1), trace_length / 256, trace_length).
              mstore(0x5a80,
                     expmod(point, degreeAdjustment(/*composition_degree_bound*/ mload(0x49a0), mul(2, sub(/*trace_length*/ mload(0x200), 1)), div(/*trace_length*/ mload(0x200), 256), /*trace_length*/ mload(0x200)), PRIME))

              // Adjustment polynomial for constraints 'vaults_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/bit_extraction_end', 'vaults_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/zeros_tail', 'vaults_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/bit_extraction_end', 'vaults_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/zeros_tail', 'settlement_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/bit_extraction_end', 'settlement_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/zeros_tail', 'settlement_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/bit_extraction_end', 'settlement_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/zeros_tail'.
              // adjustments[8] = point^degreeAdjustment(composition_degree_bound, trace_length - 1, 0, trace_length / 256).
              mstore(0x5aa0,
                     expmod(point, degreeAdjustment(/*composition_degree_bound*/ mload(0x49a0), sub(/*trace_length*/ mload(0x200), 1), 0, div(/*trace_length*/ mload(0x200), 256)), PRIME))

              // Adjustment polynomial for constraints 'vaults_state_transition/merkle_update/prev_authentication/hashes/copy_point/x', 'vaults_state_transition/merkle_update/prev_authentication/hashes/copy_point/y', 'vaults_state_transition/merkle_update/new_authentication/hashes/copy_point/x', 'vaults_state_transition/merkle_update/new_authentication/hashes/copy_point/y', 'settlement_state_transition/merkle_update/prev_authentication/hashes/copy_point/x', 'settlement_state_transition/merkle_update/prev_authentication/hashes/copy_point/y', 'settlement_state_transition/merkle_update/new_authentication/hashes/copy_point/x', 'settlement_state_transition/merkle_update/new_authentication/hashes/copy_point/y'.
              // adjustments[9] = point^degreeAdjustment(composition_degree_bound, trace_length - 1, trace_length / 512, trace_length / 256).
              mstore(0x5ac0,
                     expmod(point, degreeAdjustment(/*composition_degree_bound*/ mload(0x49a0), sub(/*trace_length*/ mload(0x200), 1), div(/*trace_length*/ mload(0x200), 512), div(/*trace_length*/ mload(0x200), 256)), PRIME))

              // Adjustment polynomial for constraints 'vaults_state_transition/merkle_update/prev_authentication/hashes/init/x', 'vaults_state_transition/merkle_update/prev_authentication/hashes/init/y', 'vaults_state_transition/merkle_update/new_authentication/hashes/init/x', 'vaults_state_transition/merkle_update/new_authentication/hashes/init/y', 'settlement_state_transition/merkle_update/prev_authentication/hashes/init/x', 'settlement_state_transition/merkle_update/prev_authentication/hashes/init/y', 'settlement_state_transition/merkle_update/new_authentication/hashes/init/x', 'settlement_state_transition/merkle_update/new_authentication/hashes/init/y'.
              // adjustments[10] = point^degreeAdjustment(composition_degree_bound, trace_length - 1, 0, trace_length / 512).
              mstore(0x5ae0,
                     expmod(point, degreeAdjustment(/*composition_degree_bound*/ mload(0x49a0), sub(/*trace_length*/ mload(0x200), 1), 0, div(/*trace_length*/ mload(0x200), 512)), PRIME))

              // Adjustment polynomial for constraints 'vaults_state_transition/merkle_update/prev_authentication/copy_prev_to_left', 'vaults_state_transition/merkle_update/prev_authentication/copy_prev_to_right', 'vaults_state_transition/merkle_update/new_authentication/copy_prev_to_left', 'vaults_state_transition/merkle_update/new_authentication/copy_prev_to_right'.
              // adjustments[11] = point^degreeAdjustment(composition_degree_bound, 2 * (trace_length - 1), trace_length / 16384 + trace_length / 16384, trace_length / 512).
              mstore(0x5b00,
                     expmod(point, degreeAdjustment(/*composition_degree_bound*/ mload(0x49a0), mul(2, sub(/*trace_length*/ mload(0x200), 1)), add(
                       div(/*trace_length*/ mload(0x200), 16384),
                       div(/*trace_length*/ mload(0x200), 16384)), div(/*trace_length*/ mload(0x200), 512)), PRIME))

              // Adjustment polynomial for constraints 'vaults_state_transition/merkle_set_prev_leaf', 'vaults_state_transition/merkle_set_new_leaf', 'sig_verify/r_and_w_nonzero', 'handle_empty_vault/consistency_key_stage0', 'handle_empty_vault/consistency_token_stage0', 'handle_empty_vault/consistency_key_stage1', 'handle_empty_vault/consistency_token_stage1'.
              // adjustments[12] = point^degreeAdjustment(composition_degree_bound, 2 * (trace_length - 1), 0, trace_length / 16384).
              mstore(0x5b20,
                     expmod(point, degreeAdjustment(/*composition_degree_bound*/ mload(0x49a0), mul(2, sub(/*trace_length*/ mload(0x200), 1)), 0, div(/*trace_length*/ mload(0x200), 16384)), PRIME))

              // Adjustment polynomial for constraints 'modification_boundary_key', 'modification_boundary_token', 'modification_boundary_amount0', 'modification_boundary_amount1', 'modification_boundary_vault_id'.
              // adjustments[13] = point^degreeAdjustment(composition_degree_bound, trace_length + trace_length / 65536 - 2, 0, trace_length / 65536).
              mstore(0x5b40,
                     expmod(point, degreeAdjustment(/*composition_degree_bound*/ mload(0x49a0), sub(add(/*trace_length*/ mload(0x200), div(/*trace_length*/ mload(0x200), 65536)), 2), 0, div(/*trace_length*/ mload(0x200), 65536)), PRIME))

              // Adjustment polynomial for constraints 'settlement_state_transition/merkle_update/side_bit_extraction/bit', 'settlement_state_transition/merkle_update/same_siblings'.
              // adjustments[14] = point^degreeAdjustment(composition_degree_bound, 2 * (trace_length - 1), trace_length / 32768, trace_length / 512).
              mstore(0x5b60,
                     expmod(point, degreeAdjustment(/*composition_degree_bound*/ mload(0x49a0), mul(2, sub(/*trace_length*/ mload(0x200), 1)), div(/*trace_length*/ mload(0x200), 32768), div(/*trace_length*/ mload(0x200), 512)), PRIME))

              // Adjustment polynomial for constraints 'settlement_state_transition/merkle_update/side_bit_extraction/zero', 'expiration_timestamp_range_check_input', 'nonce_range_check/zero', 'sig_verify/exponentiate_generator/bit_extraction_end', 'sig_verify/exponentiate_generator/zeros_tail', 'sig_verify/init_gen/x', 'sig_verify/init_gen/y'.
              // adjustments[15] = point^degreeAdjustment(composition_degree_bound, trace_length - 1, 0, trace_length / 32768).
              mstore(0x5b80,
                     expmod(point, degreeAdjustment(/*composition_degree_bound*/ mload(0x49a0), sub(/*trace_length*/ mload(0x200), 1), 0, div(/*trace_length*/ mload(0x200), 32768)), PRIME))

              // Adjustment polynomial for constraints 'settlement_state_transition/merkle_update/prev_authentication/copy_prev_to_left', 'settlement_state_transition/merkle_update/prev_authentication/copy_prev_to_right', 'settlement_state_transition/merkle_update/new_authentication/copy_prev_to_left', 'settlement_state_transition/merkle_update/new_authentication/copy_prev_to_right'.
              // adjustments[16] = point^degreeAdjustment(composition_degree_bound, 2 * (trace_length - 1), trace_length / 32768 + trace_length / 32768, trace_length / 512).
              mstore(0x5ba0,
                     expmod(point, degreeAdjustment(/*composition_degree_bound*/ mload(0x49a0), mul(2, sub(/*trace_length*/ mload(0x200), 1)), add(
                       div(/*trace_length*/ mload(0x200), 32768),
                       div(/*trace_length*/ mload(0x200), 32768)), div(/*trace_length*/ mload(0x200), 512)), PRIME))

              // Adjustment polynomial for constraints 'settlement_state_transition/merkle_set_prev_leaf', 'settlement_state_transition/merkle_set_new_leaf', 'sig_verify/add_results/slope', 'sig_verify/add_results/x', 'sig_verify/add_results/y', 'sig_verify/add_results/x_diff_inv', 'sig_verify/extract_r/slope', 'sig_verify/extract_r/x', 'sig_verify/extract_r/x_diff_inv', 'sig_verify/z_nonzero', 'sig_verify/q_on_curve/x_squared', 'sig_verify/q_on_curve/on_curve'.
              // adjustments[17] = point^degreeAdjustment(composition_degree_bound, 2 * (trace_length - 1), 0, trace_length / 32768).
              mstore(0x5bc0,
                     expmod(point, degreeAdjustment(/*composition_degree_bound*/ mload(0x49a0), mul(2, sub(/*trace_length*/ mload(0x200), 1)), 0, div(/*trace_length*/ mload(0x200), 32768)), PRIME))

              // Adjustment polynomial for constraints 'settlement_state_transition/set_prev_root', 'settlement_state_transition/root_consistency', 'settlement_state_transition/set_new_root', 'total_token_a_not_changed', 'total_token_b_not_changed', 'party_a_fulfilled_amount', 'party_b_fulfilled_amount', 'amount_a_range_check_input', 'amount_b_range_check_input', 'party_a_sig_input_packed', 'copy_signature_input_party_b', 'message_hash_determines_order_id_party_b', 'handle_empty_vault/consistency_key_change0', 'handle_empty_vault/consistency_token_change0', 'handle_empty_vault/consistency_key_change3', 'handle_empty_vault/consistency_token_change3', 'handle_empty_vault/consistency_key_change1', 'handle_empty_vault/consistency_token_change1', 'handle_empty_vault/consistency_key_change2', 'handle_empty_vault/consistency_token_change2'.
              // adjustments[18] = point^degreeAdjustment(composition_degree_bound, trace_length + n_modifications - 1, 0, trace_length / 65536).
              mstore(0x5be0,
                     expmod(point, degreeAdjustment(/*composition_degree_bound*/ mload(0x49a0), sub(add(/*trace_length*/ mload(0x200), /*n_modifications*/ mload(0x280)), 1), 0, div(/*trace_length*/ mload(0x200), 65536)), PRIME))

              // Adjustment polynomial for constraints 'settlement_state_transition/dont_change_if_modification', 'is_transfer/modification', 'copy_merkle_roots_modification'.
              // adjustments[19] = point^degreeAdjustment(composition_degree_bound, trace_length + n_settlements - 1, 0, trace_length / 65536).
              mstore(0x5c00,
                     expmod(point, degreeAdjustment(/*composition_degree_bound*/ mload(0x49a0), sub(add(/*trace_length*/ mload(0x200), /*n_settlements*/ mload(0x2a0)), 1), 0, div(/*trace_length*/ mload(0x200), 65536)), PRIME))

              // Adjustment polynomial for constraints 'amounts_range_check/bit'.
              // adjustments[20] = point^degreeAdjustment(composition_degree_bound, 2 * (trace_length - 1), trace_length / 4096, trace_length / 64).
              mstore(0x5c20,
                     expmod(point, degreeAdjustment(/*composition_degree_bound*/ mload(0x49a0), mul(2, sub(/*trace_length*/ mload(0x200), 1)), div(/*trace_length*/ mload(0x200), 4096), div(/*trace_length*/ mload(0x200), 64)), PRIME))

              // Adjustment polynomial for constraints 'ratio_party_a', 'ratio_party_b', 'is_transfer/bit', 'transfer/party_a_sold', 'transfer/party_b_buy', 'transfer/party_a_sell', 'transfer/party_b_exact_transferred', 'party_b_sig_input_packed', 'signatures/party_b_hash_sec_msg', 'copy_signature_input_party_a', 'message_hash_determines_order_id_party_a', 'party_a_public_key_copy'.
              // adjustments[21] = point^degreeAdjustment(composition_degree_bound, 2 * (trace_length - 1), 0, trace_length / 65536).
              mstore(0x5c40,
                     expmod(point, degreeAdjustment(/*composition_degree_bound*/ mload(0x49a0), mul(2, sub(/*trace_length*/ mload(0x200), 1)), 0, div(/*trace_length*/ mload(0x200), 65536)), PRIME))

              // Adjustment polynomial for constraints 'capacity_party_a', 'capacity_party_b', 'signatures/copy_token_b'.
              // adjustments[22] = point^degreeAdjustment(composition_degree_bound, trace_length - 1, 0, trace_length / 65536).
              mstore(0x5c60,
                     expmod(point, degreeAdjustment(/*composition_degree_bound*/ mload(0x49a0), sub(/*trace_length*/ mload(0x200), 1), 0, div(/*trace_length*/ mload(0x200), 65536)), PRIME))

              // Adjustment polynomial for constraints 'nonce_range_check/bit'.
              // adjustments[23] = point^degreeAdjustment(composition_degree_bound, 2 * (trace_length - 1), trace_length / 32768, trace_length / 1024).
              mstore(0x5c80,
                     expmod(point, degreeAdjustment(/*composition_degree_bound*/ mload(0x49a0), mul(2, sub(/*trace_length*/ mload(0x200), 1)), div(/*trace_length*/ mload(0x200), 32768), div(/*trace_length*/ mload(0x200), 1024)), PRIME))

              // Adjustment polynomial for constraints 'sig_verify/doubling_key/slope', 'sig_verify/doubling_key/x', 'sig_verify/doubling_key/y', 'sig_verify/exponentiate_key/booleanity_test', 'sig_verify/exponentiate_key/add_points/slope', 'sig_verify/exponentiate_key/add_points/x', 'sig_verify/exponentiate_key/add_points/y', 'sig_verify/exponentiate_key/add_points/x_diff_inv', 'sig_verify/exponentiate_key/copy_point/x', 'sig_verify/exponentiate_key/copy_point/y'.
              // adjustments[24] = point^degreeAdjustment(composition_degree_bound, 2 * (trace_length - 1), trace_length / 16384, trace_length / 64).
              mstore(0x5ca0,
                     expmod(point, degreeAdjustment(/*composition_degree_bound*/ mload(0x49a0), mul(2, sub(/*trace_length*/ mload(0x200), 1)), div(/*trace_length*/ mload(0x200), 16384), div(/*trace_length*/ mload(0x200), 64)), PRIME))

              // Adjustment polynomial for constraints 'sig_verify/exponentiate_generator/booleanity_test', 'sig_verify/exponentiate_generator/add_points/slope', 'sig_verify/exponentiate_generator/add_points/x', 'sig_verify/exponentiate_generator/add_points/y', 'sig_verify/exponentiate_generator/add_points/x_diff_inv', 'sig_verify/exponentiate_generator/copy_point/x', 'sig_verify/exponentiate_generator/copy_point/y'.
              // adjustments[25] = point^degreeAdjustment(composition_degree_bound, 2 * (trace_length - 1), trace_length / 32768, trace_length / 128).
              mstore(0x5cc0,
                     expmod(point, degreeAdjustment(/*composition_degree_bound*/ mload(0x49a0), mul(2, sub(/*trace_length*/ mload(0x200), 1)), div(/*trace_length*/ mload(0x200), 32768), div(/*trace_length*/ mload(0x200), 128)), PRIME))

              // Adjustment polynomial for constraints 'handle_empty_vault/vault_empty/empty_vault_booleanity', 'handle_empty_vault/vault_empty/amount_zero_when_empty', 'handle_empty_vault/vault_empty/amount_inv_zero_when_empty', 'handle_empty_vault/vault_empty/empty_when_amount_zero'.
              // adjustments[26] = point^degreeAdjustment(composition_degree_bound, 2 * (trace_length - 1), 0, trace_length / 8192).
              mstore(0x5ce0,
                     expmod(point, degreeAdjustment(/*composition_degree_bound*/ mload(0x49a0), mul(2, sub(/*trace_length*/ mload(0x200), 1)), 0, div(/*trace_length*/ mload(0x200), 8192)), PRIME))

              // Adjustment polynomial for constraints 'initial_vaults_root', 'initial_settlement_root', 'final_vaults_root', 'final_settlement_root'.
              // adjustments[27] = point^degreeAdjustment(composition_degree_bound, trace_length - 1, 0, 1).
              mstore(0x5d00,
                     expmod(point, degreeAdjustment(/*composition_degree_bound*/ mload(0x49a0), sub(/*trace_length*/ mload(0x200), 1), 0, 1), PRIME))

              // Adjustment polynomial for constraints 'copy_merkle_roots'.
              // adjustments[28] = point^degreeAdjustment(composition_degree_bound, trace_length - 1, 1, trace_length / 16384).
              mstore(0x5d20,
                     expmod(point, degreeAdjustment(/*composition_degree_bound*/ mload(0x49a0), sub(/*trace_length*/ mload(0x200), 1), 1, div(/*trace_length*/ mload(0x200), 16384)), PRIME))

              // Adjustment polynomial for constraints 'copy_settlement_merkle_roots'.
              // adjustments[29] = point^degreeAdjustment(composition_degree_bound, trace_length - 1, 1, trace_length / 65536).
              mstore(0x5d40,
                     expmod(point, degreeAdjustment(/*composition_degree_bound*/ mload(0x49a0), sub(/*trace_length*/ mload(0x200), 1), 1, div(/*trace_length*/ mload(0x200), 65536)), PRIME))

            }

            {
              // Compute the result of the composition polynomial.

              {
              // hash_pool/hash/ec_subset_sum/bit = column16_row3 - (column16_row7 + column16_row7).
              let val := addmod(
                /*column16_row3*/ mload(0x3dc0),
                sub(
                  PRIME,
                  addmod(/*column16_row7*/ mload(0x3e20), /*column16_row7*/ mload(0x3e20), PRIME)),
                PRIME)
              mstore(0x49c0, val)
              }


              {
              // hash_pool/hash/ec_subset_sum/bit_neg = 1 - hash_pool__hash__ec_subset_sum__bit.
              let val := addmod(
                1,
                sub(PRIME, /*intermediate_value/hash_pool/hash/ec_subset_sum/bit*/ mload(0x49c0)),
                PRIME)
              mstore(0x49e0, val)
              }


              {
              // vaults_state_transition/merkle_update/side_bit_extraction/bit_0 = column14_row255 - (column14_row767 + column14_row767).
              let val := addmod(
                /*column14_row255*/ mload(0x3b80),
                sub(
                  PRIME,
                  addmod(/*column14_row767*/ mload(0x3bc0), /*column14_row767*/ mload(0x3bc0), PRIME)),
                PRIME)
              mstore(0x4a00, val)
              }


              {
              // vaults_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/bit = column3_row0 - (column3_row1 + column3_row1).
              let val := addmod(
                /*column3_row0*/ mload(0x3300),
                sub(
                  PRIME,
                  addmod(/*column3_row1*/ mload(0x3320), /*column3_row1*/ mload(0x3320), PRIME)),
                PRIME)
              mstore(0x4a20, val)
              }


              {
              // vaults_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/bit_neg = 1 - vaults_state_transition__merkle_update__prev_authentication__hashes__ec_subset_sum__bit.
              let val := addmod(
                1,
                sub(
                  PRIME,
                  /*intermediate_value/vaults_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/bit*/ mload(0x4a20)),
                PRIME)
              mstore(0x4a40, val)
              }


              {
              // vaults_state_transition/merkle_update/side_bit_extraction/bit_1 = column14_row767 - (column14_row1279 + column14_row1279).
              let val := addmod(
                /*column14_row767*/ mload(0x3bc0),
                sub(
                  PRIME,
                  addmod(/*column14_row1279*/ mload(0x3c00), /*column14_row1279*/ mload(0x3c00), PRIME)),
                PRIME)
              mstore(0x4a60, val)
              }


              {
              // vaults_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/bit = column7_row0 - (column7_row1 + column7_row1).
              let val := addmod(
                /*column7_row0*/ mload(0x3520),
                sub(
                  PRIME,
                  addmod(/*column7_row1*/ mload(0x3540), /*column7_row1*/ mload(0x3540), PRIME)),
                PRIME)
              mstore(0x4a80, val)
              }


              {
              // vaults_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/bit_neg = 1 - vaults_state_transition__merkle_update__new_authentication__hashes__ec_subset_sum__bit.
              let val := addmod(
                1,
                sub(
                  PRIME,
                  /*intermediate_value/vaults_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/bit*/ mload(0x4a80)),
                PRIME)
              mstore(0x4aa0, val)
              }


              {
              // vaults_state_transition/merkle_update/prev_authentication/sibling_0 = vaults_state_transition__merkle_update__side_bit_extraction__bit_0 * column3_row0 + (1 - vaults_state_transition__merkle_update__side_bit_extraction__bit_0) * column3_row256.
              let val := addmod(
                mulmod(
                  /*intermediate_value/vaults_state_transition/merkle_update/side_bit_extraction/bit_0*/ mload(0x4a00),
                  /*column3_row0*/ mload(0x3300),
                  PRIME),
                mulmod(
                  addmod(
                    1,
                    sub(
                      PRIME,
                      /*intermediate_value/vaults_state_transition/merkle_update/side_bit_extraction/bit_0*/ mload(0x4a00)),
                    PRIME),
                  /*column3_row256*/ mload(0x3340),
                  PRIME),
                PRIME)
              mstore(0x4ac0, val)
              }


              {
              // vaults_state_transition/merkle_update/new_authentication/sibling_0 = vaults_state_transition__merkle_update__side_bit_extraction__bit_0 * column7_row0 + (1 - vaults_state_transition__merkle_update__side_bit_extraction__bit_0) * column7_row256.
              let val := addmod(
                mulmod(
                  /*intermediate_value/vaults_state_transition/merkle_update/side_bit_extraction/bit_0*/ mload(0x4a00),
                  /*column7_row0*/ mload(0x3520),
                  PRIME),
                mulmod(
                  addmod(
                    1,
                    sub(
                      PRIME,
                      /*intermediate_value/vaults_state_transition/merkle_update/side_bit_extraction/bit_0*/ mload(0x4a00)),
                    PRIME),
                  /*column7_row256*/ mload(0x3560),
                  PRIME),
                PRIME)
              mstore(0x4ae0, val)
              }


              {
              // vaults_state_transition/merkle_update/prev_authentication/leaf_0 = (1 - vaults_state_transition__merkle_update__side_bit_extraction__bit_0) * column3_row0 + vaults_state_transition__merkle_update__side_bit_extraction__bit_0 * column3_row256.
              let val := addmod(
                mulmod(
                  addmod(
                    1,
                    sub(
                      PRIME,
                      /*intermediate_value/vaults_state_transition/merkle_update/side_bit_extraction/bit_0*/ mload(0x4a00)),
                    PRIME),
                  /*column3_row0*/ mload(0x3300),
                  PRIME),
                mulmod(
                  /*intermediate_value/vaults_state_transition/merkle_update/side_bit_extraction/bit_0*/ mload(0x4a00),
                  /*column3_row256*/ mload(0x3340),
                  PRIME),
                PRIME)
              mstore(0x4b00, val)
              }


              {
              // vaults_state_transition/merkle_update/new_authentication/leaf_0 = (1 - vaults_state_transition__merkle_update__side_bit_extraction__bit_0) * column7_row0 + vaults_state_transition__merkle_update__side_bit_extraction__bit_0 * column7_row256.
              let val := addmod(
                mulmod(
                  addmod(
                    1,
                    sub(
                      PRIME,
                      /*intermediate_value/vaults_state_transition/merkle_update/side_bit_extraction/bit_0*/ mload(0x4a00)),
                    PRIME),
                  /*column7_row0*/ mload(0x3520),
                  PRIME),
                mulmod(
                  /*intermediate_value/vaults_state_transition/merkle_update/side_bit_extraction/bit_0*/ mload(0x4a00),
                  /*column7_row256*/ mload(0x3560),
                  PRIME),
                PRIME)
              mstore(0x4b20, val)
              }


              {
              // settlement_state_transition/merkle_update/side_bit_extraction/bit_0 = column14_row511 - (column14_row1023 + column14_row1023).
              let val := addmod(
                /*column14_row511*/ mload(0x3ba0),
                sub(
                  PRIME,
                  addmod(/*column14_row1023*/ mload(0x3be0), /*column14_row1023*/ mload(0x3be0), PRIME)),
                PRIME)
              mstore(0x4b40, val)
              }


              {
              // settlement_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/bit = column11_row0 - (column11_row1 + column11_row1).
              let val := addmod(
                /*column11_row0*/ mload(0x3960),
                sub(
                  PRIME,
                  addmod(/*column11_row1*/ mload(0x3980), /*column11_row1*/ mload(0x3980), PRIME)),
                PRIME)
              mstore(0x4b60, val)
              }


              {
              // settlement_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/bit_neg = 1 - settlement_state_transition__merkle_update__prev_authentication__hashes__ec_subset_sum__bit.
              let val := addmod(
                1,
                sub(
                  PRIME,
                  /*intermediate_value/settlement_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/bit*/ mload(0x4b60)),
                PRIME)
              mstore(0x4b80, val)
              }


              {
              // settlement_state_transition/merkle_update/side_bit_extraction/bit_1 = column14_row1023 - (column14_row1535 + column14_row1535).
              let val := addmod(
                /*column14_row1023*/ mload(0x3be0),
                sub(
                  PRIME,
                  addmod(/*column14_row1535*/ mload(0x3c20), /*column14_row1535*/ mload(0x3c20), PRIME)),
                PRIME)
              mstore(0x4ba0, val)
              }


              {
              // settlement_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/bit = column15_row0 - (column15_row1 + column15_row1).
              let val := addmod(
                /*column15_row0*/ mload(0x3cc0),
                sub(
                  PRIME,
                  addmod(/*column15_row1*/ mload(0x3ce0), /*column15_row1*/ mload(0x3ce0), PRIME)),
                PRIME)
              mstore(0x4bc0, val)
              }


              {
              // settlement_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/bit_neg = 1 - settlement_state_transition__merkle_update__new_authentication__hashes__ec_subset_sum__bit.
              let val := addmod(
                1,
                sub(
                  PRIME,
                  /*intermediate_value/settlement_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/bit*/ mload(0x4bc0)),
                PRIME)
              mstore(0x4be0, val)
              }


              {
              // settlement_state_transition/merkle_update/prev_authentication/sibling_0 = settlement_state_transition__merkle_update__side_bit_extraction__bit_0 * column11_row0 + (1 - settlement_state_transition__merkle_update__side_bit_extraction__bit_0) * column11_row256.
              let val := addmod(
                mulmod(
                  /*intermediate_value/settlement_state_transition/merkle_update/side_bit_extraction/bit_0*/ mload(0x4b40),
                  /*column11_row0*/ mload(0x3960),
                  PRIME),
                mulmod(
                  addmod(
                    1,
                    sub(
                      PRIME,
                      /*intermediate_value/settlement_state_transition/merkle_update/side_bit_extraction/bit_0*/ mload(0x4b40)),
                    PRIME),
                  /*column11_row256*/ mload(0x39a0),
                  PRIME),
                PRIME)
              mstore(0x4c00, val)
              }


              {
              // settlement_state_transition/merkle_update/new_authentication/sibling_0 = settlement_state_transition__merkle_update__side_bit_extraction__bit_0 * column15_row0 + (1 - settlement_state_transition__merkle_update__side_bit_extraction__bit_0) * column15_row256.
              let val := addmod(
                mulmod(
                  /*intermediate_value/settlement_state_transition/merkle_update/side_bit_extraction/bit_0*/ mload(0x4b40),
                  /*column15_row0*/ mload(0x3cc0),
                  PRIME),
                mulmod(
                  addmod(
                    1,
                    sub(
                      PRIME,
                      /*intermediate_value/settlement_state_transition/merkle_update/side_bit_extraction/bit_0*/ mload(0x4b40)),
                    PRIME),
                  /*column15_row256*/ mload(0x3d00),
                  PRIME),
                PRIME)
              mstore(0x4c20, val)
              }


              {
              // settlement_state_transition/merkle_update/prev_authentication/leaf_0 = (1 - settlement_state_transition__merkle_update__side_bit_extraction__bit_0) * column11_row0 + settlement_state_transition__merkle_update__side_bit_extraction__bit_0 * column11_row256.
              let val := addmod(
                mulmod(
                  addmod(
                    1,
                    sub(
                      PRIME,
                      /*intermediate_value/settlement_state_transition/merkle_update/side_bit_extraction/bit_0*/ mload(0x4b40)),
                    PRIME),
                  /*column11_row0*/ mload(0x3960),
                  PRIME),
                mulmod(
                  /*intermediate_value/settlement_state_transition/merkle_update/side_bit_extraction/bit_0*/ mload(0x4b40),
                  /*column11_row256*/ mload(0x39a0),
                  PRIME),
                PRIME)
              mstore(0x4c40, val)
              }


              {
              // settlement_state_transition/merkle_update/new_authentication/leaf_0 = (1 - settlement_state_transition__merkle_update__side_bit_extraction__bit_0) * column15_row0 + settlement_state_transition__merkle_update__side_bit_extraction__bit_0 * column15_row256.
              let val := addmod(
                mulmod(
                  addmod(
                    1,
                    sub(
                      PRIME,
                      /*intermediate_value/settlement_state_transition/merkle_update/side_bit_extraction/bit_0*/ mload(0x4b40)),
                    PRIME),
                  /*column15_row0*/ mload(0x3cc0),
                  PRIME),
                mulmod(
                  /*intermediate_value/settlement_state_transition/merkle_update/side_bit_extraction/bit_0*/ mload(0x4b40),
                  /*column15_row256*/ mload(0x3d00),
                  PRIME),
                PRIME)
              mstore(0x4c60, val)
              }


              {
              // amounts_range_check/bit_0 = column17_row0 - (column17_row64 + column17_row64).
              let val := addmod(
                /*column17_row0*/ mload(0x4200),
                sub(
                  PRIME,
                  addmod(/*column17_row64*/ mload(0x4380), /*column17_row64*/ mload(0x4380), PRIME)),
                PRIME)
              mstore(0x4c80, val)
              }


              {
              // expiration_timestamp_range_check/bit_0 = column10_row255 - (column10_row767 + column10_row767).
              let val := addmod(
                /*column10_row255*/ mload(0x3740),
                sub(
                  PRIME,
                  addmod(/*column10_row767*/ mload(0x3780), /*column10_row767*/ mload(0x3780), PRIME)),
                PRIME)
              mstore(0x4ca0, val)
              }


              {
              // nonce_range_check/bit_0 = column16_row1021 - (column16_row2045 + column16_row2045).
              let val := addmod(
                /*column16_row1021*/ mload(0x3e60),
                sub(
                  PRIME,
                  addmod(/*column16_row2045*/ mload(0x3f20), /*column16_row2045*/ mload(0x3f20), PRIME)),
                PRIME)
              mstore(0x4cc0, val)
              }


              {
              // sig_verify/doubling_key/x_squared = column17_row32 * column17_row32.
              let val := mulmod(/*column17_row32*/ mload(0x42c0), /*column17_row32*/ mload(0x42c0), PRIME)
              mstore(0x4ce0, val)
              }


              {
              // sig_verify/exponentiate_generator/bit = column17_row84 - (column17_row212 + column17_row212).
              let val := addmod(
                /*column17_row84*/ mload(0x43e0),
                sub(
                  PRIME,
                  addmod(/*column17_row212*/ mload(0x44a0), /*column17_row212*/ mload(0x44a0), PRIME)),
                PRIME)
              mstore(0x4d00, val)
              }


              {
              // sig_verify/exponentiate_generator/bit_neg = 1 - sig_verify__exponentiate_generator__bit.
              let val := addmod(
                1,
                sub(PRIME, /*intermediate_value/sig_verify/exponentiate_generator/bit*/ mload(0x4d00)),
                PRIME)
              mstore(0x4d20, val)
              }


              {
              // sig_verify/exponentiate_key/bit = column17_row56 - (column17_row120 + column17_row120).
              let val := addmod(
                /*column17_row56*/ mload(0x4360),
                sub(
                  PRIME,
                  addmod(/*column17_row120*/ mload(0x4460), /*column17_row120*/ mload(0x4460), PRIME)),
                PRIME)
              mstore(0x4d40, val)
              }


              {
              // sig_verify/exponentiate_key/bit_neg = 1 - sig_verify__exponentiate_key__bit.
              let val := addmod(
                1,
                sub(PRIME, /*intermediate_value/sig_verify/exponentiate_key/bit*/ mload(0x4d40)),
                PRIME)
              mstore(0x4d60, val)
              }


              {
              // party_a_packed_msg/partial = ((column14_row255 * vault_shift + column14_row49407) * amount_shift + column17_row4096) * amount_shift + column17_row36864.
              let val := addmod(
                mulmod(
                  addmod(
                    mulmod(
                      addmod(
                        mulmod(/*column14_row255*/ mload(0x3b80), /*vault_shift*/ mload(0x340), PRIME),
                        /*column14_row49407*/ mload(0x3ca0),
                        PRIME),
                      /*amount_shift*/ mload(0x2c0),
                      PRIME),
                    /*column17_row4096*/ mload(0x44e0),
                    PRIME),
                  /*amount_shift*/ mload(0x2c0),
                  PRIME),
                /*column17_row36864*/ mload(0x4800),
                PRIME)
              mstore(0x4d80, val)
              }


              {
              // party_b_packed_msg/partial = ((column14_row33023 * vault_shift + column14_row16639) * amount_shift + column17_row53248) * amount_shift + column17_row20480.
              let val := addmod(
                mulmod(
                  addmod(
                    mulmod(
                      addmod(
                        mulmod(/*column14_row33023*/ mload(0x3c60), /*vault_shift*/ mload(0x340), PRIME),
                        /*column14_row16639*/ mload(0x3c40),
                        PRIME),
                      /*amount_shift*/ mload(0x2c0),
                      PRIME),
                    /*column17_row53248*/ mload(0x48c0),
                    PRIME),
                  /*amount_shift*/ mload(0x2c0),
                  PRIME),
                /*column17_row20480*/ mload(0x4620),
                PRIME)
              mstore(0x4da0, val)
              }


              {
              // party_b_packed_msg_transfer/partial = (((vault_shift + column14_row33023) * vault_shift + column14_row49407) * amount_shift + column17_row53248) * amount_shift + column17_row20480.
              let val := addmod(
                mulmod(
                  addmod(
                    mulmod(
                      addmod(
                        mulmod(
                          addmod(/*vault_shift*/ mload(0x340), /*column14_row33023*/ mload(0x3c60), PRIME),
                          /*vault_shift*/ mload(0x340),
                          PRIME),
                        /*column14_row49407*/ mload(0x3ca0),
                        PRIME),
                      /*amount_shift*/ mload(0x2c0),
                      PRIME),
                    /*column17_row53248*/ mload(0x48c0),
                    PRIME),
                  /*amount_shift*/ mload(0x2c0),
                  PRIME),
                /*column17_row20480*/ mload(0x4620),
                PRIME)
              mstore(0x4dc0, val)
              }


              {
              // Constraint expression for hash_pool/hash/ec_subset_sum/booleanity_test: hash_pool__hash__ec_subset_sum__bit * (hash_pool__hash__ec_subset_sum__bit - 1).
              let val := mulmod(
                /*intermediate_value/hash_pool/hash/ec_subset_sum/bit*/ mload(0x49c0),
                addmod(
                  /*intermediate_value/hash_pool/hash/ec_subset_sum/bit*/ mload(0x49c0),
                  sub(PRIME, 1),
                  PRIME),
                PRIME)

              // Numerator: point^(trace_length / 1024) - trace_generator^(255 * trace_length / 256).
              // val *= numerators[0].
              val := mulmod(val, mload(0x57e0), PRIME)
              // Denominator: point^(trace_length / 4) - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, mload(0x50e0), PRIME)

              // res += val * (coefficients[0] + coefficients[1] * adjustments[0]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[0]*/ mload(0x480),
                                       mulmod(/*coefficients[1]*/ mload(0x4a0),
                                              /*adjustments[0]*/mload(0x59a0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for hash_pool/hash/ec_subset_sum/bit_extraction_end: column16_row3.
              let val := /*column16_row3*/ mload(0x3dc0)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 1024) - trace_generator^(63 * trace_length / 64).
              // val *= denominator_invs[1].
              val := mulmod(val, mload(0x5100), PRIME)

              // res += val * (coefficients[2] + coefficients[3] * adjustments[1]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[2]*/ mload(0x4c0),
                                       mulmod(/*coefficients[3]*/ mload(0x4e0),
                                              /*adjustments[1]*/mload(0x59c0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for hash_pool/hash/ec_subset_sum/zeros_tail: column16_row3.
              let val := /*column16_row3*/ mload(0x3dc0)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 1024) - trace_generator^(255 * trace_length / 256).
              // val *= denominator_invs[2].
              val := mulmod(val, mload(0x5120), PRIME)

              // res += val * (coefficients[4] + coefficients[5] * adjustments[1]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[4]*/ mload(0x500),
                                       mulmod(/*coefficients[5]*/ mload(0x520),
                                              /*adjustments[1]*/mload(0x59c0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for hash_pool/hash/ec_subset_sum/add_points/slope: hash_pool__hash__ec_subset_sum__bit * (column16_row2 - hash_pool_points__y) - column16_row1 * (column16_row0 - hash_pool_points__x).
              let val := addmod(
                mulmod(
                  /*intermediate_value/hash_pool/hash/ec_subset_sum/bit*/ mload(0x49c0),
                  addmod(
                    /*column16_row2*/ mload(0x3da0),
                    sub(PRIME, /*periodic_column/hash_pool_points/y*/ mload(0x20)),
                    PRIME),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*column16_row1*/ mload(0x3d80),
                    addmod(
                      /*column16_row0*/ mload(0x3d60),
                      sub(PRIME, /*periodic_column/hash_pool_points/x*/ mload(0x0)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 1024) - trace_generator^(255 * trace_length / 256).
              // val *= numerators[0].
              val := mulmod(val, mload(0x57e0), PRIME)
              // Denominator: point^(trace_length / 4) - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, mload(0x50e0), PRIME)

              // res += val * (coefficients[6] + coefficients[7] * adjustments[0]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[6]*/ mload(0x540),
                                       mulmod(/*coefficients[7]*/ mload(0x560),
                                              /*adjustments[0]*/mload(0x59a0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for hash_pool/hash/ec_subset_sum/add_points/x: column16_row1 * column16_row1 - hash_pool__hash__ec_subset_sum__bit * (column16_row0 + hash_pool_points__x + column16_row4).
              let val := addmod(
                mulmod(/*column16_row1*/ mload(0x3d80), /*column16_row1*/ mload(0x3d80), PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*intermediate_value/hash_pool/hash/ec_subset_sum/bit*/ mload(0x49c0),
                    addmod(
                      addmod(
                        /*column16_row0*/ mload(0x3d60),
                        /*periodic_column/hash_pool_points/x*/ mload(0x0),
                        PRIME),
                      /*column16_row4*/ mload(0x3de0),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 1024) - trace_generator^(255 * trace_length / 256).
              // val *= numerators[0].
              val := mulmod(val, mload(0x57e0), PRIME)
              // Denominator: point^(trace_length / 4) - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, mload(0x50e0), PRIME)

              // res += val * (coefficients[8] + coefficients[9] * adjustments[0]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[8]*/ mload(0x580),
                                       mulmod(/*coefficients[9]*/ mload(0x5a0),
                                              /*adjustments[0]*/mload(0x59a0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for hash_pool/hash/ec_subset_sum/add_points/y: hash_pool__hash__ec_subset_sum__bit * (column16_row2 + column16_row6) - column16_row1 * (column16_row0 - column16_row4).
              let val := addmod(
                mulmod(
                  /*intermediate_value/hash_pool/hash/ec_subset_sum/bit*/ mload(0x49c0),
                  addmod(/*column16_row2*/ mload(0x3da0), /*column16_row6*/ mload(0x3e00), PRIME),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*column16_row1*/ mload(0x3d80),
                    addmod(/*column16_row0*/ mload(0x3d60), sub(PRIME, /*column16_row4*/ mload(0x3de0)), PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 1024) - trace_generator^(255 * trace_length / 256).
              // val *= numerators[0].
              val := mulmod(val, mload(0x57e0), PRIME)
              // Denominator: point^(trace_length / 4) - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, mload(0x50e0), PRIME)

              // res += val * (coefficients[10] + coefficients[11] * adjustments[0]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[10]*/ mload(0x5c0),
                                       mulmod(/*coefficients[11]*/ mload(0x5e0),
                                              /*adjustments[0]*/mload(0x59a0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for hash_pool/hash/ec_subset_sum/copy_point/x: hash_pool__hash__ec_subset_sum__bit_neg * (column16_row4 - column16_row0).
              let val := mulmod(
                /*intermediate_value/hash_pool/hash/ec_subset_sum/bit_neg*/ mload(0x49e0),
                addmod(/*column16_row4*/ mload(0x3de0), sub(PRIME, /*column16_row0*/ mload(0x3d60)), PRIME),
                PRIME)

              // Numerator: point^(trace_length / 1024) - trace_generator^(255 * trace_length / 256).
              // val *= numerators[0].
              val := mulmod(val, mload(0x57e0), PRIME)
              // Denominator: point^(trace_length / 4) - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, mload(0x50e0), PRIME)

              // res += val * (coefficients[12] + coefficients[13] * adjustments[0]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[12]*/ mload(0x600),
                                       mulmod(/*coefficients[13]*/ mload(0x620),
                                              /*adjustments[0]*/mload(0x59a0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for hash_pool/hash/ec_subset_sum/copy_point/y: hash_pool__hash__ec_subset_sum__bit_neg * (column16_row6 - column16_row2).
              let val := mulmod(
                /*intermediate_value/hash_pool/hash/ec_subset_sum/bit_neg*/ mload(0x49e0),
                addmod(/*column16_row6*/ mload(0x3e00), sub(PRIME, /*column16_row2*/ mload(0x3da0)), PRIME),
                PRIME)

              // Numerator: point^(trace_length / 1024) - trace_generator^(255 * trace_length / 256).
              // val *= numerators[0].
              val := mulmod(val, mload(0x57e0), PRIME)
              // Denominator: point^(trace_length / 4) - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, mload(0x50e0), PRIME)

              // res += val * (coefficients[14] + coefficients[15] * adjustments[0]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[14]*/ mload(0x640),
                                       mulmod(/*coefficients[15]*/ mload(0x660),
                                              /*adjustments[0]*/mload(0x59a0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for hash_pool/hash/copy_point/x: column16_row1024 - column16_row1020.
              let val := addmod(
                /*column16_row1024*/ mload(0x3ea0),
                sub(PRIME, /*column16_row1020*/ mload(0x3e40)),
                PRIME)

              // Numerator: point^(trace_length / 2048) - trace_generator^(trace_length / 2).
              // val *= numerators[1].
              val := mulmod(val, mload(0x5800), PRIME)
              // Denominator: point^(trace_length / 1024) - 1.
              // val *= denominator_invs[3].
              val := mulmod(val, mload(0x5140), PRIME)

              // res += val * (coefficients[16] + coefficients[17] * adjustments[2]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[16]*/ mload(0x680),
                                       mulmod(/*coefficients[17]*/ mload(0x6a0),
                                              /*adjustments[2]*/mload(0x59e0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for hash_pool/hash/copy_point/y: column16_row1026 - column16_row1022.
              let val := addmod(
                /*column16_row1026*/ mload(0x3ec0),
                sub(PRIME, /*column16_row1022*/ mload(0x3e80)),
                PRIME)

              // Numerator: point^(trace_length / 2048) - trace_generator^(trace_length / 2).
              // val *= numerators[1].
              val := mulmod(val, mload(0x5800), PRIME)
              // Denominator: point^(trace_length / 1024) - 1.
              // val *= denominator_invs[3].
              val := mulmod(val, mload(0x5140), PRIME)

              // res += val * (coefficients[18] + coefficients[19] * adjustments[2]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[18]*/ mload(0x6c0),
                                       mulmod(/*coefficients[19]*/ mload(0x6e0),
                                              /*adjustments[2]*/mload(0x59e0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for hash_pool/hash/init/x: column16_row0 - shift_point.x.
              let val := addmod(/*column16_row0*/ mload(0x3d60), sub(PRIME, /*shift_point.x*/ mload(0x220)), PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 2048) - 1.
              // val *= denominator_invs[4].
              val := mulmod(val, mload(0x5160), PRIME)

              // res += val * (coefficients[20] + coefficients[21] * adjustments[3]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[20]*/ mload(0x700),
                                       mulmod(/*coefficients[21]*/ mload(0x720),
                                              /*adjustments[3]*/mload(0x5a00),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for hash_pool/hash/init/y: column16_row2 - shift_point.y.
              let val := addmod(/*column16_row2*/ mload(0x3da0), sub(PRIME, /*shift_point.y*/ mload(0x240)), PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 2048) - 1.
              // val *= denominator_invs[4].
              val := mulmod(val, mload(0x5160), PRIME)

              // res += val * (coefficients[22] + coefficients[23] * adjustments[3]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[22]*/ mload(0x740),
                                       mulmod(/*coefficients[23]*/ mload(0x760),
                                              /*adjustments[3]*/mload(0x5a00),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for hash_pool/output_to_input: column16_row2044 - column16_row2051.
              let val := addmod(
                /*column16_row2044*/ mload(0x3f00),
                sub(PRIME, /*column16_row2051*/ mload(0x3f40)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 4096) - 1.
              // val *= denominator_invs[5].
              val := mulmod(val, mload(0x5180), PRIME)

              // res += val * (coefficients[24] + coefficients[25] * adjustments[4]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[24]*/ mload(0x780),
                                       mulmod(/*coefficients[25]*/ mload(0x7a0),
                                              /*adjustments[4]*/mload(0x5a20),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for vaults_state_transition/merkle_update/side_bit_extraction/bit: vaults_state_transition__merkle_update__side_bit_extraction__bit_0 * vaults_state_transition__merkle_update__side_bit_extraction__bit_0 - vaults_state_transition__merkle_update__side_bit_extraction__bit_0.
              let val := addmod(
                mulmod(
                  /*intermediate_value/vaults_state_transition/merkle_update/side_bit_extraction/bit_0*/ mload(0x4a00),
                  /*intermediate_value/vaults_state_transition/merkle_update/side_bit_extraction/bit_0*/ mload(0x4a00),
                  PRIME),
                sub(
                  PRIME,
                  /*intermediate_value/vaults_state_transition/merkle_update/side_bit_extraction/bit_0*/ mload(0x4a00)),
                PRIME)

              // Numerator: point^(trace_length / 16384) - trace_generator^(31 * trace_length / 32).
              // val *= numerators[2].
              val := mulmod(val, mload(0x5820), PRIME)
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[6].
              val := mulmod(val, mload(0x51a0), PRIME)

              // res += val * (coefficients[26] + coefficients[27] * adjustments[5]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[26]*/ mload(0x7c0),
                                       mulmod(/*coefficients[27]*/ mload(0x7e0),
                                              /*adjustments[5]*/mload(0x5a40),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for vaults_state_transition/merkle_update/side_bit_extraction/zero: column14_row255.
              let val := /*column14_row255*/ mload(0x3b80)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 16384) - trace_generator^(vaults_path_length * trace_length / 32).
              // val *= denominator_invs[7].
              val := mulmod(val, mload(0x51c0), PRIME)

              // res += val * (coefficients[28] + coefficients[29] * adjustments[6]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[28]*/ mload(0x800),
                                       mulmod(/*coefficients[29]*/ mload(0x820),
                                              /*adjustments[6]*/mload(0x5a60),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for vaults_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/booleanity_test: vaults_state_transition__merkle_update__prev_authentication__hashes__ec_subset_sum__bit * (vaults_state_transition__merkle_update__prev_authentication__hashes__ec_subset_sum__bit - 1).
              let val := mulmod(
                /*intermediate_value/vaults_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/bit*/ mload(0x4a20),
                addmod(
                  /*intermediate_value/vaults_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/bit*/ mload(0x4a20),
                  sub(PRIME, 1),
                  PRIME),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= numerators[3].
              val := mulmod(val, mload(0x5840), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[8].
              val := mulmod(val, mload(0x51e0), PRIME)

              // res += val * (coefficients[30] + coefficients[31] * adjustments[7]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[30]*/ mload(0x840),
                                       mulmod(/*coefficients[31]*/ mload(0x860),
                                              /*adjustments[7]*/mload(0x5a80),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for vaults_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/bit_extraction_end: column3_row0.
              let val := /*column3_row0*/ mload(0x3300)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 256) - trace_generator^(63 * trace_length / 64).
              // val *= denominator_invs[9].
              val := mulmod(val, mload(0x5200), PRIME)

              // res += val * (coefficients[32] + coefficients[33] * adjustments[8]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[32]*/ mload(0x880),
                                       mulmod(/*coefficients[33]*/ mload(0x8a0),
                                              /*adjustments[8]*/mload(0x5aa0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for vaults_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/zeros_tail: column3_row0.
              let val := /*column3_row0*/ mload(0x3300)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= denominator_invs[10].
              val := mulmod(val, mload(0x5220), PRIME)

              // res += val * (coefficients[34] + coefficients[35] * adjustments[8]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[34]*/ mload(0x8c0),
                                       mulmod(/*coefficients[35]*/ mload(0x8e0),
                                              /*adjustments[8]*/mload(0x5aa0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for vaults_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/add_points/slope: vaults_state_transition__merkle_update__prev_authentication__hashes__ec_subset_sum__bit * (column1_row0 - vaults_merkle_hash_points__y) - column2_row0 * (column0_row0 - vaults_merkle_hash_points__x).
              let val := addmod(
                mulmod(
                  /*intermediate_value/vaults_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/bit*/ mload(0x4a20),
                  addmod(
                    /*column1_row0*/ mload(0x3260),
                    sub(PRIME, /*periodic_column/vaults_merkle_hash_points/y*/ mload(0x60)),
                    PRIME),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*column2_row0*/ mload(0x32e0),
                    addmod(
                      /*column0_row0*/ mload(0x3180),
                      sub(PRIME, /*periodic_column/vaults_merkle_hash_points/x*/ mload(0x40)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= numerators[3].
              val := mulmod(val, mload(0x5840), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[8].
              val := mulmod(val, mload(0x51e0), PRIME)

              // res += val * (coefficients[36] + coefficients[37] * adjustments[7]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[36]*/ mload(0x900),
                                       mulmod(/*coefficients[37]*/ mload(0x920),
                                              /*adjustments[7]*/mload(0x5a80),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for vaults_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/add_points/x: column2_row0 * column2_row0 - vaults_state_transition__merkle_update__prev_authentication__hashes__ec_subset_sum__bit * (column0_row0 + vaults_merkle_hash_points__x + column0_row1).
              let val := addmod(
                mulmod(/*column2_row0*/ mload(0x32e0), /*column2_row0*/ mload(0x32e0), PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*intermediate_value/vaults_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/bit*/ mload(0x4a20),
                    addmod(
                      addmod(
                        /*column0_row0*/ mload(0x3180),
                        /*periodic_column/vaults_merkle_hash_points/x*/ mload(0x40),
                        PRIME),
                      /*column0_row1*/ mload(0x31a0),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= numerators[3].
              val := mulmod(val, mload(0x5840), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[8].
              val := mulmod(val, mload(0x51e0), PRIME)

              // res += val * (coefficients[38] + coefficients[39] * adjustments[7]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[38]*/ mload(0x940),
                                       mulmod(/*coefficients[39]*/ mload(0x960),
                                              /*adjustments[7]*/mload(0x5a80),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for vaults_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/add_points/y: vaults_state_transition__merkle_update__prev_authentication__hashes__ec_subset_sum__bit * (column1_row0 + column1_row1) - column2_row0 * (column0_row0 - column0_row1).
              let val := addmod(
                mulmod(
                  /*intermediate_value/vaults_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/bit*/ mload(0x4a20),
                  addmod(/*column1_row0*/ mload(0x3260), /*column1_row1*/ mload(0x3280), PRIME),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*column2_row0*/ mload(0x32e0),
                    addmod(/*column0_row0*/ mload(0x3180), sub(PRIME, /*column0_row1*/ mload(0x31a0)), PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= numerators[3].
              val := mulmod(val, mload(0x5840), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[8].
              val := mulmod(val, mload(0x51e0), PRIME)

              // res += val * (coefficients[40] + coefficients[41] * adjustments[7]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[40]*/ mload(0x980),
                                       mulmod(/*coefficients[41]*/ mload(0x9a0),
                                              /*adjustments[7]*/mload(0x5a80),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for vaults_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/copy_point/x: vaults_state_transition__merkle_update__prev_authentication__hashes__ec_subset_sum__bit_neg * (column0_row1 - column0_row0).
              let val := mulmod(
                /*intermediate_value/vaults_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/bit_neg*/ mload(0x4a40),
                addmod(/*column0_row1*/ mload(0x31a0), sub(PRIME, /*column0_row0*/ mload(0x3180)), PRIME),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= numerators[3].
              val := mulmod(val, mload(0x5840), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[8].
              val := mulmod(val, mload(0x51e0), PRIME)

              // res += val * (coefficients[42] + coefficients[43] * adjustments[7]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[42]*/ mload(0x9c0),
                                       mulmod(/*coefficients[43]*/ mload(0x9e0),
                                              /*adjustments[7]*/mload(0x5a80),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for vaults_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/copy_point/y: vaults_state_transition__merkle_update__prev_authentication__hashes__ec_subset_sum__bit_neg * (column1_row1 - column1_row0).
              let val := mulmod(
                /*intermediate_value/vaults_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/bit_neg*/ mload(0x4a40),
                addmod(/*column1_row1*/ mload(0x3280), sub(PRIME, /*column1_row0*/ mload(0x3260)), PRIME),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= numerators[3].
              val := mulmod(val, mload(0x5840), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[8].
              val := mulmod(val, mload(0x51e0), PRIME)

              // res += val * (coefficients[44] + coefficients[45] * adjustments[7]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[44]*/ mload(0xa00),
                                       mulmod(/*coefficients[45]*/ mload(0xa20),
                                              /*adjustments[7]*/mload(0x5a80),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for vaults_state_transition/merkle_update/prev_authentication/hashes/copy_point/x: column0_row256 - column0_row255.
              let val := addmod(
                /*column0_row256*/ mload(0x31e0),
                sub(PRIME, /*column0_row255*/ mload(0x31c0)),
                PRIME)

              // Numerator: point^(trace_length / 512) - trace_generator^(trace_length / 2).
              // val *= numerators[4].
              val := mulmod(val, mload(0x5860), PRIME)
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[11].
              val := mulmod(val, mload(0x5240), PRIME)

              // res += val * (coefficients[46] + coefficients[47] * adjustments[9]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[46]*/ mload(0xa40),
                                       mulmod(/*coefficients[47]*/ mload(0xa60),
                                              /*adjustments[9]*/mload(0x5ac0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for vaults_state_transition/merkle_update/prev_authentication/hashes/copy_point/y: column1_row256 - column1_row255.
              let val := addmod(
                /*column1_row256*/ mload(0x32c0),
                sub(PRIME, /*column1_row255*/ mload(0x32a0)),
                PRIME)

              // Numerator: point^(trace_length / 512) - trace_generator^(trace_length / 2).
              // val *= numerators[4].
              val := mulmod(val, mload(0x5860), PRIME)
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[11].
              val := mulmod(val, mload(0x5240), PRIME)

              // res += val * (coefficients[48] + coefficients[49] * adjustments[9]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[48]*/ mload(0xa80),
                                       mulmod(/*coefficients[49]*/ mload(0xaa0),
                                              /*adjustments[9]*/mload(0x5ac0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for vaults_state_transition/merkle_update/prev_authentication/hashes/init/x: column0_row0 - shift_point.x.
              let val := addmod(/*column0_row0*/ mload(0x3180), sub(PRIME, /*shift_point.x*/ mload(0x220)), PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[6].
              val := mulmod(val, mload(0x51a0), PRIME)

              // res += val * (coefficients[50] + coefficients[51] * adjustments[10]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[50]*/ mload(0xac0),
                                       mulmod(/*coefficients[51]*/ mload(0xae0),
                                              /*adjustments[10]*/mload(0x5ae0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for vaults_state_transition/merkle_update/prev_authentication/hashes/init/y: column1_row0 - shift_point.y.
              let val := addmod(/*column1_row0*/ mload(0x3260), sub(PRIME, /*shift_point.y*/ mload(0x240)), PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[6].
              val := mulmod(val, mload(0x51a0), PRIME)

              // res += val * (coefficients[52] + coefficients[53] * adjustments[10]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[52]*/ mload(0xb00),
                                       mulmod(/*coefficients[53]*/ mload(0xb20),
                                              /*adjustments[10]*/mload(0x5ae0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for vaults_state_transition/merkle_update/prev_authentication/copy_prev_to_left: (1 - vaults_state_transition__merkle_update__side_bit_extraction__bit_1) * (column0_row511 - column3_row512).
              let val := mulmod(
                addmod(
                  1,
                  sub(
                    PRIME,
                    /*intermediate_value/vaults_state_transition/merkle_update/side_bit_extraction/bit_1*/ mload(0x4a60)),
                  PRIME),
                addmod(
                  /*column0_row511*/ mload(0x3200),
                  sub(PRIME, /*column3_row512*/ mload(0x3360)),
                  PRIME),
                PRIME)

              // Numerator: (point^(trace_length / 16384) - trace_generator^(31 * trace_length / 32)) * (point^(trace_length / 16384) - trace_generator^(15 * trace_length / 16)).
              // val *= numerators[5].
              val := mulmod(val, mload(0x5880), PRIME)
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[6].
              val := mulmod(val, mload(0x51a0), PRIME)

              // res += val * (coefficients[54] + coefficients[55] * adjustments[11]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[54]*/ mload(0xb40),
                                       mulmod(/*coefficients[55]*/ mload(0xb60),
                                              /*adjustments[11]*/mload(0x5b00),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for vaults_state_transition/merkle_update/prev_authentication/copy_prev_to_right: vaults_state_transition__merkle_update__side_bit_extraction__bit_1 * (column0_row511 - column3_row768).
              let val := mulmod(
                /*intermediate_value/vaults_state_transition/merkle_update/side_bit_extraction/bit_1*/ mload(0x4a60),
                addmod(
                  /*column0_row511*/ mload(0x3200),
                  sub(PRIME, /*column3_row768*/ mload(0x3380)),
                  PRIME),
                PRIME)

              // Numerator: (point^(trace_length / 16384) - trace_generator^(31 * trace_length / 32)) * (point^(trace_length / 16384) - trace_generator^(15 * trace_length / 16)).
              // val *= numerators[5].
              val := mulmod(val, mload(0x5880), PRIME)
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[6].
              val := mulmod(val, mload(0x51a0), PRIME)

              // res += val * (coefficients[56] + coefficients[57] * adjustments[11]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[56]*/ mload(0xb80),
                                       mulmod(/*coefficients[57]*/ mload(0xba0),
                                              /*adjustments[11]*/mload(0x5b00),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for vaults_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/booleanity_test: vaults_state_transition__merkle_update__new_authentication__hashes__ec_subset_sum__bit * (vaults_state_transition__merkle_update__new_authentication__hashes__ec_subset_sum__bit - 1).
              let val := mulmod(
                /*intermediate_value/vaults_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/bit*/ mload(0x4a80),
                addmod(
                  /*intermediate_value/vaults_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/bit*/ mload(0x4a80),
                  sub(PRIME, 1),
                  PRIME),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= numerators[3].
              val := mulmod(val, mload(0x5840), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[8].
              val := mulmod(val, mload(0x51e0), PRIME)

              // res += val * (coefficients[58] + coefficients[59] * adjustments[7]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[58]*/ mload(0xbc0),
                                       mulmod(/*coefficients[59]*/ mload(0xbe0),
                                              /*adjustments[7]*/mload(0x5a80),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for vaults_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/bit_extraction_end: column7_row0.
              let val := /*column7_row0*/ mload(0x3520)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 256) - trace_generator^(63 * trace_length / 64).
              // val *= denominator_invs[9].
              val := mulmod(val, mload(0x5200), PRIME)

              // res += val * (coefficients[60] + coefficients[61] * adjustments[8]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[60]*/ mload(0xc00),
                                       mulmod(/*coefficients[61]*/ mload(0xc20),
                                              /*adjustments[8]*/mload(0x5aa0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for vaults_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/zeros_tail: column7_row0.
              let val := /*column7_row0*/ mload(0x3520)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= denominator_invs[10].
              val := mulmod(val, mload(0x5220), PRIME)

              // res += val * (coefficients[62] + coefficients[63] * adjustments[8]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[62]*/ mload(0xc40),
                                       mulmod(/*coefficients[63]*/ mload(0xc60),
                                              /*adjustments[8]*/mload(0x5aa0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for vaults_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/add_points/slope: vaults_state_transition__merkle_update__new_authentication__hashes__ec_subset_sum__bit * (column5_row0 - vaults_merkle_hash_points__y) - column6_row0 * (column4_row0 - vaults_merkle_hash_points__x).
              let val := addmod(
                mulmod(
                  /*intermediate_value/vaults_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/bit*/ mload(0x4a80),
                  addmod(
                    /*column5_row0*/ mload(0x3480),
                    sub(PRIME, /*periodic_column/vaults_merkle_hash_points/y*/ mload(0x60)),
                    PRIME),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*column6_row0*/ mload(0x3500),
                    addmod(
                      /*column4_row0*/ mload(0x33a0),
                      sub(PRIME, /*periodic_column/vaults_merkle_hash_points/x*/ mload(0x40)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= numerators[3].
              val := mulmod(val, mload(0x5840), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[8].
              val := mulmod(val, mload(0x51e0), PRIME)

              // res += val * (coefficients[64] + coefficients[65] * adjustments[7]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[64]*/ mload(0xc80),
                                       mulmod(/*coefficients[65]*/ mload(0xca0),
                                              /*adjustments[7]*/mload(0x5a80),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for vaults_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/add_points/x: column6_row0 * column6_row0 - vaults_state_transition__merkle_update__new_authentication__hashes__ec_subset_sum__bit * (column4_row0 + vaults_merkle_hash_points__x + column4_row1).
              let val := addmod(
                mulmod(/*column6_row0*/ mload(0x3500), /*column6_row0*/ mload(0x3500), PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*intermediate_value/vaults_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/bit*/ mload(0x4a80),
                    addmod(
                      addmod(
                        /*column4_row0*/ mload(0x33a0),
                        /*periodic_column/vaults_merkle_hash_points/x*/ mload(0x40),
                        PRIME),
                      /*column4_row1*/ mload(0x33c0),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= numerators[3].
              val := mulmod(val, mload(0x5840), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[8].
              val := mulmod(val, mload(0x51e0), PRIME)

              // res += val * (coefficients[66] + coefficients[67] * adjustments[7]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[66]*/ mload(0xcc0),
                                       mulmod(/*coefficients[67]*/ mload(0xce0),
                                              /*adjustments[7]*/mload(0x5a80),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for vaults_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/add_points/y: vaults_state_transition__merkle_update__new_authentication__hashes__ec_subset_sum__bit * (column5_row0 + column5_row1) - column6_row0 * (column4_row0 - column4_row1).
              let val := addmod(
                mulmod(
                  /*intermediate_value/vaults_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/bit*/ mload(0x4a80),
                  addmod(/*column5_row0*/ mload(0x3480), /*column5_row1*/ mload(0x34a0), PRIME),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*column6_row0*/ mload(0x3500),
                    addmod(/*column4_row0*/ mload(0x33a0), sub(PRIME, /*column4_row1*/ mload(0x33c0)), PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= numerators[3].
              val := mulmod(val, mload(0x5840), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[8].
              val := mulmod(val, mload(0x51e0), PRIME)

              // res += val * (coefficients[68] + coefficients[69] * adjustments[7]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[68]*/ mload(0xd00),
                                       mulmod(/*coefficients[69]*/ mload(0xd20),
                                              /*adjustments[7]*/mload(0x5a80),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for vaults_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/copy_point/x: vaults_state_transition__merkle_update__new_authentication__hashes__ec_subset_sum__bit_neg * (column4_row1 - column4_row0).
              let val := mulmod(
                /*intermediate_value/vaults_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/bit_neg*/ mload(0x4aa0),
                addmod(/*column4_row1*/ mload(0x33c0), sub(PRIME, /*column4_row0*/ mload(0x33a0)), PRIME),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= numerators[3].
              val := mulmod(val, mload(0x5840), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[8].
              val := mulmod(val, mload(0x51e0), PRIME)

              // res += val * (coefficients[70] + coefficients[71] * adjustments[7]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[70]*/ mload(0xd40),
                                       mulmod(/*coefficients[71]*/ mload(0xd60),
                                              /*adjustments[7]*/mload(0x5a80),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for vaults_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/copy_point/y: vaults_state_transition__merkle_update__new_authentication__hashes__ec_subset_sum__bit_neg * (column5_row1 - column5_row0).
              let val := mulmod(
                /*intermediate_value/vaults_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/bit_neg*/ mload(0x4aa0),
                addmod(/*column5_row1*/ mload(0x34a0), sub(PRIME, /*column5_row0*/ mload(0x3480)), PRIME),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= numerators[3].
              val := mulmod(val, mload(0x5840), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[8].
              val := mulmod(val, mload(0x51e0), PRIME)

              // res += val * (coefficients[72] + coefficients[73] * adjustments[7]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[72]*/ mload(0xd80),
                                       mulmod(/*coefficients[73]*/ mload(0xda0),
                                              /*adjustments[7]*/mload(0x5a80),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for vaults_state_transition/merkle_update/new_authentication/hashes/copy_point/x: column4_row256 - column4_row255.
              let val := addmod(
                /*column4_row256*/ mload(0x3400),
                sub(PRIME, /*column4_row255*/ mload(0x33e0)),
                PRIME)

              // Numerator: point^(trace_length / 512) - trace_generator^(trace_length / 2).
              // val *= numerators[4].
              val := mulmod(val, mload(0x5860), PRIME)
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[11].
              val := mulmod(val, mload(0x5240), PRIME)

              // res += val * (coefficients[74] + coefficients[75] * adjustments[9]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[74]*/ mload(0xdc0),
                                       mulmod(/*coefficients[75]*/ mload(0xde0),
                                              /*adjustments[9]*/mload(0x5ac0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for vaults_state_transition/merkle_update/new_authentication/hashes/copy_point/y: column5_row256 - column5_row255.
              let val := addmod(
                /*column5_row256*/ mload(0x34e0),
                sub(PRIME, /*column5_row255*/ mload(0x34c0)),
                PRIME)

              // Numerator: point^(trace_length / 512) - trace_generator^(trace_length / 2).
              // val *= numerators[4].
              val := mulmod(val, mload(0x5860), PRIME)
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[11].
              val := mulmod(val, mload(0x5240), PRIME)

              // res += val * (coefficients[76] + coefficients[77] * adjustments[9]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[76]*/ mload(0xe00),
                                       mulmod(/*coefficients[77]*/ mload(0xe20),
                                              /*adjustments[9]*/mload(0x5ac0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for vaults_state_transition/merkle_update/new_authentication/hashes/init/x: column4_row0 - shift_point.x.
              let val := addmod(/*column4_row0*/ mload(0x33a0), sub(PRIME, /*shift_point.x*/ mload(0x220)), PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[6].
              val := mulmod(val, mload(0x51a0), PRIME)

              // res += val * (coefficients[78] + coefficients[79] * adjustments[10]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[78]*/ mload(0xe40),
                                       mulmod(/*coefficients[79]*/ mload(0xe60),
                                              /*adjustments[10]*/mload(0x5ae0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for vaults_state_transition/merkle_update/new_authentication/hashes/init/y: column5_row0 - shift_point.y.
              let val := addmod(/*column5_row0*/ mload(0x3480), sub(PRIME, /*shift_point.y*/ mload(0x240)), PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[6].
              val := mulmod(val, mload(0x51a0), PRIME)

              // res += val * (coefficients[80] + coefficients[81] * adjustments[10]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[80]*/ mload(0xe80),
                                       mulmod(/*coefficients[81]*/ mload(0xea0),
                                              /*adjustments[10]*/mload(0x5ae0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for vaults_state_transition/merkle_update/new_authentication/copy_prev_to_left: (1 - vaults_state_transition__merkle_update__side_bit_extraction__bit_1) * (column4_row511 - column7_row512).
              let val := mulmod(
                addmod(
                  1,
                  sub(
                    PRIME,
                    /*intermediate_value/vaults_state_transition/merkle_update/side_bit_extraction/bit_1*/ mload(0x4a60)),
                  PRIME),
                addmod(
                  /*column4_row511*/ mload(0x3420),
                  sub(PRIME, /*column7_row512*/ mload(0x3580)),
                  PRIME),
                PRIME)

              // Numerator: (point^(trace_length / 16384) - trace_generator^(31 * trace_length / 32)) * (point^(trace_length / 16384) - trace_generator^(15 * trace_length / 16)).
              // val *= numerators[5].
              val := mulmod(val, mload(0x5880), PRIME)
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[6].
              val := mulmod(val, mload(0x51a0), PRIME)

              // res += val * (coefficients[82] + coefficients[83] * adjustments[11]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[82]*/ mload(0xec0),
                                       mulmod(/*coefficients[83]*/ mload(0xee0),
                                              /*adjustments[11]*/mload(0x5b00),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for vaults_state_transition/merkle_update/new_authentication/copy_prev_to_right: vaults_state_transition__merkle_update__side_bit_extraction__bit_1 * (column4_row511 - column7_row768).
              let val := mulmod(
                /*intermediate_value/vaults_state_transition/merkle_update/side_bit_extraction/bit_1*/ mload(0x4a60),
                addmod(
                  /*column4_row511*/ mload(0x3420),
                  sub(PRIME, /*column7_row768*/ mload(0x35a0)),
                  PRIME),
                PRIME)

              // Numerator: (point^(trace_length / 16384) - trace_generator^(31 * trace_length / 32)) * (point^(trace_length / 16384) - trace_generator^(15 * trace_length / 16)).
              // val *= numerators[5].
              val := mulmod(val, mload(0x5880), PRIME)
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[6].
              val := mulmod(val, mload(0x51a0), PRIME)

              // res += val * (coefficients[84] + coefficients[85] * adjustments[11]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[84]*/ mload(0xf00),
                                       mulmod(/*coefficients[85]*/ mload(0xf20),
                                              /*adjustments[11]*/mload(0x5b00),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for vaults_state_transition/merkle_update/same_siblings: vaults_state_transition__merkle_update__prev_authentication__sibling_0 - vaults_state_transition__merkle_update__new_authentication__sibling_0.
              let val := addmod(
                /*intermediate_value/vaults_state_transition/merkle_update/prev_authentication/sibling_0*/ mload(0x4ac0),
                sub(
                  PRIME,
                  /*intermediate_value/vaults_state_transition/merkle_update/new_authentication/sibling_0*/ mload(0x4ae0)),
                PRIME)

              // Numerator: point^(trace_length / 16384) - trace_generator^(31 * trace_length / 32).
              // val *= numerators[2].
              val := mulmod(val, mload(0x5820), PRIME)
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[6].
              val := mulmod(val, mload(0x51a0), PRIME)

              // res += val * (coefficients[86] + coefficients[87] * adjustments[5]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[86]*/ mload(0xf40),
                                       mulmod(/*coefficients[87]*/ mload(0xf60),
                                              /*adjustments[5]*/mload(0x5a40),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for vaults_state_transition/merkle_set_prev_leaf: vaults_state_transition__merkle_update__prev_authentication__leaf_0 - column16_row4092.
              let val := addmod(
                /*intermediate_value/vaults_state_transition/merkle_update/prev_authentication/leaf_0*/ mload(0x4b00),
                sub(PRIME, /*column16_row4092*/ mload(0x3f80)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 16384) - 1.
              // val *= denominator_invs[12].
              val := mulmod(val, mload(0x5260), PRIME)

              // res += val * (coefficients[88] + coefficients[89] * adjustments[12]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[88]*/ mload(0xf80),
                                       mulmod(/*coefficients[89]*/ mload(0xfa0),
                                              /*adjustments[12]*/mload(0x5b20),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for vaults_state_transition/merkle_set_new_leaf: vaults_state_transition__merkle_update__new_authentication__leaf_0 - column16_row12284.
              let val := addmod(
                /*intermediate_value/vaults_state_transition/merkle_update/new_authentication/leaf_0*/ mload(0x4b20),
                sub(PRIME, /*column16_row12284*/ mload(0x4080)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 16384) - 1.
              // val *= denominator_invs[12].
              val := mulmod(val, mload(0x5260), PRIME)

              // res += val * (coefficients[90] + coefficients[91] * adjustments[12]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[90]*/ mload(0xfc0),
                                       mulmod(/*coefficients[91]*/ mload(0xfe0),
                                              /*adjustments[12]*/mload(0x5b20),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for modification_boundary_key: is_modification * (column17_row16324 * boundary_base - boundary_key).
              let val := mulmod(
                /*periodic_column/is_modification*/ mload(0xa0),
                addmod(
                  mulmod(
                    /*column17_row16324*/ mload(0x4540),
                    /*periodic_column/boundary_base*/ mload(0x80),
                    PRIME),
                  sub(PRIME, /*periodic_column/boundary_key*/ mload(0xe0)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 65536) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, mload(0x5280), PRIME)

              // res += val * (coefficients[92] + coefficients[93] * adjustments[13]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[92]*/ mload(0x1000),
                                       mulmod(/*coefficients[93]*/ mload(0x1020),
                                              /*adjustments[13]*/mload(0x5b40),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for modification_boundary_token: is_modification * (column17_row16344 * boundary_base - boundary_token).
              let val := mulmod(
                /*periodic_column/is_modification*/ mload(0xa0),
                addmod(
                  mulmod(
                    /*column17_row16344*/ mload(0x4580),
                    /*periodic_column/boundary_base*/ mload(0x80),
                    PRIME),
                  sub(PRIME, /*periodic_column/boundary_token*/ mload(0x100)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 65536) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, mload(0x5280), PRIME)

              // res += val * (coefficients[94] + coefficients[95] * adjustments[13]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[94]*/ mload(0x1040),
                                       mulmod(/*coefficients[95]*/ mload(0x1060),
                                              /*adjustments[13]*/mload(0x5b40),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for modification_boundary_amount0: is_modification * (column16_row3075 * boundary_base - boundary_amount0).
              let val := mulmod(
                /*periodic_column/is_modification*/ mload(0xa0),
                addmod(
                  mulmod(
                    /*column16_row3075*/ mload(0x3f60),
                    /*periodic_column/boundary_base*/ mload(0x80),
                    PRIME),
                  sub(PRIME, /*periodic_column/boundary_amount0*/ mload(0x120)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 65536) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, mload(0x5280), PRIME)

              // res += val * (coefficients[96] + coefficients[97] * adjustments[13]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[96]*/ mload(0x1080),
                                       mulmod(/*coefficients[97]*/ mload(0x10a0),
                                              /*adjustments[13]*/mload(0x5b40),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for modification_boundary_amount1: is_modification * (column16_row11267 * boundary_base - boundary_amount1).
              let val := mulmod(
                /*periodic_column/is_modification*/ mload(0xa0),
                addmod(
                  mulmod(
                    /*column16_row11267*/ mload(0x4060),
                    /*periodic_column/boundary_base*/ mload(0x80),
                    PRIME),
                  sub(PRIME, /*periodic_column/boundary_amount1*/ mload(0x140)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 65536) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, mload(0x5280), PRIME)

              // res += val * (coefficients[98] + coefficients[99] * adjustments[13]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[98]*/ mload(0x10c0),
                                       mulmod(/*coefficients[99]*/ mload(0x10e0),
                                              /*adjustments[13]*/mload(0x5b40),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for modification_boundary_vault_id: is_modification * (column14_row255 * boundary_base - boundary_vault_id).
              let val := mulmod(
                /*periodic_column/is_modification*/ mload(0xa0),
                addmod(
                  mulmod(
                    /*column14_row255*/ mload(0x3b80),
                    /*periodic_column/boundary_base*/ mload(0x80),
                    PRIME),
                  sub(PRIME, /*periodic_column/boundary_vault_id*/ mload(0x160)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 65536) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, mload(0x5280), PRIME)

              // res += val * (coefficients[100] + coefficients[101] * adjustments[13]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[100]*/ mload(0x1100),
                                       mulmod(/*coefficients[101]*/ mload(0x1120),
                                              /*adjustments[13]*/mload(0x5b40),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for settlement_state_transition/merkle_update/side_bit_extraction/bit: settlement_state_transition__merkle_update__side_bit_extraction__bit_0 * settlement_state_transition__merkle_update__side_bit_extraction__bit_0 - settlement_state_transition__merkle_update__side_bit_extraction__bit_0.
              let val := addmod(
                mulmod(
                  /*intermediate_value/settlement_state_transition/merkle_update/side_bit_extraction/bit_0*/ mload(0x4b40),
                  /*intermediate_value/settlement_state_transition/merkle_update/side_bit_extraction/bit_0*/ mload(0x4b40),
                  PRIME),
                sub(
                  PRIME,
                  /*intermediate_value/settlement_state_transition/merkle_update/side_bit_extraction/bit_0*/ mload(0x4b40)),
                PRIME)

              // Numerator: point^(trace_length / 32768) - trace_generator^(63 * trace_length / 64).
              // val *= numerators[6].
              val := mulmod(val, mload(0x58a0), PRIME)
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[6].
              val := mulmod(val, mload(0x51a0), PRIME)

              // res += val * (coefficients[102] + coefficients[103] * adjustments[14]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[102]*/ mload(0x1140),
                                       mulmod(/*coefficients[103]*/ mload(0x1160),
                                              /*adjustments[14]*/mload(0x5b60),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for settlement_state_transition/merkle_update/side_bit_extraction/zero: column14_row511.
              let val := /*column14_row511*/ mload(0x3ba0)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 32768) - trace_generator^(63 * trace_length / 64).
              // val *= denominator_invs[14].
              val := mulmod(val, mload(0x52a0), PRIME)

              // res += val * (coefficients[104] + coefficients[105] * adjustments[15]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[104]*/ mload(0x1180),
                                       mulmod(/*coefficients[105]*/ mload(0x11a0),
                                              /*adjustments[15]*/mload(0x5b80),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for settlement_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/booleanity_test: settlement_state_transition__merkle_update__prev_authentication__hashes__ec_subset_sum__bit * (settlement_state_transition__merkle_update__prev_authentication__hashes__ec_subset_sum__bit - 1).
              let val := mulmod(
                /*intermediate_value/settlement_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/bit*/ mload(0x4b60),
                addmod(
                  /*intermediate_value/settlement_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/bit*/ mload(0x4b60),
                  sub(PRIME, 1),
                  PRIME),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= numerators[3].
              val := mulmod(val, mload(0x5840), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[8].
              val := mulmod(val, mload(0x51e0), PRIME)

              // res += val * (coefficients[106] + coefficients[107] * adjustments[7]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[106]*/ mload(0x11c0),
                                       mulmod(/*coefficients[107]*/ mload(0x11e0),
                                              /*adjustments[7]*/mload(0x5a80),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for settlement_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/bit_extraction_end: column11_row0.
              let val := /*column11_row0*/ mload(0x3960)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 256) - trace_generator^(63 * trace_length / 64).
              // val *= denominator_invs[9].
              val := mulmod(val, mload(0x5200), PRIME)

              // res += val * (coefficients[108] + coefficients[109] * adjustments[8]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[108]*/ mload(0x1200),
                                       mulmod(/*coefficients[109]*/ mload(0x1220),
                                              /*adjustments[8]*/mload(0x5aa0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for settlement_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/zeros_tail: column11_row0.
              let val := /*column11_row0*/ mload(0x3960)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= denominator_invs[10].
              val := mulmod(val, mload(0x5220), PRIME)

              // res += val * (coefficients[110] + coefficients[111] * adjustments[8]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[110]*/ mload(0x1240),
                                       mulmod(/*coefficients[111]*/ mload(0x1260),
                                              /*adjustments[8]*/mload(0x5aa0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for settlement_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/add_points/slope: settlement_state_transition__merkle_update__prev_authentication__hashes__ec_subset_sum__bit * (column9_row0 - settlement_merkle_hash_points__y) - column10_row0 * (column8_row0 - settlement_merkle_hash_points__x).
              let val := addmod(
                mulmod(
                  /*intermediate_value/settlement_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/bit*/ mload(0x4b60),
                  addmod(
                    /*column9_row0*/ mload(0x36a0),
                    sub(PRIME, /*periodic_column/settlement_merkle_hash_points/y*/ mload(0x1a0)),
                    PRIME),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*column10_row0*/ mload(0x3720),
                    addmod(
                      /*column8_row0*/ mload(0x35c0),
                      sub(PRIME, /*periodic_column/settlement_merkle_hash_points/x*/ mload(0x180)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= numerators[3].
              val := mulmod(val, mload(0x5840), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[8].
              val := mulmod(val, mload(0x51e0), PRIME)

              // res += val * (coefficients[112] + coefficients[113] * adjustments[7]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[112]*/ mload(0x1280),
                                       mulmod(/*coefficients[113]*/ mload(0x12a0),
                                              /*adjustments[7]*/mload(0x5a80),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for settlement_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/add_points/x: column10_row0 * column10_row0 - settlement_state_transition__merkle_update__prev_authentication__hashes__ec_subset_sum__bit * (column8_row0 + settlement_merkle_hash_points__x + column8_row1).
              let val := addmod(
                mulmod(/*column10_row0*/ mload(0x3720), /*column10_row0*/ mload(0x3720), PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*intermediate_value/settlement_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/bit*/ mload(0x4b60),
                    addmod(
                      addmod(
                        /*column8_row0*/ mload(0x35c0),
                        /*periodic_column/settlement_merkle_hash_points/x*/ mload(0x180),
                        PRIME),
                      /*column8_row1*/ mload(0x35e0),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= numerators[3].
              val := mulmod(val, mload(0x5840), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[8].
              val := mulmod(val, mload(0x51e0), PRIME)

              // res += val * (coefficients[114] + coefficients[115] * adjustments[7]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[114]*/ mload(0x12c0),
                                       mulmod(/*coefficients[115]*/ mload(0x12e0),
                                              /*adjustments[7]*/mload(0x5a80),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for settlement_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/add_points/y: settlement_state_transition__merkle_update__prev_authentication__hashes__ec_subset_sum__bit * (column9_row0 + column9_row1) - column10_row0 * (column8_row0 - column8_row1).
              let val := addmod(
                mulmod(
                  /*intermediate_value/settlement_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/bit*/ mload(0x4b60),
                  addmod(/*column9_row0*/ mload(0x36a0), /*column9_row1*/ mload(0x36c0), PRIME),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*column10_row0*/ mload(0x3720),
                    addmod(/*column8_row0*/ mload(0x35c0), sub(PRIME, /*column8_row1*/ mload(0x35e0)), PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= numerators[3].
              val := mulmod(val, mload(0x5840), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[8].
              val := mulmod(val, mload(0x51e0), PRIME)

              // res += val * (coefficients[116] + coefficients[117] * adjustments[7]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[116]*/ mload(0x1300),
                                       mulmod(/*coefficients[117]*/ mload(0x1320),
                                              /*adjustments[7]*/mload(0x5a80),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for settlement_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/copy_point/x: settlement_state_transition__merkle_update__prev_authentication__hashes__ec_subset_sum__bit_neg * (column8_row1 - column8_row0).
              let val := mulmod(
                /*intermediate_value/settlement_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/bit_neg*/ mload(0x4b80),
                addmod(/*column8_row1*/ mload(0x35e0), sub(PRIME, /*column8_row0*/ mload(0x35c0)), PRIME),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= numerators[3].
              val := mulmod(val, mload(0x5840), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[8].
              val := mulmod(val, mload(0x51e0), PRIME)

              // res += val * (coefficients[118] + coefficients[119] * adjustments[7]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[118]*/ mload(0x1340),
                                       mulmod(/*coefficients[119]*/ mload(0x1360),
                                              /*adjustments[7]*/mload(0x5a80),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for settlement_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/copy_point/y: settlement_state_transition__merkle_update__prev_authentication__hashes__ec_subset_sum__bit_neg * (column9_row1 - column9_row0).
              let val := mulmod(
                /*intermediate_value/settlement_state_transition/merkle_update/prev_authentication/hashes/ec_subset_sum/bit_neg*/ mload(0x4b80),
                addmod(/*column9_row1*/ mload(0x36c0), sub(PRIME, /*column9_row0*/ mload(0x36a0)), PRIME),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= numerators[3].
              val := mulmod(val, mload(0x5840), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[8].
              val := mulmod(val, mload(0x51e0), PRIME)

              // res += val * (coefficients[120] + coefficients[121] * adjustments[7]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[120]*/ mload(0x1380),
                                       mulmod(/*coefficients[121]*/ mload(0x13a0),
                                              /*adjustments[7]*/mload(0x5a80),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for settlement_state_transition/merkle_update/prev_authentication/hashes/copy_point/x: column8_row256 - column8_row255.
              let val := addmod(
                /*column8_row256*/ mload(0x3620),
                sub(PRIME, /*column8_row255*/ mload(0x3600)),
                PRIME)

              // Numerator: point^(trace_length / 512) - trace_generator^(trace_length / 2).
              // val *= numerators[4].
              val := mulmod(val, mload(0x5860), PRIME)
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[11].
              val := mulmod(val, mload(0x5240), PRIME)

              // res += val * (coefficients[122] + coefficients[123] * adjustments[9]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[122]*/ mload(0x13c0),
                                       mulmod(/*coefficients[123]*/ mload(0x13e0),
                                              /*adjustments[9]*/mload(0x5ac0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for settlement_state_transition/merkle_update/prev_authentication/hashes/copy_point/y: column9_row256 - column9_row255.
              let val := addmod(
                /*column9_row256*/ mload(0x3700),
                sub(PRIME, /*column9_row255*/ mload(0x36e0)),
                PRIME)

              // Numerator: point^(trace_length / 512) - trace_generator^(trace_length / 2).
              // val *= numerators[4].
              val := mulmod(val, mload(0x5860), PRIME)
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[11].
              val := mulmod(val, mload(0x5240), PRIME)

              // res += val * (coefficients[124] + coefficients[125] * adjustments[9]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[124]*/ mload(0x1400),
                                       mulmod(/*coefficients[125]*/ mload(0x1420),
                                              /*adjustments[9]*/mload(0x5ac0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for settlement_state_transition/merkle_update/prev_authentication/hashes/init/x: column8_row0 - shift_point.x.
              let val := addmod(/*column8_row0*/ mload(0x35c0), sub(PRIME, /*shift_point.x*/ mload(0x220)), PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[6].
              val := mulmod(val, mload(0x51a0), PRIME)

              // res += val * (coefficients[126] + coefficients[127] * adjustments[10]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[126]*/ mload(0x1440),
                                       mulmod(/*coefficients[127]*/ mload(0x1460),
                                              /*adjustments[10]*/mload(0x5ae0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for settlement_state_transition/merkle_update/prev_authentication/hashes/init/y: column9_row0 - shift_point.y.
              let val := addmod(/*column9_row0*/ mload(0x36a0), sub(PRIME, /*shift_point.y*/ mload(0x240)), PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[6].
              val := mulmod(val, mload(0x51a0), PRIME)

              // res += val * (coefficients[128] + coefficients[129] * adjustments[10]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[128]*/ mload(0x1480),
                                       mulmod(/*coefficients[129]*/ mload(0x14a0),
                                              /*adjustments[10]*/mload(0x5ae0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for settlement_state_transition/merkle_update/prev_authentication/copy_prev_to_left: (1 - settlement_state_transition__merkle_update__side_bit_extraction__bit_1) * (column8_row511 - column11_row512).
              let val := mulmod(
                addmod(
                  1,
                  sub(
                    PRIME,
                    /*intermediate_value/settlement_state_transition/merkle_update/side_bit_extraction/bit_1*/ mload(0x4ba0)),
                  PRIME),
                addmod(
                  /*column8_row511*/ mload(0x3640),
                  sub(PRIME, /*column11_row512*/ mload(0x39c0)),
                  PRIME),
                PRIME)

              // Numerator: (point^(trace_length / 32768) - trace_generator^(63 * trace_length / 64)) * (point^(trace_length / 32768) - trace_generator^(31 * trace_length / 32)).
              // val *= numerators[7].
              val := mulmod(val, mload(0x58c0), PRIME)
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[6].
              val := mulmod(val, mload(0x51a0), PRIME)

              // res += val * (coefficients[130] + coefficients[131] * adjustments[16]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[130]*/ mload(0x14c0),
                                       mulmod(/*coefficients[131]*/ mload(0x14e0),
                                              /*adjustments[16]*/mload(0x5ba0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for settlement_state_transition/merkle_update/prev_authentication/copy_prev_to_right: settlement_state_transition__merkle_update__side_bit_extraction__bit_1 * (column8_row511 - column11_row768).
              let val := mulmod(
                /*intermediate_value/settlement_state_transition/merkle_update/side_bit_extraction/bit_1*/ mload(0x4ba0),
                addmod(
                  /*column8_row511*/ mload(0x3640),
                  sub(PRIME, /*column11_row768*/ mload(0x39e0)),
                  PRIME),
                PRIME)

              // Numerator: (point^(trace_length / 32768) - trace_generator^(63 * trace_length / 64)) * (point^(trace_length / 32768) - trace_generator^(31 * trace_length / 32)).
              // val *= numerators[7].
              val := mulmod(val, mload(0x58c0), PRIME)
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[6].
              val := mulmod(val, mload(0x51a0), PRIME)

              // res += val * (coefficients[132] + coefficients[133] * adjustments[16]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[132]*/ mload(0x1500),
                                       mulmod(/*coefficients[133]*/ mload(0x1520),
                                              /*adjustments[16]*/mload(0x5ba0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for settlement_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/booleanity_test: settlement_state_transition__merkle_update__new_authentication__hashes__ec_subset_sum__bit * (settlement_state_transition__merkle_update__new_authentication__hashes__ec_subset_sum__bit - 1).
              let val := mulmod(
                /*intermediate_value/settlement_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/bit*/ mload(0x4bc0),
                addmod(
                  /*intermediate_value/settlement_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/bit*/ mload(0x4bc0),
                  sub(PRIME, 1),
                  PRIME),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= numerators[3].
              val := mulmod(val, mload(0x5840), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[8].
              val := mulmod(val, mload(0x51e0), PRIME)

              // res += val * (coefficients[134] + coefficients[135] * adjustments[7]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[134]*/ mload(0x1540),
                                       mulmod(/*coefficients[135]*/ mload(0x1560),
                                              /*adjustments[7]*/mload(0x5a80),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for settlement_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/bit_extraction_end: column15_row0.
              let val := /*column15_row0*/ mload(0x3cc0)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 256) - trace_generator^(63 * trace_length / 64).
              // val *= denominator_invs[9].
              val := mulmod(val, mload(0x5200), PRIME)

              // res += val * (coefficients[136] + coefficients[137] * adjustments[8]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[136]*/ mload(0x1580),
                                       mulmod(/*coefficients[137]*/ mload(0x15a0),
                                              /*adjustments[8]*/mload(0x5aa0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for settlement_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/zeros_tail: column15_row0.
              let val := /*column15_row0*/ mload(0x3cc0)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= denominator_invs[10].
              val := mulmod(val, mload(0x5220), PRIME)

              // res += val * (coefficients[138] + coefficients[139] * adjustments[8]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[138]*/ mload(0x15c0),
                                       mulmod(/*coefficients[139]*/ mload(0x15e0),
                                              /*adjustments[8]*/mload(0x5aa0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for settlement_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/add_points/slope: settlement_state_transition__merkle_update__new_authentication__hashes__ec_subset_sum__bit * (column13_row0 - settlement_merkle_hash_points__y) - column14_row0 * (column12_row0 - settlement_merkle_hash_points__x).
              let val := addmod(
                mulmod(
                  /*intermediate_value/settlement_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/bit*/ mload(0x4bc0),
                  addmod(
                    /*column13_row0*/ mload(0x3ae0),
                    sub(PRIME, /*periodic_column/settlement_merkle_hash_points/y*/ mload(0x1a0)),
                    PRIME),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*column14_row0*/ mload(0x3b60),
                    addmod(
                      /*column12_row0*/ mload(0x3a00),
                      sub(PRIME, /*periodic_column/settlement_merkle_hash_points/x*/ mload(0x180)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= numerators[3].
              val := mulmod(val, mload(0x5840), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[8].
              val := mulmod(val, mload(0x51e0), PRIME)

              // res += val * (coefficients[140] + coefficients[141] * adjustments[7]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[140]*/ mload(0x1600),
                                       mulmod(/*coefficients[141]*/ mload(0x1620),
                                              /*adjustments[7]*/mload(0x5a80),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for settlement_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/add_points/x: column14_row0 * column14_row0 - settlement_state_transition__merkle_update__new_authentication__hashes__ec_subset_sum__bit * (column12_row0 + settlement_merkle_hash_points__x + column12_row1).
              let val := addmod(
                mulmod(/*column14_row0*/ mload(0x3b60), /*column14_row0*/ mload(0x3b60), PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*intermediate_value/settlement_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/bit*/ mload(0x4bc0),
                    addmod(
                      addmod(
                        /*column12_row0*/ mload(0x3a00),
                        /*periodic_column/settlement_merkle_hash_points/x*/ mload(0x180),
                        PRIME),
                      /*column12_row1*/ mload(0x3a20),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= numerators[3].
              val := mulmod(val, mload(0x5840), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[8].
              val := mulmod(val, mload(0x51e0), PRIME)

              // res += val * (coefficients[142] + coefficients[143] * adjustments[7]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[142]*/ mload(0x1640),
                                       mulmod(/*coefficients[143]*/ mload(0x1660),
                                              /*adjustments[7]*/mload(0x5a80),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for settlement_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/add_points/y: settlement_state_transition__merkle_update__new_authentication__hashes__ec_subset_sum__bit * (column13_row0 + column13_row1) - column14_row0 * (column12_row0 - column12_row1).
              let val := addmod(
                mulmod(
                  /*intermediate_value/settlement_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/bit*/ mload(0x4bc0),
                  addmod(/*column13_row0*/ mload(0x3ae0), /*column13_row1*/ mload(0x3b00), PRIME),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*column14_row0*/ mload(0x3b60),
                    addmod(/*column12_row0*/ mload(0x3a00), sub(PRIME, /*column12_row1*/ mload(0x3a20)), PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= numerators[3].
              val := mulmod(val, mload(0x5840), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[8].
              val := mulmod(val, mload(0x51e0), PRIME)

              // res += val * (coefficients[144] + coefficients[145] * adjustments[7]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[144]*/ mload(0x1680),
                                       mulmod(/*coefficients[145]*/ mload(0x16a0),
                                              /*adjustments[7]*/mload(0x5a80),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for settlement_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/copy_point/x: settlement_state_transition__merkle_update__new_authentication__hashes__ec_subset_sum__bit_neg * (column12_row1 - column12_row0).
              let val := mulmod(
                /*intermediate_value/settlement_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/bit_neg*/ mload(0x4be0),
                addmod(/*column12_row1*/ mload(0x3a20), sub(PRIME, /*column12_row0*/ mload(0x3a00)), PRIME),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= numerators[3].
              val := mulmod(val, mload(0x5840), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[8].
              val := mulmod(val, mload(0x51e0), PRIME)

              // res += val * (coefficients[146] + coefficients[147] * adjustments[7]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[146]*/ mload(0x16c0),
                                       mulmod(/*coefficients[147]*/ mload(0x16e0),
                                              /*adjustments[7]*/mload(0x5a80),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for settlement_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/copy_point/y: settlement_state_transition__merkle_update__new_authentication__hashes__ec_subset_sum__bit_neg * (column13_row1 - column13_row0).
              let val := mulmod(
                /*intermediate_value/settlement_state_transition/merkle_update/new_authentication/hashes/ec_subset_sum/bit_neg*/ mload(0x4be0),
                addmod(/*column13_row1*/ mload(0x3b00), sub(PRIME, /*column13_row0*/ mload(0x3ae0)), PRIME),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= numerators[3].
              val := mulmod(val, mload(0x5840), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[8].
              val := mulmod(val, mload(0x51e0), PRIME)

              // res += val * (coefficients[148] + coefficients[149] * adjustments[7]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[148]*/ mload(0x1700),
                                       mulmod(/*coefficients[149]*/ mload(0x1720),
                                              /*adjustments[7]*/mload(0x5a80),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for settlement_state_transition/merkle_update/new_authentication/hashes/copy_point/x: column12_row256 - column12_row255.
              let val := addmod(
                /*column12_row256*/ mload(0x3a60),
                sub(PRIME, /*column12_row255*/ mload(0x3a40)),
                PRIME)

              // Numerator: point^(trace_length / 512) - trace_generator^(trace_length / 2).
              // val *= numerators[4].
              val := mulmod(val, mload(0x5860), PRIME)
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[11].
              val := mulmod(val, mload(0x5240), PRIME)

              // res += val * (coefficients[150] + coefficients[151] * adjustments[9]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[150]*/ mload(0x1740),
                                       mulmod(/*coefficients[151]*/ mload(0x1760),
                                              /*adjustments[9]*/mload(0x5ac0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for settlement_state_transition/merkle_update/new_authentication/hashes/copy_point/y: column13_row256 - column13_row255.
              let val := addmod(
                /*column13_row256*/ mload(0x3b40),
                sub(PRIME, /*column13_row255*/ mload(0x3b20)),
                PRIME)

              // Numerator: point^(trace_length / 512) - trace_generator^(trace_length / 2).
              // val *= numerators[4].
              val := mulmod(val, mload(0x5860), PRIME)
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[11].
              val := mulmod(val, mload(0x5240), PRIME)

              // res += val * (coefficients[152] + coefficients[153] * adjustments[9]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[152]*/ mload(0x1780),
                                       mulmod(/*coefficients[153]*/ mload(0x17a0),
                                              /*adjustments[9]*/mload(0x5ac0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for settlement_state_transition/merkle_update/new_authentication/hashes/init/x: column12_row0 - shift_point.x.
              let val := addmod(/*column12_row0*/ mload(0x3a00), sub(PRIME, /*shift_point.x*/ mload(0x220)), PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[6].
              val := mulmod(val, mload(0x51a0), PRIME)

              // res += val * (coefficients[154] + coefficients[155] * adjustments[10]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[154]*/ mload(0x17c0),
                                       mulmod(/*coefficients[155]*/ mload(0x17e0),
                                              /*adjustments[10]*/mload(0x5ae0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for settlement_state_transition/merkle_update/new_authentication/hashes/init/y: column13_row0 - shift_point.y.
              let val := addmod(/*column13_row0*/ mload(0x3ae0), sub(PRIME, /*shift_point.y*/ mload(0x240)), PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[6].
              val := mulmod(val, mload(0x51a0), PRIME)

              // res += val * (coefficients[156] + coefficients[157] * adjustments[10]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[156]*/ mload(0x1800),
                                       mulmod(/*coefficients[157]*/ mload(0x1820),
                                              /*adjustments[10]*/mload(0x5ae0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for settlement_state_transition/merkle_update/new_authentication/copy_prev_to_left: (1 - settlement_state_transition__merkle_update__side_bit_extraction__bit_1) * (column12_row511 - column15_row512).
              let val := mulmod(
                addmod(
                  1,
                  sub(
                    PRIME,
                    /*intermediate_value/settlement_state_transition/merkle_update/side_bit_extraction/bit_1*/ mload(0x4ba0)),
                  PRIME),
                addmod(
                  /*column12_row511*/ mload(0x3a80),
                  sub(PRIME, /*column15_row512*/ mload(0x3d20)),
                  PRIME),
                PRIME)

              // Numerator: (point^(trace_length / 32768) - trace_generator^(63 * trace_length / 64)) * (point^(trace_length / 32768) - trace_generator^(31 * trace_length / 32)).
              // val *= numerators[7].
              val := mulmod(val, mload(0x58c0), PRIME)
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[6].
              val := mulmod(val, mload(0x51a0), PRIME)

              // res += val * (coefficients[158] + coefficients[159] * adjustments[16]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[158]*/ mload(0x1840),
                                       mulmod(/*coefficients[159]*/ mload(0x1860),
                                              /*adjustments[16]*/mload(0x5ba0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for settlement_state_transition/merkle_update/new_authentication/copy_prev_to_right: settlement_state_transition__merkle_update__side_bit_extraction__bit_1 * (column12_row511 - column15_row768).
              let val := mulmod(
                /*intermediate_value/settlement_state_transition/merkle_update/side_bit_extraction/bit_1*/ mload(0x4ba0),
                addmod(
                  /*column12_row511*/ mload(0x3a80),
                  sub(PRIME, /*column15_row768*/ mload(0x3d40)),
                  PRIME),
                PRIME)

              // Numerator: (point^(trace_length / 32768) - trace_generator^(63 * trace_length / 64)) * (point^(trace_length / 32768) - trace_generator^(31 * trace_length / 32)).
              // val *= numerators[7].
              val := mulmod(val, mload(0x58c0), PRIME)
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[6].
              val := mulmod(val, mload(0x51a0), PRIME)

              // res += val * (coefficients[160] + coefficients[161] * adjustments[16]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[160]*/ mload(0x1880),
                                       mulmod(/*coefficients[161]*/ mload(0x18a0),
                                              /*adjustments[16]*/mload(0x5ba0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for settlement_state_transition/merkle_update/same_siblings: settlement_state_transition__merkle_update__prev_authentication__sibling_0 - settlement_state_transition__merkle_update__new_authentication__sibling_0.
              let val := addmod(
                /*intermediate_value/settlement_state_transition/merkle_update/prev_authentication/sibling_0*/ mload(0x4c00),
                sub(
                  PRIME,
                  /*intermediate_value/settlement_state_transition/merkle_update/new_authentication/sibling_0*/ mload(0x4c20)),
                PRIME)

              // Numerator: point^(trace_length / 32768) - trace_generator^(63 * trace_length / 64).
              // val *= numerators[6].
              val := mulmod(val, mload(0x58a0), PRIME)
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[6].
              val := mulmod(val, mload(0x51a0), PRIME)

              // res += val * (coefficients[162] + coefficients[163] * adjustments[14]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[162]*/ mload(0x18c0),
                                       mulmod(/*coefficients[163]*/ mload(0x18e0),
                                              /*adjustments[14]*/mload(0x5b60),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for settlement_state_transition/merkle_set_prev_leaf: settlement_state_transition__merkle_update__prev_authentication__leaf_0 - column17_row16368.
              let val := addmod(
                /*intermediate_value/settlement_state_transition/merkle_update/prev_authentication/leaf_0*/ mload(0x4c40),
                sub(PRIME, /*column17_row16368*/ mload(0x45c0)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 32768) - 1.
              // val *= denominator_invs[15].
              val := mulmod(val, mload(0x52c0), PRIME)

              // res += val * (coefficients[164] + coefficients[165] * adjustments[17]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[164]*/ mload(0x1900),
                                       mulmod(/*coefficients[165]*/ mload(0x1920),
                                              /*adjustments[17]*/mload(0x5bc0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for settlement_state_transition/merkle_set_new_leaf: settlement_state_transition__merkle_update__new_authentication__leaf_0 - column17_row32752.
              let val := addmod(
                /*intermediate_value/settlement_state_transition/merkle_update/new_authentication/leaf_0*/ mload(0x4c60),
                sub(PRIME, /*column17_row32752*/ mload(0x47a0)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 32768) - 1.
              // val *= denominator_invs[15].
              val := mulmod(val, mload(0x52c0), PRIME)

              // res += val * (coefficients[166] + coefficients[167] * adjustments[17]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[166]*/ mload(0x1940),
                                       mulmod(/*coefficients[167]*/ mload(0x1960),
                                              /*adjustments[17]*/mload(0x5bc0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for settlement_state_transition/set_prev_root: is_settlement * (column8_row32255 - column10_row14847).
              let val := mulmod(
                /*periodic_column/is_settlement*/ mload(0xc0),
                addmod(
                  /*column8_row32255*/ mload(0x3660),
                  sub(PRIME, /*column10_row14847*/ mload(0x3840)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 65536) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, mload(0x5280), PRIME)

              // res += val * (coefficients[168] + coefficients[169] * adjustments[18]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[168]*/ mload(0x1980),
                                       mulmod(/*coefficients[169]*/ mload(0x19a0),
                                              /*adjustments[18]*/mload(0x5be0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for settlement_state_transition/root_consistency: is_settlement * (column8_row65023 - column12_row32255).
              let val := mulmod(
                /*periodic_column/is_settlement*/ mload(0xc0),
                addmod(
                  /*column8_row65023*/ mload(0x3680),
                  sub(PRIME, /*column12_row32255*/ mload(0x3aa0)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 65536) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, mload(0x5280), PRIME)

              // res += val * (coefficients[170] + coefficients[171] * adjustments[18]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[170]*/ mload(0x19c0),
                                       mulmod(/*coefficients[171]*/ mload(0x19e0),
                                              /*adjustments[18]*/mload(0x5be0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for settlement_state_transition/set_new_root: is_settlement * (column12_row65023 - column10_row47615).
              let val := mulmod(
                /*periodic_column/is_settlement*/ mload(0xc0),
                addmod(
                  /*column12_row65023*/ mload(0x3ac0),
                  sub(PRIME, /*column10_row47615*/ mload(0x3900)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 65536) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, mload(0x5280), PRIME)

              // res += val * (coefficients[172] + coefficients[173] * adjustments[18]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[172]*/ mload(0x1a00),
                                       mulmod(/*coefficients[173]*/ mload(0x1a20),
                                              /*adjustments[18]*/mload(0x5be0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for settlement_state_transition/dont_change_if_modification: is_modification * (column10_row14847 - column10_row47615).
              let val := mulmod(
                /*periodic_column/is_modification*/ mload(0xa0),
                addmod(
                  /*column10_row14847*/ mload(0x3840),
                  sub(PRIME, /*column10_row47615*/ mload(0x3900)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 65536) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, mload(0x5280), PRIME)

              // res += val * (coefficients[174] + coefficients[175] * adjustments[19]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[174]*/ mload(0x1a40),
                                       mulmod(/*coefficients[175]*/ mload(0x1a60),
                                              /*adjustments[19]*/mload(0x5c00),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for amounts_range_check/bit: amounts_range_check__bit_0 * amounts_range_check__bit_0 - amounts_range_check__bit_0.
              let val := addmod(
                mulmod(
                  /*intermediate_value/amounts_range_check/bit_0*/ mload(0x4c80),
                  /*intermediate_value/amounts_range_check/bit_0*/ mload(0x4c80),
                  PRIME),
                sub(PRIME, /*intermediate_value/amounts_range_check/bit_0*/ mload(0x4c80)),
                PRIME)

              // Numerator: point^(trace_length / 4096) - trace_generator^(63 * trace_length / 64).
              // val *= numerators[8].
              val := mulmod(val, mload(0x58e0), PRIME)
              // Denominator: point^(trace_length / 64) - 1.
              // val *= denominator_invs[16].
              val := mulmod(val, mload(0x52e0), PRIME)

              // res += val * (coefficients[176] + coefficients[177] * adjustments[20]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[176]*/ mload(0x1a80),
                                       mulmod(/*coefficients[177]*/ mload(0x1aa0),
                                              /*adjustments[20]*/mload(0x5c20),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for amounts_range_check/zero: column17_row0.
              let val := /*column17_row0*/ mload(0x4200)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 4096) - trace_generator^(63 * trace_length / 64).
              // val *= denominator_invs[17].
              val := mulmod(val, mload(0x5300), PRIME)

              // res += val * (coefficients[178] + coefficients[179] * adjustments[4]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[178]*/ mload(0x1ac0),
                                       mulmod(/*coefficients[179]*/ mload(0x1ae0),
                                              /*adjustments[4]*/mload(0x5a20),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for total_token_a_not_changed: is_settlement * (column16_row3075 + column16_row19459 - (column16_row11267 + column16_row27651)).
              let val := mulmod(
                /*periodic_column/is_settlement*/ mload(0xc0),
                addmod(
                  addmod(/*column16_row3075*/ mload(0x3f60), /*column16_row19459*/ mload(0x40a0), PRIME),
                  sub(
                    PRIME,
                    addmod(/*column16_row11267*/ mload(0x4060), /*column16_row27651*/ mload(0x40c0), PRIME)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 65536) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, mload(0x5280), PRIME)

              // res += val * (coefficients[180] + coefficients[181] * adjustments[18]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[180]*/ mload(0x1b00),
                                       mulmod(/*coefficients[181]*/ mload(0x1b20),
                                              /*adjustments[18]*/mload(0x5be0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for total_token_b_not_changed: is_settlement * (column16_row35843 + column16_row52227 - (column16_row44035 + column16_row60419)).
              let val := mulmod(
                /*periodic_column/is_settlement*/ mload(0xc0),
                addmod(
                  addmod(/*column16_row35843*/ mload(0x4100), /*column16_row52227*/ mload(0x41c0), PRIME),
                  sub(
                    PRIME,
                    addmod(/*column16_row44035*/ mload(0x41a0), /*column16_row60419*/ mload(0x41e0), PRIME)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 65536) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, mload(0x5280), PRIME)

              // res += val * (coefficients[182] + coefficients[183] * adjustments[18]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[182]*/ mload(0x1b40),
                                       mulmod(/*coefficients[183]*/ mload(0x1b60),
                                              /*adjustments[18]*/mload(0x5be0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for party_a_fulfilled_amount: is_settlement * (column17_row32752 - (column17_row16368 + column17_row8192)).
              let val := mulmod(
                /*periodic_column/is_settlement*/ mload(0xc0),
                addmod(
                  /*column17_row32752*/ mload(0x47a0),
                  sub(
                    PRIME,
                    addmod(/*column17_row16368*/ mload(0x45c0), /*column17_row8192*/ mload(0x4500), PRIME)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 65536) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, mload(0x5280), PRIME)

              // res += val * (coefficients[184] + coefficients[185] * adjustments[18]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[184]*/ mload(0x1b80),
                                       mulmod(/*coefficients[185]*/ mload(0x1ba0),
                                              /*adjustments[18]*/mload(0x5be0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for party_b_fulfilled_amount: is_settlement * (column17_row65520 - (column17_row49136 + column17_row40960)).
              let val := mulmod(
                /*periodic_column/is_settlement*/ mload(0xc0),
                addmod(
                  /*column17_row65520*/ mload(0x4980),
                  sub(
                    PRIME,
                    addmod(/*column17_row49136*/ mload(0x48a0), /*column17_row40960*/ mload(0x4820), PRIME)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 65536) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, mload(0x5280), PRIME)

              // res += val * (coefficients[186] + coefficients[187] * adjustments[18]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[186]*/ mload(0x1bc0),
                                       mulmod(/*coefficients[187]*/ mload(0x1be0),
                                              /*adjustments[18]*/mload(0x5be0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for amount_a_range_check_input: (column17_row8192 + column16_row11267 - column16_row3075) * is_settlement.
              let val := mulmod(
                addmod(
                  addmod(/*column17_row8192*/ mload(0x4500), /*column16_row11267*/ mload(0x4060), PRIME),
                  sub(PRIME, /*column16_row3075*/ mload(0x3f60)),
                  PRIME),
                /*periodic_column/is_settlement*/ mload(0xc0),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 65536) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, mload(0x5280), PRIME)

              // res += val * (coefficients[188] + coefficients[189] * adjustments[18]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[188]*/ mload(0x1c00),
                                       mulmod(/*coefficients[189]*/ mload(0x1c20),
                                              /*adjustments[18]*/mload(0x5be0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for amount_b_range_check_input: (column17_row40960 + column16_row44035 - column16_row35843) * is_settlement.
              let val := mulmod(
                addmod(
                  addmod(/*column17_row40960*/ mload(0x4820), /*column16_row44035*/ mload(0x41a0), PRIME),
                  sub(PRIME, /*column16_row35843*/ mload(0x4100)),
                  PRIME),
                /*periodic_column/is_settlement*/ mload(0xc0),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 65536) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, mload(0x5280), PRIME)

              // res += val * (coefficients[190] + coefficients[191] * adjustments[18]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[190]*/ mload(0x1c40),
                                       mulmod(/*coefficients[191]*/ mload(0x1c60),
                                              /*adjustments[18]*/mload(0x5be0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for amounts_range_check_inputs: column17_row0 - column16_row11267.
              let val := addmod(
                /*column17_row0*/ mload(0x4200),
                sub(PRIME, /*column16_row11267*/ mload(0x4060)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 16384) - 1.
              // val *= denominator_invs[12].
              val := mulmod(val, mload(0x5260), PRIME)

              // res += val * (coefficients[192] + coefficients[193] * adjustments[6]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[192]*/ mload(0x1c80),
                                       mulmod(/*coefficients[193]*/ mload(0x1ca0),
                                              /*adjustments[6]*/mload(0x5a60),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for ratio_party_a: column17_row40960 * column17_row4096 - (column17_row8192 * column17_row36864 + column17_row12288 + column17_row28672 * amount_shift).
              let val := addmod(
                mulmod(/*column17_row40960*/ mload(0x4820), /*column17_row4096*/ mload(0x44e0), PRIME),
                sub(
                  PRIME,
                  addmod(
                    addmod(
                      mulmod(/*column17_row8192*/ mload(0x4500), /*column17_row36864*/ mload(0x4800), PRIME),
                      /*column17_row12288*/ mload(0x4520),
                      PRIME),
                    mulmod(/*column17_row28672*/ mload(0x4680), /*amount_shift*/ mload(0x2c0), PRIME),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 65536) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, mload(0x5280), PRIME)

              // res += val * (coefficients[194] + coefficients[195] * adjustments[21]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[194]*/ mload(0x1cc0),
                                       mulmod(/*coefficients[195]*/ mload(0x1ce0),
                                              /*adjustments[21]*/mload(0x5c40),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for ratio_party_b: column17_row8192 * column17_row53248 - (column17_row40960 * column17_row20480 + column17_row45056 + column17_row61440 * amount_shift).
              let val := addmod(
                mulmod(/*column17_row8192*/ mload(0x4500), /*column17_row53248*/ mload(0x48c0), PRIME),
                sub(
                  PRIME,
                  addmod(
                    addmod(
                      mulmod(/*column17_row40960*/ mload(0x4820), /*column17_row20480*/ mload(0x4620), PRIME),
                      /*column17_row45056*/ mload(0x4840),
                      PRIME),
                    mulmod(/*column17_row61440*/ mload(0x4920), /*amount_shift*/ mload(0x2c0), PRIME),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 65536) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, mload(0x5280), PRIME)

              // res += val * (coefficients[196] + coefficients[197] * adjustments[21]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[196]*/ mload(0x1d00),
                                       mulmod(/*coefficients[197]*/ mload(0x1d20),
                                              /*adjustments[21]*/mload(0x5c40),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for capacity_party_a: column17_row24576 + column17_row32752 - column17_row4096.
              let val := addmod(
                addmod(/*column17_row24576*/ mload(0x4660), /*column17_row32752*/ mload(0x47a0), PRIME),
                sub(PRIME, /*column17_row4096*/ mload(0x44e0)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 65536) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, mload(0x5280), PRIME)

              // res += val * (coefficients[198] + coefficients[199] * adjustments[22]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[198]*/ mload(0x1d40),
                                       mulmod(/*coefficients[199]*/ mload(0x1d60),
                                              /*adjustments[22]*/mload(0x5c60),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for capacity_party_b: column17_row57344 + column17_row65520 - column17_row53248.
              let val := addmod(
                addmod(/*column17_row57344*/ mload(0x4900), /*column17_row65520*/ mload(0x4980), PRIME),
                sub(PRIME, /*column17_row53248*/ mload(0x48c0)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 65536) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, mload(0x5280), PRIME)

              // res += val * (coefficients[200] + coefficients[201] * adjustments[22]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[200]*/ mload(0x1d80),
                                       mulmod(/*coefficients[201]*/ mload(0x1da0),
                                              /*adjustments[22]*/mload(0x5c60),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for expiration_timestamp_range_check/bit: expiration_timestamp_range_check__bit_0 * expiration_timestamp_range_check__bit_0 - expiration_timestamp_range_check__bit_0.
              let val := addmod(
                mulmod(
                  /*intermediate_value/expiration_timestamp_range_check/bit_0*/ mload(0x4ca0),
                  /*intermediate_value/expiration_timestamp_range_check/bit_0*/ mload(0x4ca0),
                  PRIME),
                sub(
                  PRIME,
                  /*intermediate_value/expiration_timestamp_range_check/bit_0*/ mload(0x4ca0)),
                PRIME)

              // Numerator: point^(trace_length / 16384) - trace_generator^(31 * trace_length / 32).
              // val *= numerators[2].
              val := mulmod(val, mload(0x5820), PRIME)
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[6].
              val := mulmod(val, mload(0x51a0), PRIME)

              // res += val * (coefficients[202] + coefficients[203] * adjustments[5]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[202]*/ mload(0x1dc0),
                                       mulmod(/*coefficients[203]*/ mload(0x1de0),
                                              /*adjustments[5]*/mload(0x5a40),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for expiration_timestamp_range_check/zero: column10_row255.
              let val := /*column10_row255*/ mload(0x3740)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 16384) - trace_generator^(11 * trace_length / 16).
              // val *= denominator_invs[18].
              val := mulmod(val, mload(0x5320), PRIME)

              // res += val * (coefficients[204] + coefficients[205] * adjustments[6]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[204]*/ mload(0x1e00),
                                       mulmod(/*coefficients[205]*/ mload(0x1e20),
                                              /*adjustments[6]*/mload(0x5a60),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for expiration_timestamp_range_check_input: column10_row16639 + global_expiration_timestamp_elm - column10_row255.
              let val := addmod(
                addmod(
                  /*column10_row16639*/ mload(0x3860),
                  /*global_expiration_timestamp_elm*/ mload(0x2e0),
                  PRIME),
                sub(PRIME, /*column10_row255*/ mload(0x3740)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 32768) - 1.
              // val *= denominator_invs[15].
              val := mulmod(val, mload(0x52c0), PRIME)

              // res += val * (coefficients[206] + coefficients[207] * adjustments[15]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[206]*/ mload(0x1e40),
                                       mulmod(/*coefficients[207]*/ mload(0x1e60),
                                              /*adjustments[15]*/mload(0x5b80),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for nonce_range_check/bit: nonce_range_check__bit_0 * nonce_range_check__bit_0 - nonce_range_check__bit_0.
              let val := addmod(
                mulmod(
                  /*intermediate_value/nonce_range_check/bit_0*/ mload(0x4cc0),
                  /*intermediate_value/nonce_range_check/bit_0*/ mload(0x4cc0),
                  PRIME),
                sub(PRIME, /*intermediate_value/nonce_range_check/bit_0*/ mload(0x4cc0)),
                PRIME)

              // Numerator: point^(trace_length / 32768) - trace_generator^(31 * trace_length / 32).
              // val *= numerators[9].
              val := mulmod(val, mload(0x5900), PRIME)
              // Denominator: point^(trace_length / 1024) - 1.
              // val *= denominator_invs[3].
              val := mulmod(val, mload(0x5140), PRIME)

              // res += val * (coefficients[208] + coefficients[209] * adjustments[23]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[208]*/ mload(0x1e80),
                                       mulmod(/*coefficients[209]*/ mload(0x1ea0),
                                              /*adjustments[23]*/mload(0x5c80),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for nonce_range_check/zero: column16_row1021.
              let val := /*column16_row1021*/ mload(0x3e60)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 32768) - trace_generator^(31 * trace_length / 32).
              // val *= denominator_invs[19].
              val := mulmod(val, mload(0x5340), PRIME)

              // res += val * (coefficients[210] + coefficients[211] * adjustments[15]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[210]*/ mload(0x1ec0),
                                       mulmod(/*coefficients[211]*/ mload(0x1ee0),
                                              /*adjustments[15]*/mload(0x5b80),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for is_transfer/bit: column10_row31231 * column10_row31231 - column10_row31231.
              let val := addmod(
                mulmod(/*column10_row31231*/ mload(0x38c0), /*column10_row31231*/ mload(0x38c0), PRIME),
                sub(PRIME, /*column10_row31231*/ mload(0x38c0)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 65536) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, mload(0x5280), PRIME)

              // res += val * (coefficients[212] + coefficients[213] * adjustments[21]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[212]*/ mload(0x1f00),
                                       mulmod(/*coefficients[213]*/ mload(0x1f20),
                                              /*adjustments[21]*/mload(0x5c40),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for is_transfer/modification: is_modification * (1 - column10_row31231).
              let val := mulmod(
                /*periodic_column/is_modification*/ mload(0xa0),
                addmod(1, sub(PRIME, /*column10_row31231*/ mload(0x38c0)), PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 65536) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, mload(0x5280), PRIME)

              // res += val * (coefficients[214] + coefficients[215] * adjustments[19]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[214]*/ mload(0x1f40),
                                       mulmod(/*coefficients[215]*/ mload(0x1f60),
                                              /*adjustments[19]*/mload(0x5c00),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for transfer/party_a_sold: column17_row8192 * column10_row31231.
              let val := mulmod(/*column17_row8192*/ mload(0x4500), /*column10_row31231*/ mload(0x38c0), PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 65536) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, mload(0x5280), PRIME)

              // res += val * (coefficients[216] + coefficients[217] * adjustments[21]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[216]*/ mload(0x1f80),
                                       mulmod(/*coefficients[217]*/ mload(0x1fa0),
                                              /*adjustments[21]*/mload(0x5c40),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for transfer/party_b_buy: column17_row20480 * column10_row31231.
              let val := mulmod(/*column17_row20480*/ mload(0x4620), /*column10_row31231*/ mload(0x38c0), PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 65536) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, mload(0x5280), PRIME)

              // res += val * (coefficients[218] + coefficients[219] * adjustments[21]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[218]*/ mload(0x1fc0),
                                       mulmod(/*coefficients[219]*/ mload(0x1fe0),
                                              /*adjustments[21]*/mload(0x5c40),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for transfer/party_a_sell: (column17_row4096 + 1 - amount_shift) * column10_row31231.
              let val := mulmod(
                addmod(
                  addmod(/*column17_row4096*/ mload(0x44e0), 1, PRIME),
                  sub(PRIME, /*amount_shift*/ mload(0x2c0)),
                  PRIME),
                /*column10_row31231*/ mload(0x38c0),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 65536) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, mload(0x5280), PRIME)

              // res += val * (coefficients[220] + coefficients[221] * adjustments[21]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[220]*/ mload(0x2000),
                                       mulmod(/*coefficients[221]*/ mload(0x2020),
                                              /*adjustments[21]*/mload(0x5c40),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for transfer/party_b_exact_transferred: column10_row31231 * (column17_row40960 - column17_row53248).
              let val := mulmod(
                /*column10_row31231*/ mload(0x38c0),
                addmod(
                  /*column17_row40960*/ mload(0x4820),
                  sub(PRIME, /*column17_row53248*/ mload(0x48c0)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 65536) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, mload(0x5280), PRIME)

              // res += val * (coefficients[222] + coefficients[223] * adjustments[21]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[222]*/ mload(0x2040),
                                       mulmod(/*coefficients[223]*/ mload(0x2060),
                                              /*adjustments[21]*/mload(0x5c40),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for sig_verify/doubling_key/slope: sig_verify__doubling_key__x_squared + sig_verify__doubling_key__x_squared + sig_verify__doubling_key__x_squared + sig_config.alpha - (column17_row16 + column17_row16) * column17_row48.
              let val := addmod(
                addmod(
                  addmod(
                    addmod(
                      /*intermediate_value/sig_verify/doubling_key/x_squared*/ mload(0x4ce0),
                      /*intermediate_value/sig_verify/doubling_key/x_squared*/ mload(0x4ce0),
                      PRIME),
                    /*intermediate_value/sig_verify/doubling_key/x_squared*/ mload(0x4ce0),
                    PRIME),
                  /*sig_config.alpha*/ mload(0x300),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    addmod(/*column17_row16*/ mload(0x4260), /*column17_row16*/ mload(0x4260), PRIME),
                    /*column17_row48*/ mload(0x4320),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 16384) - trace_generator^(255 * trace_length / 256).
              // val *= numerators[10].
              val := mulmod(val, mload(0x5920), PRIME)
              // Denominator: point^(trace_length / 64) - 1.
              // val *= denominator_invs[16].
              val := mulmod(val, mload(0x52e0), PRIME)

              // res += val * (coefficients[224] + coefficients[225] * adjustments[24]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[224]*/ mload(0x2080),
                                       mulmod(/*coefficients[225]*/ mload(0x20a0),
                                              /*adjustments[24]*/mload(0x5ca0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for sig_verify/doubling_key/x: column17_row48 * column17_row48 - (column17_row32 + column17_row32 + column17_row96).
              let val := addmod(
                mulmod(/*column17_row48*/ mload(0x4320), /*column17_row48*/ mload(0x4320), PRIME),
                sub(
                  PRIME,
                  addmod(
                    addmod(/*column17_row32*/ mload(0x42c0), /*column17_row32*/ mload(0x42c0), PRIME),
                    /*column17_row96*/ mload(0x4400),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 16384) - trace_generator^(255 * trace_length / 256).
              // val *= numerators[10].
              val := mulmod(val, mload(0x5920), PRIME)
              // Denominator: point^(trace_length / 64) - 1.
              // val *= denominator_invs[16].
              val := mulmod(val, mload(0x52e0), PRIME)

              // res += val * (coefficients[226] + coefficients[227] * adjustments[24]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[226]*/ mload(0x20c0),
                                       mulmod(/*coefficients[227]*/ mload(0x20e0),
                                              /*adjustments[24]*/mload(0x5ca0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for sig_verify/doubling_key/y: column17_row16 + column17_row80 - column17_row48 * (column17_row32 - column17_row96).
              let val := addmod(
                addmod(/*column17_row16*/ mload(0x4260), /*column17_row80*/ mload(0x43c0), PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*column17_row48*/ mload(0x4320),
                    addmod(
                      /*column17_row32*/ mload(0x42c0),
                      sub(PRIME, /*column17_row96*/ mload(0x4400)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 16384) - trace_generator^(255 * trace_length / 256).
              // val *= numerators[10].
              val := mulmod(val, mload(0x5920), PRIME)
              // Denominator: point^(trace_length / 64) - 1.
              // val *= denominator_invs[16].
              val := mulmod(val, mload(0x52e0), PRIME)

              // res += val * (coefficients[228] + coefficients[229] * adjustments[24]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[228]*/ mload(0x2100),
                                       mulmod(/*coefficients[229]*/ mload(0x2120),
                                              /*adjustments[24]*/mload(0x5ca0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for sig_verify/exponentiate_generator/booleanity_test: sig_verify__exponentiate_generator__bit * (sig_verify__exponentiate_generator__bit - 1).
              let val := mulmod(
                /*intermediate_value/sig_verify/exponentiate_generator/bit*/ mload(0x4d00),
                addmod(
                  /*intermediate_value/sig_verify/exponentiate_generator/bit*/ mload(0x4d00),
                  sub(PRIME, 1),
                  PRIME),
                PRIME)

              // Numerator: point^(trace_length / 32768) - trace_generator^(255 * trace_length / 256).
              // val *= numerators[11].
              val := mulmod(val, mload(0x5940), PRIME)
              // Denominator: point^(trace_length / 128) - 1.
              // val *= denominator_invs[20].
              val := mulmod(val, mload(0x5360), PRIME)

              // res += val * (coefficients[230] + coefficients[231] * adjustments[25]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[230]*/ mload(0x2140),
                                       mulmod(/*coefficients[231]*/ mload(0x2160),
                                              /*adjustments[25]*/mload(0x5cc0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for sig_verify/exponentiate_generator/bit_extraction_end: column17_row84.
              let val := /*column17_row84*/ mload(0x43e0)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 32768) - trace_generator^(251 * trace_length / 256).
              // val *= denominator_invs[21].
              val := mulmod(val, mload(0x5380), PRIME)

              // res += val * (coefficients[232] + coefficients[233] * adjustments[15]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[232]*/ mload(0x2180),
                                       mulmod(/*coefficients[233]*/ mload(0x21a0),
                                              /*adjustments[15]*/mload(0x5b80),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for sig_verify/exponentiate_generator/zeros_tail: column17_row84.
              let val := /*column17_row84*/ mload(0x43e0)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 32768) - trace_generator^(255 * trace_length / 256).
              // val *= denominator_invs[22].
              val := mulmod(val, mload(0x53a0), PRIME)

              // res += val * (coefficients[234] + coefficients[235] * adjustments[15]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[234]*/ mload(0x21c0),
                                       mulmod(/*coefficients[235]*/ mload(0x21e0),
                                              /*adjustments[15]*/mload(0x5b80),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for sig_verify/exponentiate_generator/add_points/slope: sig_verify__exponentiate_generator__bit * (column17_row100 - ecdsa_points__y) - column17_row20 * (column17_row36 - ecdsa_points__x).
              let val := addmod(
                mulmod(
                  /*intermediate_value/sig_verify/exponentiate_generator/bit*/ mload(0x4d00),
                  addmod(
                    /*column17_row100*/ mload(0x4420),
                    sub(PRIME, /*periodic_column/ecdsa_points/y*/ mload(0x1e0)),
                    PRIME),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*column17_row20*/ mload(0x4280),
                    addmod(
                      /*column17_row36*/ mload(0x42e0),
                      sub(PRIME, /*periodic_column/ecdsa_points/x*/ mload(0x1c0)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 32768) - trace_generator^(255 * trace_length / 256).
              // val *= numerators[11].
              val := mulmod(val, mload(0x5940), PRIME)
              // Denominator: point^(trace_length / 128) - 1.
              // val *= denominator_invs[20].
              val := mulmod(val, mload(0x5360), PRIME)

              // res += val * (coefficients[236] + coefficients[237] * adjustments[25]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[236]*/ mload(0x2200),
                                       mulmod(/*coefficients[237]*/ mload(0x2220),
                                              /*adjustments[25]*/mload(0x5cc0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for sig_verify/exponentiate_generator/add_points/x: column17_row20 * column17_row20 - sig_verify__exponentiate_generator__bit * (column17_row36 + ecdsa_points__x + column17_row164).
              let val := addmod(
                mulmod(/*column17_row20*/ mload(0x4280), /*column17_row20*/ mload(0x4280), PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*intermediate_value/sig_verify/exponentiate_generator/bit*/ mload(0x4d00),
                    addmod(
                      addmod(
                        /*column17_row36*/ mload(0x42e0),
                        /*periodic_column/ecdsa_points/x*/ mload(0x1c0),
                        PRIME),
                      /*column17_row164*/ mload(0x4480),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 32768) - trace_generator^(255 * trace_length / 256).
              // val *= numerators[11].
              val := mulmod(val, mload(0x5940), PRIME)
              // Denominator: point^(trace_length / 128) - 1.
              // val *= denominator_invs[20].
              val := mulmod(val, mload(0x5360), PRIME)

              // res += val * (coefficients[238] + coefficients[239] * adjustments[25]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[238]*/ mload(0x2240),
                                       mulmod(/*coefficients[239]*/ mload(0x2260),
                                              /*adjustments[25]*/mload(0x5cc0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for sig_verify/exponentiate_generator/add_points/y: sig_verify__exponentiate_generator__bit * (column17_row100 + column17_row228) - column17_row20 * (column17_row36 - column17_row164).
              let val := addmod(
                mulmod(
                  /*intermediate_value/sig_verify/exponentiate_generator/bit*/ mload(0x4d00),
                  addmod(/*column17_row100*/ mload(0x4420), /*column17_row228*/ mload(0x44c0), PRIME),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*column17_row20*/ mload(0x4280),
                    addmod(
                      /*column17_row36*/ mload(0x42e0),
                      sub(PRIME, /*column17_row164*/ mload(0x4480)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 32768) - trace_generator^(255 * trace_length / 256).
              // val *= numerators[11].
              val := mulmod(val, mload(0x5940), PRIME)
              // Denominator: point^(trace_length / 128) - 1.
              // val *= denominator_invs[20].
              val := mulmod(val, mload(0x5360), PRIME)

              // res += val * (coefficients[240] + coefficients[241] * adjustments[25]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[240]*/ mload(0x2280),
                                       mulmod(/*coefficients[241]*/ mload(0x22a0),
                                              /*adjustments[25]*/mload(0x5cc0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for sig_verify/exponentiate_generator/add_points/x_diff_inv: column17_row52 * (column17_row36 - ecdsa_points__x) - 1.
              let val := addmod(
                mulmod(
                  /*column17_row52*/ mload(0x4340),
                  addmod(
                    /*column17_row36*/ mload(0x42e0),
                    sub(PRIME, /*periodic_column/ecdsa_points/x*/ mload(0x1c0)),
                    PRIME),
                  PRIME),
                sub(PRIME, 1),
                PRIME)

              // Numerator: point^(trace_length / 32768) - trace_generator^(255 * trace_length / 256).
              // val *= numerators[11].
              val := mulmod(val, mload(0x5940), PRIME)
              // Denominator: point^(trace_length / 128) - 1.
              // val *= denominator_invs[20].
              val := mulmod(val, mload(0x5360), PRIME)

              // res += val * (coefficients[242] + coefficients[243] * adjustments[25]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[242]*/ mload(0x22c0),
                                       mulmod(/*coefficients[243]*/ mload(0x22e0),
                                              /*adjustments[25]*/mload(0x5cc0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for sig_verify/exponentiate_generator/copy_point/x: sig_verify__exponentiate_generator__bit_neg * (column17_row164 - column17_row36).
              let val := mulmod(
                /*intermediate_value/sig_verify/exponentiate_generator/bit_neg*/ mload(0x4d20),
                addmod(
                  /*column17_row164*/ mload(0x4480),
                  sub(PRIME, /*column17_row36*/ mload(0x42e0)),
                  PRIME),
                PRIME)

              // Numerator: point^(trace_length / 32768) - trace_generator^(255 * trace_length / 256).
              // val *= numerators[11].
              val := mulmod(val, mload(0x5940), PRIME)
              // Denominator: point^(trace_length / 128) - 1.
              // val *= denominator_invs[20].
              val := mulmod(val, mload(0x5360), PRIME)

              // res += val * (coefficients[244] + coefficients[245] * adjustments[25]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[244]*/ mload(0x2300),
                                       mulmod(/*coefficients[245]*/ mload(0x2320),
                                              /*adjustments[25]*/mload(0x5cc0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for sig_verify/exponentiate_generator/copy_point/y: sig_verify__exponentiate_generator__bit_neg * (column17_row228 - column17_row100).
              let val := mulmod(
                /*intermediate_value/sig_verify/exponentiate_generator/bit_neg*/ mload(0x4d20),
                addmod(
                  /*column17_row228*/ mload(0x44c0),
                  sub(PRIME, /*column17_row100*/ mload(0x4420)),
                  PRIME),
                PRIME)

              // Numerator: point^(trace_length / 32768) - trace_generator^(255 * trace_length / 256).
              // val *= numerators[11].
              val := mulmod(val, mload(0x5940), PRIME)
              // Denominator: point^(trace_length / 128) - 1.
              // val *= denominator_invs[20].
              val := mulmod(val, mload(0x5360), PRIME)

              // res += val * (coefficients[246] + coefficients[247] * adjustments[25]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[246]*/ mload(0x2340),
                                       mulmod(/*coefficients[247]*/ mload(0x2360),
                                              /*adjustments[25]*/mload(0x5cc0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for sig_verify/exponentiate_key/booleanity_test: sig_verify__exponentiate_key__bit * (sig_verify__exponentiate_key__bit - 1).
              let val := mulmod(
                /*intermediate_value/sig_verify/exponentiate_key/bit*/ mload(0x4d40),
                addmod(
                  /*intermediate_value/sig_verify/exponentiate_key/bit*/ mload(0x4d40),
                  sub(PRIME, 1),
                  PRIME),
                PRIME)

              // Numerator: point^(trace_length / 16384) - trace_generator^(255 * trace_length / 256).
              // val *= numerators[10].
              val := mulmod(val, mload(0x5920), PRIME)
              // Denominator: point^(trace_length / 64) - 1.
              // val *= denominator_invs[16].
              val := mulmod(val, mload(0x52e0), PRIME)

              // res += val * (coefficients[248] + coefficients[249] * adjustments[24]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[248]*/ mload(0x2380),
                                       mulmod(/*coefficients[249]*/ mload(0x23a0),
                                              /*adjustments[24]*/mload(0x5ca0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for sig_verify/exponentiate_key/bit_extraction_end: column17_row56.
              let val := /*column17_row56*/ mload(0x4360)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 16384) - trace_generator^(251 * trace_length / 256).
              // val *= denominator_invs[23].
              val := mulmod(val, mload(0x53c0), PRIME)

              // res += val * (coefficients[250] + coefficients[251] * adjustments[6]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[250]*/ mload(0x23c0),
                                       mulmod(/*coefficients[251]*/ mload(0x23e0),
                                              /*adjustments[6]*/mload(0x5a60),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for sig_verify/exponentiate_key/zeros_tail: column17_row56.
              let val := /*column17_row56*/ mload(0x4360)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 16384) - trace_generator^(255 * trace_length / 256).
              // val *= denominator_invs[24].
              val := mulmod(val, mload(0x53e0), PRIME)

              // res += val * (coefficients[252] + coefficients[253] * adjustments[6]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[252]*/ mload(0x2400),
                                       mulmod(/*coefficients[253]*/ mload(0x2420),
                                              /*adjustments[6]*/mload(0x5a60),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for sig_verify/exponentiate_key/add_points/slope: sig_verify__exponentiate_key__bit * (column17_row40 - column17_row16) - column17_row24 * (column17_row8 - column17_row32).
              let val := addmod(
                mulmod(
                  /*intermediate_value/sig_verify/exponentiate_key/bit*/ mload(0x4d40),
                  addmod(
                    /*column17_row40*/ mload(0x4300),
                    sub(PRIME, /*column17_row16*/ mload(0x4260)),
                    PRIME),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*column17_row24*/ mload(0x42a0),
                    addmod(
                      /*column17_row8*/ mload(0x4240),
                      sub(PRIME, /*column17_row32*/ mload(0x42c0)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 16384) - trace_generator^(255 * trace_length / 256).
              // val *= numerators[10].
              val := mulmod(val, mload(0x5920), PRIME)
              // Denominator: point^(trace_length / 64) - 1.
              // val *= denominator_invs[16].
              val := mulmod(val, mload(0x52e0), PRIME)

              // res += val * (coefficients[254] + coefficients[255] * adjustments[24]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[254]*/ mload(0x2440),
                                       mulmod(/*coefficients[255]*/ mload(0x2460),
                                              /*adjustments[24]*/mload(0x5ca0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for sig_verify/exponentiate_key/add_points/x: column17_row24 * column17_row24 - sig_verify__exponentiate_key__bit * (column17_row8 + column17_row32 + column17_row72).
              let val := addmod(
                mulmod(/*column17_row24*/ mload(0x42a0), /*column17_row24*/ mload(0x42a0), PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*intermediate_value/sig_verify/exponentiate_key/bit*/ mload(0x4d40),
                    addmod(
                      addmod(/*column17_row8*/ mload(0x4240), /*column17_row32*/ mload(0x42c0), PRIME),
                      /*column17_row72*/ mload(0x43a0),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 16384) - trace_generator^(255 * trace_length / 256).
              // val *= numerators[10].
              val := mulmod(val, mload(0x5920), PRIME)
              // Denominator: point^(trace_length / 64) - 1.
              // val *= denominator_invs[16].
              val := mulmod(val, mload(0x52e0), PRIME)

              // res += val * (coefficients[256] + coefficients[257] * adjustments[24]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[256]*/ mload(0x2480),
                                       mulmod(/*coefficients[257]*/ mload(0x24a0),
                                              /*adjustments[24]*/mload(0x5ca0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for sig_verify/exponentiate_key/add_points/y: sig_verify__exponentiate_key__bit * (column17_row40 + column17_row104) - column17_row24 * (column17_row8 - column17_row72).
              let val := addmod(
                mulmod(
                  /*intermediate_value/sig_verify/exponentiate_key/bit*/ mload(0x4d40),
                  addmod(/*column17_row40*/ mload(0x4300), /*column17_row104*/ mload(0x4440), PRIME),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*column17_row24*/ mload(0x42a0),
                    addmod(
                      /*column17_row8*/ mload(0x4240),
                      sub(PRIME, /*column17_row72*/ mload(0x43a0)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 16384) - trace_generator^(255 * trace_length / 256).
              // val *= numerators[10].
              val := mulmod(val, mload(0x5920), PRIME)
              // Denominator: point^(trace_length / 64) - 1.
              // val *= denominator_invs[16].
              val := mulmod(val, mload(0x52e0), PRIME)

              // res += val * (coefficients[258] + coefficients[259] * adjustments[24]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[258]*/ mload(0x24c0),
                                       mulmod(/*coefficients[259]*/ mload(0x24e0),
                                              /*adjustments[24]*/mload(0x5ca0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for sig_verify/exponentiate_key/add_points/x_diff_inv: column17_row4 * (column17_row8 - column17_row32) - 1.
              let val := addmod(
                mulmod(
                  /*column17_row4*/ mload(0x4220),
                  addmod(
                    /*column17_row8*/ mload(0x4240),
                    sub(PRIME, /*column17_row32*/ mload(0x42c0)),
                    PRIME),
                  PRIME),
                sub(PRIME, 1),
                PRIME)

              // Numerator: point^(trace_length / 16384) - trace_generator^(255 * trace_length / 256).
              // val *= numerators[10].
              val := mulmod(val, mload(0x5920), PRIME)
              // Denominator: point^(trace_length / 64) - 1.
              // val *= denominator_invs[16].
              val := mulmod(val, mload(0x52e0), PRIME)

              // res += val * (coefficients[260] + coefficients[261] * adjustments[24]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[260]*/ mload(0x2500),
                                       mulmod(/*coefficients[261]*/ mload(0x2520),
                                              /*adjustments[24]*/mload(0x5ca0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for sig_verify/exponentiate_key/copy_point/x: sig_verify__exponentiate_key__bit_neg * (column17_row72 - column17_row8).
              let val := mulmod(
                /*intermediate_value/sig_verify/exponentiate_key/bit_neg*/ mload(0x4d60),
                addmod(
                  /*column17_row72*/ mload(0x43a0),
                  sub(PRIME, /*column17_row8*/ mload(0x4240)),
                  PRIME),
                PRIME)

              // Numerator: point^(trace_length / 16384) - trace_generator^(255 * trace_length / 256).
              // val *= numerators[10].
              val := mulmod(val, mload(0x5920), PRIME)
              // Denominator: point^(trace_length / 64) - 1.
              // val *= denominator_invs[16].
              val := mulmod(val, mload(0x52e0), PRIME)

              // res += val * (coefficients[262] + coefficients[263] * adjustments[24]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[262]*/ mload(0x2540),
                                       mulmod(/*coefficients[263]*/ mload(0x2560),
                                              /*adjustments[24]*/mload(0x5ca0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for sig_verify/exponentiate_key/copy_point/y: sig_verify__exponentiate_key__bit_neg * (column17_row104 - column17_row40).
              let val := mulmod(
                /*intermediate_value/sig_verify/exponentiate_key/bit_neg*/ mload(0x4d60),
                addmod(
                  /*column17_row104*/ mload(0x4440),
                  sub(PRIME, /*column17_row40*/ mload(0x4300)),
                  PRIME),
                PRIME)

              // Numerator: point^(trace_length / 16384) - trace_generator^(255 * trace_length / 256).
              // val *= numerators[10].
              val := mulmod(val, mload(0x5920), PRIME)
              // Denominator: point^(trace_length / 64) - 1.
              // val *= denominator_invs[16].
              val := mulmod(val, mload(0x52e0), PRIME)

              // res += val * (coefficients[264] + coefficients[265] * adjustments[24]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[264]*/ mload(0x2580),
                                       mulmod(/*coefficients[265]*/ mload(0x25a0),
                                              /*adjustments[24]*/mload(0x5ca0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for sig_verify/init_gen/x: column17_row36 - sig_config.shift_point.x.
              let val := addmod(/*column17_row36*/ mload(0x42e0), sub(PRIME, /*shift_point.x*/ mload(0x220)), PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 32768) - 1.
              // val *= denominator_invs[15].
              val := mulmod(val, mload(0x52c0), PRIME)

              // res += val * (coefficients[266] + coefficients[267] * adjustments[15]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[266]*/ mload(0x25c0),
                                       mulmod(/*coefficients[267]*/ mload(0x25e0),
                                              /*adjustments[15]*/mload(0x5b80),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for sig_verify/init_gen/y: column17_row100 + sig_config.shift_point.y.
              let val := addmod(/*column17_row100*/ mload(0x4420), /*shift_point.y*/ mload(0x240), PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 32768) - 1.
              // val *= denominator_invs[15].
              val := mulmod(val, mload(0x52c0), PRIME)

              // res += val * (coefficients[268] + coefficients[269] * adjustments[15]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[268]*/ mload(0x2600),
                                       mulmod(/*coefficients[269]*/ mload(0x2620),
                                              /*adjustments[15]*/mload(0x5b80),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for sig_verify/init_key/x: column17_row8 - sig_config.shift_point.x.
              let val := addmod(/*column17_row8*/ mload(0x4240), sub(PRIME, /*shift_point.x*/ mload(0x220)), PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 16384) - 1.
              // val *= denominator_invs[12].
              val := mulmod(val, mload(0x5260), PRIME)

              // res += val * (coefficients[270] + coefficients[271] * adjustments[6]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[270]*/ mload(0x2640),
                                       mulmod(/*coefficients[271]*/ mload(0x2660),
                                              /*adjustments[6]*/mload(0x5a60),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for sig_verify/init_key/y: column17_row40 - sig_config.shift_point.y.
              let val := addmod(/*column17_row40*/ mload(0x4300), sub(PRIME, /*shift_point.y*/ mload(0x240)), PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 16384) - 1.
              // val *= denominator_invs[12].
              val := mulmod(val, mload(0x5260), PRIME)

              // res += val * (coefficients[272] + coefficients[273] * adjustments[6]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[272]*/ mload(0x2680),
                                       mulmod(/*coefficients[273]*/ mload(0x26a0),
                                              /*adjustments[6]*/mload(0x5a60),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for sig_verify/add_results/slope: column17_row32740 - (column17_row16360 + column17_row32692 * (column17_row32676 - column17_row16328)).
              let val := addmod(
                /*column17_row32740*/ mload(0x4760),
                sub(
                  PRIME,
                  addmod(
                    /*column17_row16360*/ mload(0x45a0),
                    mulmod(
                      /*column17_row32692*/ mload(0x46e0),
                      addmod(
                        /*column17_row32676*/ mload(0x46c0),
                        sub(PRIME, /*column17_row16328*/ mload(0x4560)),
                        PRIME),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 32768) - 1.
              // val *= denominator_invs[15].
              val := mulmod(val, mload(0x52c0), PRIME)

              // res += val * (coefficients[274] + coefficients[275] * adjustments[17]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[274]*/ mload(0x26c0),
                                       mulmod(/*coefficients[275]*/ mload(0x26e0),
                                              /*adjustments[17]*/mload(0x5bc0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for sig_verify/add_results/x: column17_row32692 * column17_row32692 - (column17_row32676 + column17_row16328 + column17_row16416).
              let val := addmod(
                mulmod(/*column17_row32692*/ mload(0x46e0), /*column17_row32692*/ mload(0x46e0), PRIME),
                sub(
                  PRIME,
                  addmod(
                    addmod(/*column17_row32676*/ mload(0x46c0), /*column17_row16328*/ mload(0x4560), PRIME),
                    /*column17_row16416*/ mload(0x4600),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 32768) - 1.
              // val *= denominator_invs[15].
              val := mulmod(val, mload(0x52c0), PRIME)

              // res += val * (coefficients[276] + coefficients[277] * adjustments[17]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[276]*/ mload(0x2700),
                                       mulmod(/*coefficients[277]*/ mload(0x2720),
                                              /*adjustments[17]*/mload(0x5bc0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for sig_verify/add_results/y: column17_row32740 + column17_row16400 - column17_row32692 * (column17_row32676 - column17_row16416).
              let val := addmod(
                addmod(/*column17_row32740*/ mload(0x4760), /*column17_row16400*/ mload(0x45e0), PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*column17_row32692*/ mload(0x46e0),
                    addmod(
                      /*column17_row32676*/ mload(0x46c0),
                      sub(PRIME, /*column17_row16416*/ mload(0x4600)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 32768) - 1.
              // val *= denominator_invs[15].
              val := mulmod(val, mload(0x52c0), PRIME)

              // res += val * (coefficients[278] + coefficients[279] * adjustments[17]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[278]*/ mload(0x2740),
                                       mulmod(/*coefficients[279]*/ mload(0x2760),
                                              /*adjustments[17]*/mload(0x5bc0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for sig_verify/add_results/x_diff_inv: column17_row32660 * (column17_row32676 - column17_row16328) - 1.
              let val := addmod(
                mulmod(
                  /*column17_row32660*/ mload(0x46a0),
                  addmod(
                    /*column17_row32676*/ mload(0x46c0),
                    sub(PRIME, /*column17_row16328*/ mload(0x4560)),
                    PRIME),
                  PRIME),
                sub(PRIME, 1),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 32768) - 1.
              // val *= denominator_invs[15].
              val := mulmod(val, mload(0x52c0), PRIME)

              // res += val * (coefficients[280] + coefficients[281] * adjustments[17]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[280]*/ mload(0x2780),
                                       mulmod(/*coefficients[281]*/ mload(0x27a0),
                                              /*adjustments[17]*/mload(0x5bc0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for sig_verify/extract_r/slope: column17_row32744 + sig_config.shift_point.y - column10_row10751 * (column17_row32712 - sig_config.shift_point.x).
              let val := addmod(
                addmod(/*column17_row32744*/ mload(0x4780), /*shift_point.y*/ mload(0x240), PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*column10_row10751*/ mload(0x3820),
                    addmod(
                      /*column17_row32712*/ mload(0x4720),
                      sub(PRIME, /*shift_point.x*/ mload(0x220)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 32768) - 1.
              // val *= denominator_invs[15].
              val := mulmod(val, mload(0x52c0), PRIME)

              // res += val * (coefficients[282] + coefficients[283] * adjustments[17]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[282]*/ mload(0x27c0),
                                       mulmod(/*coefficients[283]*/ mload(0x27e0),
                                              /*adjustments[17]*/mload(0x5bc0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for sig_verify/extract_r/x: column10_row10751 * column10_row10751 - (column17_row32712 + sig_config.shift_point.x + column17_row56).
              let val := addmod(
                mulmod(/*column10_row10751*/ mload(0x3820), /*column10_row10751*/ mload(0x3820), PRIME),
                sub(
                  PRIME,
                  addmod(
                    addmod(/*column17_row32712*/ mload(0x4720), /*shift_point.x*/ mload(0x220), PRIME),
                    /*column17_row56*/ mload(0x4360),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 32768) - 1.
              // val *= denominator_invs[15].
              val := mulmod(val, mload(0x52c0), PRIME)

              // res += val * (coefficients[284] + coefficients[285] * adjustments[17]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[284]*/ mload(0x2800),
                                       mulmod(/*coefficients[285]*/ mload(0x2820),
                                              /*adjustments[17]*/mload(0x5bc0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for sig_verify/extract_r/x_diff_inv: column10_row27135 * (column17_row32712 - sig_config.shift_point.x) - 1.
              let val := addmod(
                mulmod(
                  /*column10_row27135*/ mload(0x38a0),
                  addmod(
                    /*column17_row32712*/ mload(0x4720),
                    sub(PRIME, /*shift_point.x*/ mload(0x220)),
                    PRIME),
                  PRIME),
                sub(PRIME, 1),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 32768) - 1.
              // val *= denominator_invs[15].
              val := mulmod(val, mload(0x52c0), PRIME)

              // res += val * (coefficients[286] + coefficients[287] * adjustments[17]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[286]*/ mload(0x2840),
                                       mulmod(/*coefficients[287]*/ mload(0x2860),
                                              /*adjustments[17]*/mload(0x5bc0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for sig_verify/z_nonzero: column17_row84 * column10_row6655 - 1.
              let val := addmod(
                mulmod(/*column17_row84*/ mload(0x43e0), /*column10_row6655*/ mload(0x37e0), PRIME),
                sub(PRIME, 1),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 32768) - 1.
              // val *= denominator_invs[15].
              val := mulmod(val, mload(0x52c0), PRIME)

              // res += val * (coefficients[288] + coefficients[289] * adjustments[17]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[288]*/ mload(0x2880),
                                       mulmod(/*coefficients[289]*/ mload(0x28a0),
                                              /*adjustments[17]*/mload(0x5bc0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for sig_verify/r_and_w_nonzero: column17_row56 * column10_row2559 - 1.
              let val := addmod(
                mulmod(/*column17_row56*/ mload(0x4360), /*column10_row2559*/ mload(0x37a0), PRIME),
                sub(PRIME, 1),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 16384) - 1.
              // val *= denominator_invs[12].
              val := mulmod(val, mload(0x5260), PRIME)

              // res += val * (coefficients[290] + coefficients[291] * adjustments[12]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[290]*/ mload(0x28c0),
                                       mulmod(/*coefficients[291]*/ mload(0x28e0),
                                              /*adjustments[12]*/mload(0x5b20),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for sig_verify/q_on_curve/x_squared: column10_row23039 - column17_row32 * column17_row32.
              let val := addmod(
                /*column10_row23039*/ mload(0x3880),
                sub(
                  PRIME,
                  mulmod(/*column17_row32*/ mload(0x42c0), /*column17_row32*/ mload(0x42c0), PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 32768) - 1.
              // val *= denominator_invs[15].
              val := mulmod(val, mload(0x52c0), PRIME)

              // res += val * (coefficients[292] + coefficients[293] * adjustments[17]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[292]*/ mload(0x2900),
                                       mulmod(/*coefficients[293]*/ mload(0x2920),
                                              /*adjustments[17]*/mload(0x5bc0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for sig_verify/q_on_curve/on_curve: column17_row16 * column17_row16 - (column17_row32 * column10_row23039 + sig_config.alpha * column17_row32 + sig_config.beta).
              let val := addmod(
                mulmod(/*column17_row16*/ mload(0x4260), /*column17_row16*/ mload(0x4260), PRIME),
                sub(
                  PRIME,
                  addmod(
                    addmod(
                      mulmod(/*column17_row32*/ mload(0x42c0), /*column10_row23039*/ mload(0x3880), PRIME),
                      mulmod(/*sig_config.alpha*/ mload(0x300), /*column17_row32*/ mload(0x42c0), PRIME),
                      PRIME),
                    /*sig_config.beta*/ mload(0x320),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 32768) - 1.
              // val *= denominator_invs[15].
              val := mulmod(val, mload(0x52c0), PRIME)

              // res += val * (coefficients[294] + coefficients[295] * adjustments[17]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[294]*/ mload(0x2940),
                                       mulmod(/*coefficients[295]*/ mload(0x2960),
                                              /*adjustments[17]*/mload(0x5bc0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for party_a_sig_input_packed: is_settlement * (column16_row7171 - ((party_a_packed_msg__partial * nonce_shift + column16_row1021) * expiration_timestamp_shift + column10_row255)).
              let val := mulmod(
                /*periodic_column/is_settlement*/ mload(0xc0),
                addmod(
                  /*column16_row7171*/ mload(0x3fe0),
                  sub(
                    PRIME,
                    addmod(
                      mulmod(
                        addmod(
                          mulmod(
                            /*intermediate_value/party_a_packed_msg/partial*/ mload(0x4d80),
                            /*nonce_shift*/ mload(0x360),
                            PRIME),
                          /*column16_row1021*/ mload(0x3e60),
                          PRIME),
                        /*expiration_timestamp_shift*/ mload(0x380),
                        PRIME),
                      /*column10_row255*/ mload(0x3740),
                      PRIME)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 65536) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, mload(0x5280), PRIME)

              // res += val * (coefficients[296] + coefficients[297] * adjustments[18]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[296]*/ mload(0x2980),
                                       mulmod(/*coefficients[297]*/ mload(0x29a0),
                                              /*adjustments[18]*/mload(0x5be0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for party_b_sig_input_packed: column16_row39939 - ((1 - column10_row31231) * ((party_b_packed_msg__partial * nonce_shift + column16_row33789) * expiration_timestamp_shift + column10_row33023) + column10_row31231 * ((party_b_packed_msg_transfer__partial * nonce_shift + column16_row33789) * expiration_timestamp_shift + column10_row33023)).
              let val := addmod(
                /*column16_row39939*/ mload(0x4160),
                sub(
                  PRIME,
                  addmod(
                    mulmod(
                      addmod(1, sub(PRIME, /*column10_row31231*/ mload(0x38c0)), PRIME),
                      addmod(
                        mulmod(
                          addmod(
                            mulmod(
                              /*intermediate_value/party_b_packed_msg/partial*/ mload(0x4da0),
                              /*nonce_shift*/ mload(0x360),
                              PRIME),
                            /*column16_row33789*/ mload(0x40e0),
                            PRIME),
                          /*expiration_timestamp_shift*/ mload(0x380),
                          PRIME),
                        /*column10_row33023*/ mload(0x38e0),
                        PRIME),
                      PRIME),
                    mulmod(
                      /*column10_row31231*/ mload(0x38c0),
                      addmod(
                        mulmod(
                          addmod(
                            mulmod(
                              /*intermediate_value/party_b_packed_msg_transfer/partial*/ mload(0x4dc0),
                              /*nonce_shift*/ mload(0x360),
                              PRIME),
                            /*column16_row33789*/ mload(0x40e0),
                            PRIME),
                          /*expiration_timestamp_shift*/ mload(0x380),
                          PRIME),
                        /*column10_row33023*/ mload(0x38e0),
                        PRIME),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 65536) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, mload(0x5280), PRIME)

              // res += val * (coefficients[298] + coefficients[299] * adjustments[21]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[298]*/ mload(0x29c0),
                                       mulmod(/*coefficients[299]*/ mload(0x29e0),
                                              /*adjustments[21]*/mload(0x5c40),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for signatures/party_b_hash_sec_msg: column16_row37891 - (column10_row31231 * column10_row63999 + (1 - column10_row31231) * column16_row4099).
              let val := addmod(
                /*column16_row37891*/ mload(0x4140),
                sub(
                  PRIME,
                  addmod(
                    mulmod(/*column10_row31231*/ mload(0x38c0), /*column10_row63999*/ mload(0x3920), PRIME),
                    mulmod(
                      addmod(1, sub(PRIME, /*column10_row31231*/ mload(0x38c0)), PRIME),
                      /*column16_row4099*/ mload(0x3fa0),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 65536) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, mload(0x5280), PRIME)

              // res += val * (coefficients[300] + coefficients[301] * adjustments[21]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[300]*/ mload(0x2a00),
                                       mulmod(/*coefficients[301]*/ mload(0x2a20),
                                              /*adjustments[21]*/mload(0x5c40),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for signatures/copy_token_b: column16_row5123 - column16_row36867.
              let val := addmod(
                /*column16_row5123*/ mload(0x3fc0),
                sub(PRIME, /*column16_row36867*/ mload(0x4120)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 65536) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, mload(0x5280), PRIME)

              // res += val * (coefficients[302] + coefficients[303] * adjustments[22]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[302]*/ mload(0x2a40),
                                       mulmod(/*coefficients[303]*/ mload(0x2a60),
                                              /*adjustments[22]*/mload(0x5c60),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for copy_signature_input_party_a: (1 - column10_row31231) * (column16_row8188 - column17_row84).
              let val := mulmod(
                addmod(1, sub(PRIME, /*column10_row31231*/ mload(0x38c0)), PRIME),
                addmod(
                  /*column16_row8188*/ mload(0x4000),
                  sub(PRIME, /*column17_row84*/ mload(0x43e0)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 65536) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, mload(0x5280), PRIME)

              // res += val * (coefficients[304] + coefficients[305] * adjustments[21]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[304]*/ mload(0x2a80),
                                       mulmod(/*coefficients[305]*/ mload(0x2aa0),
                                              /*adjustments[21]*/mload(0x5c40),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for copy_signature_input_party_b: is_settlement * (column16_row40956 - column17_row32852).
              let val := mulmod(
                /*periodic_column/is_settlement*/ mload(0xc0),
                addmod(
                  /*column16_row40956*/ mload(0x4180),
                  sub(PRIME, /*column17_row32852*/ mload(0x47e0)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 65536) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, mload(0x5280), PRIME)

              // res += val * (coefficients[306] + coefficients[307] * adjustments[18]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[306]*/ mload(0x2ac0),
                                       mulmod(/*coefficients[307]*/ mload(0x2ae0),
                                              /*adjustments[18]*/mload(0x5be0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for message_hash_determines_order_id_party_a: column14_row511 - (1 - column10_row31231) * column17_row24148.
              let val := addmod(
                /*column14_row511*/ mload(0x3ba0),
                sub(
                  PRIME,
                  mulmod(
                    addmod(1, sub(PRIME, /*column10_row31231*/ mload(0x38c0)), PRIME),
                    /*column17_row24148*/ mload(0x4640),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 65536) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, mload(0x5280), PRIME)

              // res += val * (coefficients[308] + coefficients[309] * adjustments[21]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[308]*/ mload(0x2b00),
                                       mulmod(/*coefficients[309]*/ mload(0x2b20),
                                              /*adjustments[21]*/mload(0x5c40),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for message_hash_determines_order_id_party_b: is_settlement * (column14_row33279 - column17_row56916).
              let val := mulmod(
                /*periodic_column/is_settlement*/ mload(0xc0),
                addmod(
                  /*column14_row33279*/ mload(0x3c80),
                  sub(PRIME, /*column17_row56916*/ mload(0x48e0)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 65536) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, mload(0x5280), PRIME)

              // res += val * (coefficients[310] + coefficients[311] * adjustments[18]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[310]*/ mload(0x2b40),
                                       mulmod(/*coefficients[311]*/ mload(0x2b60),
                                              /*adjustments[18]*/mload(0x5be0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for party_a_public_key_copy: (1 - column10_row31231) * (column17_row32 - column10_row63999).
              let val := mulmod(
                addmod(1, sub(PRIME, /*column10_row31231*/ mload(0x38c0)), PRIME),
                addmod(
                  /*column17_row32*/ mload(0x42c0),
                  sub(PRIME, /*column10_row63999*/ mload(0x3920)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 65536) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, mload(0x5280), PRIME)

              // res += val * (coefficients[312] + coefficients[313] * adjustments[21]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[312]*/ mload(0x2b80),
                                       mulmod(/*coefficients[313]*/ mload(0x2ba0),
                                              /*adjustments[21]*/mload(0x5c40),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for handle_empty_vault/consistency_key_change0: is_settlement * (column10_row63999 - column17_row16324).
              let val := mulmod(
                /*periodic_column/is_settlement*/ mload(0xc0),
                addmod(
                  /*column10_row63999*/ mload(0x3920),
                  sub(PRIME, /*column17_row16324*/ mload(0x4540)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 65536) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, mload(0x5280), PRIME)

              // res += val * (coefficients[314] + coefficients[315] * adjustments[18]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[314]*/ mload(0x2bc0),
                                       mulmod(/*coefficients[315]*/ mload(0x2be0),
                                              /*adjustments[18]*/mload(0x5be0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for handle_empty_vault/consistency_token_change0: is_settlement * (column16_row4099 - column17_row16344).
              let val := mulmod(
                /*periodic_column/is_settlement*/ mload(0xc0),
                addmod(
                  /*column16_row4099*/ mload(0x3fa0),
                  sub(PRIME, /*column17_row16344*/ mload(0x4580)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 65536) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, mload(0x5280), PRIME)

              // res += val * (coefficients[316] + coefficients[317] * adjustments[18]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[316]*/ mload(0x2c00),
                                       mulmod(/*coefficients[317]*/ mload(0x2c20),
                                              /*adjustments[18]*/mload(0x5be0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for handle_empty_vault/consistency_key_change3: is_settlement * (column10_row63999 - column17_row65476).
              let val := mulmod(
                /*periodic_column/is_settlement*/ mload(0xc0),
                addmod(
                  /*column10_row63999*/ mload(0x3920),
                  sub(PRIME, /*column17_row65476*/ mload(0x4940)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 65536) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, mload(0x5280), PRIME)

              // res += val * (coefficients[318] + coefficients[319] * adjustments[18]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[318]*/ mload(0x2c40),
                                       mulmod(/*coefficients[319]*/ mload(0x2c60),
                                              /*adjustments[18]*/mload(0x5be0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for handle_empty_vault/consistency_token_change3: is_settlement * (column16_row5123 - column17_row65496).
              let val := mulmod(
                /*periodic_column/is_settlement*/ mload(0xc0),
                addmod(
                  /*column16_row5123*/ mload(0x3fc0),
                  sub(PRIME, /*column17_row65496*/ mload(0x4960)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 65536) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, mload(0x5280), PRIME)

              // res += val * (coefficients[320] + coefficients[321] * adjustments[18]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[320]*/ mload(0x2c80),
                                       mulmod(/*coefficients[321]*/ mload(0x2ca0),
                                              /*adjustments[18]*/mload(0x5be0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for handle_empty_vault/consistency_key_change1: is_settlement * (column17_row32800 - column17_row32708).
              let val := mulmod(
                /*periodic_column/is_settlement*/ mload(0xc0),
                addmod(
                  /*column17_row32800*/ mload(0x47c0),
                  sub(PRIME, /*column17_row32708*/ mload(0x4700)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 65536) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, mload(0x5280), PRIME)

              // res += val * (coefficients[322] + coefficients[323] * adjustments[18]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[322]*/ mload(0x2cc0),
                                       mulmod(/*coefficients[323]*/ mload(0x2ce0),
                                              /*adjustments[18]*/mload(0x5be0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for handle_empty_vault/consistency_token_change1: is_settlement * (column16_row4099 - column17_row32728).
              let val := mulmod(
                /*periodic_column/is_settlement*/ mload(0xc0),
                addmod(
                  /*column16_row4099*/ mload(0x3fa0),
                  sub(PRIME, /*column17_row32728*/ mload(0x4740)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 65536) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, mload(0x5280), PRIME)

              // res += val * (coefficients[324] + coefficients[325] * adjustments[18]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[324]*/ mload(0x2d00),
                                       mulmod(/*coefficients[325]*/ mload(0x2d20),
                                              /*adjustments[18]*/mload(0x5be0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for handle_empty_vault/consistency_key_change2: is_settlement * (column17_row32800 - column17_row49092).
              let val := mulmod(
                /*periodic_column/is_settlement*/ mload(0xc0),
                addmod(
                  /*column17_row32800*/ mload(0x47c0),
                  sub(PRIME, /*column17_row49092*/ mload(0x4860)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 65536) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, mload(0x5280), PRIME)

              // res += val * (coefficients[326] + coefficients[327] * adjustments[18]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[326]*/ mload(0x2d40),
                                       mulmod(/*coefficients[327]*/ mload(0x2d60),
                                              /*adjustments[18]*/mload(0x5be0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for handle_empty_vault/consistency_token_change2: is_settlement * (column16_row5123 - column17_row49112).
              let val := mulmod(
                /*periodic_column/is_settlement*/ mload(0xc0),
                addmod(
                  /*column16_row5123*/ mload(0x3fc0),
                  sub(PRIME, /*column17_row49112*/ mload(0x4880)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 65536) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, mload(0x5280), PRIME)

              // res += val * (coefficients[328] + coefficients[329] * adjustments[18]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[328]*/ mload(0x2d80),
                                       mulmod(/*coefficients[329]*/ mload(0x2da0),
                                              /*adjustments[18]*/mload(0x5be0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for handle_empty_vault/vault_empty/empty_vault_booleanity: column10_row511 * (1 - column10_row511).
              let val := mulmod(
                /*column10_row511*/ mload(0x3760),
                addmod(1, sub(PRIME, /*column10_row511*/ mload(0x3760)), PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 8192) - 1.
              // val *= denominator_invs[25].
              val := mulmod(val, mload(0x5400), PRIME)

              // res += val * (coefficients[330] + coefficients[331] * adjustments[26]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[330]*/ mload(0x2dc0),
                                       mulmod(/*coefficients[331]*/ mload(0x2de0),
                                              /*adjustments[26]*/mload(0x5ce0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for handle_empty_vault/vault_empty/amount_zero_when_empty: column10_row511 * column16_row3075.
              let val := mulmod(/*column10_row511*/ mload(0x3760), /*column16_row3075*/ mload(0x3f60), PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 8192) - 1.
              // val *= denominator_invs[25].
              val := mulmod(val, mload(0x5400), PRIME)

              // res += val * (coefficients[332] + coefficients[333] * adjustments[26]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[332]*/ mload(0x2e00),
                                       mulmod(/*coefficients[333]*/ mload(0x2e20),
                                              /*adjustments[26]*/mload(0x5ce0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for handle_empty_vault/vault_empty/amount_inv_zero_when_empty: column10_row511 * column10_row4607.
              let val := mulmod(/*column10_row511*/ mload(0x3760), /*column10_row4607*/ mload(0x37c0), PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 8192) - 1.
              // val *= denominator_invs[25].
              val := mulmod(val, mload(0x5400), PRIME)

              // res += val * (coefficients[334] + coefficients[335] * adjustments[26]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[334]*/ mload(0x2e40),
                                       mulmod(/*coefficients[335]*/ mload(0x2e60),
                                              /*adjustments[26]*/mload(0x5ce0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for handle_empty_vault/vault_empty/empty_when_amount_zero: column16_row3075 * column10_row4607 + column10_row511 - 1.
              let val := addmod(
                addmod(
                  mulmod(/*column16_row3075*/ mload(0x3f60), /*column10_row4607*/ mload(0x37c0), PRIME),
                  /*column10_row511*/ mload(0x3760),
                  PRIME),
                sub(PRIME, 1),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 8192) - 1.
              // val *= denominator_invs[25].
              val := mulmod(val, mload(0x5400), PRIME)

              // res += val * (coefficients[336] + coefficients[337] * adjustments[26]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[336]*/ mload(0x2e80),
                                       mulmod(/*coefficients[337]*/ mload(0x2ea0),
                                              /*adjustments[26]*/mload(0x5ce0),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for handle_empty_vault/consistency_key_stage0: (1 - column10_row511) * column17_row16324 - column16_row3.
              let val := addmod(
                mulmod(
                  addmod(1, sub(PRIME, /*column10_row511*/ mload(0x3760)), PRIME),
                  /*column17_row16324*/ mload(0x4540),
                  PRIME),
                sub(PRIME, /*column16_row3*/ mload(0x3dc0)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 16384) - 1.
              // val *= denominator_invs[12].
              val := mulmod(val, mload(0x5260), PRIME)

              // res += val * (coefficients[338] + coefficients[339] * adjustments[12]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[338]*/ mload(0x2ec0),
                                       mulmod(/*coefficients[339]*/ mload(0x2ee0),
                                              /*adjustments[12]*/mload(0x5b20),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for handle_empty_vault/consistency_token_stage0: (1 - column10_row511) * column17_row16344 - column16_row1027.
              let val := addmod(
                mulmod(
                  addmod(1, sub(PRIME, /*column10_row511*/ mload(0x3760)), PRIME),
                  /*column17_row16344*/ mload(0x4580),
                  PRIME),
                sub(PRIME, /*column16_row1027*/ mload(0x3ee0)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 16384) - 1.
              // val *= denominator_invs[12].
              val := mulmod(val, mload(0x5260), PRIME)

              // res += val * (coefficients[340] + coefficients[341] * adjustments[12]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[340]*/ mload(0x2f00),
                                       mulmod(/*coefficients[341]*/ mload(0x2f20),
                                              /*adjustments[12]*/mload(0x5b20),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for handle_empty_vault/consistency_key_stage1: (1 - column10_row8703) * column17_row16324 - column16_row8195.
              let val := addmod(
                mulmod(
                  addmod(1, sub(PRIME, /*column10_row8703*/ mload(0x3800)), PRIME),
                  /*column17_row16324*/ mload(0x4540),
                  PRIME),
                sub(PRIME, /*column16_row8195*/ mload(0x4020)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 16384) - 1.
              // val *= denominator_invs[12].
              val := mulmod(val, mload(0x5260), PRIME)

              // res += val * (coefficients[342] + coefficients[343] * adjustments[12]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[342]*/ mload(0x2f40),
                                       mulmod(/*coefficients[343]*/ mload(0x2f60),
                                              /*adjustments[12]*/mload(0x5b20),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for handle_empty_vault/consistency_token_stage1: (1 - column10_row8703) * column17_row16344 - column16_row9219.
              let val := addmod(
                mulmod(
                  addmod(1, sub(PRIME, /*column10_row8703*/ mload(0x3800)), PRIME),
                  /*column17_row16344*/ mload(0x4580),
                  PRIME),
                sub(PRIME, /*column16_row9219*/ mload(0x4040)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 16384) - 1.
              // val *= denominator_invs[12].
              val := mulmod(val, mload(0x5260), PRIME)

              // res += val * (coefficients[344] + coefficients[345] * adjustments[12]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[344]*/ mload(0x2f80),
                                       mulmod(/*coefficients[345]*/ mload(0x2fa0),
                                              /*adjustments[12]*/mload(0x5b20),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for initial_vaults_root: column0_row_expr0 - initial_vaults_root.
              let val := addmod(
                /*column0_row_expr0*/ mload(0x3220),
                sub(PRIME, /*initial_vaults_root*/ mload(0x3a0)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point - 1.
              // val *= denominator_invs[26].
              val := mulmod(val, mload(0x5420), PRIME)

              // res += val * (coefficients[346] + coefficients[347] * adjustments[27]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[346]*/ mload(0x2fc0),
                                       mulmod(/*coefficients[347]*/ mload(0x2fe0),
                                              /*adjustments[27]*/mload(0x5d00),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for initial_settlement_root: column10_row14847 - initial_settlement_root.
              let val := addmod(
                /*column10_row14847*/ mload(0x3840),
                sub(PRIME, /*initial_settlement_root*/ mload(0x3c0)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point - 1.
              // val *= denominator_invs[26].
              val := mulmod(val, mload(0x5420), PRIME)

              // res += val * (coefficients[348] + coefficients[349] * adjustments[27]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[348]*/ mload(0x3000),
                                       mulmod(/*coefficients[349]*/ mload(0x3020),
                                              /*adjustments[27]*/mload(0x5d00),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for final_vaults_root: column4_row_expr1 - final_vaults_root.
              let val := addmod(
                /*column4_row_expr1*/ mload(0x3440),
                sub(PRIME, /*final_vaults_root*/ mload(0x3e0)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point - trace_generator^(65536 * (n_transactions - 1)).
              // val *= denominator_invs[27].
              val := mulmod(val, mload(0x5440), PRIME)

              // res += val * (coefficients[350] + coefficients[351] * adjustments[27]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[350]*/ mload(0x3040),
                                       mulmod(/*coefficients[351]*/ mload(0x3060),
                                              /*adjustments[27]*/mload(0x5d00),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for final_settlement_root: column10_row47615 - final_settlement_root.
              let val := addmod(
                /*column10_row47615*/ mload(0x3900),
                sub(PRIME, /*final_settlement_root*/ mload(0x420)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point - trace_generator^(65536 * (n_transactions - 1)).
              // val *= denominator_invs[27].
              val := mulmod(val, mload(0x5440), PRIME)

              // res += val * (coefficients[352] + coefficients[353] * adjustments[27]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[352]*/ mload(0x3080),
                                       mulmod(/*coefficients[353]*/ mload(0x30a0),
                                              /*adjustments[27]*/mload(0x5d00),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for copy_merkle_roots: column4_row_expr0 - column0_row_expr2.
              let val := addmod(
                /*column4_row_expr0*/ mload(0x3460),
                sub(PRIME, /*column0_row_expr2*/ mload(0x3240)),
                PRIME)

              // Numerator: point - trace_generator^(65536 * (trace_length / 65536 - 1) + 49152).
              // val *= numerators[12].
              val := mulmod(val, mload(0x5960), PRIME)
              // Denominator: point^(trace_length / 16384) - 1.
              // val *= denominator_invs[12].
              val := mulmod(val, mload(0x5260), PRIME)

              // res += val * (coefficients[354] + coefficients[355] * adjustments[28]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[354]*/ mload(0x30c0),
                                       mulmod(/*coefficients[355]*/ mload(0x30e0),
                                              /*adjustments[28]*/mload(0x5d20),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for copy_settlement_merkle_roots: column10_row47615 - column10_row80383.
              let val := addmod(
                /*column10_row47615*/ mload(0x3900),
                sub(PRIME, /*column10_row80383*/ mload(0x3940)),
                PRIME)

              // Numerator: point - trace_generator^(65536 * (trace_length / 65536 - 1)).
              // val *= numerators[13].
              val := mulmod(val, mload(0x5980), PRIME)
              // Denominator: point^(trace_length / 65536) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, mload(0x5280), PRIME)

              // res += val * (coefficients[356] + coefficients[357] * adjustments[29]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[356]*/ mload(0x3100),
                                       mulmod(/*coefficients[357]*/ mload(0x3120),
                                              /*adjustments[29]*/mload(0x5d40),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

              {
              // Constraint expression for copy_merkle_roots_modification: is_modification * (column4_row_expr0 - column4_row_expr1).
              let val := mulmod(
                /*periodic_column/is_modification*/ mload(0xa0),
                addmod(
                  /*column4_row_expr0*/ mload(0x3460),
                  sub(PRIME, /*column4_row_expr1*/ mload(0x3440)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // val := mulmod(val, 1, PRIME).
              // Denominator: point^(trace_length / 65536) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, mload(0x5280), PRIME)

              // res += val * (coefficients[358] + coefficients[359] * adjustments[19]).
              res := addmod(res,
                            mulmod(val,
                                   add(/*coefficients[358]*/ mload(0x3140),
                                       mulmod(/*coefficients[359]*/ mload(0x3160),
                                              /*adjustments[19]*/mload(0x5c00),
                      PRIME)),
                      PRIME),
                      PRIME)
              }

            mstore(0, res)
            return(0, 0x20)
            }
        }
    }
}
// ---------- End of auto-generated code. ----------
