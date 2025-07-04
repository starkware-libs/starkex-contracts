// ---------- The following code was auto-generated. PLEASE DO NOT EDIT. ----------
// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

contract CpuConstraintPoly {
    // The Memory map during the execution of this contract is as follows:
    // [0x0, 0x20) - periodic_column/pedersen/points/x.
    // [0x20, 0x40) - periodic_column/pedersen/points/y.
    // [0x40, 0x60) - periodic_column/ecdsa/generator_points/x.
    // [0x60, 0x80) - periodic_column/ecdsa/generator_points/y.
    // [0x80, 0xa0) - trace_length.
    // [0xa0, 0xc0) - offset_size.
    // [0xc0, 0xe0) - half_offset_size.
    // [0xe0, 0x100) - initial_ap.
    // [0x100, 0x120) - initial_pc.
    // [0x120, 0x140) - final_ap.
    // [0x140, 0x160) - final_pc.
    // [0x160, 0x180) - memory/multi_column_perm/perm/interaction_elm.
    // [0x180, 0x1a0) - memory/multi_column_perm/hash_interaction_elm0.
    // [0x1a0, 0x1c0) - memory/multi_column_perm/perm/public_memory_prod.
    // [0x1c0, 0x1e0) - rc16/perm/interaction_elm.
    // [0x1e0, 0x200) - rc16/perm/public_memory_prod.
    // [0x200, 0x220) - rc_min.
    // [0x220, 0x240) - rc_max.
    // [0x240, 0x260) - pedersen/shift_point.x.
    // [0x260, 0x280) - pedersen/shift_point.y.
    // [0x280, 0x2a0) - initial_pedersen_addr.
    // [0x2a0, 0x2c0) - initial_rc_addr.
    // [0x2c0, 0x2e0) - ecdsa/sig_config.alpha.
    // [0x2e0, 0x300) - ecdsa/sig_config.shift_point.x.
    // [0x300, 0x320) - ecdsa/sig_config.shift_point.y.
    // [0x320, 0x340) - ecdsa/sig_config.beta.
    // [0x340, 0x360) - initial_ecdsa_addr.
    // [0x360, 0x380) - trace_generator.
    // [0x380, 0x3a0) - oods_point.
    // [0x3a0, 0x400) - interaction_elements.
    // [0x400, 0x420) - composition_alpha.
    // [0x420, 0x1d40) - oods_values.
    // ----------------------- end of input data - -------------------------
    // [0x1d40, 0x1d60) - intermediate_value/cpu/decode/opcode_rc/bit_0.
    // [0x1d60, 0x1d80) - intermediate_value/cpu/decode/opcode_rc/bit_2.
    // [0x1d80, 0x1da0) - intermediate_value/cpu/decode/opcode_rc/bit_4.
    // [0x1da0, 0x1dc0) - intermediate_value/cpu/decode/opcode_rc/bit_3.
    // [0x1dc0, 0x1de0) - intermediate_value/cpu/decode/flag_op1_base_op0_0.
    // [0x1de0, 0x1e00) - intermediate_value/cpu/decode/opcode_rc/bit_5.
    // [0x1e00, 0x1e20) - intermediate_value/cpu/decode/opcode_rc/bit_6.
    // [0x1e20, 0x1e40) - intermediate_value/cpu/decode/opcode_rc/bit_9.
    // [0x1e40, 0x1e60) - intermediate_value/cpu/decode/flag_res_op1_0.
    // [0x1e60, 0x1e80) - intermediate_value/cpu/decode/opcode_rc/bit_7.
    // [0x1e80, 0x1ea0) - intermediate_value/cpu/decode/opcode_rc/bit_8.
    // [0x1ea0, 0x1ec0) - intermediate_value/cpu/decode/flag_pc_update_regular_0.
    // [0x1ec0, 0x1ee0) - intermediate_value/cpu/decode/opcode_rc/bit_12.
    // [0x1ee0, 0x1f00) - intermediate_value/cpu/decode/opcode_rc/bit_13.
    // [0x1f00, 0x1f20) - intermediate_value/cpu/decode/fp_update_regular_0.
    // [0x1f20, 0x1f40) - intermediate_value/cpu/decode/opcode_rc/bit_1.
    // [0x1f40, 0x1f60) - intermediate_value/npc_reg_0.
    // [0x1f60, 0x1f80) - intermediate_value/cpu/decode/opcode_rc/bit_10.
    // [0x1f80, 0x1fa0) - intermediate_value/cpu/decode/opcode_rc/bit_11.
    // [0x1fa0, 0x1fc0) - intermediate_value/cpu/decode/opcode_rc/bit_14.
    // [0x1fc0, 0x1fe0) - intermediate_value/memory/address_diff_0.
    // [0x1fe0, 0x2000) - intermediate_value/rc16/diff_0.
    // [0x2000, 0x2020) - intermediate_value/pedersen/hash0/ec_subset_sum/bit_0.
    // [0x2020, 0x2040) - intermediate_value/pedersen/hash0/ec_subset_sum/bit_neg_0.
    // [0x2040, 0x2060) - intermediate_value/pedersen/hash1/ec_subset_sum/bit_0.
    // [0x2060, 0x2080) - intermediate_value/pedersen/hash1/ec_subset_sum/bit_neg_0.
    // [0x2080, 0x20a0) - intermediate_value/pedersen/hash2/ec_subset_sum/bit_0.
    // [0x20a0, 0x20c0) - intermediate_value/pedersen/hash2/ec_subset_sum/bit_neg_0.
    // [0x20c0, 0x20e0) - intermediate_value/pedersen/hash3/ec_subset_sum/bit_0.
    // [0x20e0, 0x2100) - intermediate_value/pedersen/hash3/ec_subset_sum/bit_neg_0.
    // [0x2100, 0x2120) - intermediate_value/rc_builtin/value0_0.
    // [0x2120, 0x2140) - intermediate_value/rc_builtin/value1_0.
    // [0x2140, 0x2160) - intermediate_value/rc_builtin/value2_0.
    // [0x2160, 0x2180) - intermediate_value/rc_builtin/value3_0.
    // [0x2180, 0x21a0) - intermediate_value/rc_builtin/value4_0.
    // [0x21a0, 0x21c0) - intermediate_value/rc_builtin/value5_0.
    // [0x21c0, 0x21e0) - intermediate_value/rc_builtin/value6_0.
    // [0x21e0, 0x2200) - intermediate_value/rc_builtin/value7_0.
    // [0x2200, 0x2220) - intermediate_value/ecdsa/signature0/doubling_key/x_squared.
    // [0x2220, 0x2240) - intermediate_value/ecdsa/signature0/exponentiate_generator/bit_0.
    // [0x2240, 0x2260) - intermediate_value/ecdsa/signature0/exponentiate_generator/bit_neg_0.
    // [0x2260, 0x2280) - intermediate_value/ecdsa/signature0/exponentiate_key/bit_0.
    // [0x2280, 0x22a0) - intermediate_value/ecdsa/signature0/exponentiate_key/bit_neg_0.
    // [0x22a0, 0x2520) - expmods.
    // [0x2520, 0x2820) - domains.
    // [0x2820, 0x2ac0) - denominator_invs.
    // [0x2ac0, 0x2d60) - denominators.
    // [0x2d60, 0x2e20) - expmod_context.

    fallback() external {
        uint256 res;
        assembly {
            let PRIME := 0x800000000000011000000000000000000000000000000000000000000000001
            // Copy input from calldata to memory.
            calldatacopy(0x0, 0x0, /*Input data size*/ 0x1d40)
            let point := /*oods_point*/ mload(0x380)
            function expmod(base, exponent, modulus) -> result {
              let p := /*expmod_context*/ 0x2d60
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
              result := mload(p)
            }
            {
              // Prepare expmods for denominators and numerators.

              // expmods[0] = point^(trace_length / 8192).
              mstore(0x22a0, expmod(point, div(/*trace_length*/ mload(0x80), 8192), PRIME))

              // expmods[1] = point^(trace_length / 4096).
              mstore(0x22c0, mulmod(
                /*point^(trace_length / 8192)*/ mload(0x22a0),
                /*point^(trace_length / 8192)*/ mload(0x22a0),
                PRIME))

              // expmods[2] = point^(trace_length / 512).
              mstore(0x22e0, expmod(point, div(/*trace_length*/ mload(0x80), 512), PRIME))

              // expmods[3] = point^(trace_length / 256).
              mstore(0x2300, mulmod(
                /*point^(trace_length / 512)*/ mload(0x22e0),
                /*point^(trace_length / 512)*/ mload(0x22e0),
                PRIME))

              // expmods[4] = point^(trace_length / 128).
              mstore(0x2320, mulmod(
                /*point^(trace_length / 256)*/ mload(0x2300),
                /*point^(trace_length / 256)*/ mload(0x2300),
                PRIME))

              // expmods[5] = point^(trace_length / 32).
              mstore(0x2340, expmod(point, div(/*trace_length*/ mload(0x80), 32), PRIME))

              // expmods[6] = point^(trace_length / 16).
              mstore(0x2360, mulmod(
                /*point^(trace_length / 32)*/ mload(0x2340),
                /*point^(trace_length / 32)*/ mload(0x2340),
                PRIME))

              // expmods[7] = point^(trace_length / 8).
              mstore(0x2380, mulmod(
                /*point^(trace_length / 16)*/ mload(0x2360),
                /*point^(trace_length / 16)*/ mload(0x2360),
                PRIME))

              // expmods[8] = point^(trace_length / 2).
              mstore(0x23a0, expmod(point, div(/*trace_length*/ mload(0x80), 2), PRIME))

              // expmods[9] = point^trace_length.
              mstore(0x23c0, mulmod(
                /*point^(trace_length / 2)*/ mload(0x23a0),
                /*point^(trace_length / 2)*/ mload(0x23a0),
                PRIME))

              // expmods[10] = trace_generator^(trace_length / 2).
              mstore(0x23e0, expmod(/*trace_generator*/ mload(0x360), div(/*trace_length*/ mload(0x80), 2), PRIME))

              // expmods[11] = trace_generator^(15 * trace_length / 16).
              mstore(0x2400, expmod(/*trace_generator*/ mload(0x360), div(mul(15, /*trace_length*/ mload(0x80)), 16), PRIME))

              // expmods[12] = trace_generator^(251 * trace_length / 256).
              mstore(0x2420, expmod(/*trace_generator*/ mload(0x360), div(mul(251, /*trace_length*/ mload(0x80)), 256), PRIME))

              // expmods[13] = trace_generator^(63 * trace_length / 64).
              mstore(0x2440, expmod(/*trace_generator*/ mload(0x360), div(mul(63, /*trace_length*/ mload(0x80)), 64), PRIME))

              // expmods[14] = trace_generator^(255 * trace_length / 256).
              mstore(0x2460, expmod(/*trace_generator*/ mload(0x360), div(mul(255, /*trace_length*/ mload(0x80)), 256), PRIME))

              // expmods[15] = trace_generator^(16 * (trace_length / 16 - 1)).
              mstore(0x2480, expmod(/*trace_generator*/ mload(0x360), mul(16, sub(div(/*trace_length*/ mload(0x80), 16), 1)), PRIME))

              // expmods[16] = trace_generator^(2 * (trace_length / 2 - 1)).
              mstore(0x24a0, expmod(/*trace_generator*/ mload(0x360), mul(2, sub(div(/*trace_length*/ mload(0x80), 2), 1)), PRIME))

              // expmods[17] = trace_generator^(trace_length - 1).
              mstore(0x24c0, expmod(/*trace_generator*/ mload(0x360), sub(/*trace_length*/ mload(0x80), 1), PRIME))

              // expmods[18] = trace_generator^(128 * (trace_length / 128 - 1)).
              mstore(0x24e0, expmod(/*trace_generator*/ mload(0x360), mul(128, sub(div(/*trace_length*/ mload(0x80), 128), 1)), PRIME))

              // expmods[19] = trace_generator^(8192 * (trace_length / 8192 - 1)).
              mstore(0x2500, expmod(/*trace_generator*/ mload(0x360), mul(8192, sub(div(/*trace_length*/ mload(0x80), 8192), 1)), PRIME))

            }

            {
              // Compute domains.

              // Denominator for constraints: 'cpu/decode/opcode_rc/bit', 'rc16/perm/step0', 'rc16/diff_is_bit', 'pedersen/hash0/ec_subset_sum/booleanity_test', 'pedersen/hash0/ec_subset_sum/add_points/slope', 'pedersen/hash0/ec_subset_sum/add_points/x', 'pedersen/hash0/ec_subset_sum/add_points/y', 'pedersen/hash0/ec_subset_sum/copy_point/x', 'pedersen/hash0/ec_subset_sum/copy_point/y', 'pedersen/hash1/ec_subset_sum/booleanity_test', 'pedersen/hash1/ec_subset_sum/add_points/slope', 'pedersen/hash1/ec_subset_sum/add_points/x', 'pedersen/hash1/ec_subset_sum/add_points/y', 'pedersen/hash1/ec_subset_sum/copy_point/x', 'pedersen/hash1/ec_subset_sum/copy_point/y', 'pedersen/hash2/ec_subset_sum/booleanity_test', 'pedersen/hash2/ec_subset_sum/add_points/slope', 'pedersen/hash2/ec_subset_sum/add_points/x', 'pedersen/hash2/ec_subset_sum/add_points/y', 'pedersen/hash2/ec_subset_sum/copy_point/x', 'pedersen/hash2/ec_subset_sum/copy_point/y', 'pedersen/hash3/ec_subset_sum/booleanity_test', 'pedersen/hash3/ec_subset_sum/add_points/slope', 'pedersen/hash3/ec_subset_sum/add_points/x', 'pedersen/hash3/ec_subset_sum/add_points/y', 'pedersen/hash3/ec_subset_sum/copy_point/x', 'pedersen/hash3/ec_subset_sum/copy_point/y'.
              // domains[0] = point^trace_length - 1.
              mstore(0x2520,
                     addmod(/*point^trace_length*/ mload(0x23c0), sub(PRIME, 1), PRIME))

              // Denominator for constraints: 'memory/multi_column_perm/perm/step0', 'memory/diff_is_bit', 'memory/is_func'.
              // domains[1] = point^(trace_length / 2) - 1.
              mstore(0x2540,
                     addmod(/*point^(trace_length / 2)*/ mload(0x23a0), sub(PRIME, 1), PRIME))

              // Denominator for constraints: 'public_memory_addr_zero', 'public_memory_value_zero'.
              // domains[2] = point^(trace_length / 8) - 1.
              mstore(0x2560,
                     addmod(/*point^(trace_length / 8)*/ mload(0x2380), sub(PRIME, 1), PRIME))

              // Denominator for constraints: 'cpu/decode/opcode_rc/zero'.
              // Numerator for constraints: 'cpu/decode/opcode_rc/bit'.
              // domains[3] = point^(trace_length / 16) - trace_generator^(15 * trace_length / 16).
              mstore(0x2580,
                     addmod(
                       /*point^(trace_length / 16)*/ mload(0x2360),
                       sub(PRIME, /*trace_generator^(15 * trace_length / 16)*/ mload(0x2400)),
                       PRIME))

              // Denominator for constraints: 'cpu/decode/opcode_rc_input', 'cpu/decode/flag_op1_base_op0_bit', 'cpu/decode/flag_res_op1_bit', 'cpu/decode/flag_pc_update_regular_bit', 'cpu/decode/fp_update_regular_bit', 'cpu/operands/mem_dst_addr', 'cpu/operands/mem0_addr', 'cpu/operands/mem1_addr', 'cpu/operands/ops_mul', 'cpu/operands/res', 'cpu/update_registers/update_pc/tmp0', 'cpu/update_registers/update_pc/tmp1', 'cpu/update_registers/update_pc/pc_cond_negative', 'cpu/update_registers/update_pc/pc_cond_positive', 'cpu/update_registers/update_ap/ap_update', 'cpu/update_registers/update_fp/fp_update', 'cpu/opcodes/call/push_fp', 'cpu/opcodes/call/push_pc', 'cpu/opcodes/call/off0', 'cpu/opcodes/call/off1', 'cpu/opcodes/call/flags', 'cpu/opcodes/ret/off0', 'cpu/opcodes/ret/off2', 'cpu/opcodes/ret/flags', 'cpu/opcodes/assert_eq/assert_eq', 'ecdsa/signature0/doubling_key/slope', 'ecdsa/signature0/doubling_key/x', 'ecdsa/signature0/doubling_key/y', 'ecdsa/signature0/exponentiate_key/booleanity_test', 'ecdsa/signature0/exponentiate_key/add_points/slope', 'ecdsa/signature0/exponentiate_key/add_points/x', 'ecdsa/signature0/exponentiate_key/add_points/y', 'ecdsa/signature0/exponentiate_key/add_points/x_diff_inv', 'ecdsa/signature0/exponentiate_key/copy_point/x', 'ecdsa/signature0/exponentiate_key/copy_point/y'.
              // domains[4] = point^(trace_length / 16) - 1.
              mstore(0x25a0,
                     addmod(/*point^(trace_length / 16)*/ mload(0x2360), sub(PRIME, 1), PRIME))

              // Denominator for constraints: 'ecdsa/signature0/exponentiate_generator/booleanity_test', 'ecdsa/signature0/exponentiate_generator/add_points/slope', 'ecdsa/signature0/exponentiate_generator/add_points/x', 'ecdsa/signature0/exponentiate_generator/add_points/y', 'ecdsa/signature0/exponentiate_generator/add_points/x_diff_inv', 'ecdsa/signature0/exponentiate_generator/copy_point/x', 'ecdsa/signature0/exponentiate_generator/copy_point/y'.
              // domains[5] = point^(trace_length / 32) - 1.
              mstore(0x25c0,
                     addmod(/*point^(trace_length / 32)*/ mload(0x2340), sub(PRIME, 1), PRIME))

              // Denominator for constraints: 'pedersen/input0_addr', 'pedersen/input1_addr', 'pedersen/output_addr', 'rc_builtin/value', 'rc_builtin/addr_step'.
              // domains[6] = point^(trace_length / 128) - 1.
              mstore(0x25e0,
                     addmod(/*point^(trace_length / 128)*/ mload(0x2320), sub(PRIME, 1), PRIME))

              // Denominator for constraints: 'pedersen/hash0/ec_subset_sum/bit_unpacking/last_one_is_zero', 'pedersen/hash0/ec_subset_sum/bit_unpacking/zeroes_between_ones0', 'pedersen/hash0/ec_subset_sum/bit_unpacking/cumulative_bit192', 'pedersen/hash0/ec_subset_sum/bit_unpacking/zeroes_between_ones192', 'pedersen/hash0/ec_subset_sum/bit_unpacking/cumulative_bit196', 'pedersen/hash0/ec_subset_sum/bit_unpacking/zeroes_between_ones196', 'pedersen/hash0/copy_point/x', 'pedersen/hash0/copy_point/y', 'pedersen/hash1/ec_subset_sum/bit_unpacking/last_one_is_zero', 'pedersen/hash1/ec_subset_sum/bit_unpacking/zeroes_between_ones0', 'pedersen/hash1/ec_subset_sum/bit_unpacking/cumulative_bit192', 'pedersen/hash1/ec_subset_sum/bit_unpacking/zeroes_between_ones192', 'pedersen/hash1/ec_subset_sum/bit_unpacking/cumulative_bit196', 'pedersen/hash1/ec_subset_sum/bit_unpacking/zeroes_between_ones196', 'pedersen/hash1/copy_point/x', 'pedersen/hash1/copy_point/y', 'pedersen/hash2/ec_subset_sum/bit_unpacking/last_one_is_zero', 'pedersen/hash2/ec_subset_sum/bit_unpacking/zeroes_between_ones0', 'pedersen/hash2/ec_subset_sum/bit_unpacking/cumulative_bit192', 'pedersen/hash2/ec_subset_sum/bit_unpacking/zeroes_between_ones192', 'pedersen/hash2/ec_subset_sum/bit_unpacking/cumulative_bit196', 'pedersen/hash2/ec_subset_sum/bit_unpacking/zeroes_between_ones196', 'pedersen/hash2/copy_point/x', 'pedersen/hash2/copy_point/y', 'pedersen/hash3/ec_subset_sum/bit_unpacking/last_one_is_zero', 'pedersen/hash3/ec_subset_sum/bit_unpacking/zeroes_between_ones0', 'pedersen/hash3/ec_subset_sum/bit_unpacking/cumulative_bit192', 'pedersen/hash3/ec_subset_sum/bit_unpacking/zeroes_between_ones192', 'pedersen/hash3/ec_subset_sum/bit_unpacking/cumulative_bit196', 'pedersen/hash3/ec_subset_sum/bit_unpacking/zeroes_between_ones196', 'pedersen/hash3/copy_point/x', 'pedersen/hash3/copy_point/y'.
              // domains[7] = point^(trace_length / 256) - 1.
              mstore(0x2600,
                     addmod(/*point^(trace_length / 256)*/ mload(0x2300), sub(PRIME, 1), PRIME))

              // Denominator for constraints: 'pedersen/hash0/ec_subset_sum/zeros_tail', 'pedersen/hash1/ec_subset_sum/zeros_tail', 'pedersen/hash2/ec_subset_sum/zeros_tail', 'pedersen/hash3/ec_subset_sum/zeros_tail'.
              // Numerator for constraints: 'pedersen/hash0/ec_subset_sum/booleanity_test', 'pedersen/hash0/ec_subset_sum/add_points/slope', 'pedersen/hash0/ec_subset_sum/add_points/x', 'pedersen/hash0/ec_subset_sum/add_points/y', 'pedersen/hash0/ec_subset_sum/copy_point/x', 'pedersen/hash0/ec_subset_sum/copy_point/y', 'pedersen/hash1/ec_subset_sum/booleanity_test', 'pedersen/hash1/ec_subset_sum/add_points/slope', 'pedersen/hash1/ec_subset_sum/add_points/x', 'pedersen/hash1/ec_subset_sum/add_points/y', 'pedersen/hash1/ec_subset_sum/copy_point/x', 'pedersen/hash1/ec_subset_sum/copy_point/y', 'pedersen/hash2/ec_subset_sum/booleanity_test', 'pedersen/hash2/ec_subset_sum/add_points/slope', 'pedersen/hash2/ec_subset_sum/add_points/x', 'pedersen/hash2/ec_subset_sum/add_points/y', 'pedersen/hash2/ec_subset_sum/copy_point/x', 'pedersen/hash2/ec_subset_sum/copy_point/y', 'pedersen/hash3/ec_subset_sum/booleanity_test', 'pedersen/hash3/ec_subset_sum/add_points/slope', 'pedersen/hash3/ec_subset_sum/add_points/x', 'pedersen/hash3/ec_subset_sum/add_points/y', 'pedersen/hash3/ec_subset_sum/copy_point/x', 'pedersen/hash3/ec_subset_sum/copy_point/y'.
              // domains[8] = point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              mstore(0x2620,
                     addmod(
                       /*point^(trace_length / 256)*/ mload(0x2300),
                       sub(PRIME, /*trace_generator^(255 * trace_length / 256)*/ mload(0x2460)),
                       PRIME))

              // Denominator for constraints: 'pedersen/hash0/ec_subset_sum/bit_extraction_end', 'pedersen/hash1/ec_subset_sum/bit_extraction_end', 'pedersen/hash2/ec_subset_sum/bit_extraction_end', 'pedersen/hash3/ec_subset_sum/bit_extraction_end'.
              // domains[9] = point^(trace_length / 256) - trace_generator^(63 * trace_length / 64).
              mstore(0x2640,
                     addmod(
                       /*point^(trace_length / 256)*/ mload(0x2300),
                       sub(PRIME, /*trace_generator^(63 * trace_length / 64)*/ mload(0x2440)),
                       PRIME))

              // Numerator for constraints: 'pedersen/hash0/copy_point/x', 'pedersen/hash0/copy_point/y', 'pedersen/hash1/copy_point/x', 'pedersen/hash1/copy_point/y', 'pedersen/hash2/copy_point/x', 'pedersen/hash2/copy_point/y', 'pedersen/hash3/copy_point/x', 'pedersen/hash3/copy_point/y'.
              // domains[10] = point^(trace_length / 512) - trace_generator^(trace_length / 2).
              mstore(0x2660,
                     addmod(
                       /*point^(trace_length / 512)*/ mload(0x22e0),
                       sub(PRIME, /*trace_generator^(trace_length / 2)*/ mload(0x23e0)),
                       PRIME))

              // Denominator for constraints: 'pedersen/hash0/init/x', 'pedersen/hash0/init/y', 'pedersen/hash1/init/x', 'pedersen/hash1/init/y', 'pedersen/hash2/init/x', 'pedersen/hash2/init/y', 'pedersen/hash3/init/x', 'pedersen/hash3/init/y', 'pedersen/input0_value0', 'pedersen/input0_value1', 'pedersen/input0_value2', 'pedersen/input0_value3', 'pedersen/input1_value0', 'pedersen/input1_value1', 'pedersen/input1_value2', 'pedersen/input1_value3', 'pedersen/output_value0', 'pedersen/output_value1', 'pedersen/output_value2', 'pedersen/output_value3'.
              // domains[11] = point^(trace_length / 512) - 1.
              mstore(0x2680,
                     addmod(/*point^(trace_length / 512)*/ mload(0x22e0), sub(PRIME, 1), PRIME))

              // Denominator for constraints: 'ecdsa/signature0/exponentiate_key/zeros_tail'.
              // Numerator for constraints: 'ecdsa/signature0/doubling_key/slope', 'ecdsa/signature0/doubling_key/x', 'ecdsa/signature0/doubling_key/y', 'ecdsa/signature0/exponentiate_key/booleanity_test', 'ecdsa/signature0/exponentiate_key/add_points/slope', 'ecdsa/signature0/exponentiate_key/add_points/x', 'ecdsa/signature0/exponentiate_key/add_points/y', 'ecdsa/signature0/exponentiate_key/add_points/x_diff_inv', 'ecdsa/signature0/exponentiate_key/copy_point/x', 'ecdsa/signature0/exponentiate_key/copy_point/y'.
              // domains[12] = point^(trace_length / 4096) - trace_generator^(255 * trace_length / 256).
              mstore(0x26a0,
                     addmod(
                       /*point^(trace_length / 4096)*/ mload(0x22c0),
                       sub(PRIME, /*trace_generator^(255 * trace_length / 256)*/ mload(0x2460)),
                       PRIME))

              // Denominator for constraints: 'ecdsa/signature0/exponentiate_key/bit_extraction_end'.
              // domains[13] = point^(trace_length / 4096) - trace_generator^(251 * trace_length / 256).
              mstore(0x26c0,
                     addmod(
                       /*point^(trace_length / 4096)*/ mload(0x22c0),
                       sub(PRIME, /*trace_generator^(251 * trace_length / 256)*/ mload(0x2420)),
                       PRIME))

              // Denominator for constraints: 'ecdsa/signature0/init_key/x', 'ecdsa/signature0/init_key/y', 'ecdsa/signature0/r_and_w_nonzero'.
              // domains[14] = point^(trace_length / 4096) - 1.
              mstore(0x26e0,
                     addmod(/*point^(trace_length / 4096)*/ mload(0x22c0), sub(PRIME, 1), PRIME))

              // Denominator for constraints: 'ecdsa/signature0/exponentiate_generator/zeros_tail'.
              // Numerator for constraints: 'ecdsa/signature0/exponentiate_generator/booleanity_test', 'ecdsa/signature0/exponentiate_generator/add_points/slope', 'ecdsa/signature0/exponentiate_generator/add_points/x', 'ecdsa/signature0/exponentiate_generator/add_points/y', 'ecdsa/signature0/exponentiate_generator/add_points/x_diff_inv', 'ecdsa/signature0/exponentiate_generator/copy_point/x', 'ecdsa/signature0/exponentiate_generator/copy_point/y'.
              // domains[15] = point^(trace_length / 8192) - trace_generator^(255 * trace_length / 256).
              mstore(0x2700,
                     addmod(
                       /*point^(trace_length / 8192)*/ mload(0x22a0),
                       sub(PRIME, /*trace_generator^(255 * trace_length / 256)*/ mload(0x2460)),
                       PRIME))

              // Denominator for constraints: 'ecdsa/signature0/exponentiate_generator/bit_extraction_end'.
              // domains[16] = point^(trace_length / 8192) - trace_generator^(251 * trace_length / 256).
              mstore(0x2720,
                     addmod(
                       /*point^(trace_length / 8192)*/ mload(0x22a0),
                       sub(PRIME, /*trace_generator^(251 * trace_length / 256)*/ mload(0x2420)),
                       PRIME))

              // Denominator for constraints: 'ecdsa/signature0/init_gen/x', 'ecdsa/signature0/init_gen/y', 'ecdsa/signature0/add_results/slope', 'ecdsa/signature0/add_results/x', 'ecdsa/signature0/add_results/y', 'ecdsa/signature0/add_results/x_diff_inv', 'ecdsa/signature0/extract_r/slope', 'ecdsa/signature0/extract_r/x', 'ecdsa/signature0/extract_r/x_diff_inv', 'ecdsa/signature0/z_nonzero', 'ecdsa/signature0/q_on_curve/x_squared', 'ecdsa/signature0/q_on_curve/on_curve', 'ecdsa/message_addr', 'ecdsa/pubkey_addr', 'ecdsa/message_value0', 'ecdsa/pubkey_value0'.
              // domains[17] = point^(trace_length / 8192) - 1.
              mstore(0x2740,
                     addmod(/*point^(trace_length / 8192)*/ mload(0x22a0), sub(PRIME, 1), PRIME))

              // Denominator for constraints: 'final_ap', 'final_fp', 'final_pc'.
              // Numerator for constraints: 'cpu/update_registers/update_pc/tmp0', 'cpu/update_registers/update_pc/tmp1', 'cpu/update_registers/update_pc/pc_cond_negative', 'cpu/update_registers/update_pc/pc_cond_positive', 'cpu/update_registers/update_ap/ap_update', 'cpu/update_registers/update_fp/fp_update'.
              // domains[18] = point - trace_generator^(16 * (trace_length / 16 - 1)).
              mstore(0x2760,
                     addmod(
                       point,
                       sub(PRIME, /*trace_generator^(16 * (trace_length / 16 - 1))*/ mload(0x2480)),
                       PRIME))

              // Denominator for constraints: 'initial_ap', 'initial_fp', 'initial_pc', 'memory/multi_column_perm/perm/init0', 'memory/initial_addr', 'rc16/perm/init0', 'rc16/minimum', 'pedersen/init_addr', 'rc_builtin/init_addr', 'ecdsa/init_addr'.
              // domains[19] = point - 1.
              mstore(0x2780,
                     addmod(point, sub(PRIME, 1), PRIME))

              // Denominator for constraints: 'memory/multi_column_perm/perm/last'.
              // Numerator for constraints: 'memory/multi_column_perm/perm/step0', 'memory/diff_is_bit', 'memory/is_func'.
              // domains[20] = point - trace_generator^(2 * (trace_length / 2 - 1)).
              mstore(0x27a0,
                     addmod(
                       point,
                       sub(PRIME, /*trace_generator^(2 * (trace_length / 2 - 1))*/ mload(0x24a0)),
                       PRIME))

              // Denominator for constraints: 'rc16/perm/last', 'rc16/maximum'.
              // Numerator for constraints: 'rc16/perm/step0', 'rc16/diff_is_bit'.
              // domains[21] = point - trace_generator^(trace_length - 1).
              mstore(0x27c0,
                     addmod(point, sub(PRIME, /*trace_generator^(trace_length - 1)*/ mload(0x24c0)), PRIME))

              // Numerator for constraints: 'pedersen/input0_addr', 'rc_builtin/addr_step'.
              // domains[22] = point - trace_generator^(128 * (trace_length / 128 - 1)).
              mstore(0x27e0,
                     addmod(
                       point,
                       sub(PRIME, /*trace_generator^(128 * (trace_length / 128 - 1))*/ mload(0x24e0)),
                       PRIME))

              // Numerator for constraints: 'ecdsa/pubkey_addr'.
              // domains[23] = point - trace_generator^(8192 * (trace_length / 8192 - 1)).
              mstore(0x2800,
                     addmod(
                       point,
                       sub(PRIME, /*trace_generator^(8192 * (trace_length / 8192 - 1))*/ mload(0x2500)),
                       PRIME))

            }

            {
              // Prepare denominators for batch inverse.

              // denominators[0] = domains[0].
              mstore(0x2ac0, /*domains[0]*/ mload(0x2520))

              // denominators[1] = domains[3].
              mstore(0x2ae0, /*domains[3]*/ mload(0x2580))

              // denominators[2] = domains[4].
              mstore(0x2b00, /*domains[4]*/ mload(0x25a0))

              // denominators[3] = domains[18].
              mstore(0x2b20, /*domains[18]*/ mload(0x2760))

              // denominators[4] = domains[19].
              mstore(0x2b40, /*domains[19]*/ mload(0x2780))

              // denominators[5] = domains[1].
              mstore(0x2b60, /*domains[1]*/ mload(0x2540))

              // denominators[6] = domains[20].
              mstore(0x2b80, /*domains[20]*/ mload(0x27a0))

              // denominators[7] = domains[2].
              mstore(0x2ba0, /*domains[2]*/ mload(0x2560))

              // denominators[8] = domains[21].
              mstore(0x2bc0, /*domains[21]*/ mload(0x27c0))

              // denominators[9] = domains[7].
              mstore(0x2be0, /*domains[7]*/ mload(0x2600))

              // denominators[10] = domains[8].
              mstore(0x2c00, /*domains[8]*/ mload(0x2620))

              // denominators[11] = domains[9].
              mstore(0x2c20, /*domains[9]*/ mload(0x2640))

              // denominators[12] = domains[11].
              mstore(0x2c40, /*domains[11]*/ mload(0x2680))

              // denominators[13] = domains[6].
              mstore(0x2c60, /*domains[6]*/ mload(0x25e0))

              // denominators[14] = domains[12].
              mstore(0x2c80, /*domains[12]*/ mload(0x26a0))

              // denominators[15] = domains[5].
              mstore(0x2ca0, /*domains[5]*/ mload(0x25c0))

              // denominators[16] = domains[15].
              mstore(0x2cc0, /*domains[15]*/ mload(0x2700))

              // denominators[17] = domains[16].
              mstore(0x2ce0, /*domains[16]*/ mload(0x2720))

              // denominators[18] = domains[13].
              mstore(0x2d00, /*domains[13]*/ mload(0x26c0))

              // denominators[19] = domains[17].
              mstore(0x2d20, /*domains[17]*/ mload(0x2740))

              // denominators[20] = domains[14].
              mstore(0x2d40, /*domains[14]*/ mload(0x26e0))

            }

            {
              // Compute the inverses of the denominators into denominatorInvs using batch inverse.

              // Start by computing the cumulative product.
              // Let (d_0, d_1, d_2, ..., d_{n-1}) be the values in denominators. After this loop
              // denominatorInvs will be (1, d_0, d_0 * d_1, ...) and prod will contain the value of
              // d_0 * ... * d_{n-1}.
              // Compute the offset between the partialProducts array and the input values array.
              let productsToValuesOffset := 0x2a0
              let prod := 1
              let partialProductEndPtr := 0x2ac0
              for { let partialProductPtr := 0x2820 }
                  lt(partialProductPtr, partialProductEndPtr)
                  { partialProductPtr := add(partialProductPtr, 0x20) } {
                  mstore(partialProductPtr, prod)
                  // prod *= d_{i}.
                  prod := mulmod(prod,
                                 mload(add(partialProductPtr, productsToValuesOffset)),
                                 PRIME)
              }

              let firstPartialProductPtr := 0x2820
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
              let currentPartialProductPtr := 0x2ac0
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
              // Compute the result of the composition polynomial.

              {
              // cpu/decode/opcode_rc/bit_0 = column1_row0 - (column1_row1 + column1_row1).
              let val := addmod(
                /*column1_row0*/ mload(0x5a0),
                sub(
                  PRIME,
                  addmod(/*column1_row1*/ mload(0x5c0), /*column1_row1*/ mload(0x5c0), PRIME)),
                PRIME)
              mstore(0x1d40, val)
              }


              {
              // cpu/decode/opcode_rc/bit_2 = column1_row2 - (column1_row3 + column1_row3).
              let val := addmod(
                /*column1_row2*/ mload(0x5e0),
                sub(
                  PRIME,
                  addmod(/*column1_row3*/ mload(0x600), /*column1_row3*/ mload(0x600), PRIME)),
                PRIME)
              mstore(0x1d60, val)
              }


              {
              // cpu/decode/opcode_rc/bit_4 = column1_row4 - (column1_row5 + column1_row5).
              let val := addmod(
                /*column1_row4*/ mload(0x620),
                sub(
                  PRIME,
                  addmod(/*column1_row5*/ mload(0x640), /*column1_row5*/ mload(0x640), PRIME)),
                PRIME)
              mstore(0x1d80, val)
              }


              {
              // cpu/decode/opcode_rc/bit_3 = column1_row3 - (column1_row4 + column1_row4).
              let val := addmod(
                /*column1_row3*/ mload(0x600),
                sub(
                  PRIME,
                  addmod(/*column1_row4*/ mload(0x620), /*column1_row4*/ mload(0x620), PRIME)),
                PRIME)
              mstore(0x1da0, val)
              }


              {
              // cpu/decode/flag_op1_base_op0_0 = 1 - (cpu__decode__opcode_rc__bit_2 + cpu__decode__opcode_rc__bit_4 + cpu__decode__opcode_rc__bit_3).
              let val := addmod(
                1,
                sub(
                  PRIME,
                  addmod(
                    addmod(
                      /*intermediate_value/cpu/decode/opcode_rc/bit_2*/ mload(0x1d60),
                      /*intermediate_value/cpu/decode/opcode_rc/bit_4*/ mload(0x1d80),
                      PRIME),
                    /*intermediate_value/cpu/decode/opcode_rc/bit_3*/ mload(0x1da0),
                    PRIME)),
                PRIME)
              mstore(0x1dc0, val)
              }


              {
              // cpu/decode/opcode_rc/bit_5 = column1_row5 - (column1_row6 + column1_row6).
              let val := addmod(
                /*column1_row5*/ mload(0x640),
                sub(
                  PRIME,
                  addmod(/*column1_row6*/ mload(0x660), /*column1_row6*/ mload(0x660), PRIME)),
                PRIME)
              mstore(0x1de0, val)
              }


              {
              // cpu/decode/opcode_rc/bit_6 = column1_row6 - (column1_row7 + column1_row7).
              let val := addmod(
                /*column1_row6*/ mload(0x660),
                sub(
                  PRIME,
                  addmod(/*column1_row7*/ mload(0x680), /*column1_row7*/ mload(0x680), PRIME)),
                PRIME)
              mstore(0x1e00, val)
              }


              {
              // cpu/decode/opcode_rc/bit_9 = column1_row9 - (column1_row10 + column1_row10).
              let val := addmod(
                /*column1_row9*/ mload(0x6c0),
                sub(
                  PRIME,
                  addmod(/*column1_row10*/ mload(0x6e0), /*column1_row10*/ mload(0x6e0), PRIME)),
                PRIME)
              mstore(0x1e20, val)
              }


              {
              // cpu/decode/flag_res_op1_0 = 1 - (cpu__decode__opcode_rc__bit_5 + cpu__decode__opcode_rc__bit_6 + cpu__decode__opcode_rc__bit_9).
              let val := addmod(
                1,
                sub(
                  PRIME,
                  addmod(
                    addmod(
                      /*intermediate_value/cpu/decode/opcode_rc/bit_5*/ mload(0x1de0),
                      /*intermediate_value/cpu/decode/opcode_rc/bit_6*/ mload(0x1e00),
                      PRIME),
                    /*intermediate_value/cpu/decode/opcode_rc/bit_9*/ mload(0x1e20),
                    PRIME)),
                PRIME)
              mstore(0x1e40, val)
              }


              {
              // cpu/decode/opcode_rc/bit_7 = column1_row7 - (column1_row8 + column1_row8).
              let val := addmod(
                /*column1_row7*/ mload(0x680),
                sub(
                  PRIME,
                  addmod(/*column1_row8*/ mload(0x6a0), /*column1_row8*/ mload(0x6a0), PRIME)),
                PRIME)
              mstore(0x1e60, val)
              }


              {
              // cpu/decode/opcode_rc/bit_8 = column1_row8 - (column1_row9 + column1_row9).
              let val := addmod(
                /*column1_row8*/ mload(0x6a0),
                sub(
                  PRIME,
                  addmod(/*column1_row9*/ mload(0x6c0), /*column1_row9*/ mload(0x6c0), PRIME)),
                PRIME)
              mstore(0x1e80, val)
              }


              {
              // cpu/decode/flag_pc_update_regular_0 = 1 - (cpu__decode__opcode_rc__bit_7 + cpu__decode__opcode_rc__bit_8 + cpu__decode__opcode_rc__bit_9).
              let val := addmod(
                1,
                sub(
                  PRIME,
                  addmod(
                    addmod(
                      /*intermediate_value/cpu/decode/opcode_rc/bit_7*/ mload(0x1e60),
                      /*intermediate_value/cpu/decode/opcode_rc/bit_8*/ mload(0x1e80),
                      PRIME),
                    /*intermediate_value/cpu/decode/opcode_rc/bit_9*/ mload(0x1e20),
                    PRIME)),
                PRIME)
              mstore(0x1ea0, val)
              }


              {
              // cpu/decode/opcode_rc/bit_12 = column1_row12 - (column1_row13 + column1_row13).
              let val := addmod(
                /*column1_row12*/ mload(0x720),
                sub(
                  PRIME,
                  addmod(/*column1_row13*/ mload(0x740), /*column1_row13*/ mload(0x740), PRIME)),
                PRIME)
              mstore(0x1ec0, val)
              }


              {
              // cpu/decode/opcode_rc/bit_13 = column1_row13 - (column1_row14 + column1_row14).
              let val := addmod(
                /*column1_row13*/ mload(0x740),
                sub(
                  PRIME,
                  addmod(/*column1_row14*/ mload(0x760), /*column1_row14*/ mload(0x760), PRIME)),
                PRIME)
              mstore(0x1ee0, val)
              }


              {
              // cpu/decode/fp_update_regular_0 = 1 - (cpu__decode__opcode_rc__bit_12 + cpu__decode__opcode_rc__bit_13).
              let val := addmod(
                1,
                sub(
                  PRIME,
                  addmod(
                    /*intermediate_value/cpu/decode/opcode_rc/bit_12*/ mload(0x1ec0),
                    /*intermediate_value/cpu/decode/opcode_rc/bit_13*/ mload(0x1ee0),
                    PRIME)),
                PRIME)
              mstore(0x1f00, val)
              }


              {
              // cpu/decode/opcode_rc/bit_1 = column1_row1 - (column1_row2 + column1_row2).
              let val := addmod(
                /*column1_row1*/ mload(0x5c0),
                sub(
                  PRIME,
                  addmod(/*column1_row2*/ mload(0x5e0), /*column1_row2*/ mload(0x5e0), PRIME)),
                PRIME)
              mstore(0x1f20, val)
              }


              {
              // npc_reg_0 = column19_row0 + cpu__decode__opcode_rc__bit_2 + 1.
              let val := addmod(
                addmod(
                  /*column19_row0*/ mload(0x11e0),
                  /*intermediate_value/cpu/decode/opcode_rc/bit_2*/ mload(0x1d60),
                  PRIME),
                1,
                PRIME)
              mstore(0x1f40, val)
              }


              {
              // cpu/decode/opcode_rc/bit_10 = column1_row10 - (column1_row11 + column1_row11).
              let val := addmod(
                /*column1_row10*/ mload(0x6e0),
                sub(
                  PRIME,
                  addmod(/*column1_row11*/ mload(0x700), /*column1_row11*/ mload(0x700), PRIME)),
                PRIME)
              mstore(0x1f60, val)
              }


              {
              // cpu/decode/opcode_rc/bit_11 = column1_row11 - (column1_row12 + column1_row12).
              let val := addmod(
                /*column1_row11*/ mload(0x700),
                sub(
                  PRIME,
                  addmod(/*column1_row12*/ mload(0x720), /*column1_row12*/ mload(0x720), PRIME)),
                PRIME)
              mstore(0x1f80, val)
              }


              {
              // cpu/decode/opcode_rc/bit_14 = column1_row14 - (column1_row15 + column1_row15).
              let val := addmod(
                /*column1_row14*/ mload(0x760),
                sub(
                  PRIME,
                  addmod(/*column1_row15*/ mload(0x780), /*column1_row15*/ mload(0x780), PRIME)),
                PRIME)
              mstore(0x1fa0, val)
              }


              {
              // memory/address_diff_0 = column20_row2 - column20_row0.
              let val := addmod(/*column20_row2*/ mload(0x1680), sub(PRIME, /*column20_row0*/ mload(0x1640)), PRIME)
              mstore(0x1fc0, val)
              }


              {
              // rc16/diff_0 = column2_row1 - column2_row0.
              let val := addmod(/*column2_row1*/ mload(0x7c0), sub(PRIME, /*column2_row0*/ mload(0x7a0)), PRIME)
              mstore(0x1fe0, val)
              }


              {
              // pedersen/hash0/ec_subset_sum/bit_0 = column5_row0 - (column5_row1 + column5_row1).
              let val := addmod(
                /*column5_row0*/ mload(0x900),
                sub(
                  PRIME,
                  addmod(/*column5_row1*/ mload(0x920), /*column5_row1*/ mload(0x920), PRIME)),
                PRIME)
              mstore(0x2000, val)
              }


              {
              // pedersen/hash0/ec_subset_sum/bit_neg_0 = 1 - pedersen__hash0__ec_subset_sum__bit_0.
              let val := addmod(
                1,
                sub(PRIME, /*intermediate_value/pedersen/hash0/ec_subset_sum/bit_0*/ mload(0x2000)),
                PRIME)
              mstore(0x2020, val)
              }


              {
              // pedersen/hash1/ec_subset_sum/bit_0 = column8_row0 - (column8_row1 + column8_row1).
              let val := addmod(
                /*column8_row0*/ mload(0xb40),
                sub(
                  PRIME,
                  addmod(/*column8_row1*/ mload(0xb60), /*column8_row1*/ mload(0xb60), PRIME)),
                PRIME)
              mstore(0x2040, val)
              }


              {
              // pedersen/hash1/ec_subset_sum/bit_neg_0 = 1 - pedersen__hash1__ec_subset_sum__bit_0.
              let val := addmod(
                1,
                sub(PRIME, /*intermediate_value/pedersen/hash1/ec_subset_sum/bit_0*/ mload(0x2040)),
                PRIME)
              mstore(0x2060, val)
              }


              {
              // pedersen/hash2/ec_subset_sum/bit_0 = column11_row0 - (column11_row1 + column11_row1).
              let val := addmod(
                /*column11_row0*/ mload(0xd80),
                sub(
                  PRIME,
                  addmod(/*column11_row1*/ mload(0xda0), /*column11_row1*/ mload(0xda0), PRIME)),
                PRIME)
              mstore(0x2080, val)
              }


              {
              // pedersen/hash2/ec_subset_sum/bit_neg_0 = 1 - pedersen__hash2__ec_subset_sum__bit_0.
              let val := addmod(
                1,
                sub(PRIME, /*intermediate_value/pedersen/hash2/ec_subset_sum/bit_0*/ mload(0x2080)),
                PRIME)
              mstore(0x20a0, val)
              }


              {
              // pedersen/hash3/ec_subset_sum/bit_0 = column14_row0 - (column14_row1 + column14_row1).
              let val := addmod(
                /*column14_row0*/ mload(0xfc0),
                sub(
                  PRIME,
                  addmod(/*column14_row1*/ mload(0xfe0), /*column14_row1*/ mload(0xfe0), PRIME)),
                PRIME)
              mstore(0x20c0, val)
              }


              {
              // pedersen/hash3/ec_subset_sum/bit_neg_0 = 1 - pedersen__hash3__ec_subset_sum__bit_0.
              let val := addmod(
                1,
                sub(PRIME, /*intermediate_value/pedersen/hash3/ec_subset_sum/bit_0*/ mload(0x20c0)),
                PRIME)
              mstore(0x20e0, val)
              }


              {
              // rc_builtin/value0_0 = column0_row12.
              let val := /*column0_row12*/ mload(0x4a0)
              mstore(0x2100, val)
              }


              {
              // rc_builtin/value1_0 = rc_builtin__value0_0 * offset_size + column0_row28.
              let val := addmod(
                mulmod(
                  /*intermediate_value/rc_builtin/value0_0*/ mload(0x2100),
                  /*offset_size*/ mload(0xa0),
                  PRIME),
                /*column0_row28*/ mload(0x4c0),
                PRIME)
              mstore(0x2120, val)
              }


              {
              // rc_builtin/value2_0 = rc_builtin__value1_0 * offset_size + column0_row44.
              let val := addmod(
                mulmod(
                  /*intermediate_value/rc_builtin/value1_0*/ mload(0x2120),
                  /*offset_size*/ mload(0xa0),
                  PRIME),
                /*column0_row44*/ mload(0x4e0),
                PRIME)
              mstore(0x2140, val)
              }


              {
              // rc_builtin/value3_0 = rc_builtin__value2_0 * offset_size + column0_row60.
              let val := addmod(
                mulmod(
                  /*intermediate_value/rc_builtin/value2_0*/ mload(0x2140),
                  /*offset_size*/ mload(0xa0),
                  PRIME),
                /*column0_row60*/ mload(0x500),
                PRIME)
              mstore(0x2160, val)
              }


              {
              // rc_builtin/value4_0 = rc_builtin__value3_0 * offset_size + column0_row76.
              let val := addmod(
                mulmod(
                  /*intermediate_value/rc_builtin/value3_0*/ mload(0x2160),
                  /*offset_size*/ mload(0xa0),
                  PRIME),
                /*column0_row76*/ mload(0x520),
                PRIME)
              mstore(0x2180, val)
              }


              {
              // rc_builtin/value5_0 = rc_builtin__value4_0 * offset_size + column0_row92.
              let val := addmod(
                mulmod(
                  /*intermediate_value/rc_builtin/value4_0*/ mload(0x2180),
                  /*offset_size*/ mload(0xa0),
                  PRIME),
                /*column0_row92*/ mload(0x540),
                PRIME)
              mstore(0x21a0, val)
              }


              {
              // rc_builtin/value6_0 = rc_builtin__value5_0 * offset_size + column0_row108.
              let val := addmod(
                mulmod(
                  /*intermediate_value/rc_builtin/value5_0*/ mload(0x21a0),
                  /*offset_size*/ mload(0xa0),
                  PRIME),
                /*column0_row108*/ mload(0x560),
                PRIME)
              mstore(0x21c0, val)
              }


              {
              // rc_builtin/value7_0 = rc_builtin__value6_0 * offset_size + column0_row124.
              let val := addmod(
                mulmod(
                  /*intermediate_value/rc_builtin/value6_0*/ mload(0x21c0),
                  /*offset_size*/ mload(0xa0),
                  PRIME),
                /*column0_row124*/ mload(0x580),
                PRIME)
              mstore(0x21e0, val)
              }


              {
              // ecdsa/signature0/doubling_key/x_squared = column21_row6 * column21_row6.
              let val := mulmod(/*column21_row6*/ mload(0x1780), /*column21_row6*/ mload(0x1780), PRIME)
              mstore(0x2200, val)
              }


              {
              // ecdsa/signature0/exponentiate_generator/bit_0 = column21_row15 - (column21_row47 + column21_row47).
              let val := addmod(
                /*column21_row15*/ mload(0x18a0),
                sub(
                  PRIME,
                  addmod(/*column21_row47*/ mload(0x1a00), /*column21_row47*/ mload(0x1a00), PRIME)),
                PRIME)
              mstore(0x2220, val)
              }


              {
              // ecdsa/signature0/exponentiate_generator/bit_neg_0 = 1 - ecdsa__signature0__exponentiate_generator__bit_0.
              let val := addmod(
                1,
                sub(
                  PRIME,
                  /*intermediate_value/ecdsa/signature0/exponentiate_generator/bit_0*/ mload(0x2220)),
                PRIME)
              mstore(0x2240, val)
              }


              {
              // ecdsa/signature0/exponentiate_key/bit_0 = column21_row5 - (column21_row21 + column21_row21).
              let val := addmod(
                /*column21_row5*/ mload(0x1760),
                sub(
                  PRIME,
                  addmod(/*column21_row21*/ mload(0x1900), /*column21_row21*/ mload(0x1900), PRIME)),
                PRIME)
              mstore(0x2260, val)
              }


              {
              // ecdsa/signature0/exponentiate_key/bit_neg_0 = 1 - ecdsa__signature0__exponentiate_key__bit_0.
              let val := addmod(
                1,
                sub(
                  PRIME,
                  /*intermediate_value/ecdsa/signature0/exponentiate_key/bit_0*/ mload(0x2260)),
                PRIME)
              mstore(0x2280, val)
              }


              let composition_alpha_pow := 1
              let composition_alpha := /*composition_alpha*/ mload(0x400)
              {
              // Constraint expression for cpu/decode/opcode_rc/bit: cpu__decode__opcode_rc__bit_0 * cpu__decode__opcode_rc__bit_0 - cpu__decode__opcode_rc__bit_0.
              let val := addmod(
                mulmod(
                  /*intermediate_value/cpu/decode/opcode_rc/bit_0*/ mload(0x1d40),
                  /*intermediate_value/cpu/decode/opcode_rc/bit_0*/ mload(0x1d40),
                  PRIME),
                sub(PRIME, /*intermediate_value/cpu/decode/opcode_rc/bit_0*/ mload(0x1d40)),
                PRIME)

              // Numerator: point^(trace_length / 16) - trace_generator^(15 * trace_length / 16).
              // val *= domains[3].
              val := mulmod(val, /*domains[3]*/ mload(0x2580), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x2820), PRIME)

              // res += val * alpha ** 0.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/decode/opcode_rc/zero: column1_row0.
              let val := /*column1_row0*/ mload(0x5a0)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 16) - trace_generator^(15 * trace_length / 16).
              // val *= denominator_invs[1].
              val := mulmod(val, /*denominator_invs[1]*/ mload(0x2840), PRIME)

              // res += val * alpha ** 1.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/decode/opcode_rc_input: column19_row1 - (((column1_row0 * offset_size + column0_row4) * offset_size + column0_row8) * offset_size + column0_row0).
              let val := addmod(
                /*column19_row1*/ mload(0x1200),
                sub(
                  PRIME,
                  addmod(
                    mulmod(
                      addmod(
                        mulmod(
                          addmod(
                            mulmod(/*column1_row0*/ mload(0x5a0), /*offset_size*/ mload(0xa0), PRIME),
                            /*column0_row4*/ mload(0x460),
                            PRIME),
                          /*offset_size*/ mload(0xa0),
                          PRIME),
                        /*column0_row8*/ mload(0x480),
                        PRIME),
                      /*offset_size*/ mload(0xa0),
                      PRIME),
                    /*column0_row0*/ mload(0x420),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x2860), PRIME)

              // res += val * alpha ** 2.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/decode/flag_op1_base_op0_bit: cpu__decode__flag_op1_base_op0_0 * cpu__decode__flag_op1_base_op0_0 - cpu__decode__flag_op1_base_op0_0.
              let val := addmod(
                mulmod(
                  /*intermediate_value/cpu/decode/flag_op1_base_op0_0*/ mload(0x1dc0),
                  /*intermediate_value/cpu/decode/flag_op1_base_op0_0*/ mload(0x1dc0),
                  PRIME),
                sub(PRIME, /*intermediate_value/cpu/decode/flag_op1_base_op0_0*/ mload(0x1dc0)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x2860), PRIME)

              // res += val * alpha ** 3.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/decode/flag_res_op1_bit: cpu__decode__flag_res_op1_0 * cpu__decode__flag_res_op1_0 - cpu__decode__flag_res_op1_0.
              let val := addmod(
                mulmod(
                  /*intermediate_value/cpu/decode/flag_res_op1_0*/ mload(0x1e40),
                  /*intermediate_value/cpu/decode/flag_res_op1_0*/ mload(0x1e40),
                  PRIME),
                sub(PRIME, /*intermediate_value/cpu/decode/flag_res_op1_0*/ mload(0x1e40)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x2860), PRIME)

              // res += val * alpha ** 4.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/decode/flag_pc_update_regular_bit: cpu__decode__flag_pc_update_regular_0 * cpu__decode__flag_pc_update_regular_0 - cpu__decode__flag_pc_update_regular_0.
              let val := addmod(
                mulmod(
                  /*intermediate_value/cpu/decode/flag_pc_update_regular_0*/ mload(0x1ea0),
                  /*intermediate_value/cpu/decode/flag_pc_update_regular_0*/ mload(0x1ea0),
                  PRIME),
                sub(PRIME, /*intermediate_value/cpu/decode/flag_pc_update_regular_0*/ mload(0x1ea0)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x2860), PRIME)

              // res += val * alpha ** 5.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/decode/fp_update_regular_bit: cpu__decode__fp_update_regular_0 * cpu__decode__fp_update_regular_0 - cpu__decode__fp_update_regular_0.
              let val := addmod(
                mulmod(
                  /*intermediate_value/cpu/decode/fp_update_regular_0*/ mload(0x1f00),
                  /*intermediate_value/cpu/decode/fp_update_regular_0*/ mload(0x1f00),
                  PRIME),
                sub(PRIME, /*intermediate_value/cpu/decode/fp_update_regular_0*/ mload(0x1f00)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x2860), PRIME)

              // res += val * alpha ** 6.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/operands/mem_dst_addr: column19_row8 + half_offset_size - (cpu__decode__opcode_rc__bit_0 * column21_row8 + (1 - cpu__decode__opcode_rc__bit_0) * column21_row0 + column0_row0).
              let val := addmod(
                addmod(/*column19_row8*/ mload(0x12e0), /*half_offset_size*/ mload(0xc0), PRIME),
                sub(
                  PRIME,
                  addmod(
                    addmod(
                      mulmod(
                        /*intermediate_value/cpu/decode/opcode_rc/bit_0*/ mload(0x1d40),
                        /*column21_row8*/ mload(0x17c0),
                        PRIME),
                      mulmod(
                        addmod(
                          1,
                          sub(PRIME, /*intermediate_value/cpu/decode/opcode_rc/bit_0*/ mload(0x1d40)),
                          PRIME),
                        /*column21_row0*/ mload(0x16c0),
                        PRIME),
                      PRIME),
                    /*column0_row0*/ mload(0x420),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x2860), PRIME)

              // res += val * alpha ** 7.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/operands/mem0_addr: column19_row4 + half_offset_size - (cpu__decode__opcode_rc__bit_1 * column21_row8 + (1 - cpu__decode__opcode_rc__bit_1) * column21_row0 + column0_row8).
              let val := addmod(
                addmod(/*column19_row4*/ mload(0x1260), /*half_offset_size*/ mload(0xc0), PRIME),
                sub(
                  PRIME,
                  addmod(
                    addmod(
                      mulmod(
                        /*intermediate_value/cpu/decode/opcode_rc/bit_1*/ mload(0x1f20),
                        /*column21_row8*/ mload(0x17c0),
                        PRIME),
                      mulmod(
                        addmod(
                          1,
                          sub(PRIME, /*intermediate_value/cpu/decode/opcode_rc/bit_1*/ mload(0x1f20)),
                          PRIME),
                        /*column21_row0*/ mload(0x16c0),
                        PRIME),
                      PRIME),
                    /*column0_row8*/ mload(0x480),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x2860), PRIME)

              // res += val * alpha ** 8.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/operands/mem1_addr: column19_row12 + half_offset_size - (cpu__decode__opcode_rc__bit_2 * column19_row0 + cpu__decode__opcode_rc__bit_4 * column21_row0 + cpu__decode__opcode_rc__bit_3 * column21_row8 + cpu__decode__flag_op1_base_op0_0 * column19_row5 + column0_row4).
              let val := addmod(
                addmod(/*column19_row12*/ mload(0x1320), /*half_offset_size*/ mload(0xc0), PRIME),
                sub(
                  PRIME,
                  addmod(
                    addmod(
                      addmod(
                        addmod(
                          mulmod(
                            /*intermediate_value/cpu/decode/opcode_rc/bit_2*/ mload(0x1d60),
                            /*column19_row0*/ mload(0x11e0),
                            PRIME),
                          mulmod(
                            /*intermediate_value/cpu/decode/opcode_rc/bit_4*/ mload(0x1d80),
                            /*column21_row0*/ mload(0x16c0),
                            PRIME),
                          PRIME),
                        mulmod(
                          /*intermediate_value/cpu/decode/opcode_rc/bit_3*/ mload(0x1da0),
                          /*column21_row8*/ mload(0x17c0),
                          PRIME),
                        PRIME),
                      mulmod(
                        /*intermediate_value/cpu/decode/flag_op1_base_op0_0*/ mload(0x1dc0),
                        /*column19_row5*/ mload(0x1280),
                        PRIME),
                      PRIME),
                    /*column0_row4*/ mload(0x460),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x2860), PRIME)

              // res += val * alpha ** 9.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/operands/ops_mul: column21_row4 - column19_row5 * column19_row13.
              let val := addmod(
                /*column21_row4*/ mload(0x1740),
                sub(
                  PRIME,
                  mulmod(/*column19_row5*/ mload(0x1280), /*column19_row13*/ mload(0x1340), PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x2860), PRIME)

              // res += val * alpha ** 10.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/operands/res: (1 - cpu__decode__opcode_rc__bit_9) * column21_row12 - (cpu__decode__opcode_rc__bit_5 * (column19_row5 + column19_row13) + cpu__decode__opcode_rc__bit_6 * column21_row4 + cpu__decode__flag_res_op1_0 * column19_row13).
              let val := addmod(
                mulmod(
                  addmod(
                    1,
                    sub(PRIME, /*intermediate_value/cpu/decode/opcode_rc/bit_9*/ mload(0x1e20)),
                    PRIME),
                  /*column21_row12*/ mload(0x1840),
                  PRIME),
                sub(
                  PRIME,
                  addmod(
                    addmod(
                      mulmod(
                        /*intermediate_value/cpu/decode/opcode_rc/bit_5*/ mload(0x1de0),
                        addmod(/*column19_row5*/ mload(0x1280), /*column19_row13*/ mload(0x1340), PRIME),
                        PRIME),
                      mulmod(
                        /*intermediate_value/cpu/decode/opcode_rc/bit_6*/ mload(0x1e00),
                        /*column21_row4*/ mload(0x1740),
                        PRIME),
                      PRIME),
                    mulmod(
                      /*intermediate_value/cpu/decode/flag_res_op1_0*/ mload(0x1e40),
                      /*column19_row13*/ mload(0x1340),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x2860), PRIME)

              // res += val * alpha ** 11.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/update_registers/update_pc/tmp0: column21_row2 - cpu__decode__opcode_rc__bit_9 * column19_row9.
              let val := addmod(
                /*column21_row2*/ mload(0x1700),
                sub(
                  PRIME,
                  mulmod(
                    /*intermediate_value/cpu/decode/opcode_rc/bit_9*/ mload(0x1e20),
                    /*column19_row9*/ mload(0x1300),
                    PRIME)),
                PRIME)

              // Numerator: point - trace_generator^(16 * (trace_length / 16 - 1)).
              // val *= domains[18].
              val := mulmod(val, /*domains[18]*/ mload(0x2760), PRIME)
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x2860), PRIME)

              // res += val * alpha ** 12.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/update_registers/update_pc/tmp1: column21_row10 - column21_row2 * column21_row12.
              let val := addmod(
                /*column21_row10*/ mload(0x1800),
                sub(
                  PRIME,
                  mulmod(/*column21_row2*/ mload(0x1700), /*column21_row12*/ mload(0x1840), PRIME)),
                PRIME)

              // Numerator: point - trace_generator^(16 * (trace_length / 16 - 1)).
              // val *= domains[18].
              val := mulmod(val, /*domains[18]*/ mload(0x2760), PRIME)
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x2860), PRIME)

              // res += val * alpha ** 13.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/update_registers/update_pc/pc_cond_negative: (1 - cpu__decode__opcode_rc__bit_9) * column19_row16 + column21_row2 * (column19_row16 - (column19_row0 + column19_row13)) - (cpu__decode__flag_pc_update_regular_0 * npc_reg_0 + cpu__decode__opcode_rc__bit_7 * column21_row12 + cpu__decode__opcode_rc__bit_8 * (column19_row0 + column21_row12)).
              let val := addmod(
                addmod(
                  mulmod(
                    addmod(
                      1,
                      sub(PRIME, /*intermediate_value/cpu/decode/opcode_rc/bit_9*/ mload(0x1e20)),
                      PRIME),
                    /*column19_row16*/ mload(0x1360),
                    PRIME),
                  mulmod(
                    /*column21_row2*/ mload(0x1700),
                    addmod(
                      /*column19_row16*/ mload(0x1360),
                      sub(
                        PRIME,
                        addmod(/*column19_row0*/ mload(0x11e0), /*column19_row13*/ mload(0x1340), PRIME)),
                      PRIME),
                    PRIME),
                  PRIME),
                sub(
                  PRIME,
                  addmod(
                    addmod(
                      mulmod(
                        /*intermediate_value/cpu/decode/flag_pc_update_regular_0*/ mload(0x1ea0),
                        /*intermediate_value/npc_reg_0*/ mload(0x1f40),
                        PRIME),
                      mulmod(
                        /*intermediate_value/cpu/decode/opcode_rc/bit_7*/ mload(0x1e60),
                        /*column21_row12*/ mload(0x1840),
                        PRIME),
                      PRIME),
                    mulmod(
                      /*intermediate_value/cpu/decode/opcode_rc/bit_8*/ mload(0x1e80),
                      addmod(/*column19_row0*/ mload(0x11e0), /*column21_row12*/ mload(0x1840), PRIME),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point - trace_generator^(16 * (trace_length / 16 - 1)).
              // val *= domains[18].
              val := mulmod(val, /*domains[18]*/ mload(0x2760), PRIME)
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x2860), PRIME)

              // res += val * alpha ** 14.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/update_registers/update_pc/pc_cond_positive: (column21_row10 - cpu__decode__opcode_rc__bit_9) * (column19_row16 - npc_reg_0).
              let val := mulmod(
                addmod(
                  /*column21_row10*/ mload(0x1800),
                  sub(PRIME, /*intermediate_value/cpu/decode/opcode_rc/bit_9*/ mload(0x1e20)),
                  PRIME),
                addmod(
                  /*column19_row16*/ mload(0x1360),
                  sub(PRIME, /*intermediate_value/npc_reg_0*/ mload(0x1f40)),
                  PRIME),
                PRIME)

              // Numerator: point - trace_generator^(16 * (trace_length / 16 - 1)).
              // val *= domains[18].
              val := mulmod(val, /*domains[18]*/ mload(0x2760), PRIME)
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x2860), PRIME)

              // res += val * alpha ** 15.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/update_registers/update_ap/ap_update: column21_row16 - (column21_row0 + cpu__decode__opcode_rc__bit_10 * column21_row12 + cpu__decode__opcode_rc__bit_11 + cpu__decode__opcode_rc__bit_12 * 2).
              let val := addmod(
                /*column21_row16*/ mload(0x18c0),
                sub(
                  PRIME,
                  addmod(
                    addmod(
                      addmod(
                        /*column21_row0*/ mload(0x16c0),
                        mulmod(
                          /*intermediate_value/cpu/decode/opcode_rc/bit_10*/ mload(0x1f60),
                          /*column21_row12*/ mload(0x1840),
                          PRIME),
                        PRIME),
                      /*intermediate_value/cpu/decode/opcode_rc/bit_11*/ mload(0x1f80),
                      PRIME),
                    mulmod(/*intermediate_value/cpu/decode/opcode_rc/bit_12*/ mload(0x1ec0), 2, PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point - trace_generator^(16 * (trace_length / 16 - 1)).
              // val *= domains[18].
              val := mulmod(val, /*domains[18]*/ mload(0x2760), PRIME)
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x2860), PRIME)

              // res += val * alpha ** 16.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/update_registers/update_fp/fp_update: column21_row24 - (cpu__decode__fp_update_regular_0 * column21_row8 + cpu__decode__opcode_rc__bit_13 * column19_row9 + cpu__decode__opcode_rc__bit_12 * (column21_row0 + 2)).
              let val := addmod(
                /*column21_row24*/ mload(0x1960),
                sub(
                  PRIME,
                  addmod(
                    addmod(
                      mulmod(
                        /*intermediate_value/cpu/decode/fp_update_regular_0*/ mload(0x1f00),
                        /*column21_row8*/ mload(0x17c0),
                        PRIME),
                      mulmod(
                        /*intermediate_value/cpu/decode/opcode_rc/bit_13*/ mload(0x1ee0),
                        /*column19_row9*/ mload(0x1300),
                        PRIME),
                      PRIME),
                    mulmod(
                      /*intermediate_value/cpu/decode/opcode_rc/bit_12*/ mload(0x1ec0),
                      addmod(/*column21_row0*/ mload(0x16c0), 2, PRIME),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point - trace_generator^(16 * (trace_length / 16 - 1)).
              // val *= domains[18].
              val := mulmod(val, /*domains[18]*/ mload(0x2760), PRIME)
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x2860), PRIME)

              // res += val * alpha ** 17.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/opcodes/call/push_fp: cpu__decode__opcode_rc__bit_12 * (column19_row9 - column21_row8).
              let val := mulmod(
                /*intermediate_value/cpu/decode/opcode_rc/bit_12*/ mload(0x1ec0),
                addmod(/*column19_row9*/ mload(0x1300), sub(PRIME, /*column21_row8*/ mload(0x17c0)), PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x2860), PRIME)

              // res += val * alpha ** 18.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/opcodes/call/push_pc: cpu__decode__opcode_rc__bit_12 * (column19_row5 - (column19_row0 + cpu__decode__opcode_rc__bit_2 + 1)).
              let val := mulmod(
                /*intermediate_value/cpu/decode/opcode_rc/bit_12*/ mload(0x1ec0),
                addmod(
                  /*column19_row5*/ mload(0x1280),
                  sub(
                    PRIME,
                    addmod(
                      addmod(
                        /*column19_row0*/ mload(0x11e0),
                        /*intermediate_value/cpu/decode/opcode_rc/bit_2*/ mload(0x1d60),
                        PRIME),
                      1,
                      PRIME)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x2860), PRIME)

              // res += val * alpha ** 19.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/opcodes/call/off0: cpu__decode__opcode_rc__bit_12 * (column0_row0 - half_offset_size).
              let val := mulmod(
                /*intermediate_value/cpu/decode/opcode_rc/bit_12*/ mload(0x1ec0),
                addmod(/*column0_row0*/ mload(0x420), sub(PRIME, /*half_offset_size*/ mload(0xc0)), PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x2860), PRIME)

              // res += val * alpha ** 20.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/opcodes/call/off1: cpu__decode__opcode_rc__bit_12 * (column0_row8 - (half_offset_size + 1)).
              let val := mulmod(
                /*intermediate_value/cpu/decode/opcode_rc/bit_12*/ mload(0x1ec0),
                addmod(
                  /*column0_row8*/ mload(0x480),
                  sub(PRIME, addmod(/*half_offset_size*/ mload(0xc0), 1, PRIME)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x2860), PRIME)

              // res += val * alpha ** 21.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/opcodes/call/flags: cpu__decode__opcode_rc__bit_12 * (cpu__decode__opcode_rc__bit_12 + cpu__decode__opcode_rc__bit_12 + 1 + 1 - (cpu__decode__opcode_rc__bit_0 + cpu__decode__opcode_rc__bit_1 + 4)).
              let val := mulmod(
                /*intermediate_value/cpu/decode/opcode_rc/bit_12*/ mload(0x1ec0),
                addmod(
                  addmod(
                    addmod(
                      addmod(
                        /*intermediate_value/cpu/decode/opcode_rc/bit_12*/ mload(0x1ec0),
                        /*intermediate_value/cpu/decode/opcode_rc/bit_12*/ mload(0x1ec0),
                        PRIME),
                      1,
                      PRIME),
                    1,
                    PRIME),
                  sub(
                    PRIME,
                    addmod(
                      addmod(
                        /*intermediate_value/cpu/decode/opcode_rc/bit_0*/ mload(0x1d40),
                        /*intermediate_value/cpu/decode/opcode_rc/bit_1*/ mload(0x1f20),
                        PRIME),
                      4,
                      PRIME)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x2860), PRIME)

              // res += val * alpha ** 22.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/opcodes/ret/off0: cpu__decode__opcode_rc__bit_13 * (column0_row0 + 2 - half_offset_size).
              let val := mulmod(
                /*intermediate_value/cpu/decode/opcode_rc/bit_13*/ mload(0x1ee0),
                addmod(
                  addmod(/*column0_row0*/ mload(0x420), 2, PRIME),
                  sub(PRIME, /*half_offset_size*/ mload(0xc0)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x2860), PRIME)

              // res += val * alpha ** 23.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/opcodes/ret/off2: cpu__decode__opcode_rc__bit_13 * (column0_row4 + 1 - half_offset_size).
              let val := mulmod(
                /*intermediate_value/cpu/decode/opcode_rc/bit_13*/ mload(0x1ee0),
                addmod(
                  addmod(/*column0_row4*/ mload(0x460), 1, PRIME),
                  sub(PRIME, /*half_offset_size*/ mload(0xc0)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x2860), PRIME)

              // res += val * alpha ** 24.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/opcodes/ret/flags: cpu__decode__opcode_rc__bit_13 * (cpu__decode__opcode_rc__bit_7 + cpu__decode__opcode_rc__bit_0 + cpu__decode__opcode_rc__bit_3 + cpu__decode__flag_res_op1_0 - 4).
              let val := mulmod(
                /*intermediate_value/cpu/decode/opcode_rc/bit_13*/ mload(0x1ee0),
                addmod(
                  addmod(
                    addmod(
                      addmod(
                        /*intermediate_value/cpu/decode/opcode_rc/bit_7*/ mload(0x1e60),
                        /*intermediate_value/cpu/decode/opcode_rc/bit_0*/ mload(0x1d40),
                        PRIME),
                      /*intermediate_value/cpu/decode/opcode_rc/bit_3*/ mload(0x1da0),
                      PRIME),
                    /*intermediate_value/cpu/decode/flag_res_op1_0*/ mload(0x1e40),
                    PRIME),
                  sub(PRIME, 4),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x2860), PRIME)

              // res += val * alpha ** 25.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/opcodes/assert_eq/assert_eq: cpu__decode__opcode_rc__bit_14 * (column19_row9 - column21_row12).
              let val := mulmod(
                /*intermediate_value/cpu/decode/opcode_rc/bit_14*/ mload(0x1fa0),
                addmod(
                  /*column19_row9*/ mload(0x1300),
                  sub(PRIME, /*column21_row12*/ mload(0x1840)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x2860), PRIME)

              // res += val * alpha ** 26.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for initial_ap: column21_row0 - initial_ap.
              let val := addmod(/*column21_row0*/ mload(0x16c0), sub(PRIME, /*initial_ap*/ mload(0xe0)), PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point - 1.
              // val *= denominator_invs[4].
              val := mulmod(val, /*denominator_invs[4]*/ mload(0x28a0), PRIME)

              // res += val * alpha ** 27.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for initial_fp: column21_row8 - initial_ap.
              let val := addmod(/*column21_row8*/ mload(0x17c0), sub(PRIME, /*initial_ap*/ mload(0xe0)), PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point - 1.
              // val *= denominator_invs[4].
              val := mulmod(val, /*denominator_invs[4]*/ mload(0x28a0), PRIME)

              // res += val * alpha ** 28.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for initial_pc: column19_row0 - initial_pc.
              let val := addmod(/*column19_row0*/ mload(0x11e0), sub(PRIME, /*initial_pc*/ mload(0x100)), PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point - 1.
              // val *= denominator_invs[4].
              val := mulmod(val, /*denominator_invs[4]*/ mload(0x28a0), PRIME)

              // res += val * alpha ** 29.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for final_ap: column21_row0 - final_ap.
              let val := addmod(/*column21_row0*/ mload(0x16c0), sub(PRIME, /*final_ap*/ mload(0x120)), PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point - trace_generator^(16 * (trace_length / 16 - 1)).
              // val *= denominator_invs[3].
              val := mulmod(val, /*denominator_invs[3]*/ mload(0x2880), PRIME)

              // res += val * alpha ** 30.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for final_fp: column21_row8 - initial_ap.
              let val := addmod(/*column21_row8*/ mload(0x17c0), sub(PRIME, /*initial_ap*/ mload(0xe0)), PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point - trace_generator^(16 * (trace_length / 16 - 1)).
              // val *= denominator_invs[3].
              val := mulmod(val, /*denominator_invs[3]*/ mload(0x2880), PRIME)

              // res += val * alpha ** 31.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for final_pc: column19_row0 - final_pc.
              let val := addmod(/*column19_row0*/ mload(0x11e0), sub(PRIME, /*final_pc*/ mload(0x140)), PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point - trace_generator^(16 * (trace_length / 16 - 1)).
              // val *= denominator_invs[3].
              val := mulmod(val, /*denominator_invs[3]*/ mload(0x2880), PRIME)

              // res += val * alpha ** 32.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for memory/multi_column_perm/perm/init0: (memory/multi_column_perm/perm/interaction_elm - (column20_row0 + memory/multi_column_perm/hash_interaction_elm0 * column20_row1)) * column24_inter1_row0 + column19_row0 + memory/multi_column_perm/hash_interaction_elm0 * column19_row1 - memory/multi_column_perm/perm/interaction_elm.
              let val := addmod(
                addmod(
                  addmod(
                    mulmod(
                      addmod(
                        /*memory/multi_column_perm/perm/interaction_elm*/ mload(0x160),
                        sub(
                          PRIME,
                          addmod(
                            /*column20_row0*/ mload(0x1640),
                            mulmod(
                              /*memory/multi_column_perm/hash_interaction_elm0*/ mload(0x180),
                              /*column20_row1*/ mload(0x1660),
                              PRIME),
                            PRIME)),
                        PRIME),
                      /*column24_inter1_row0*/ mload(0x1d00),
                      PRIME),
                    /*column19_row0*/ mload(0x11e0),
                    PRIME),
                  mulmod(
                    /*memory/multi_column_perm/hash_interaction_elm0*/ mload(0x180),
                    /*column19_row1*/ mload(0x1200),
                    PRIME),
                  PRIME),
                sub(PRIME, /*memory/multi_column_perm/perm/interaction_elm*/ mload(0x160)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point - 1.
              // val *= denominator_invs[4].
              val := mulmod(val, /*denominator_invs[4]*/ mload(0x28a0), PRIME)

              // res += val * alpha ** 33.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for memory/multi_column_perm/perm/step0: (memory/multi_column_perm/perm/interaction_elm - (column20_row2 + memory/multi_column_perm/hash_interaction_elm0 * column20_row3)) * column24_inter1_row2 - (memory/multi_column_perm/perm/interaction_elm - (column19_row2 + memory/multi_column_perm/hash_interaction_elm0 * column19_row3)) * column24_inter1_row0.
              let val := addmod(
                mulmod(
                  addmod(
                    /*memory/multi_column_perm/perm/interaction_elm*/ mload(0x160),
                    sub(
                      PRIME,
                      addmod(
                        /*column20_row2*/ mload(0x1680),
                        mulmod(
                          /*memory/multi_column_perm/hash_interaction_elm0*/ mload(0x180),
                          /*column20_row3*/ mload(0x16a0),
                          PRIME),
                        PRIME)),
                    PRIME),
                  /*column24_inter1_row2*/ mload(0x1d20),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    addmod(
                      /*memory/multi_column_perm/perm/interaction_elm*/ mload(0x160),
                      sub(
                        PRIME,
                        addmod(
                          /*column19_row2*/ mload(0x1220),
                          mulmod(
                            /*memory/multi_column_perm/hash_interaction_elm0*/ mload(0x180),
                            /*column19_row3*/ mload(0x1240),
                            PRIME),
                          PRIME)),
                      PRIME),
                    /*column24_inter1_row0*/ mload(0x1d00),
                    PRIME)),
                PRIME)

              // Numerator: point - trace_generator^(2 * (trace_length / 2 - 1)).
              // val *= domains[20].
              val := mulmod(val, /*domains[20]*/ mload(0x27a0), PRIME)
              // Denominator: point^(trace_length / 2) - 1.
              // val *= denominator_invs[5].
              val := mulmod(val, /*denominator_invs[5]*/ mload(0x28c0), PRIME)

              // res += val * alpha ** 34.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for memory/multi_column_perm/perm/last: column24_inter1_row0 - memory/multi_column_perm/perm/public_memory_prod.
              let val := addmod(
                /*column24_inter1_row0*/ mload(0x1d00),
                sub(PRIME, /*memory/multi_column_perm/perm/public_memory_prod*/ mload(0x1a0)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point - trace_generator^(2 * (trace_length / 2 - 1)).
              // val *= denominator_invs[6].
              val := mulmod(val, /*denominator_invs[6]*/ mload(0x28e0), PRIME)

              // res += val * alpha ** 35.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for memory/diff_is_bit: memory__address_diff_0 * memory__address_diff_0 - memory__address_diff_0.
              let val := addmod(
                mulmod(
                  /*intermediate_value/memory/address_diff_0*/ mload(0x1fc0),
                  /*intermediate_value/memory/address_diff_0*/ mload(0x1fc0),
                  PRIME),
                sub(PRIME, /*intermediate_value/memory/address_diff_0*/ mload(0x1fc0)),
                PRIME)

              // Numerator: point - trace_generator^(2 * (trace_length / 2 - 1)).
              // val *= domains[20].
              val := mulmod(val, /*domains[20]*/ mload(0x27a0), PRIME)
              // Denominator: point^(trace_length / 2) - 1.
              // val *= denominator_invs[5].
              val := mulmod(val, /*denominator_invs[5]*/ mload(0x28c0), PRIME)

              // res += val * alpha ** 36.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for memory/is_func: (memory__address_diff_0 - 1) * (column20_row1 - column20_row3).
              let val := mulmod(
                addmod(/*intermediate_value/memory/address_diff_0*/ mload(0x1fc0), sub(PRIME, 1), PRIME),
                addmod(/*column20_row1*/ mload(0x1660), sub(PRIME, /*column20_row3*/ mload(0x16a0)), PRIME),
                PRIME)

              // Numerator: point - trace_generator^(2 * (trace_length / 2 - 1)).
              // val *= domains[20].
              val := mulmod(val, /*domains[20]*/ mload(0x27a0), PRIME)
              // Denominator: point^(trace_length / 2) - 1.
              // val *= denominator_invs[5].
              val := mulmod(val, /*denominator_invs[5]*/ mload(0x28c0), PRIME)

              // res += val * alpha ** 37.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for memory/initial_addr: column20_row0 - 1.
              let val := addmod(/*column20_row0*/ mload(0x1640), sub(PRIME, 1), PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point - 1.
              // val *= denominator_invs[4].
              val := mulmod(val, /*denominator_invs[4]*/ mload(0x28a0), PRIME)

              // res += val * alpha ** 38.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for public_memory_addr_zero: column19_row2.
              let val := /*column19_row2*/ mload(0x1220)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 8) - 1.
              // val *= denominator_invs[7].
              val := mulmod(val, /*denominator_invs[7]*/ mload(0x2900), PRIME)

              // res += val * alpha ** 39.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for public_memory_value_zero: column19_row3.
              let val := /*column19_row3*/ mload(0x1240)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 8) - 1.
              // val *= denominator_invs[7].
              val := mulmod(val, /*denominator_invs[7]*/ mload(0x2900), PRIME)

              // res += val * alpha ** 40.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for rc16/perm/init0: (rc16/perm/interaction_elm - column2_row0) * column23_inter1_row0 + column0_row0 - rc16/perm/interaction_elm.
              let val := addmod(
                addmod(
                  mulmod(
                    addmod(
                      /*rc16/perm/interaction_elm*/ mload(0x1c0),
                      sub(PRIME, /*column2_row0*/ mload(0x7a0)),
                      PRIME),
                    /*column23_inter1_row0*/ mload(0x1cc0),
                    PRIME),
                  /*column0_row0*/ mload(0x420),
                  PRIME),
                sub(PRIME, /*rc16/perm/interaction_elm*/ mload(0x1c0)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point - 1.
              // val *= denominator_invs[4].
              val := mulmod(val, /*denominator_invs[4]*/ mload(0x28a0), PRIME)

              // res += val * alpha ** 41.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for rc16/perm/step0: (rc16/perm/interaction_elm - column2_row1) * column23_inter1_row1 - (rc16/perm/interaction_elm - column0_row1) * column23_inter1_row0.
              let val := addmod(
                mulmod(
                  addmod(
                    /*rc16/perm/interaction_elm*/ mload(0x1c0),
                    sub(PRIME, /*column2_row1*/ mload(0x7c0)),
                    PRIME),
                  /*column23_inter1_row1*/ mload(0x1ce0),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    addmod(
                      /*rc16/perm/interaction_elm*/ mload(0x1c0),
                      sub(PRIME, /*column0_row1*/ mload(0x440)),
                      PRIME),
                    /*column23_inter1_row0*/ mload(0x1cc0),
                    PRIME)),
                PRIME)

              // Numerator: point - trace_generator^(trace_length - 1).
              // val *= domains[21].
              val := mulmod(val, /*domains[21]*/ mload(0x27c0), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x2820), PRIME)

              // res += val * alpha ** 42.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for rc16/perm/last: column23_inter1_row0 - rc16/perm/public_memory_prod.
              let val := addmod(
                /*column23_inter1_row0*/ mload(0x1cc0),
                sub(PRIME, /*rc16/perm/public_memory_prod*/ mload(0x1e0)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point - trace_generator^(trace_length - 1).
              // val *= denominator_invs[8].
              val := mulmod(val, /*denominator_invs[8]*/ mload(0x2920), PRIME)

              // res += val * alpha ** 43.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for rc16/diff_is_bit: rc16__diff_0 * rc16__diff_0 - rc16__diff_0.
              let val := addmod(
                mulmod(
                  /*intermediate_value/rc16/diff_0*/ mload(0x1fe0),
                  /*intermediate_value/rc16/diff_0*/ mload(0x1fe0),
                  PRIME),
                sub(PRIME, /*intermediate_value/rc16/diff_0*/ mload(0x1fe0)),
                PRIME)

              // Numerator: point - trace_generator^(trace_length - 1).
              // val *= domains[21].
              val := mulmod(val, /*domains[21]*/ mload(0x27c0), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x2820), PRIME)

              // res += val * alpha ** 44.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for rc16/minimum: column2_row0 - rc_min.
              let val := addmod(/*column2_row0*/ mload(0x7a0), sub(PRIME, /*rc_min*/ mload(0x200)), PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point - 1.
              // val *= denominator_invs[4].
              val := mulmod(val, /*denominator_invs[4]*/ mload(0x28a0), PRIME)

              // res += val * alpha ** 45.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for rc16/maximum: column2_row0 - rc_max.
              let val := addmod(/*column2_row0*/ mload(0x7a0), sub(PRIME, /*rc_max*/ mload(0x220)), PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point - trace_generator^(trace_length - 1).
              // val *= denominator_invs[8].
              val := mulmod(val, /*denominator_invs[8]*/ mload(0x2920), PRIME)

              // res += val * alpha ** 46.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash0/ec_subset_sum/bit_unpacking/last_one_is_zero: column16_row255 * (column5_row0 - (column5_row1 + column5_row1)).
              let val := mulmod(
                /*column16_row255*/ mload(0x1140),
                addmod(
                  /*column5_row0*/ mload(0x900),
                  sub(
                    PRIME,
                    addmod(/*column5_row1*/ mload(0x920), /*column5_row1*/ mload(0x920), PRIME)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[9].
              val := mulmod(val, /*denominator_invs[9]*/ mload(0x2940), PRIME)

              // res += val * alpha ** 47.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash0/ec_subset_sum/bit_unpacking/zeroes_between_ones0: column16_row255 * (column5_row1 - 3138550867693340381917894711603833208051177722232017256448 * column5_row192).
              let val := mulmod(
                /*column16_row255*/ mload(0x1140),
                addmod(
                  /*column5_row1*/ mload(0x920),
                  sub(
                    PRIME,
                    mulmod(
                      3138550867693340381917894711603833208051177722232017256448,
                      /*column5_row192*/ mload(0x940),
                      PRIME)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[9].
              val := mulmod(val, /*denominator_invs[9]*/ mload(0x2940), PRIME)

              // res += val * alpha ** 48.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash0/ec_subset_sum/bit_unpacking/cumulative_bit192: column16_row255 - column15_row255 * (column5_row192 - (column5_row193 + column5_row193)).
              let val := addmod(
                /*column16_row255*/ mload(0x1140),
                sub(
                  PRIME,
                  mulmod(
                    /*column15_row255*/ mload(0x1100),
                    addmod(
                      /*column5_row192*/ mload(0x940),
                      sub(
                        PRIME,
                        addmod(/*column5_row193*/ mload(0x960), /*column5_row193*/ mload(0x960), PRIME)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[9].
              val := mulmod(val, /*denominator_invs[9]*/ mload(0x2940), PRIME)

              // res += val * alpha ** 49.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash0/ec_subset_sum/bit_unpacking/zeroes_between_ones192: column15_row255 * (column5_row193 - 8 * column5_row196).
              let val := mulmod(
                /*column15_row255*/ mload(0x1100),
                addmod(
                  /*column5_row193*/ mload(0x960),
                  sub(PRIME, mulmod(8, /*column5_row196*/ mload(0x980), PRIME)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[9].
              val := mulmod(val, /*denominator_invs[9]*/ mload(0x2940), PRIME)

              // res += val * alpha ** 50.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash0/ec_subset_sum/bit_unpacking/cumulative_bit196: column15_row255 - (column5_row251 - (column5_row252 + column5_row252)) * (column5_row196 - (column5_row197 + column5_row197)).
              let val := addmod(
                /*column15_row255*/ mload(0x1100),
                sub(
                  PRIME,
                  mulmod(
                    addmod(
                      /*column5_row251*/ mload(0x9c0),
                      sub(
                        PRIME,
                        addmod(/*column5_row252*/ mload(0x9e0), /*column5_row252*/ mload(0x9e0), PRIME)),
                      PRIME),
                    addmod(
                      /*column5_row196*/ mload(0x980),
                      sub(
                        PRIME,
                        addmod(/*column5_row197*/ mload(0x9a0), /*column5_row197*/ mload(0x9a0), PRIME)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[9].
              val := mulmod(val, /*denominator_invs[9]*/ mload(0x2940), PRIME)

              // res += val * alpha ** 51.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash0/ec_subset_sum/bit_unpacking/zeroes_between_ones196: (column5_row251 - (column5_row252 + column5_row252)) * (column5_row197 - 18014398509481984 * column5_row251).
              let val := mulmod(
                addmod(
                  /*column5_row251*/ mload(0x9c0),
                  sub(
                    PRIME,
                    addmod(/*column5_row252*/ mload(0x9e0), /*column5_row252*/ mload(0x9e0), PRIME)),
                  PRIME),
                addmod(
                  /*column5_row197*/ mload(0x9a0),
                  sub(PRIME, mulmod(18014398509481984, /*column5_row251*/ mload(0x9c0), PRIME)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[9].
              val := mulmod(val, /*denominator_invs[9]*/ mload(0x2940), PRIME)

              // res += val * alpha ** 52.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash0/ec_subset_sum/booleanity_test: pedersen__hash0__ec_subset_sum__bit_0 * (pedersen__hash0__ec_subset_sum__bit_0 - 1).
              let val := mulmod(
                /*intermediate_value/pedersen/hash0/ec_subset_sum/bit_0*/ mload(0x2000),
                addmod(
                  /*intermediate_value/pedersen/hash0/ec_subset_sum/bit_0*/ mload(0x2000),
                  sub(PRIME, 1),
                  PRIME),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[8].
              val := mulmod(val, /*domains[8]*/ mload(0x2620), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x2820), PRIME)

              // res += val * alpha ** 53.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash0/ec_subset_sum/bit_extraction_end: column5_row0.
              let val := /*column5_row0*/ mload(0x900)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - trace_generator^(63 * trace_length / 64).
              // val *= denominator_invs[11].
              val := mulmod(val, /*denominator_invs[11]*/ mload(0x2980), PRIME)

              // res += val * alpha ** 54.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash0/ec_subset_sum/zeros_tail: column5_row0.
              let val := /*column5_row0*/ mload(0x900)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= denominator_invs[10].
              val := mulmod(val, /*denominator_invs[10]*/ mload(0x2960), PRIME)

              // res += val * alpha ** 55.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash0/ec_subset_sum/add_points/slope: pedersen__hash0__ec_subset_sum__bit_0 * (column4_row0 - pedersen__points__y) - column15_row0 * (column3_row0 - pedersen__points__x).
              let val := addmod(
                mulmod(
                  /*intermediate_value/pedersen/hash0/ec_subset_sum/bit_0*/ mload(0x2000),
                  addmod(
                    /*column4_row0*/ mload(0x880),
                    sub(PRIME, /*periodic_column/pedersen/points/y*/ mload(0x20)),
                    PRIME),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*column15_row0*/ mload(0x10e0),
                    addmod(
                      /*column3_row0*/ mload(0x7e0),
                      sub(PRIME, /*periodic_column/pedersen/points/x*/ mload(0x0)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[8].
              val := mulmod(val, /*domains[8]*/ mload(0x2620), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x2820), PRIME)

              // res += val * alpha ** 56.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash0/ec_subset_sum/add_points/x: column15_row0 * column15_row0 - pedersen__hash0__ec_subset_sum__bit_0 * (column3_row0 + pedersen__points__x + column3_row1).
              let val := addmod(
                mulmod(/*column15_row0*/ mload(0x10e0), /*column15_row0*/ mload(0x10e0), PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*intermediate_value/pedersen/hash0/ec_subset_sum/bit_0*/ mload(0x2000),
                    addmod(
                      addmod(
                        /*column3_row0*/ mload(0x7e0),
                        /*periodic_column/pedersen/points/x*/ mload(0x0),
                        PRIME),
                      /*column3_row1*/ mload(0x800),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[8].
              val := mulmod(val, /*domains[8]*/ mload(0x2620), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x2820), PRIME)

              // res += val * alpha ** 57.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash0/ec_subset_sum/add_points/y: pedersen__hash0__ec_subset_sum__bit_0 * (column4_row0 + column4_row1) - column15_row0 * (column3_row0 - column3_row1).
              let val := addmod(
                mulmod(
                  /*intermediate_value/pedersen/hash0/ec_subset_sum/bit_0*/ mload(0x2000),
                  addmod(/*column4_row0*/ mload(0x880), /*column4_row1*/ mload(0x8a0), PRIME),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*column15_row0*/ mload(0x10e0),
                    addmod(/*column3_row0*/ mload(0x7e0), sub(PRIME, /*column3_row1*/ mload(0x800)), PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[8].
              val := mulmod(val, /*domains[8]*/ mload(0x2620), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x2820), PRIME)

              // res += val * alpha ** 58.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash0/ec_subset_sum/copy_point/x: pedersen__hash0__ec_subset_sum__bit_neg_0 * (column3_row1 - column3_row0).
              let val := mulmod(
                /*intermediate_value/pedersen/hash0/ec_subset_sum/bit_neg_0*/ mload(0x2020),
                addmod(/*column3_row1*/ mload(0x800), sub(PRIME, /*column3_row0*/ mload(0x7e0)), PRIME),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[8].
              val := mulmod(val, /*domains[8]*/ mload(0x2620), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x2820), PRIME)

              // res += val * alpha ** 59.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash0/ec_subset_sum/copy_point/y: pedersen__hash0__ec_subset_sum__bit_neg_0 * (column4_row1 - column4_row0).
              let val := mulmod(
                /*intermediate_value/pedersen/hash0/ec_subset_sum/bit_neg_0*/ mload(0x2020),
                addmod(/*column4_row1*/ mload(0x8a0), sub(PRIME, /*column4_row0*/ mload(0x880)), PRIME),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[8].
              val := mulmod(val, /*domains[8]*/ mload(0x2620), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x2820), PRIME)

              // res += val * alpha ** 60.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash0/copy_point/x: column3_row256 - column3_row255.
              let val := addmod(/*column3_row256*/ mload(0x840), sub(PRIME, /*column3_row255*/ mload(0x820)), PRIME)

              // Numerator: point^(trace_length / 512) - trace_generator^(trace_length / 2).
              // val *= domains[10].
              val := mulmod(val, /*domains[10]*/ mload(0x2660), PRIME)
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[9].
              val := mulmod(val, /*denominator_invs[9]*/ mload(0x2940), PRIME)

              // res += val * alpha ** 61.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash0/copy_point/y: column4_row256 - column4_row255.
              let val := addmod(/*column4_row256*/ mload(0x8e0), sub(PRIME, /*column4_row255*/ mload(0x8c0)), PRIME)

              // Numerator: point^(trace_length / 512) - trace_generator^(trace_length / 2).
              // val *= domains[10].
              val := mulmod(val, /*domains[10]*/ mload(0x2660), PRIME)
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[9].
              val := mulmod(val, /*denominator_invs[9]*/ mload(0x2940), PRIME)

              // res += val * alpha ** 62.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash0/init/x: column3_row0 - pedersen/shift_point.x.
              let val := addmod(
                /*column3_row0*/ mload(0x7e0),
                sub(PRIME, /*pedersen/shift_point.x*/ mload(0x240)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[12].
              val := mulmod(val, /*denominator_invs[12]*/ mload(0x29a0), PRIME)

              // res += val * alpha ** 63.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash0/init/y: column4_row0 - pedersen/shift_point.y.
              let val := addmod(
                /*column4_row0*/ mload(0x880),
                sub(PRIME, /*pedersen/shift_point.y*/ mload(0x260)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[12].
              val := mulmod(val, /*denominator_invs[12]*/ mload(0x29a0), PRIME)

              // res += val * alpha ** 64.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash1/ec_subset_sum/bit_unpacking/last_one_is_zero: column18_row255 * (column8_row0 - (column8_row1 + column8_row1)).
              let val := mulmod(
                /*column18_row255*/ mload(0x11c0),
                addmod(
                  /*column8_row0*/ mload(0xb40),
                  sub(
                    PRIME,
                    addmod(/*column8_row1*/ mload(0xb60), /*column8_row1*/ mload(0xb60), PRIME)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[9].
              val := mulmod(val, /*denominator_invs[9]*/ mload(0x2940), PRIME)

              // res += val * alpha ** 65.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash1/ec_subset_sum/bit_unpacking/zeroes_between_ones0: column18_row255 * (column8_row1 - 3138550867693340381917894711603833208051177722232017256448 * column8_row192).
              let val := mulmod(
                /*column18_row255*/ mload(0x11c0),
                addmod(
                  /*column8_row1*/ mload(0xb60),
                  sub(
                    PRIME,
                    mulmod(
                      3138550867693340381917894711603833208051177722232017256448,
                      /*column8_row192*/ mload(0xb80),
                      PRIME)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[9].
              val := mulmod(val, /*denominator_invs[9]*/ mload(0x2940), PRIME)

              // res += val * alpha ** 66.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash1/ec_subset_sum/bit_unpacking/cumulative_bit192: column18_row255 - column17_row255 * (column8_row192 - (column8_row193 + column8_row193)).
              let val := addmod(
                /*column18_row255*/ mload(0x11c0),
                sub(
                  PRIME,
                  mulmod(
                    /*column17_row255*/ mload(0x1180),
                    addmod(
                      /*column8_row192*/ mload(0xb80),
                      sub(
                        PRIME,
                        addmod(/*column8_row193*/ mload(0xba0), /*column8_row193*/ mload(0xba0), PRIME)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[9].
              val := mulmod(val, /*denominator_invs[9]*/ mload(0x2940), PRIME)

              // res += val * alpha ** 67.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash1/ec_subset_sum/bit_unpacking/zeroes_between_ones192: column17_row255 * (column8_row193 - 8 * column8_row196).
              let val := mulmod(
                /*column17_row255*/ mload(0x1180),
                addmod(
                  /*column8_row193*/ mload(0xba0),
                  sub(PRIME, mulmod(8, /*column8_row196*/ mload(0xbc0), PRIME)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[9].
              val := mulmod(val, /*denominator_invs[9]*/ mload(0x2940), PRIME)

              // res += val * alpha ** 68.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash1/ec_subset_sum/bit_unpacking/cumulative_bit196: column17_row255 - (column8_row251 - (column8_row252 + column8_row252)) * (column8_row196 - (column8_row197 + column8_row197)).
              let val := addmod(
                /*column17_row255*/ mload(0x1180),
                sub(
                  PRIME,
                  mulmod(
                    addmod(
                      /*column8_row251*/ mload(0xc00),
                      sub(
                        PRIME,
                        addmod(/*column8_row252*/ mload(0xc20), /*column8_row252*/ mload(0xc20), PRIME)),
                      PRIME),
                    addmod(
                      /*column8_row196*/ mload(0xbc0),
                      sub(
                        PRIME,
                        addmod(/*column8_row197*/ mload(0xbe0), /*column8_row197*/ mload(0xbe0), PRIME)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[9].
              val := mulmod(val, /*denominator_invs[9]*/ mload(0x2940), PRIME)

              // res += val * alpha ** 69.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash1/ec_subset_sum/bit_unpacking/zeroes_between_ones196: (column8_row251 - (column8_row252 + column8_row252)) * (column8_row197 - 18014398509481984 * column8_row251).
              let val := mulmod(
                addmod(
                  /*column8_row251*/ mload(0xc00),
                  sub(
                    PRIME,
                    addmod(/*column8_row252*/ mload(0xc20), /*column8_row252*/ mload(0xc20), PRIME)),
                  PRIME),
                addmod(
                  /*column8_row197*/ mload(0xbe0),
                  sub(PRIME, mulmod(18014398509481984, /*column8_row251*/ mload(0xc00), PRIME)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[9].
              val := mulmod(val, /*denominator_invs[9]*/ mload(0x2940), PRIME)

              // res += val * alpha ** 70.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash1/ec_subset_sum/booleanity_test: pedersen__hash1__ec_subset_sum__bit_0 * (pedersen__hash1__ec_subset_sum__bit_0 - 1).
              let val := mulmod(
                /*intermediate_value/pedersen/hash1/ec_subset_sum/bit_0*/ mload(0x2040),
                addmod(
                  /*intermediate_value/pedersen/hash1/ec_subset_sum/bit_0*/ mload(0x2040),
                  sub(PRIME, 1),
                  PRIME),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[8].
              val := mulmod(val, /*domains[8]*/ mload(0x2620), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x2820), PRIME)

              // res += val * alpha ** 71.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash1/ec_subset_sum/bit_extraction_end: column8_row0.
              let val := /*column8_row0*/ mload(0xb40)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - trace_generator^(63 * trace_length / 64).
              // val *= denominator_invs[11].
              val := mulmod(val, /*denominator_invs[11]*/ mload(0x2980), PRIME)

              // res += val * alpha ** 72.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash1/ec_subset_sum/zeros_tail: column8_row0.
              let val := /*column8_row0*/ mload(0xb40)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= denominator_invs[10].
              val := mulmod(val, /*denominator_invs[10]*/ mload(0x2960), PRIME)

              // res += val * alpha ** 73.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash1/ec_subset_sum/add_points/slope: pedersen__hash1__ec_subset_sum__bit_0 * (column7_row0 - pedersen__points__y) - column16_row0 * (column6_row0 - pedersen__points__x).
              let val := addmod(
                mulmod(
                  /*intermediate_value/pedersen/hash1/ec_subset_sum/bit_0*/ mload(0x2040),
                  addmod(
                    /*column7_row0*/ mload(0xac0),
                    sub(PRIME, /*periodic_column/pedersen/points/y*/ mload(0x20)),
                    PRIME),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*column16_row0*/ mload(0x1120),
                    addmod(
                      /*column6_row0*/ mload(0xa20),
                      sub(PRIME, /*periodic_column/pedersen/points/x*/ mload(0x0)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[8].
              val := mulmod(val, /*domains[8]*/ mload(0x2620), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x2820), PRIME)

              // res += val * alpha ** 74.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash1/ec_subset_sum/add_points/x: column16_row0 * column16_row0 - pedersen__hash1__ec_subset_sum__bit_0 * (column6_row0 + pedersen__points__x + column6_row1).
              let val := addmod(
                mulmod(/*column16_row0*/ mload(0x1120), /*column16_row0*/ mload(0x1120), PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*intermediate_value/pedersen/hash1/ec_subset_sum/bit_0*/ mload(0x2040),
                    addmod(
                      addmod(
                        /*column6_row0*/ mload(0xa20),
                        /*periodic_column/pedersen/points/x*/ mload(0x0),
                        PRIME),
                      /*column6_row1*/ mload(0xa40),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[8].
              val := mulmod(val, /*domains[8]*/ mload(0x2620), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x2820), PRIME)

              // res += val * alpha ** 75.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash1/ec_subset_sum/add_points/y: pedersen__hash1__ec_subset_sum__bit_0 * (column7_row0 + column7_row1) - column16_row0 * (column6_row0 - column6_row1).
              let val := addmod(
                mulmod(
                  /*intermediate_value/pedersen/hash1/ec_subset_sum/bit_0*/ mload(0x2040),
                  addmod(/*column7_row0*/ mload(0xac0), /*column7_row1*/ mload(0xae0), PRIME),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*column16_row0*/ mload(0x1120),
                    addmod(/*column6_row0*/ mload(0xa20), sub(PRIME, /*column6_row1*/ mload(0xa40)), PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[8].
              val := mulmod(val, /*domains[8]*/ mload(0x2620), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x2820), PRIME)

              // res += val * alpha ** 76.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash1/ec_subset_sum/copy_point/x: pedersen__hash1__ec_subset_sum__bit_neg_0 * (column6_row1 - column6_row0).
              let val := mulmod(
                /*intermediate_value/pedersen/hash1/ec_subset_sum/bit_neg_0*/ mload(0x2060),
                addmod(/*column6_row1*/ mload(0xa40), sub(PRIME, /*column6_row0*/ mload(0xa20)), PRIME),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[8].
              val := mulmod(val, /*domains[8]*/ mload(0x2620), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x2820), PRIME)

              // res += val * alpha ** 77.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash1/ec_subset_sum/copy_point/y: pedersen__hash1__ec_subset_sum__bit_neg_0 * (column7_row1 - column7_row0).
              let val := mulmod(
                /*intermediate_value/pedersen/hash1/ec_subset_sum/bit_neg_0*/ mload(0x2060),
                addmod(/*column7_row1*/ mload(0xae0), sub(PRIME, /*column7_row0*/ mload(0xac0)), PRIME),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[8].
              val := mulmod(val, /*domains[8]*/ mload(0x2620), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x2820), PRIME)

              // res += val * alpha ** 78.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash1/copy_point/x: column6_row256 - column6_row255.
              let val := addmod(/*column6_row256*/ mload(0xa80), sub(PRIME, /*column6_row255*/ mload(0xa60)), PRIME)

              // Numerator: point^(trace_length / 512) - trace_generator^(trace_length / 2).
              // val *= domains[10].
              val := mulmod(val, /*domains[10]*/ mload(0x2660), PRIME)
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[9].
              val := mulmod(val, /*denominator_invs[9]*/ mload(0x2940), PRIME)

              // res += val * alpha ** 79.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash1/copy_point/y: column7_row256 - column7_row255.
              let val := addmod(/*column7_row256*/ mload(0xb20), sub(PRIME, /*column7_row255*/ mload(0xb00)), PRIME)

              // Numerator: point^(trace_length / 512) - trace_generator^(trace_length / 2).
              // val *= domains[10].
              val := mulmod(val, /*domains[10]*/ mload(0x2660), PRIME)
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[9].
              val := mulmod(val, /*denominator_invs[9]*/ mload(0x2940), PRIME)

              // res += val * alpha ** 80.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash1/init/x: column6_row0 - pedersen/shift_point.x.
              let val := addmod(
                /*column6_row0*/ mload(0xa20),
                sub(PRIME, /*pedersen/shift_point.x*/ mload(0x240)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[12].
              val := mulmod(val, /*denominator_invs[12]*/ mload(0x29a0), PRIME)

              // res += val * alpha ** 81.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash1/init/y: column7_row0 - pedersen/shift_point.y.
              let val := addmod(
                /*column7_row0*/ mload(0xac0),
                sub(PRIME, /*pedersen/shift_point.y*/ mload(0x260)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[12].
              val := mulmod(val, /*denominator_invs[12]*/ mload(0x29a0), PRIME)

              // res += val * alpha ** 82.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash2/ec_subset_sum/bit_unpacking/last_one_is_zero: column22_row144 * (column11_row0 - (column11_row1 + column11_row1)).
              let val := mulmod(
                /*column22_row144*/ mload(0x1c60),
                addmod(
                  /*column11_row0*/ mload(0xd80),
                  sub(
                    PRIME,
                    addmod(/*column11_row1*/ mload(0xda0), /*column11_row1*/ mload(0xda0), PRIME)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[9].
              val := mulmod(val, /*denominator_invs[9]*/ mload(0x2940), PRIME)

              // res += val * alpha ** 83.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash2/ec_subset_sum/bit_unpacking/zeroes_between_ones0: column22_row144 * (column11_row1 - 3138550867693340381917894711603833208051177722232017256448 * column11_row192).
              let val := mulmod(
                /*column22_row144*/ mload(0x1c60),
                addmod(
                  /*column11_row1*/ mload(0xda0),
                  sub(
                    PRIME,
                    mulmod(
                      3138550867693340381917894711603833208051177722232017256448,
                      /*column11_row192*/ mload(0xdc0),
                      PRIME)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[9].
              val := mulmod(val, /*denominator_invs[9]*/ mload(0x2940), PRIME)

              // res += val * alpha ** 84.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash2/ec_subset_sum/bit_unpacking/cumulative_bit192: column22_row144 - column22_row16 * (column11_row192 - (column11_row193 + column11_row193)).
              let val := addmod(
                /*column22_row144*/ mload(0x1c60),
                sub(
                  PRIME,
                  mulmod(
                    /*column22_row16*/ mload(0x1c20),
                    addmod(
                      /*column11_row192*/ mload(0xdc0),
                      sub(
                        PRIME,
                        addmod(/*column11_row193*/ mload(0xde0), /*column11_row193*/ mload(0xde0), PRIME)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[9].
              val := mulmod(val, /*denominator_invs[9]*/ mload(0x2940), PRIME)

              // res += val * alpha ** 85.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash2/ec_subset_sum/bit_unpacking/zeroes_between_ones192: column22_row16 * (column11_row193 - 8 * column11_row196).
              let val := mulmod(
                /*column22_row16*/ mload(0x1c20),
                addmod(
                  /*column11_row193*/ mload(0xde0),
                  sub(PRIME, mulmod(8, /*column11_row196*/ mload(0xe00), PRIME)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[9].
              val := mulmod(val, /*denominator_invs[9]*/ mload(0x2940), PRIME)

              // res += val * alpha ** 86.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash2/ec_subset_sum/bit_unpacking/cumulative_bit196: column22_row16 - (column11_row251 - (column11_row252 + column11_row252)) * (column11_row196 - (column11_row197 + column11_row197)).
              let val := addmod(
                /*column22_row16*/ mload(0x1c20),
                sub(
                  PRIME,
                  mulmod(
                    addmod(
                      /*column11_row251*/ mload(0xe40),
                      sub(
                        PRIME,
                        addmod(/*column11_row252*/ mload(0xe60), /*column11_row252*/ mload(0xe60), PRIME)),
                      PRIME),
                    addmod(
                      /*column11_row196*/ mload(0xe00),
                      sub(
                        PRIME,
                        addmod(/*column11_row197*/ mload(0xe20), /*column11_row197*/ mload(0xe20), PRIME)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[9].
              val := mulmod(val, /*denominator_invs[9]*/ mload(0x2940), PRIME)

              // res += val * alpha ** 87.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash2/ec_subset_sum/bit_unpacking/zeroes_between_ones196: (column11_row251 - (column11_row252 + column11_row252)) * (column11_row197 - 18014398509481984 * column11_row251).
              let val := mulmod(
                addmod(
                  /*column11_row251*/ mload(0xe40),
                  sub(
                    PRIME,
                    addmod(/*column11_row252*/ mload(0xe60), /*column11_row252*/ mload(0xe60), PRIME)),
                  PRIME),
                addmod(
                  /*column11_row197*/ mload(0xe20),
                  sub(PRIME, mulmod(18014398509481984, /*column11_row251*/ mload(0xe40), PRIME)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[9].
              val := mulmod(val, /*denominator_invs[9]*/ mload(0x2940), PRIME)

              // res += val * alpha ** 88.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash2/ec_subset_sum/booleanity_test: pedersen__hash2__ec_subset_sum__bit_0 * (pedersen__hash2__ec_subset_sum__bit_0 - 1).
              let val := mulmod(
                /*intermediate_value/pedersen/hash2/ec_subset_sum/bit_0*/ mload(0x2080),
                addmod(
                  /*intermediate_value/pedersen/hash2/ec_subset_sum/bit_0*/ mload(0x2080),
                  sub(PRIME, 1),
                  PRIME),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[8].
              val := mulmod(val, /*domains[8]*/ mload(0x2620), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x2820), PRIME)

              // res += val * alpha ** 89.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash2/ec_subset_sum/bit_extraction_end: column11_row0.
              let val := /*column11_row0*/ mload(0xd80)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - trace_generator^(63 * trace_length / 64).
              // val *= denominator_invs[11].
              val := mulmod(val, /*denominator_invs[11]*/ mload(0x2980), PRIME)

              // res += val * alpha ** 90.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash2/ec_subset_sum/zeros_tail: column11_row0.
              let val := /*column11_row0*/ mload(0xd80)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= denominator_invs[10].
              val := mulmod(val, /*denominator_invs[10]*/ mload(0x2960), PRIME)

              // res += val * alpha ** 91.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash2/ec_subset_sum/add_points/slope: pedersen__hash2__ec_subset_sum__bit_0 * (column10_row0 - pedersen__points__y) - column17_row0 * (column9_row0 - pedersen__points__x).
              let val := addmod(
                mulmod(
                  /*intermediate_value/pedersen/hash2/ec_subset_sum/bit_0*/ mload(0x2080),
                  addmod(
                    /*column10_row0*/ mload(0xd00),
                    sub(PRIME, /*periodic_column/pedersen/points/y*/ mload(0x20)),
                    PRIME),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*column17_row0*/ mload(0x1160),
                    addmod(
                      /*column9_row0*/ mload(0xc60),
                      sub(PRIME, /*periodic_column/pedersen/points/x*/ mload(0x0)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[8].
              val := mulmod(val, /*domains[8]*/ mload(0x2620), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x2820), PRIME)

              // res += val * alpha ** 92.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash2/ec_subset_sum/add_points/x: column17_row0 * column17_row0 - pedersen__hash2__ec_subset_sum__bit_0 * (column9_row0 + pedersen__points__x + column9_row1).
              let val := addmod(
                mulmod(/*column17_row0*/ mload(0x1160), /*column17_row0*/ mload(0x1160), PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*intermediate_value/pedersen/hash2/ec_subset_sum/bit_0*/ mload(0x2080),
                    addmod(
                      addmod(
                        /*column9_row0*/ mload(0xc60),
                        /*periodic_column/pedersen/points/x*/ mload(0x0),
                        PRIME),
                      /*column9_row1*/ mload(0xc80),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[8].
              val := mulmod(val, /*domains[8]*/ mload(0x2620), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x2820), PRIME)

              // res += val * alpha ** 93.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash2/ec_subset_sum/add_points/y: pedersen__hash2__ec_subset_sum__bit_0 * (column10_row0 + column10_row1) - column17_row0 * (column9_row0 - column9_row1).
              let val := addmod(
                mulmod(
                  /*intermediate_value/pedersen/hash2/ec_subset_sum/bit_0*/ mload(0x2080),
                  addmod(/*column10_row0*/ mload(0xd00), /*column10_row1*/ mload(0xd20), PRIME),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*column17_row0*/ mload(0x1160),
                    addmod(/*column9_row0*/ mload(0xc60), sub(PRIME, /*column9_row1*/ mload(0xc80)), PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[8].
              val := mulmod(val, /*domains[8]*/ mload(0x2620), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x2820), PRIME)

              // res += val * alpha ** 94.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash2/ec_subset_sum/copy_point/x: pedersen__hash2__ec_subset_sum__bit_neg_0 * (column9_row1 - column9_row0).
              let val := mulmod(
                /*intermediate_value/pedersen/hash2/ec_subset_sum/bit_neg_0*/ mload(0x20a0),
                addmod(/*column9_row1*/ mload(0xc80), sub(PRIME, /*column9_row0*/ mload(0xc60)), PRIME),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[8].
              val := mulmod(val, /*domains[8]*/ mload(0x2620), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x2820), PRIME)

              // res += val * alpha ** 95.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash2/ec_subset_sum/copy_point/y: pedersen__hash2__ec_subset_sum__bit_neg_0 * (column10_row1 - column10_row0).
              let val := mulmod(
                /*intermediate_value/pedersen/hash2/ec_subset_sum/bit_neg_0*/ mload(0x20a0),
                addmod(/*column10_row1*/ mload(0xd20), sub(PRIME, /*column10_row0*/ mload(0xd00)), PRIME),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[8].
              val := mulmod(val, /*domains[8]*/ mload(0x2620), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x2820), PRIME)

              // res += val * alpha ** 96.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash2/copy_point/x: column9_row256 - column9_row255.
              let val := addmod(/*column9_row256*/ mload(0xcc0), sub(PRIME, /*column9_row255*/ mload(0xca0)), PRIME)

              // Numerator: point^(trace_length / 512) - trace_generator^(trace_length / 2).
              // val *= domains[10].
              val := mulmod(val, /*domains[10]*/ mload(0x2660), PRIME)
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[9].
              val := mulmod(val, /*denominator_invs[9]*/ mload(0x2940), PRIME)

              // res += val * alpha ** 97.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash2/copy_point/y: column10_row256 - column10_row255.
              let val := addmod(
                /*column10_row256*/ mload(0xd60),
                sub(PRIME, /*column10_row255*/ mload(0xd40)),
                PRIME)

              // Numerator: point^(trace_length / 512) - trace_generator^(trace_length / 2).
              // val *= domains[10].
              val := mulmod(val, /*domains[10]*/ mload(0x2660), PRIME)
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[9].
              val := mulmod(val, /*denominator_invs[9]*/ mload(0x2940), PRIME)

              // res += val * alpha ** 98.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash2/init/x: column9_row0 - pedersen/shift_point.x.
              let val := addmod(
                /*column9_row0*/ mload(0xc60),
                sub(PRIME, /*pedersen/shift_point.x*/ mload(0x240)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[12].
              val := mulmod(val, /*denominator_invs[12]*/ mload(0x29a0), PRIME)

              // res += val * alpha ** 99.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash2/init/y: column10_row0 - pedersen/shift_point.y.
              let val := addmod(
                /*column10_row0*/ mload(0xd00),
                sub(PRIME, /*pedersen/shift_point.y*/ mload(0x260)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[12].
              val := mulmod(val, /*denominator_invs[12]*/ mload(0x29a0), PRIME)

              // res += val * alpha ** 100.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash3/ec_subset_sum/bit_unpacking/last_one_is_zero: column22_row208 * (column14_row0 - (column14_row1 + column14_row1)).
              let val := mulmod(
                /*column22_row208*/ mload(0x1c80),
                addmod(
                  /*column14_row0*/ mload(0xfc0),
                  sub(
                    PRIME,
                    addmod(/*column14_row1*/ mload(0xfe0), /*column14_row1*/ mload(0xfe0), PRIME)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[9].
              val := mulmod(val, /*denominator_invs[9]*/ mload(0x2940), PRIME)

              // res += val * alpha ** 101.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash3/ec_subset_sum/bit_unpacking/zeroes_between_ones0: column22_row208 * (column14_row1 - 3138550867693340381917894711603833208051177722232017256448 * column14_row192).
              let val := mulmod(
                /*column22_row208*/ mload(0x1c80),
                addmod(
                  /*column14_row1*/ mload(0xfe0),
                  sub(
                    PRIME,
                    mulmod(
                      3138550867693340381917894711603833208051177722232017256448,
                      /*column14_row192*/ mload(0x1000),
                      PRIME)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[9].
              val := mulmod(val, /*denominator_invs[9]*/ mload(0x2940), PRIME)

              // res += val * alpha ** 102.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash3/ec_subset_sum/bit_unpacking/cumulative_bit192: column22_row208 - column22_row80 * (column14_row192 - (column14_row193 + column14_row193)).
              let val := addmod(
                /*column22_row208*/ mload(0x1c80),
                sub(
                  PRIME,
                  mulmod(
                    /*column22_row80*/ mload(0x1c40),
                    addmod(
                      /*column14_row192*/ mload(0x1000),
                      sub(
                        PRIME,
                        addmod(/*column14_row193*/ mload(0x1020), /*column14_row193*/ mload(0x1020), PRIME)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[9].
              val := mulmod(val, /*denominator_invs[9]*/ mload(0x2940), PRIME)

              // res += val * alpha ** 103.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash3/ec_subset_sum/bit_unpacking/zeroes_between_ones192: column22_row80 * (column14_row193 - 8 * column14_row196).
              let val := mulmod(
                /*column22_row80*/ mload(0x1c40),
                addmod(
                  /*column14_row193*/ mload(0x1020),
                  sub(PRIME, mulmod(8, /*column14_row196*/ mload(0x1040), PRIME)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[9].
              val := mulmod(val, /*denominator_invs[9]*/ mload(0x2940), PRIME)

              // res += val * alpha ** 104.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash3/ec_subset_sum/bit_unpacking/cumulative_bit196: column22_row80 - (column14_row251 - (column14_row252 + column14_row252)) * (column14_row196 - (column14_row197 + column14_row197)).
              let val := addmod(
                /*column22_row80*/ mload(0x1c40),
                sub(
                  PRIME,
                  mulmod(
                    addmod(
                      /*column14_row251*/ mload(0x1080),
                      sub(
                        PRIME,
                        addmod(/*column14_row252*/ mload(0x10a0), /*column14_row252*/ mload(0x10a0), PRIME)),
                      PRIME),
                    addmod(
                      /*column14_row196*/ mload(0x1040),
                      sub(
                        PRIME,
                        addmod(/*column14_row197*/ mload(0x1060), /*column14_row197*/ mload(0x1060), PRIME)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[9].
              val := mulmod(val, /*denominator_invs[9]*/ mload(0x2940), PRIME)

              // res += val * alpha ** 105.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash3/ec_subset_sum/bit_unpacking/zeroes_between_ones196: (column14_row251 - (column14_row252 + column14_row252)) * (column14_row197 - 18014398509481984 * column14_row251).
              let val := mulmod(
                addmod(
                  /*column14_row251*/ mload(0x1080),
                  sub(
                    PRIME,
                    addmod(/*column14_row252*/ mload(0x10a0), /*column14_row252*/ mload(0x10a0), PRIME)),
                  PRIME),
                addmod(
                  /*column14_row197*/ mload(0x1060),
                  sub(PRIME, mulmod(18014398509481984, /*column14_row251*/ mload(0x1080), PRIME)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[9].
              val := mulmod(val, /*denominator_invs[9]*/ mload(0x2940), PRIME)

              // res += val * alpha ** 106.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash3/ec_subset_sum/booleanity_test: pedersen__hash3__ec_subset_sum__bit_0 * (pedersen__hash3__ec_subset_sum__bit_0 - 1).
              let val := mulmod(
                /*intermediate_value/pedersen/hash3/ec_subset_sum/bit_0*/ mload(0x20c0),
                addmod(
                  /*intermediate_value/pedersen/hash3/ec_subset_sum/bit_0*/ mload(0x20c0),
                  sub(PRIME, 1),
                  PRIME),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[8].
              val := mulmod(val, /*domains[8]*/ mload(0x2620), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x2820), PRIME)

              // res += val * alpha ** 107.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash3/ec_subset_sum/bit_extraction_end: column14_row0.
              let val := /*column14_row0*/ mload(0xfc0)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - trace_generator^(63 * trace_length / 64).
              // val *= denominator_invs[11].
              val := mulmod(val, /*denominator_invs[11]*/ mload(0x2980), PRIME)

              // res += val * alpha ** 108.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash3/ec_subset_sum/zeros_tail: column14_row0.
              let val := /*column14_row0*/ mload(0xfc0)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= denominator_invs[10].
              val := mulmod(val, /*denominator_invs[10]*/ mload(0x2960), PRIME)

              // res += val * alpha ** 109.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash3/ec_subset_sum/add_points/slope: pedersen__hash3__ec_subset_sum__bit_0 * (column13_row0 - pedersen__points__y) - column18_row0 * (column12_row0 - pedersen__points__x).
              let val := addmod(
                mulmod(
                  /*intermediate_value/pedersen/hash3/ec_subset_sum/bit_0*/ mload(0x20c0),
                  addmod(
                    /*column13_row0*/ mload(0xf40),
                    sub(PRIME, /*periodic_column/pedersen/points/y*/ mload(0x20)),
                    PRIME),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*column18_row0*/ mload(0x11a0),
                    addmod(
                      /*column12_row0*/ mload(0xea0),
                      sub(PRIME, /*periodic_column/pedersen/points/x*/ mload(0x0)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[8].
              val := mulmod(val, /*domains[8]*/ mload(0x2620), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x2820), PRIME)

              // res += val * alpha ** 110.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash3/ec_subset_sum/add_points/x: column18_row0 * column18_row0 - pedersen__hash3__ec_subset_sum__bit_0 * (column12_row0 + pedersen__points__x + column12_row1).
              let val := addmod(
                mulmod(/*column18_row0*/ mload(0x11a0), /*column18_row0*/ mload(0x11a0), PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*intermediate_value/pedersen/hash3/ec_subset_sum/bit_0*/ mload(0x20c0),
                    addmod(
                      addmod(
                        /*column12_row0*/ mload(0xea0),
                        /*periodic_column/pedersen/points/x*/ mload(0x0),
                        PRIME),
                      /*column12_row1*/ mload(0xec0),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[8].
              val := mulmod(val, /*domains[8]*/ mload(0x2620), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x2820), PRIME)

              // res += val * alpha ** 111.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash3/ec_subset_sum/add_points/y: pedersen__hash3__ec_subset_sum__bit_0 * (column13_row0 + column13_row1) - column18_row0 * (column12_row0 - column12_row1).
              let val := addmod(
                mulmod(
                  /*intermediate_value/pedersen/hash3/ec_subset_sum/bit_0*/ mload(0x20c0),
                  addmod(/*column13_row0*/ mload(0xf40), /*column13_row1*/ mload(0xf60), PRIME),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*column18_row0*/ mload(0x11a0),
                    addmod(/*column12_row0*/ mload(0xea0), sub(PRIME, /*column12_row1*/ mload(0xec0)), PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[8].
              val := mulmod(val, /*domains[8]*/ mload(0x2620), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x2820), PRIME)

              // res += val * alpha ** 112.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash3/ec_subset_sum/copy_point/x: pedersen__hash3__ec_subset_sum__bit_neg_0 * (column12_row1 - column12_row0).
              let val := mulmod(
                /*intermediate_value/pedersen/hash3/ec_subset_sum/bit_neg_0*/ mload(0x20e0),
                addmod(/*column12_row1*/ mload(0xec0), sub(PRIME, /*column12_row0*/ mload(0xea0)), PRIME),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[8].
              val := mulmod(val, /*domains[8]*/ mload(0x2620), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x2820), PRIME)

              // res += val * alpha ** 113.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash3/ec_subset_sum/copy_point/y: pedersen__hash3__ec_subset_sum__bit_neg_0 * (column13_row1 - column13_row0).
              let val := mulmod(
                /*intermediate_value/pedersen/hash3/ec_subset_sum/bit_neg_0*/ mload(0x20e0),
                addmod(/*column13_row1*/ mload(0xf60), sub(PRIME, /*column13_row0*/ mload(0xf40)), PRIME),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[8].
              val := mulmod(val, /*domains[8]*/ mload(0x2620), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x2820), PRIME)

              // res += val * alpha ** 114.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash3/copy_point/x: column12_row256 - column12_row255.
              let val := addmod(
                /*column12_row256*/ mload(0xf00),
                sub(PRIME, /*column12_row255*/ mload(0xee0)),
                PRIME)

              // Numerator: point^(trace_length / 512) - trace_generator^(trace_length / 2).
              // val *= domains[10].
              val := mulmod(val, /*domains[10]*/ mload(0x2660), PRIME)
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[9].
              val := mulmod(val, /*denominator_invs[9]*/ mload(0x2940), PRIME)

              // res += val * alpha ** 115.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash3/copy_point/y: column13_row256 - column13_row255.
              let val := addmod(
                /*column13_row256*/ mload(0xfa0),
                sub(PRIME, /*column13_row255*/ mload(0xf80)),
                PRIME)

              // Numerator: point^(trace_length / 512) - trace_generator^(trace_length / 2).
              // val *= domains[10].
              val := mulmod(val, /*domains[10]*/ mload(0x2660), PRIME)
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[9].
              val := mulmod(val, /*denominator_invs[9]*/ mload(0x2940), PRIME)

              // res += val * alpha ** 116.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash3/init/x: column12_row0 - pedersen/shift_point.x.
              let val := addmod(
                /*column12_row0*/ mload(0xea0),
                sub(PRIME, /*pedersen/shift_point.x*/ mload(0x240)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[12].
              val := mulmod(val, /*denominator_invs[12]*/ mload(0x29a0), PRIME)

              // res += val * alpha ** 117.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash3/init/y: column13_row0 - pedersen/shift_point.y.
              let val := addmod(
                /*column13_row0*/ mload(0xf40),
                sub(PRIME, /*pedersen/shift_point.y*/ mload(0x260)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[12].
              val := mulmod(val, /*denominator_invs[12]*/ mload(0x29a0), PRIME)

              // res += val * alpha ** 118.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/input0_value0: column19_row7 - column5_row0.
              let val := addmod(/*column19_row7*/ mload(0x12c0), sub(PRIME, /*column5_row0*/ mload(0x900)), PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[12].
              val := mulmod(val, /*denominator_invs[12]*/ mload(0x29a0), PRIME)

              // res += val * alpha ** 119.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/input0_value1: column19_row135 - column8_row0.
              let val := addmod(/*column19_row135*/ mload(0x14a0), sub(PRIME, /*column8_row0*/ mload(0xb40)), PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[12].
              val := mulmod(val, /*denominator_invs[12]*/ mload(0x29a0), PRIME)

              // res += val * alpha ** 120.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/input0_value2: column19_row263 - column11_row0.
              let val := addmod(
                /*column19_row263*/ mload(0x1520),
                sub(PRIME, /*column11_row0*/ mload(0xd80)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[12].
              val := mulmod(val, /*denominator_invs[12]*/ mload(0x29a0), PRIME)

              // res += val * alpha ** 121.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/input0_value3: column19_row391 - column14_row0.
              let val := addmod(
                /*column19_row391*/ mload(0x1580),
                sub(PRIME, /*column14_row0*/ mload(0xfc0)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[12].
              val := mulmod(val, /*denominator_invs[12]*/ mload(0x29a0), PRIME)

              // res += val * alpha ** 122.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/input0_addr: column19_row134 - (column19_row38 + 1).
              let val := addmod(
                /*column19_row134*/ mload(0x1480),
                sub(PRIME, addmod(/*column19_row38*/ mload(0x13c0), 1, PRIME)),
                PRIME)

              // Numerator: point - trace_generator^(128 * (trace_length / 128 - 1)).
              // val *= domains[22].
              val := mulmod(val, /*domains[22]*/ mload(0x27e0), PRIME)
              // Denominator: point^(trace_length / 128) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, /*denominator_invs[13]*/ mload(0x29c0), PRIME)

              // res += val * alpha ** 123.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/init_addr: column19_row6 - initial_pedersen_addr.
              let val := addmod(
                /*column19_row6*/ mload(0x12a0),
                sub(PRIME, /*initial_pedersen_addr*/ mload(0x280)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point - 1.
              // val *= denominator_invs[4].
              val := mulmod(val, /*denominator_invs[4]*/ mload(0x28a0), PRIME)

              // res += val * alpha ** 124.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/input1_value0: column19_row71 - column5_row256.
              let val := addmod(
                /*column19_row71*/ mload(0x1420),
                sub(PRIME, /*column5_row256*/ mload(0xa00)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[12].
              val := mulmod(val, /*denominator_invs[12]*/ mload(0x29a0), PRIME)

              // res += val * alpha ** 125.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/input1_value1: column19_row199 - column8_row256.
              let val := addmod(
                /*column19_row199*/ mload(0x14e0),
                sub(PRIME, /*column8_row256*/ mload(0xc40)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[12].
              val := mulmod(val, /*denominator_invs[12]*/ mload(0x29a0), PRIME)

              // res += val * alpha ** 126.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/input1_value2: column19_row327 - column11_row256.
              let val := addmod(
                /*column19_row327*/ mload(0x1560),
                sub(PRIME, /*column11_row256*/ mload(0xe80)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[12].
              val := mulmod(val, /*denominator_invs[12]*/ mload(0x29a0), PRIME)

              // res += val * alpha ** 127.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/input1_value3: column19_row455 - column14_row256.
              let val := addmod(
                /*column19_row455*/ mload(0x15c0),
                sub(PRIME, /*column14_row256*/ mload(0x10c0)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[12].
              val := mulmod(val, /*denominator_invs[12]*/ mload(0x29a0), PRIME)

              // res += val * alpha ** 128.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/input1_addr: column19_row70 - (column19_row6 + 1).
              let val := addmod(
                /*column19_row70*/ mload(0x1400),
                sub(PRIME, addmod(/*column19_row6*/ mload(0x12a0), 1, PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 128) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, /*denominator_invs[13]*/ mload(0x29c0), PRIME)

              // res += val * alpha ** 129.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/output_value0: column19_row39 - column3_row511.
              let val := addmod(
                /*column19_row39*/ mload(0x13e0),
                sub(PRIME, /*column3_row511*/ mload(0x860)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[12].
              val := mulmod(val, /*denominator_invs[12]*/ mload(0x29a0), PRIME)

              // res += val * alpha ** 130.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/output_value1: column19_row167 - column6_row511.
              let val := addmod(
                /*column19_row167*/ mload(0x14c0),
                sub(PRIME, /*column6_row511*/ mload(0xaa0)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[12].
              val := mulmod(val, /*denominator_invs[12]*/ mload(0x29a0), PRIME)

              // res += val * alpha ** 131.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/output_value2: column19_row295 - column9_row511.
              let val := addmod(
                /*column19_row295*/ mload(0x1540),
                sub(PRIME, /*column9_row511*/ mload(0xce0)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[12].
              val := mulmod(val, /*denominator_invs[12]*/ mload(0x29a0), PRIME)

              // res += val * alpha ** 132.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/output_value3: column19_row423 - column12_row511.
              let val := addmod(
                /*column19_row423*/ mload(0x15a0),
                sub(PRIME, /*column12_row511*/ mload(0xf20)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[12].
              val := mulmod(val, /*denominator_invs[12]*/ mload(0x29a0), PRIME)

              // res += val * alpha ** 133.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/output_addr: column19_row38 - (column19_row70 + 1).
              let val := addmod(
                /*column19_row38*/ mload(0x13c0),
                sub(PRIME, addmod(/*column19_row70*/ mload(0x1400), 1, PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 128) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, /*denominator_invs[13]*/ mload(0x29c0), PRIME)

              // res += val * alpha ** 134.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for rc_builtin/value: rc_builtin__value7_0 - column19_row103.
              let val := addmod(
                /*intermediate_value/rc_builtin/value7_0*/ mload(0x21e0),
                sub(PRIME, /*column19_row103*/ mload(0x1460)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 128) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, /*denominator_invs[13]*/ mload(0x29c0), PRIME)

              // res += val * alpha ** 135.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for rc_builtin/addr_step: column19_row230 - (column19_row102 + 1).
              let val := addmod(
                /*column19_row230*/ mload(0x1500),
                sub(PRIME, addmod(/*column19_row102*/ mload(0x1440), 1, PRIME)),
                PRIME)

              // Numerator: point - trace_generator^(128 * (trace_length / 128 - 1)).
              // val *= domains[22].
              val := mulmod(val, /*domains[22]*/ mload(0x27e0), PRIME)
              // Denominator: point^(trace_length / 128) - 1.
              // val *= denominator_invs[13].
              val := mulmod(val, /*denominator_invs[13]*/ mload(0x29c0), PRIME)

              // res += val * alpha ** 136.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for rc_builtin/init_addr: column19_row102 - initial_rc_addr.
              let val := addmod(
                /*column19_row102*/ mload(0x1440),
                sub(PRIME, /*initial_rc_addr*/ mload(0x2a0)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point - 1.
              // val *= denominator_invs[4].
              val := mulmod(val, /*denominator_invs[4]*/ mload(0x28a0), PRIME)

              // res += val * alpha ** 137.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/doubling_key/slope: ecdsa__signature0__doubling_key__x_squared + ecdsa__signature0__doubling_key__x_squared + ecdsa__signature0__doubling_key__x_squared + ecdsa/sig_config.alpha - (column21_row14 + column21_row14) * column21_row13.
              let val := addmod(
                addmod(
                  addmod(
                    addmod(
                      /*intermediate_value/ecdsa/signature0/doubling_key/x_squared*/ mload(0x2200),
                      /*intermediate_value/ecdsa/signature0/doubling_key/x_squared*/ mload(0x2200),
                      PRIME),
                    /*intermediate_value/ecdsa/signature0/doubling_key/x_squared*/ mload(0x2200),
                    PRIME),
                  /*ecdsa/sig_config.alpha*/ mload(0x2c0),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    addmod(/*column21_row14*/ mload(0x1880), /*column21_row14*/ mload(0x1880), PRIME),
                    /*column21_row13*/ mload(0x1860),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 4096) - trace_generator^(255 * trace_length / 256).
              // val *= domains[12].
              val := mulmod(val, /*domains[12]*/ mload(0x26a0), PRIME)
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x2860), PRIME)

              // res += val * alpha ** 138.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/doubling_key/x: column21_row13 * column21_row13 - (column21_row6 + column21_row6 + column21_row22).
              let val := addmod(
                mulmod(/*column21_row13*/ mload(0x1860), /*column21_row13*/ mload(0x1860), PRIME),
                sub(
                  PRIME,
                  addmod(
                    addmod(/*column21_row6*/ mload(0x1780), /*column21_row6*/ mload(0x1780), PRIME),
                    /*column21_row22*/ mload(0x1920),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 4096) - trace_generator^(255 * trace_length / 256).
              // val *= domains[12].
              val := mulmod(val, /*domains[12]*/ mload(0x26a0), PRIME)
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x2860), PRIME)

              // res += val * alpha ** 139.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/doubling_key/y: column21_row14 + column21_row30 - column21_row13 * (column21_row6 - column21_row22).
              let val := addmod(
                addmod(/*column21_row14*/ mload(0x1880), /*column21_row30*/ mload(0x19a0), PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*column21_row13*/ mload(0x1860),
                    addmod(
                      /*column21_row6*/ mload(0x1780),
                      sub(PRIME, /*column21_row22*/ mload(0x1920)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 4096) - trace_generator^(255 * trace_length / 256).
              // val *= domains[12].
              val := mulmod(val, /*domains[12]*/ mload(0x26a0), PRIME)
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x2860), PRIME)

              // res += val * alpha ** 140.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/exponentiate_generator/booleanity_test: ecdsa__signature0__exponentiate_generator__bit_0 * (ecdsa__signature0__exponentiate_generator__bit_0 - 1).
              let val := mulmod(
                /*intermediate_value/ecdsa/signature0/exponentiate_generator/bit_0*/ mload(0x2220),
                addmod(
                  /*intermediate_value/ecdsa/signature0/exponentiate_generator/bit_0*/ mload(0x2220),
                  sub(PRIME, 1),
                  PRIME),
                PRIME)

              // Numerator: point^(trace_length / 8192) - trace_generator^(255 * trace_length / 256).
              // val *= domains[15].
              val := mulmod(val, /*domains[15]*/ mload(0x2700), PRIME)
              // Denominator: point^(trace_length / 32) - 1.
              // val *= denominator_invs[15].
              val := mulmod(val, /*denominator_invs[15]*/ mload(0x2a00), PRIME)

              // res += val * alpha ** 141.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/exponentiate_generator/bit_extraction_end: column21_row15.
              let val := /*column21_row15*/ mload(0x18a0)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 8192) - trace_generator^(251 * trace_length / 256).
              // val *= denominator_invs[17].
              val := mulmod(val, /*denominator_invs[17]*/ mload(0x2a40), PRIME)

              // res += val * alpha ** 142.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/exponentiate_generator/zeros_tail: column21_row15.
              let val := /*column21_row15*/ mload(0x18a0)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 8192) - trace_generator^(255 * trace_length / 256).
              // val *= denominator_invs[16].
              val := mulmod(val, /*denominator_invs[16]*/ mload(0x2a20), PRIME)

              // res += val * alpha ** 143.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/exponentiate_generator/add_points/slope: ecdsa__signature0__exponentiate_generator__bit_0 * (column21_row23 - ecdsa__generator_points__y) - column21_row31 * (column21_row7 - ecdsa__generator_points__x).
              let val := addmod(
                mulmod(
                  /*intermediate_value/ecdsa/signature0/exponentiate_generator/bit_0*/ mload(0x2220),
                  addmod(
                    /*column21_row23*/ mload(0x1940),
                    sub(PRIME, /*periodic_column/ecdsa/generator_points/y*/ mload(0x60)),
                    PRIME),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*column21_row31*/ mload(0x19c0),
                    addmod(
                      /*column21_row7*/ mload(0x17a0),
                      sub(PRIME, /*periodic_column/ecdsa/generator_points/x*/ mload(0x40)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 8192) - trace_generator^(255 * trace_length / 256).
              // val *= domains[15].
              val := mulmod(val, /*domains[15]*/ mload(0x2700), PRIME)
              // Denominator: point^(trace_length / 32) - 1.
              // val *= denominator_invs[15].
              val := mulmod(val, /*denominator_invs[15]*/ mload(0x2a00), PRIME)

              // res += val * alpha ** 144.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/exponentiate_generator/add_points/x: column21_row31 * column21_row31 - ecdsa__signature0__exponentiate_generator__bit_0 * (column21_row7 + ecdsa__generator_points__x + column21_row39).
              let val := addmod(
                mulmod(/*column21_row31*/ mload(0x19c0), /*column21_row31*/ mload(0x19c0), PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*intermediate_value/ecdsa/signature0/exponentiate_generator/bit_0*/ mload(0x2220),
                    addmod(
                      addmod(
                        /*column21_row7*/ mload(0x17a0),
                        /*periodic_column/ecdsa/generator_points/x*/ mload(0x40),
                        PRIME),
                      /*column21_row39*/ mload(0x19e0),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 8192) - trace_generator^(255 * trace_length / 256).
              // val *= domains[15].
              val := mulmod(val, /*domains[15]*/ mload(0x2700), PRIME)
              // Denominator: point^(trace_length / 32) - 1.
              // val *= denominator_invs[15].
              val := mulmod(val, /*denominator_invs[15]*/ mload(0x2a00), PRIME)

              // res += val * alpha ** 145.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/exponentiate_generator/add_points/y: ecdsa__signature0__exponentiate_generator__bit_0 * (column21_row23 + column21_row55) - column21_row31 * (column21_row7 - column21_row39).
              let val := addmod(
                mulmod(
                  /*intermediate_value/ecdsa/signature0/exponentiate_generator/bit_0*/ mload(0x2220),
                  addmod(/*column21_row23*/ mload(0x1940), /*column21_row55*/ mload(0x1a20), PRIME),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*column21_row31*/ mload(0x19c0),
                    addmod(
                      /*column21_row7*/ mload(0x17a0),
                      sub(PRIME, /*column21_row39*/ mload(0x19e0)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 8192) - trace_generator^(255 * trace_length / 256).
              // val *= domains[15].
              val := mulmod(val, /*domains[15]*/ mload(0x2700), PRIME)
              // Denominator: point^(trace_length / 32) - 1.
              // val *= denominator_invs[15].
              val := mulmod(val, /*denominator_invs[15]*/ mload(0x2a00), PRIME)

              // res += val * alpha ** 146.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/exponentiate_generator/add_points/x_diff_inv: column22_row0 * (column21_row7 - ecdsa__generator_points__x) - 1.
              let val := addmod(
                mulmod(
                  /*column22_row0*/ mload(0x1c00),
                  addmod(
                    /*column21_row7*/ mload(0x17a0),
                    sub(PRIME, /*periodic_column/ecdsa/generator_points/x*/ mload(0x40)),
                    PRIME),
                  PRIME),
                sub(PRIME, 1),
                PRIME)

              // Numerator: point^(trace_length / 8192) - trace_generator^(255 * trace_length / 256).
              // val *= domains[15].
              val := mulmod(val, /*domains[15]*/ mload(0x2700), PRIME)
              // Denominator: point^(trace_length / 32) - 1.
              // val *= denominator_invs[15].
              val := mulmod(val, /*denominator_invs[15]*/ mload(0x2a00), PRIME)

              // res += val * alpha ** 147.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/exponentiate_generator/copy_point/x: ecdsa__signature0__exponentiate_generator__bit_neg_0 * (column21_row39 - column21_row7).
              let val := mulmod(
                /*intermediate_value/ecdsa/signature0/exponentiate_generator/bit_neg_0*/ mload(0x2240),
                addmod(
                  /*column21_row39*/ mload(0x19e0),
                  sub(PRIME, /*column21_row7*/ mload(0x17a0)),
                  PRIME),
                PRIME)

              // Numerator: point^(trace_length / 8192) - trace_generator^(255 * trace_length / 256).
              // val *= domains[15].
              val := mulmod(val, /*domains[15]*/ mload(0x2700), PRIME)
              // Denominator: point^(trace_length / 32) - 1.
              // val *= denominator_invs[15].
              val := mulmod(val, /*denominator_invs[15]*/ mload(0x2a00), PRIME)

              // res += val * alpha ** 148.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/exponentiate_generator/copy_point/y: ecdsa__signature0__exponentiate_generator__bit_neg_0 * (column21_row55 - column21_row23).
              let val := mulmod(
                /*intermediate_value/ecdsa/signature0/exponentiate_generator/bit_neg_0*/ mload(0x2240),
                addmod(
                  /*column21_row55*/ mload(0x1a20),
                  sub(PRIME, /*column21_row23*/ mload(0x1940)),
                  PRIME),
                PRIME)

              // Numerator: point^(trace_length / 8192) - trace_generator^(255 * trace_length / 256).
              // val *= domains[15].
              val := mulmod(val, /*domains[15]*/ mload(0x2700), PRIME)
              // Denominator: point^(trace_length / 32) - 1.
              // val *= denominator_invs[15].
              val := mulmod(val, /*denominator_invs[15]*/ mload(0x2a00), PRIME)

              // res += val * alpha ** 149.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/exponentiate_key/booleanity_test: ecdsa__signature0__exponentiate_key__bit_0 * (ecdsa__signature0__exponentiate_key__bit_0 - 1).
              let val := mulmod(
                /*intermediate_value/ecdsa/signature0/exponentiate_key/bit_0*/ mload(0x2260),
                addmod(
                  /*intermediate_value/ecdsa/signature0/exponentiate_key/bit_0*/ mload(0x2260),
                  sub(PRIME, 1),
                  PRIME),
                PRIME)

              // Numerator: point^(trace_length / 4096) - trace_generator^(255 * trace_length / 256).
              // val *= domains[12].
              val := mulmod(val, /*domains[12]*/ mload(0x26a0), PRIME)
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x2860), PRIME)

              // res += val * alpha ** 150.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/exponentiate_key/bit_extraction_end: column21_row5.
              let val := /*column21_row5*/ mload(0x1760)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 4096) - trace_generator^(251 * trace_length / 256).
              // val *= denominator_invs[18].
              val := mulmod(val, /*denominator_invs[18]*/ mload(0x2a60), PRIME)

              // res += val * alpha ** 151.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/exponentiate_key/zeros_tail: column21_row5.
              let val := /*column21_row5*/ mload(0x1760)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 4096) - trace_generator^(255 * trace_length / 256).
              // val *= denominator_invs[14].
              val := mulmod(val, /*denominator_invs[14]*/ mload(0x29e0), PRIME)

              // res += val * alpha ** 152.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/exponentiate_key/add_points/slope: ecdsa__signature0__exponentiate_key__bit_0 * (column21_row9 - column21_row14) - column21_row3 * (column21_row1 - column21_row6).
              let val := addmod(
                mulmod(
                  /*intermediate_value/ecdsa/signature0/exponentiate_key/bit_0*/ mload(0x2260),
                  addmod(
                    /*column21_row9*/ mload(0x17e0),
                    sub(PRIME, /*column21_row14*/ mload(0x1880)),
                    PRIME),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*column21_row3*/ mload(0x1720),
                    addmod(/*column21_row1*/ mload(0x16e0), sub(PRIME, /*column21_row6*/ mload(0x1780)), PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 4096) - trace_generator^(255 * trace_length / 256).
              // val *= domains[12].
              val := mulmod(val, /*domains[12]*/ mload(0x26a0), PRIME)
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x2860), PRIME)

              // res += val * alpha ** 153.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/exponentiate_key/add_points/x: column21_row3 * column21_row3 - ecdsa__signature0__exponentiate_key__bit_0 * (column21_row1 + column21_row6 + column21_row17).
              let val := addmod(
                mulmod(/*column21_row3*/ mload(0x1720), /*column21_row3*/ mload(0x1720), PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*intermediate_value/ecdsa/signature0/exponentiate_key/bit_0*/ mload(0x2260),
                    addmod(
                      addmod(/*column21_row1*/ mload(0x16e0), /*column21_row6*/ mload(0x1780), PRIME),
                      /*column21_row17*/ mload(0x18e0),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 4096) - trace_generator^(255 * trace_length / 256).
              // val *= domains[12].
              val := mulmod(val, /*domains[12]*/ mload(0x26a0), PRIME)
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x2860), PRIME)

              // res += val * alpha ** 154.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/exponentiate_key/add_points/y: ecdsa__signature0__exponentiate_key__bit_0 * (column21_row9 + column21_row25) - column21_row3 * (column21_row1 - column21_row17).
              let val := addmod(
                mulmod(
                  /*intermediate_value/ecdsa/signature0/exponentiate_key/bit_0*/ mload(0x2260),
                  addmod(/*column21_row9*/ mload(0x17e0), /*column21_row25*/ mload(0x1980), PRIME),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*column21_row3*/ mload(0x1720),
                    addmod(
                      /*column21_row1*/ mload(0x16e0),
                      sub(PRIME, /*column21_row17*/ mload(0x18e0)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 4096) - trace_generator^(255 * trace_length / 256).
              // val *= domains[12].
              val := mulmod(val, /*domains[12]*/ mload(0x26a0), PRIME)
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x2860), PRIME)

              // res += val * alpha ** 155.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/exponentiate_key/add_points/x_diff_inv: column21_row11 * (column21_row1 - column21_row6) - 1.
              let val := addmod(
                mulmod(
                  /*column21_row11*/ mload(0x1820),
                  addmod(/*column21_row1*/ mload(0x16e0), sub(PRIME, /*column21_row6*/ mload(0x1780)), PRIME),
                  PRIME),
                sub(PRIME, 1),
                PRIME)

              // Numerator: point^(trace_length / 4096) - trace_generator^(255 * trace_length / 256).
              // val *= domains[12].
              val := mulmod(val, /*domains[12]*/ mload(0x26a0), PRIME)
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x2860), PRIME)

              // res += val * alpha ** 156.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/exponentiate_key/copy_point/x: ecdsa__signature0__exponentiate_key__bit_neg_0 * (column21_row17 - column21_row1).
              let val := mulmod(
                /*intermediate_value/ecdsa/signature0/exponentiate_key/bit_neg_0*/ mload(0x2280),
                addmod(
                  /*column21_row17*/ mload(0x18e0),
                  sub(PRIME, /*column21_row1*/ mload(0x16e0)),
                  PRIME),
                PRIME)

              // Numerator: point^(trace_length / 4096) - trace_generator^(255 * trace_length / 256).
              // val *= domains[12].
              val := mulmod(val, /*domains[12]*/ mload(0x26a0), PRIME)
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x2860), PRIME)

              // res += val * alpha ** 157.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/exponentiate_key/copy_point/y: ecdsa__signature0__exponentiate_key__bit_neg_0 * (column21_row25 - column21_row9).
              let val := mulmod(
                /*intermediate_value/ecdsa/signature0/exponentiate_key/bit_neg_0*/ mload(0x2280),
                addmod(
                  /*column21_row25*/ mload(0x1980),
                  sub(PRIME, /*column21_row9*/ mload(0x17e0)),
                  PRIME),
                PRIME)

              // Numerator: point^(trace_length / 4096) - trace_generator^(255 * trace_length / 256).
              // val *= domains[12].
              val := mulmod(val, /*domains[12]*/ mload(0x26a0), PRIME)
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x2860), PRIME)

              // res += val * alpha ** 158.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/init_gen/x: column21_row7 - ecdsa/sig_config.shift_point.x.
              let val := addmod(
                /*column21_row7*/ mload(0x17a0),
                sub(PRIME, /*ecdsa/sig_config.shift_point.x*/ mload(0x2e0)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 8192) - 1.
              // val *= denominator_invs[19].
              val := mulmod(val, /*denominator_invs[19]*/ mload(0x2a80), PRIME)

              // res += val * alpha ** 159.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/init_gen/y: column21_row23 + ecdsa/sig_config.shift_point.y.
              let val := addmod(
                /*column21_row23*/ mload(0x1940),
                /*ecdsa/sig_config.shift_point.y*/ mload(0x300),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 8192) - 1.
              // val *= denominator_invs[19].
              val := mulmod(val, /*denominator_invs[19]*/ mload(0x2a80), PRIME)

              // res += val * alpha ** 160.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/init_key/x: column21_row1 - ecdsa/sig_config.shift_point.x.
              let val := addmod(
                /*column21_row1*/ mload(0x16e0),
                sub(PRIME, /*ecdsa/sig_config.shift_point.x*/ mload(0x2e0)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 4096) - 1.
              // val *= denominator_invs[20].
              val := mulmod(val, /*denominator_invs[20]*/ mload(0x2aa0), PRIME)

              // res += val * alpha ** 161.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/init_key/y: column21_row9 - ecdsa/sig_config.shift_point.y.
              let val := addmod(
                /*column21_row9*/ mload(0x17e0),
                sub(PRIME, /*ecdsa/sig_config.shift_point.y*/ mload(0x300)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 4096) - 1.
              // val *= denominator_invs[20].
              val := mulmod(val, /*denominator_invs[20]*/ mload(0x2aa0), PRIME)

              // res += val * alpha ** 162.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/add_results/slope: column21_row8183 - (column21_row4089 + column21_row8191 * (column21_row8167 - column21_row4081)).
              let val := addmod(
                /*column21_row8183*/ mload(0x1b80),
                sub(
                  PRIME,
                  addmod(
                    /*column21_row4089*/ mload(0x1a80),
                    mulmod(
                      /*column21_row8191*/ mload(0x1be0),
                      addmod(
                        /*column21_row8167*/ mload(0x1b20),
                        sub(PRIME, /*column21_row4081*/ mload(0x1a40)),
                        PRIME),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 8192) - 1.
              // val *= denominator_invs[19].
              val := mulmod(val, /*denominator_invs[19]*/ mload(0x2a80), PRIME)

              // res += val * alpha ** 163.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/add_results/x: column21_row8191 * column21_row8191 - (column21_row8167 + column21_row4081 + column21_row4102).
              let val := addmod(
                mulmod(/*column21_row8191*/ mload(0x1be0), /*column21_row8191*/ mload(0x1be0), PRIME),
                sub(
                  PRIME,
                  addmod(
                    addmod(/*column21_row8167*/ mload(0x1b20), /*column21_row4081*/ mload(0x1a40), PRIME),
                    /*column21_row4102*/ mload(0x1ae0),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 8192) - 1.
              // val *= denominator_invs[19].
              val := mulmod(val, /*denominator_invs[19]*/ mload(0x2a80), PRIME)

              // res += val * alpha ** 164.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/add_results/y: column21_row8183 + column21_row4110 - column21_row8191 * (column21_row8167 - column21_row4102).
              let val := addmod(
                addmod(/*column21_row8183*/ mload(0x1b80), /*column21_row4110*/ mload(0x1b00), PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*column21_row8191*/ mload(0x1be0),
                    addmod(
                      /*column21_row8167*/ mload(0x1b20),
                      sub(PRIME, /*column21_row4102*/ mload(0x1ae0)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 8192) - 1.
              // val *= denominator_invs[19].
              val := mulmod(val, /*denominator_invs[19]*/ mload(0x2a80), PRIME)

              // res += val * alpha ** 165.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/add_results/x_diff_inv: column22_row8160 * (column21_row8167 - column21_row4081) - 1.
              let val := addmod(
                mulmod(
                  /*column22_row8160*/ mload(0x1ca0),
                  addmod(
                    /*column21_row8167*/ mload(0x1b20),
                    sub(PRIME, /*column21_row4081*/ mload(0x1a40)),
                    PRIME),
                  PRIME),
                sub(PRIME, 1),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 8192) - 1.
              // val *= denominator_invs[19].
              val := mulmod(val, /*denominator_invs[19]*/ mload(0x2a80), PRIME)

              // res += val * alpha ** 166.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/extract_r/slope: column21_row8185 + ecdsa/sig_config.shift_point.y - column21_row4083 * (column21_row8177 - ecdsa/sig_config.shift_point.x).
              let val := addmod(
                addmod(
                  /*column21_row8185*/ mload(0x1ba0),
                  /*ecdsa/sig_config.shift_point.y*/ mload(0x300),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*column21_row4083*/ mload(0x1a60),
                    addmod(
                      /*column21_row8177*/ mload(0x1b40),
                      sub(PRIME, /*ecdsa/sig_config.shift_point.x*/ mload(0x2e0)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 8192) - 1.
              // val *= denominator_invs[19].
              val := mulmod(val, /*denominator_invs[19]*/ mload(0x2a80), PRIME)

              // res += val * alpha ** 167.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/extract_r/x: column21_row4083 * column21_row4083 - (column21_row8177 + ecdsa/sig_config.shift_point.x + column21_row5).
              let val := addmod(
                mulmod(/*column21_row4083*/ mload(0x1a60), /*column21_row4083*/ mload(0x1a60), PRIME),
                sub(
                  PRIME,
                  addmod(
                    addmod(
                      /*column21_row8177*/ mload(0x1b40),
                      /*ecdsa/sig_config.shift_point.x*/ mload(0x2e0),
                      PRIME),
                    /*column21_row5*/ mload(0x1760),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 8192) - 1.
              // val *= denominator_invs[19].
              val := mulmod(val, /*denominator_invs[19]*/ mload(0x2a80), PRIME)

              // res += val * alpha ** 168.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/extract_r/x_diff_inv: column21_row8179 * (column21_row8177 - ecdsa/sig_config.shift_point.x) - 1.
              let val := addmod(
                mulmod(
                  /*column21_row8179*/ mload(0x1b60),
                  addmod(
                    /*column21_row8177*/ mload(0x1b40),
                    sub(PRIME, /*ecdsa/sig_config.shift_point.x*/ mload(0x2e0)),
                    PRIME),
                  PRIME),
                sub(PRIME, 1),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 8192) - 1.
              // val *= denominator_invs[19].
              val := mulmod(val, /*denominator_invs[19]*/ mload(0x2a80), PRIME)

              // res += val * alpha ** 169.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/z_nonzero: column21_row15 * column21_row4091 - 1.
              let val := addmod(
                mulmod(/*column21_row15*/ mload(0x18a0), /*column21_row4091*/ mload(0x1aa0), PRIME),
                sub(PRIME, 1),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 8192) - 1.
              // val *= denominator_invs[19].
              val := mulmod(val, /*denominator_invs[19]*/ mload(0x2a80), PRIME)

              // res += val * alpha ** 170.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/r_and_w_nonzero: column21_row5 * column21_row4093 - 1.
              let val := addmod(
                mulmod(/*column21_row5*/ mload(0x1760), /*column21_row4093*/ mload(0x1ac0), PRIME),
                sub(PRIME, 1),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 4096) - 1.
              // val *= denominator_invs[20].
              val := mulmod(val, /*denominator_invs[20]*/ mload(0x2aa0), PRIME)

              // res += val * alpha ** 171.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/q_on_curve/x_squared: column21_row8187 - column21_row6 * column21_row6.
              let val := addmod(
                /*column21_row8187*/ mload(0x1bc0),
                sub(
                  PRIME,
                  mulmod(/*column21_row6*/ mload(0x1780), /*column21_row6*/ mload(0x1780), PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 8192) - 1.
              // val *= denominator_invs[19].
              val := mulmod(val, /*denominator_invs[19]*/ mload(0x2a80), PRIME)

              // res += val * alpha ** 172.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/q_on_curve/on_curve: column21_row14 * column21_row14 - (column21_row6 * column21_row8187 + ecdsa/sig_config.alpha * column21_row6 + ecdsa/sig_config.beta).
              let val := addmod(
                mulmod(/*column21_row14*/ mload(0x1880), /*column21_row14*/ mload(0x1880), PRIME),
                sub(
                  PRIME,
                  addmod(
                    addmod(
                      mulmod(/*column21_row6*/ mload(0x1780), /*column21_row8187*/ mload(0x1bc0), PRIME),
                      mulmod(/*ecdsa/sig_config.alpha*/ mload(0x2c0), /*column21_row6*/ mload(0x1780), PRIME),
                      PRIME),
                    /*ecdsa/sig_config.beta*/ mload(0x320),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 8192) - 1.
              // val *= denominator_invs[19].
              val := mulmod(val, /*denominator_invs[19]*/ mload(0x2a80), PRIME)

              // res += val * alpha ** 173.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/init_addr: column19_row22 - initial_ecdsa_addr.
              let val := addmod(
                /*column19_row22*/ mload(0x1380),
                sub(PRIME, /*initial_ecdsa_addr*/ mload(0x340)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point - 1.
              // val *= denominator_invs[4].
              val := mulmod(val, /*denominator_invs[4]*/ mload(0x28a0), PRIME)

              // res += val * alpha ** 174.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/message_addr: column19_row4118 - (column19_row22 + 1).
              let val := addmod(
                /*column19_row4118*/ mload(0x15e0),
                sub(PRIME, addmod(/*column19_row22*/ mload(0x1380), 1, PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 8192) - 1.
              // val *= denominator_invs[19].
              val := mulmod(val, /*denominator_invs[19]*/ mload(0x2a80), PRIME)

              // res += val * alpha ** 175.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/pubkey_addr: column19_row8214 - (column19_row4118 + 1).
              let val := addmod(
                /*column19_row8214*/ mload(0x1620),
                sub(PRIME, addmod(/*column19_row4118*/ mload(0x15e0), 1, PRIME)),
                PRIME)

              // Numerator: point - trace_generator^(8192 * (trace_length / 8192 - 1)).
              // val *= domains[23].
              val := mulmod(val, /*domains[23]*/ mload(0x2800), PRIME)
              // Denominator: point^(trace_length / 8192) - 1.
              // val *= denominator_invs[19].
              val := mulmod(val, /*denominator_invs[19]*/ mload(0x2a80), PRIME)

              // res += val * alpha ** 176.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/message_value0: column19_row4119 - column21_row15.
              let val := addmod(
                /*column19_row4119*/ mload(0x1600),
                sub(PRIME, /*column21_row15*/ mload(0x18a0)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 8192) - 1.
              // val *= denominator_invs[19].
              val := mulmod(val, /*denominator_invs[19]*/ mload(0x2a80), PRIME)

              // res += val * alpha ** 177.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/pubkey_value0: column19_row23 - column21_row6.
              let val := addmod(
                /*column19_row23*/ mload(0x13a0),
                sub(PRIME, /*column21_row6*/ mload(0x1780)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 8192) - 1.
              // val *= denominator_invs[19].
              val := mulmod(val, /*denominator_invs[19]*/ mload(0x2a80), PRIME)

              // res += val * alpha ** 178.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

            mstore(0, res)
            return(0, 0x20)
            }
        }
    }
}
// ---------- End of auto-generated code. ----------
