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
    // [0x240, 0x260) - diluted_check/permutation/interaction_elm.
    // [0x260, 0x280) - diluted_check/permutation/public_memory_prod.
    // [0x280, 0x2a0) - diluted_check/first_elm.
    // [0x2a0, 0x2c0) - diluted_check/interaction_z.
    // [0x2c0, 0x2e0) - diluted_check/interaction_alpha.
    // [0x2e0, 0x300) - diluted_check/final_cum_val.
    // [0x300, 0x320) - pedersen/shift_point.x.
    // [0x320, 0x340) - pedersen/shift_point.y.
    // [0x340, 0x360) - initial_pedersen_addr.
    // [0x360, 0x380) - initial_rc_addr.
    // [0x380, 0x3a0) - ecdsa/sig_config.alpha.
    // [0x3a0, 0x3c0) - ecdsa/sig_config.shift_point.x.
    // [0x3c0, 0x3e0) - ecdsa/sig_config.shift_point.y.
    // [0x3e0, 0x400) - ecdsa/sig_config.beta.
    // [0x400, 0x420) - initial_ecdsa_addr.
    // [0x420, 0x440) - initial_bitwise_addr.
    // [0x440, 0x460) - trace_generator.
    // [0x460, 0x480) - oods_point.
    // [0x480, 0x540) - interaction_elements.
    // [0x540, 0x560) - composition_alpha.
    // [0x560, 0x2420) - oods_values.
    // ----------------------- end of input data - -------------------------
    // [0x2420, 0x2440) - intermediate_value/cpu/decode/opcode_rc/bit_0.
    // [0x2440, 0x2460) - intermediate_value/cpu/decode/opcode_rc/bit_2.
    // [0x2460, 0x2480) - intermediate_value/cpu/decode/opcode_rc/bit_4.
    // [0x2480, 0x24a0) - intermediate_value/cpu/decode/opcode_rc/bit_3.
    // [0x24a0, 0x24c0) - intermediate_value/cpu/decode/flag_op1_base_op0_0.
    // [0x24c0, 0x24e0) - intermediate_value/cpu/decode/opcode_rc/bit_5.
    // [0x24e0, 0x2500) - intermediate_value/cpu/decode/opcode_rc/bit_6.
    // [0x2500, 0x2520) - intermediate_value/cpu/decode/opcode_rc/bit_9.
    // [0x2520, 0x2540) - intermediate_value/cpu/decode/flag_res_op1_0.
    // [0x2540, 0x2560) - intermediate_value/cpu/decode/opcode_rc/bit_7.
    // [0x2560, 0x2580) - intermediate_value/cpu/decode/opcode_rc/bit_8.
    // [0x2580, 0x25a0) - intermediate_value/cpu/decode/flag_pc_update_regular_0.
    // [0x25a0, 0x25c0) - intermediate_value/cpu/decode/opcode_rc/bit_12.
    // [0x25c0, 0x25e0) - intermediate_value/cpu/decode/opcode_rc/bit_13.
    // [0x25e0, 0x2600) - intermediate_value/cpu/decode/fp_update_regular_0.
    // [0x2600, 0x2620) - intermediate_value/cpu/decode/opcode_rc/bit_1.
    // [0x2620, 0x2640) - intermediate_value/npc_reg_0.
    // [0x2640, 0x2660) - intermediate_value/cpu/decode/opcode_rc/bit_10.
    // [0x2660, 0x2680) - intermediate_value/cpu/decode/opcode_rc/bit_11.
    // [0x2680, 0x26a0) - intermediate_value/cpu/decode/opcode_rc/bit_14.
    // [0x26a0, 0x26c0) - intermediate_value/memory/address_diff_0.
    // [0x26c0, 0x26e0) - intermediate_value/rc16/diff_0.
    // [0x26e0, 0x2700) - intermediate_value/pedersen/hash0/ec_subset_sum/bit_0.
    // [0x2700, 0x2720) - intermediate_value/pedersen/hash0/ec_subset_sum/bit_neg_0.
    // [0x2720, 0x2740) - intermediate_value/pedersen/hash1/ec_subset_sum/bit_0.
    // [0x2740, 0x2760) - intermediate_value/pedersen/hash1/ec_subset_sum/bit_neg_0.
    // [0x2760, 0x2780) - intermediate_value/pedersen/hash2/ec_subset_sum/bit_0.
    // [0x2780, 0x27a0) - intermediate_value/pedersen/hash2/ec_subset_sum/bit_neg_0.
    // [0x27a0, 0x27c0) - intermediate_value/pedersen/hash3/ec_subset_sum/bit_0.
    // [0x27c0, 0x27e0) - intermediate_value/pedersen/hash3/ec_subset_sum/bit_neg_0.
    // [0x27e0, 0x2800) - intermediate_value/rc_builtin/value0_0.
    // [0x2800, 0x2820) - intermediate_value/rc_builtin/value1_0.
    // [0x2820, 0x2840) - intermediate_value/rc_builtin/value2_0.
    // [0x2840, 0x2860) - intermediate_value/rc_builtin/value3_0.
    // [0x2860, 0x2880) - intermediate_value/rc_builtin/value4_0.
    // [0x2880, 0x28a0) - intermediate_value/rc_builtin/value5_0.
    // [0x28a0, 0x28c0) - intermediate_value/rc_builtin/value6_0.
    // [0x28c0, 0x28e0) - intermediate_value/rc_builtin/value7_0.
    // [0x28e0, 0x2900) - intermediate_value/ecdsa/signature0/doubling_key/x_squared.
    // [0x2900, 0x2920) - intermediate_value/ecdsa/signature0/exponentiate_generator/bit_0.
    // [0x2920, 0x2940) - intermediate_value/ecdsa/signature0/exponentiate_generator/bit_neg_0.
    // [0x2940, 0x2960) - intermediate_value/ecdsa/signature0/exponentiate_key/bit_0.
    // [0x2960, 0x2980) - intermediate_value/ecdsa/signature0/exponentiate_key/bit_neg_0.
    // [0x2980, 0x29a0) - intermediate_value/bitwise/sum_var_0_0.
    // [0x29a0, 0x29c0) - intermediate_value/bitwise/sum_var_8_0.
    // [0x29c0, 0x2ec0) - expmods.
    // [0x2ec0, 0x3280) - domains.
    // [0x3280, 0x35a0) - denominator_invs.
    // [0x35a0, 0x38c0) - denominators.
    // [0x38c0, 0x3980) - expmod_context.

    fallback() external {
        uint256 res;
        assembly {
            let PRIME := 0x800000000000011000000000000000000000000000000000000000000000001
            // Copy input from calldata to memory.
            calldatacopy(0x0, 0x0, /*Input data size*/ 0x2420)
            let point := /*oods_point*/ mload(0x460)
            function expmod(base, exponent, modulus) -> result {
              let p := /*expmod_context*/ 0x38c0
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
              mstore(0x29c0, expmod(point, div(/*trace_length*/ mload(0x80), 8192), PRIME))

              // expmods[1] = point^(trace_length / 4096).
              mstore(0x29e0, mulmod(
                /*point^(trace_length / 8192)*/ mload(0x29c0),
                /*point^(trace_length / 8192)*/ mload(0x29c0),
                PRIME))

              // expmods[2] = point^(trace_length / 1024).
              mstore(0x2a00, expmod(point, div(/*trace_length*/ mload(0x80), 1024), PRIME))

              // expmods[3] = point^(trace_length / 512).
              mstore(0x2a20, mulmod(
                /*point^(trace_length / 1024)*/ mload(0x2a00),
                /*point^(trace_length / 1024)*/ mload(0x2a00),
                PRIME))

              // expmods[4] = point^(trace_length / 256).
              mstore(0x2a40, mulmod(
                /*point^(trace_length / 512)*/ mload(0x2a20),
                /*point^(trace_length / 512)*/ mload(0x2a20),
                PRIME))

              // expmods[5] = point^(trace_length / 128).
              mstore(0x2a60, mulmod(
                /*point^(trace_length / 256)*/ mload(0x2a40),
                /*point^(trace_length / 256)*/ mload(0x2a40),
                PRIME))

              // expmods[6] = point^(trace_length / 32).
              mstore(0x2a80, expmod(point, div(/*trace_length*/ mload(0x80), 32), PRIME))

              // expmods[7] = point^(trace_length / 16).
              mstore(0x2aa0, mulmod(
                /*point^(trace_length / 32)*/ mload(0x2a80),
                /*point^(trace_length / 32)*/ mload(0x2a80),
                PRIME))

              // expmods[8] = point^(trace_length / 8).
              mstore(0x2ac0, mulmod(
                /*point^(trace_length / 16)*/ mload(0x2aa0),
                /*point^(trace_length / 16)*/ mload(0x2aa0),
                PRIME))

              // expmods[9] = point^(trace_length / 4).
              mstore(0x2ae0, mulmod(
                /*point^(trace_length / 8)*/ mload(0x2ac0),
                /*point^(trace_length / 8)*/ mload(0x2ac0),
                PRIME))

              // expmods[10] = point^(trace_length / 2).
              mstore(0x2b00, mulmod(
                /*point^(trace_length / 4)*/ mload(0x2ae0),
                /*point^(trace_length / 4)*/ mload(0x2ae0),
                PRIME))

              // expmods[11] = point^trace_length.
              mstore(0x2b20, mulmod(
                /*point^(trace_length / 2)*/ mload(0x2b00),
                /*point^(trace_length / 2)*/ mload(0x2b00),
                PRIME))

              // expmods[12] = trace_generator^(trace_length / 64).
              mstore(0x2b40, expmod(/*trace_generator*/ mload(0x440), div(/*trace_length*/ mload(0x80), 64), PRIME))

              // expmods[13] = trace_generator^(trace_length / 32).
              mstore(0x2b60, mulmod(
                /*trace_generator^(trace_length / 64)*/ mload(0x2b40),
                /*trace_generator^(trace_length / 64)*/ mload(0x2b40),
                PRIME))

              // expmods[14] = trace_generator^(3 * trace_length / 64).
              mstore(0x2b80, mulmod(
                /*trace_generator^(trace_length / 64)*/ mload(0x2b40),
                /*trace_generator^(trace_length / 32)*/ mload(0x2b60),
                PRIME))

              // expmods[15] = trace_generator^(trace_length / 16).
              mstore(0x2ba0, mulmod(
                /*trace_generator^(trace_length / 64)*/ mload(0x2b40),
                /*trace_generator^(3 * trace_length / 64)*/ mload(0x2b80),
                PRIME))

              // expmods[16] = trace_generator^(5 * trace_length / 64).
              mstore(0x2bc0, mulmod(
                /*trace_generator^(trace_length / 64)*/ mload(0x2b40),
                /*trace_generator^(trace_length / 16)*/ mload(0x2ba0),
                PRIME))

              // expmods[17] = trace_generator^(3 * trace_length / 32).
              mstore(0x2be0, mulmod(
                /*trace_generator^(trace_length / 64)*/ mload(0x2b40),
                /*trace_generator^(5 * trace_length / 64)*/ mload(0x2bc0),
                PRIME))

              // expmods[18] = trace_generator^(7 * trace_length / 64).
              mstore(0x2c00, mulmod(
                /*trace_generator^(trace_length / 64)*/ mload(0x2b40),
                /*trace_generator^(3 * trace_length / 32)*/ mload(0x2be0),
                PRIME))

              // expmods[19] = trace_generator^(trace_length / 8).
              mstore(0x2c20, mulmod(
                /*trace_generator^(trace_length / 64)*/ mload(0x2b40),
                /*trace_generator^(7 * trace_length / 64)*/ mload(0x2c00),
                PRIME))

              // expmods[20] = trace_generator^(9 * trace_length / 64).
              mstore(0x2c40, mulmod(
                /*trace_generator^(trace_length / 64)*/ mload(0x2b40),
                /*trace_generator^(trace_length / 8)*/ mload(0x2c20),
                PRIME))

              // expmods[21] = trace_generator^(5 * trace_length / 32).
              mstore(0x2c60, mulmod(
                /*trace_generator^(trace_length / 64)*/ mload(0x2b40),
                /*trace_generator^(9 * trace_length / 64)*/ mload(0x2c40),
                PRIME))

              // expmods[22] = trace_generator^(11 * trace_length / 64).
              mstore(0x2c80, mulmod(
                /*trace_generator^(trace_length / 64)*/ mload(0x2b40),
                /*trace_generator^(5 * trace_length / 32)*/ mload(0x2c60),
                PRIME))

              // expmods[23] = trace_generator^(3 * trace_length / 16).
              mstore(0x2ca0, mulmod(
                /*trace_generator^(trace_length / 64)*/ mload(0x2b40),
                /*trace_generator^(11 * trace_length / 64)*/ mload(0x2c80),
                PRIME))

              // expmods[24] = trace_generator^(13 * trace_length / 64).
              mstore(0x2cc0, mulmod(
                /*trace_generator^(trace_length / 64)*/ mload(0x2b40),
                /*trace_generator^(3 * trace_length / 16)*/ mload(0x2ca0),
                PRIME))

              // expmods[25] = trace_generator^(7 * trace_length / 32).
              mstore(0x2ce0, mulmod(
                /*trace_generator^(trace_length / 64)*/ mload(0x2b40),
                /*trace_generator^(13 * trace_length / 64)*/ mload(0x2cc0),
                PRIME))

              // expmods[26] = trace_generator^(15 * trace_length / 64).
              mstore(0x2d00, mulmod(
                /*trace_generator^(trace_length / 64)*/ mload(0x2b40),
                /*trace_generator^(7 * trace_length / 32)*/ mload(0x2ce0),
                PRIME))

              // expmods[27] = trace_generator^(trace_length / 2).
              mstore(0x2d20, expmod(/*trace_generator*/ mload(0x440), div(/*trace_length*/ mload(0x80), 2), PRIME))

              // expmods[28] = trace_generator^(3 * trace_length / 4).
              mstore(0x2d40, expmod(/*trace_generator*/ mload(0x440), div(mul(3, /*trace_length*/ mload(0x80)), 4), PRIME))

              // expmods[29] = trace_generator^(15 * trace_length / 16).
              mstore(0x2d60, mulmod(
                /*trace_generator^(3 * trace_length / 16)*/ mload(0x2ca0),
                /*trace_generator^(3 * trace_length / 4)*/ mload(0x2d40),
                PRIME))

              // expmods[30] = trace_generator^(251 * trace_length / 256).
              mstore(0x2d80, expmod(/*trace_generator*/ mload(0x440), div(mul(251, /*trace_length*/ mload(0x80)), 256), PRIME))

              // expmods[31] = trace_generator^(63 * trace_length / 64).
              mstore(0x2da0, mulmod(
                /*trace_generator^(3 * trace_length / 64)*/ mload(0x2b80),
                /*trace_generator^(15 * trace_length / 16)*/ mload(0x2d60),
                PRIME))

              // expmods[32] = trace_generator^(255 * trace_length / 256).
              mstore(0x2dc0, mulmod(
                /*trace_generator^(trace_length / 64)*/ mload(0x2b40),
                /*trace_generator^(251 * trace_length / 256)*/ mload(0x2d80),
                PRIME))

              // expmods[33] = trace_generator^(16 * (trace_length / 16 - 1)).
              mstore(0x2de0, expmod(/*trace_generator*/ mload(0x440), mul(16, sub(div(/*trace_length*/ mload(0x80), 16), 1)), PRIME))

              // expmods[34] = trace_generator^(2 * (trace_length / 2 - 1)).
              mstore(0x2e00, expmod(/*trace_generator*/ mload(0x440), mul(2, sub(div(/*trace_length*/ mload(0x80), 2), 1)), PRIME))

              // expmods[35] = trace_generator^(4 * (trace_length / 4 - 1)).
              mstore(0x2e20, expmod(/*trace_generator*/ mload(0x440), mul(4, sub(div(/*trace_length*/ mload(0x80), 4), 1)), PRIME))

              // expmods[36] = trace_generator^(8 * (trace_length / 8 - 1)).
              mstore(0x2e40, expmod(/*trace_generator*/ mload(0x440), mul(8, sub(div(/*trace_length*/ mload(0x80), 8), 1)), PRIME))

              // expmods[37] = trace_generator^(128 * (trace_length / 128 - 1)).
              mstore(0x2e60, expmod(/*trace_generator*/ mload(0x440), mul(128, sub(div(/*trace_length*/ mload(0x80), 128), 1)), PRIME))

              // expmods[38] = trace_generator^(8192 * (trace_length / 8192 - 1)).
              mstore(0x2e80, expmod(/*trace_generator*/ mload(0x440), mul(8192, sub(div(/*trace_length*/ mload(0x80), 8192), 1)), PRIME))

              // expmods[39] = trace_generator^(1024 * (trace_length / 1024 - 1)).
              mstore(0x2ea0, expmod(/*trace_generator*/ mload(0x440), mul(1024, sub(div(/*trace_length*/ mload(0x80), 1024), 1)), PRIME))

            }

            {
              // Compute domains.

              // Denominator for constraints: 'cpu/decode/opcode_rc/bit', 'pedersen/hash0/ec_subset_sum/booleanity_test', 'pedersen/hash0/ec_subset_sum/add_points/slope', 'pedersen/hash0/ec_subset_sum/add_points/x', 'pedersen/hash0/ec_subset_sum/add_points/y', 'pedersen/hash0/ec_subset_sum/copy_point/x', 'pedersen/hash0/ec_subset_sum/copy_point/y', 'pedersen/hash1/ec_subset_sum/booleanity_test', 'pedersen/hash1/ec_subset_sum/add_points/slope', 'pedersen/hash1/ec_subset_sum/add_points/x', 'pedersen/hash1/ec_subset_sum/add_points/y', 'pedersen/hash1/ec_subset_sum/copy_point/x', 'pedersen/hash1/ec_subset_sum/copy_point/y', 'pedersen/hash2/ec_subset_sum/booleanity_test', 'pedersen/hash2/ec_subset_sum/add_points/slope', 'pedersen/hash2/ec_subset_sum/add_points/x', 'pedersen/hash2/ec_subset_sum/add_points/y', 'pedersen/hash2/ec_subset_sum/copy_point/x', 'pedersen/hash2/ec_subset_sum/copy_point/y', 'pedersen/hash3/ec_subset_sum/booleanity_test', 'pedersen/hash3/ec_subset_sum/add_points/slope', 'pedersen/hash3/ec_subset_sum/add_points/x', 'pedersen/hash3/ec_subset_sum/add_points/y', 'pedersen/hash3/ec_subset_sum/copy_point/x', 'pedersen/hash3/ec_subset_sum/copy_point/y'.
              // domains[0] = point^trace_length - 1.
              mstore(0x2ec0,
                     addmod(/*point^trace_length*/ mload(0x2b20), sub(PRIME, 1), PRIME))

              // Denominator for constraints: 'memory/multi_column_perm/perm/step0', 'memory/diff_is_bit', 'memory/is_func'.
              // domains[1] = point^(trace_length / 2) - 1.
              mstore(0x2ee0,
                     addmod(/*point^(trace_length / 2)*/ mload(0x2b00), sub(PRIME, 1), PRIME))

              // Denominator for constraints: 'rc16/perm/step0', 'rc16/diff_is_bit'.
              // domains[2] = point^(trace_length / 4) - 1.
              mstore(0x2f00,
                     addmod(/*point^(trace_length / 4)*/ mload(0x2ae0), sub(PRIME, 1), PRIME))

              // Denominator for constraints: 'public_memory_addr_zero', 'public_memory_value_zero', 'diluted_check/permutation/step0', 'diluted_check/step'.
              // domains[3] = point^(trace_length / 8) - 1.
              mstore(0x2f20,
                     addmod(/*point^(trace_length / 8)*/ mload(0x2ac0), sub(PRIME, 1), PRIME))

              // Denominator for constraints: 'cpu/decode/opcode_rc/zero'.
              // Numerator for constraints: 'cpu/decode/opcode_rc/bit'.
              // domains[4] = point^(trace_length / 16) - trace_generator^(15 * trace_length / 16).
              mstore(0x2f40,
                     addmod(
                       /*point^(trace_length / 16)*/ mload(0x2aa0),
                       sub(PRIME, /*trace_generator^(15 * trace_length / 16)*/ mload(0x2d60)),
                       PRIME))

              // Denominator for constraints: 'cpu/decode/opcode_rc_input', 'cpu/decode/flag_op1_base_op0_bit', 'cpu/decode/flag_res_op1_bit', 'cpu/decode/flag_pc_update_regular_bit', 'cpu/decode/fp_update_regular_bit', 'cpu/operands/mem_dst_addr', 'cpu/operands/mem0_addr', 'cpu/operands/mem1_addr', 'cpu/operands/ops_mul', 'cpu/operands/res', 'cpu/update_registers/update_pc/tmp0', 'cpu/update_registers/update_pc/tmp1', 'cpu/update_registers/update_pc/pc_cond_negative', 'cpu/update_registers/update_pc/pc_cond_positive', 'cpu/update_registers/update_ap/ap_update', 'cpu/update_registers/update_fp/fp_update', 'cpu/opcodes/call/push_fp', 'cpu/opcodes/call/push_pc', 'cpu/opcodes/call/off0', 'cpu/opcodes/call/off1', 'cpu/opcodes/call/flags', 'cpu/opcodes/ret/off0', 'cpu/opcodes/ret/off2', 'cpu/opcodes/ret/flags', 'cpu/opcodes/assert_eq/assert_eq', 'ecdsa/signature0/doubling_key/slope', 'ecdsa/signature0/doubling_key/x', 'ecdsa/signature0/doubling_key/y', 'ecdsa/signature0/exponentiate_key/booleanity_test', 'ecdsa/signature0/exponentiate_key/add_points/slope', 'ecdsa/signature0/exponentiate_key/add_points/x', 'ecdsa/signature0/exponentiate_key/add_points/y', 'ecdsa/signature0/exponentiate_key/add_points/x_diff_inv', 'ecdsa/signature0/exponentiate_key/copy_point/x', 'ecdsa/signature0/exponentiate_key/copy_point/y'.
              // domains[5] = point^(trace_length / 16) - 1.
              mstore(0x2f60,
                     addmod(/*point^(trace_length / 16)*/ mload(0x2aa0), sub(PRIME, 1), PRIME))

              // Denominator for constraints: 'ecdsa/signature0/exponentiate_generator/booleanity_test', 'ecdsa/signature0/exponentiate_generator/add_points/slope', 'ecdsa/signature0/exponentiate_generator/add_points/x', 'ecdsa/signature0/exponentiate_generator/add_points/y', 'ecdsa/signature0/exponentiate_generator/add_points/x_diff_inv', 'ecdsa/signature0/exponentiate_generator/copy_point/x', 'ecdsa/signature0/exponentiate_generator/copy_point/y'.
              // domains[6] = point^(trace_length / 32) - 1.
              mstore(0x2f80,
                     addmod(/*point^(trace_length / 32)*/ mload(0x2a80), sub(PRIME, 1), PRIME))

              // Denominator for constraints: 'pedersen/input0_addr', 'pedersen/input1_addr', 'pedersen/output_addr', 'rc_builtin/value', 'rc_builtin/addr_step'.
              // domains[7] = point^(trace_length / 128) - 1.
              mstore(0x2fa0,
                     addmod(/*point^(trace_length / 128)*/ mload(0x2a60), sub(PRIME, 1), PRIME))

              // Denominator for constraints: 'pedersen/hash0/ec_subset_sum/bit_unpacking/last_one_is_zero', 'pedersen/hash0/ec_subset_sum/bit_unpacking/zeroes_between_ones0', 'pedersen/hash0/ec_subset_sum/bit_unpacking/cumulative_bit192', 'pedersen/hash0/ec_subset_sum/bit_unpacking/zeroes_between_ones192', 'pedersen/hash0/ec_subset_sum/bit_unpacking/cumulative_bit196', 'pedersen/hash0/ec_subset_sum/bit_unpacking/zeroes_between_ones196', 'pedersen/hash0/copy_point/x', 'pedersen/hash0/copy_point/y', 'pedersen/hash1/ec_subset_sum/bit_unpacking/last_one_is_zero', 'pedersen/hash1/ec_subset_sum/bit_unpacking/zeroes_between_ones0', 'pedersen/hash1/ec_subset_sum/bit_unpacking/cumulative_bit192', 'pedersen/hash1/ec_subset_sum/bit_unpacking/zeroes_between_ones192', 'pedersen/hash1/ec_subset_sum/bit_unpacking/cumulative_bit196', 'pedersen/hash1/ec_subset_sum/bit_unpacking/zeroes_between_ones196', 'pedersen/hash1/copy_point/x', 'pedersen/hash1/copy_point/y', 'pedersen/hash2/ec_subset_sum/bit_unpacking/last_one_is_zero', 'pedersen/hash2/ec_subset_sum/bit_unpacking/zeroes_between_ones0', 'pedersen/hash2/ec_subset_sum/bit_unpacking/cumulative_bit192', 'pedersen/hash2/ec_subset_sum/bit_unpacking/zeroes_between_ones192', 'pedersen/hash2/ec_subset_sum/bit_unpacking/cumulative_bit196', 'pedersen/hash2/ec_subset_sum/bit_unpacking/zeroes_between_ones196', 'pedersen/hash2/copy_point/x', 'pedersen/hash2/copy_point/y', 'pedersen/hash3/ec_subset_sum/bit_unpacking/last_one_is_zero', 'pedersen/hash3/ec_subset_sum/bit_unpacking/zeroes_between_ones0', 'pedersen/hash3/ec_subset_sum/bit_unpacking/cumulative_bit192', 'pedersen/hash3/ec_subset_sum/bit_unpacking/zeroes_between_ones192', 'pedersen/hash3/ec_subset_sum/bit_unpacking/cumulative_bit196', 'pedersen/hash3/ec_subset_sum/bit_unpacking/zeroes_between_ones196', 'pedersen/hash3/copy_point/x', 'pedersen/hash3/copy_point/y', 'bitwise/step_var_pool_addr', 'bitwise/partition'.
              // domains[8] = point^(trace_length / 256) - 1.
              mstore(0x2fc0,
                     addmod(/*point^(trace_length / 256)*/ mload(0x2a40), sub(PRIME, 1), PRIME))

              // Denominator for constraints: 'pedersen/hash0/ec_subset_sum/zeros_tail', 'pedersen/hash1/ec_subset_sum/zeros_tail', 'pedersen/hash2/ec_subset_sum/zeros_tail', 'pedersen/hash3/ec_subset_sum/zeros_tail'.
              // Numerator for constraints: 'pedersen/hash0/ec_subset_sum/booleanity_test', 'pedersen/hash0/ec_subset_sum/add_points/slope', 'pedersen/hash0/ec_subset_sum/add_points/x', 'pedersen/hash0/ec_subset_sum/add_points/y', 'pedersen/hash0/ec_subset_sum/copy_point/x', 'pedersen/hash0/ec_subset_sum/copy_point/y', 'pedersen/hash1/ec_subset_sum/booleanity_test', 'pedersen/hash1/ec_subset_sum/add_points/slope', 'pedersen/hash1/ec_subset_sum/add_points/x', 'pedersen/hash1/ec_subset_sum/add_points/y', 'pedersen/hash1/ec_subset_sum/copy_point/x', 'pedersen/hash1/ec_subset_sum/copy_point/y', 'pedersen/hash2/ec_subset_sum/booleanity_test', 'pedersen/hash2/ec_subset_sum/add_points/slope', 'pedersen/hash2/ec_subset_sum/add_points/x', 'pedersen/hash2/ec_subset_sum/add_points/y', 'pedersen/hash2/ec_subset_sum/copy_point/x', 'pedersen/hash2/ec_subset_sum/copy_point/y', 'pedersen/hash3/ec_subset_sum/booleanity_test', 'pedersen/hash3/ec_subset_sum/add_points/slope', 'pedersen/hash3/ec_subset_sum/add_points/x', 'pedersen/hash3/ec_subset_sum/add_points/y', 'pedersen/hash3/ec_subset_sum/copy_point/x', 'pedersen/hash3/ec_subset_sum/copy_point/y'.
              // domains[9] = point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              mstore(0x2fe0,
                     addmod(
                       /*point^(trace_length / 256)*/ mload(0x2a40),
                       sub(PRIME, /*trace_generator^(255 * trace_length / 256)*/ mload(0x2dc0)),
                       PRIME))

              // Denominator for constraints: 'pedersen/hash0/ec_subset_sum/bit_extraction_end', 'pedersen/hash1/ec_subset_sum/bit_extraction_end', 'pedersen/hash2/ec_subset_sum/bit_extraction_end', 'pedersen/hash3/ec_subset_sum/bit_extraction_end'.
              // domains[10] = point^(trace_length / 256) - trace_generator^(63 * trace_length / 64).
              mstore(0x3000,
                     addmod(
                       /*point^(trace_length / 256)*/ mload(0x2a40),
                       sub(PRIME, /*trace_generator^(63 * trace_length / 64)*/ mload(0x2da0)),
                       PRIME))

              // Numerator for constraints: 'pedersen/hash0/copy_point/x', 'pedersen/hash0/copy_point/y', 'pedersen/hash1/copy_point/x', 'pedersen/hash1/copy_point/y', 'pedersen/hash2/copy_point/x', 'pedersen/hash2/copy_point/y', 'pedersen/hash3/copy_point/x', 'pedersen/hash3/copy_point/y'.
              // domains[11] = point^(trace_length / 512) - trace_generator^(trace_length / 2).
              mstore(0x3020,
                     addmod(
                       /*point^(trace_length / 512)*/ mload(0x2a20),
                       sub(PRIME, /*trace_generator^(trace_length / 2)*/ mload(0x2d20)),
                       PRIME))

              // Denominator for constraints: 'pedersen/hash0/init/x', 'pedersen/hash0/init/y', 'pedersen/hash1/init/x', 'pedersen/hash1/init/y', 'pedersen/hash2/init/x', 'pedersen/hash2/init/y', 'pedersen/hash3/init/x', 'pedersen/hash3/init/y', 'pedersen/input0_value0', 'pedersen/input0_value1', 'pedersen/input0_value2', 'pedersen/input0_value3', 'pedersen/input1_value0', 'pedersen/input1_value1', 'pedersen/input1_value2', 'pedersen/input1_value3', 'pedersen/output_value0', 'pedersen/output_value1', 'pedersen/output_value2', 'pedersen/output_value3'.
              // domains[12] = point^(trace_length / 512) - 1.
              mstore(0x3040,
                     addmod(/*point^(trace_length / 512)*/ mload(0x2a20), sub(PRIME, 1), PRIME))

              // Numerator for constraints: 'bitwise/step_var_pool_addr'.
              // domains[13] = point^(trace_length / 1024) - trace_generator^(3 * trace_length / 4).
              mstore(0x3060,
                     addmod(
                       /*point^(trace_length / 1024)*/ mload(0x2a00),
                       sub(PRIME, /*trace_generator^(3 * trace_length / 4)*/ mload(0x2d40)),
                       PRIME))

              // Denominator for constraints: 'bitwise/x_or_y_addr', 'bitwise/next_var_pool_addr', 'bitwise/or_is_and_plus_xor', 'bitwise/unique_unpacking192', 'bitwise/unique_unpacking193', 'bitwise/unique_unpacking194', 'bitwise/unique_unpacking195'.
              // domains[14] = point^(trace_length / 1024) - 1.
              mstore(0x3080,
                     addmod(/*point^(trace_length / 1024)*/ mload(0x2a00), sub(PRIME, 1), PRIME))

              // Denominator for constraints: 'bitwise/addition_is_xor_with_and'.
              // domains[15] = (point^(trace_length / 1024) - trace_generator^(trace_length / 64)) * (point^(trace_length / 1024) - trace_generator^(trace_length / 32)) * (point^(trace_length / 1024) - trace_generator^(3 * trace_length / 64)) * (point^(trace_length / 1024) - trace_generator^(trace_length / 16)) * (point^(trace_length / 1024) - trace_generator^(5 * trace_length / 64)) * (point^(trace_length / 1024) - trace_generator^(3 * trace_length / 32)) * (point^(trace_length / 1024) - trace_generator^(7 * trace_length / 64)) * (point^(trace_length / 1024) - trace_generator^(trace_length / 8)) * (point^(trace_length / 1024) - trace_generator^(9 * trace_length / 64)) * (point^(trace_length / 1024) - trace_generator^(5 * trace_length / 32)) * (point^(trace_length / 1024) - trace_generator^(11 * trace_length / 64)) * (point^(trace_length / 1024) - trace_generator^(3 * trace_length / 16)) * (point^(trace_length / 1024) - trace_generator^(13 * trace_length / 64)) * (point^(trace_length / 1024) - trace_generator^(7 * trace_length / 32)) * (point^(trace_length / 1024) - trace_generator^(15 * trace_length / 64)) * domain14.
              {
                let domain := mulmod(
                    mulmod(
                      mulmod(
                        addmod(
                          /*point^(trace_length / 1024)*/ mload(0x2a00),
                          sub(PRIME, /*trace_generator^(trace_length / 64)*/ mload(0x2b40)),
                          PRIME),
                        addmod(
                          /*point^(trace_length / 1024)*/ mload(0x2a00),
                          sub(PRIME, /*trace_generator^(trace_length / 32)*/ mload(0x2b60)),
                          PRIME),
                        PRIME),
                      addmod(
                        /*point^(trace_length / 1024)*/ mload(0x2a00),
                        sub(PRIME, /*trace_generator^(3 * trace_length / 64)*/ mload(0x2b80)),
                        PRIME),
                      PRIME),
                    addmod(
                      /*point^(trace_length / 1024)*/ mload(0x2a00),
                      sub(PRIME, /*trace_generator^(trace_length / 16)*/ mload(0x2ba0)),
                      PRIME),
                    PRIME)
                domain := mulmod(
                  domain,
                  mulmod(
                    mulmod(
                      mulmod(
                        addmod(
                          /*point^(trace_length / 1024)*/ mload(0x2a00),
                          sub(PRIME, /*trace_generator^(5 * trace_length / 64)*/ mload(0x2bc0)),
                          PRIME),
                        addmod(
                          /*point^(trace_length / 1024)*/ mload(0x2a00),
                          sub(PRIME, /*trace_generator^(3 * trace_length / 32)*/ mload(0x2be0)),
                          PRIME),
                        PRIME),
                      addmod(
                        /*point^(trace_length / 1024)*/ mload(0x2a00),
                        sub(PRIME, /*trace_generator^(7 * trace_length / 64)*/ mload(0x2c00)),
                        PRIME),
                      PRIME),
                    addmod(
                      /*point^(trace_length / 1024)*/ mload(0x2a00),
                      sub(PRIME, /*trace_generator^(trace_length / 8)*/ mload(0x2c20)),
                      PRIME),
                    PRIME),
                  PRIME)
                domain := mulmod(
                  domain,
                  mulmod(
                    mulmod(
                      mulmod(
                        addmod(
                          /*point^(trace_length / 1024)*/ mload(0x2a00),
                          sub(PRIME, /*trace_generator^(9 * trace_length / 64)*/ mload(0x2c40)),
                          PRIME),
                        addmod(
                          /*point^(trace_length / 1024)*/ mload(0x2a00),
                          sub(PRIME, /*trace_generator^(5 * trace_length / 32)*/ mload(0x2c60)),
                          PRIME),
                        PRIME),
                      addmod(
                        /*point^(trace_length / 1024)*/ mload(0x2a00),
                        sub(PRIME, /*trace_generator^(11 * trace_length / 64)*/ mload(0x2c80)),
                        PRIME),
                      PRIME),
                    addmod(
                      /*point^(trace_length / 1024)*/ mload(0x2a00),
                      sub(PRIME, /*trace_generator^(3 * trace_length / 16)*/ mload(0x2ca0)),
                      PRIME),
                    PRIME),
                  PRIME)
                domain := mulmod(
                  domain,
                  mulmod(
                    mulmod(
                      mulmod(
                        addmod(
                          /*point^(trace_length / 1024)*/ mload(0x2a00),
                          sub(PRIME, /*trace_generator^(13 * trace_length / 64)*/ mload(0x2cc0)),
                          PRIME),
                        addmod(
                          /*point^(trace_length / 1024)*/ mload(0x2a00),
                          sub(PRIME, /*trace_generator^(7 * trace_length / 32)*/ mload(0x2ce0)),
                          PRIME),
                        PRIME),
                      addmod(
                        /*point^(trace_length / 1024)*/ mload(0x2a00),
                        sub(PRIME, /*trace_generator^(15 * trace_length / 64)*/ mload(0x2d00)),
                        PRIME),
                      PRIME),
                    /*domains[14]*/ mload(0x3080),
                    PRIME),
                  PRIME)
                mstore(0x30a0, domain)
              }

              // Denominator for constraints: 'ecdsa/signature0/exponentiate_key/zeros_tail'.
              // Numerator for constraints: 'ecdsa/signature0/doubling_key/slope', 'ecdsa/signature0/doubling_key/x', 'ecdsa/signature0/doubling_key/y', 'ecdsa/signature0/exponentiate_key/booleanity_test', 'ecdsa/signature0/exponentiate_key/add_points/slope', 'ecdsa/signature0/exponentiate_key/add_points/x', 'ecdsa/signature0/exponentiate_key/add_points/y', 'ecdsa/signature0/exponentiate_key/add_points/x_diff_inv', 'ecdsa/signature0/exponentiate_key/copy_point/x', 'ecdsa/signature0/exponentiate_key/copy_point/y'.
              // domains[16] = point^(trace_length / 4096) - trace_generator^(255 * trace_length / 256).
              mstore(0x30c0,
                     addmod(
                       /*point^(trace_length / 4096)*/ mload(0x29e0),
                       sub(PRIME, /*trace_generator^(255 * trace_length / 256)*/ mload(0x2dc0)),
                       PRIME))

              // Denominator for constraints: 'ecdsa/signature0/exponentiate_key/bit_extraction_end'.
              // domains[17] = point^(trace_length / 4096) - trace_generator^(251 * trace_length / 256).
              mstore(0x30e0,
                     addmod(
                       /*point^(trace_length / 4096)*/ mload(0x29e0),
                       sub(PRIME, /*trace_generator^(251 * trace_length / 256)*/ mload(0x2d80)),
                       PRIME))

              // Denominator for constraints: 'ecdsa/signature0/init_key/x', 'ecdsa/signature0/init_key/y', 'ecdsa/signature0/r_and_w_nonzero'.
              // domains[18] = point^(trace_length / 4096) - 1.
              mstore(0x3100,
                     addmod(/*point^(trace_length / 4096)*/ mload(0x29e0), sub(PRIME, 1), PRIME))

              // Denominator for constraints: 'ecdsa/signature0/exponentiate_generator/zeros_tail'.
              // Numerator for constraints: 'ecdsa/signature0/exponentiate_generator/booleanity_test', 'ecdsa/signature0/exponentiate_generator/add_points/slope', 'ecdsa/signature0/exponentiate_generator/add_points/x', 'ecdsa/signature0/exponentiate_generator/add_points/y', 'ecdsa/signature0/exponentiate_generator/add_points/x_diff_inv', 'ecdsa/signature0/exponentiate_generator/copy_point/x', 'ecdsa/signature0/exponentiate_generator/copy_point/y'.
              // domains[19] = point^(trace_length / 8192) - trace_generator^(255 * trace_length / 256).
              mstore(0x3120,
                     addmod(
                       /*point^(trace_length / 8192)*/ mload(0x29c0),
                       sub(PRIME, /*trace_generator^(255 * trace_length / 256)*/ mload(0x2dc0)),
                       PRIME))

              // Denominator for constraints: 'ecdsa/signature0/exponentiate_generator/bit_extraction_end'.
              // domains[20] = point^(trace_length / 8192) - trace_generator^(251 * trace_length / 256).
              mstore(0x3140,
                     addmod(
                       /*point^(trace_length / 8192)*/ mload(0x29c0),
                       sub(PRIME, /*trace_generator^(251 * trace_length / 256)*/ mload(0x2d80)),
                       PRIME))

              // Denominator for constraints: 'ecdsa/signature0/init_gen/x', 'ecdsa/signature0/init_gen/y', 'ecdsa/signature0/add_results/slope', 'ecdsa/signature0/add_results/x', 'ecdsa/signature0/add_results/y', 'ecdsa/signature0/add_results/x_diff_inv', 'ecdsa/signature0/extract_r/slope', 'ecdsa/signature0/extract_r/x', 'ecdsa/signature0/extract_r/x_diff_inv', 'ecdsa/signature0/z_nonzero', 'ecdsa/signature0/q_on_curve/x_squared', 'ecdsa/signature0/q_on_curve/on_curve', 'ecdsa/message_addr', 'ecdsa/pubkey_addr', 'ecdsa/message_value0', 'ecdsa/pubkey_value0'.
              // domains[21] = point^(trace_length / 8192) - 1.
              mstore(0x3160,
                     addmod(/*point^(trace_length / 8192)*/ mload(0x29c0), sub(PRIME, 1), PRIME))

              // Denominator for constraints: 'final_ap', 'final_fp', 'final_pc'.
              // Numerator for constraints: 'cpu/update_registers/update_pc/tmp0', 'cpu/update_registers/update_pc/tmp1', 'cpu/update_registers/update_pc/pc_cond_negative', 'cpu/update_registers/update_pc/pc_cond_positive', 'cpu/update_registers/update_ap/ap_update', 'cpu/update_registers/update_fp/fp_update'.
              // domains[22] = point - trace_generator^(16 * (trace_length / 16 - 1)).
              mstore(0x3180,
                     addmod(
                       point,
                       sub(PRIME, /*trace_generator^(16 * (trace_length / 16 - 1))*/ mload(0x2de0)),
                       PRIME))

              // Denominator for constraints: 'initial_ap', 'initial_fp', 'initial_pc', 'memory/multi_column_perm/perm/init0', 'memory/initial_addr', 'rc16/perm/init0', 'rc16/minimum', 'diluted_check/permutation/init0', 'diluted_check/init', 'diluted_check/first_element', 'pedersen/init_addr', 'rc_builtin/init_addr', 'ecdsa/init_addr', 'bitwise/init_var_pool_addr'.
              // domains[23] = point - 1.
              mstore(0x31a0,
                     addmod(point, sub(PRIME, 1), PRIME))

              // Denominator for constraints: 'memory/multi_column_perm/perm/last'.
              // Numerator for constraints: 'memory/multi_column_perm/perm/step0', 'memory/diff_is_bit', 'memory/is_func'.
              // domains[24] = point - trace_generator^(2 * (trace_length / 2 - 1)).
              mstore(0x31c0,
                     addmod(
                       point,
                       sub(PRIME, /*trace_generator^(2 * (trace_length / 2 - 1))*/ mload(0x2e00)),
                       PRIME))

              // Denominator for constraints: 'rc16/perm/last', 'rc16/maximum'.
              // Numerator for constraints: 'rc16/perm/step0', 'rc16/diff_is_bit'.
              // domains[25] = point - trace_generator^(4 * (trace_length / 4 - 1)).
              mstore(0x31e0,
                     addmod(
                       point,
                       sub(PRIME, /*trace_generator^(4 * (trace_length / 4 - 1))*/ mload(0x2e20)),
                       PRIME))

              // Denominator for constraints: 'diluted_check/permutation/last', 'diluted_check/last'.
              // Numerator for constraints: 'diluted_check/permutation/step0', 'diluted_check/step'.
              // domains[26] = point - trace_generator^(8 * (trace_length / 8 - 1)).
              mstore(0x3200,
                     addmod(
                       point,
                       sub(PRIME, /*trace_generator^(8 * (trace_length / 8 - 1))*/ mload(0x2e40)),
                       PRIME))

              // Numerator for constraints: 'pedersen/input0_addr', 'rc_builtin/addr_step'.
              // domains[27] = point - trace_generator^(128 * (trace_length / 128 - 1)).
              mstore(0x3220,
                     addmod(
                       point,
                       sub(PRIME, /*trace_generator^(128 * (trace_length / 128 - 1))*/ mload(0x2e60)),
                       PRIME))

              // Numerator for constraints: 'ecdsa/pubkey_addr'.
              // domains[28] = point - trace_generator^(8192 * (trace_length / 8192 - 1)).
              mstore(0x3240,
                     addmod(
                       point,
                       sub(PRIME, /*trace_generator^(8192 * (trace_length / 8192 - 1))*/ mload(0x2e80)),
                       PRIME))

              // Numerator for constraints: 'bitwise/next_var_pool_addr'.
              // domains[29] = point - trace_generator^(1024 * (trace_length / 1024 - 1)).
              mstore(0x3260,
                     addmod(
                       point,
                       sub(PRIME, /*trace_generator^(1024 * (trace_length / 1024 - 1))*/ mload(0x2ea0)),
                       PRIME))

            }

            {
              // Prepare denominators for batch inverse.

              // denominators[0] = domains[0].
              mstore(0x35a0, /*domains[0]*/ mload(0x2ec0))

              // denominators[1] = domains[4].
              mstore(0x35c0, /*domains[4]*/ mload(0x2f40))

              // denominators[2] = domains[5].
              mstore(0x35e0, /*domains[5]*/ mload(0x2f60))

              // denominators[3] = domains[22].
              mstore(0x3600, /*domains[22]*/ mload(0x3180))

              // denominators[4] = domains[23].
              mstore(0x3620, /*domains[23]*/ mload(0x31a0))

              // denominators[5] = domains[1].
              mstore(0x3640, /*domains[1]*/ mload(0x2ee0))

              // denominators[6] = domains[24].
              mstore(0x3660, /*domains[24]*/ mload(0x31c0))

              // denominators[7] = domains[3].
              mstore(0x3680, /*domains[3]*/ mload(0x2f20))

              // denominators[8] = domains[2].
              mstore(0x36a0, /*domains[2]*/ mload(0x2f00))

              // denominators[9] = domains[25].
              mstore(0x36c0, /*domains[25]*/ mload(0x31e0))

              // denominators[10] = domains[26].
              mstore(0x36e0, /*domains[26]*/ mload(0x3200))

              // denominators[11] = domains[8].
              mstore(0x3700, /*domains[8]*/ mload(0x2fc0))

              // denominators[12] = domains[9].
              mstore(0x3720, /*domains[9]*/ mload(0x2fe0))

              // denominators[13] = domains[10].
              mstore(0x3740, /*domains[10]*/ mload(0x3000))

              // denominators[14] = domains[12].
              mstore(0x3760, /*domains[12]*/ mload(0x3040))

              // denominators[15] = domains[7].
              mstore(0x3780, /*domains[7]*/ mload(0x2fa0))

              // denominators[16] = domains[16].
              mstore(0x37a0, /*domains[16]*/ mload(0x30c0))

              // denominators[17] = domains[6].
              mstore(0x37c0, /*domains[6]*/ mload(0x2f80))

              // denominators[18] = domains[19].
              mstore(0x37e0, /*domains[19]*/ mload(0x3120))

              // denominators[19] = domains[20].
              mstore(0x3800, /*domains[20]*/ mload(0x3140))

              // denominators[20] = domains[17].
              mstore(0x3820, /*domains[17]*/ mload(0x30e0))

              // denominators[21] = domains[21].
              mstore(0x3840, /*domains[21]*/ mload(0x3160))

              // denominators[22] = domains[18].
              mstore(0x3860, /*domains[18]*/ mload(0x3100))

              // denominators[23] = domains[14].
              mstore(0x3880, /*domains[14]*/ mload(0x3080))

              // denominators[24] = domains[15].
              mstore(0x38a0, /*domains[15]*/ mload(0x30a0))

            }

            {
              // Compute the inverses of the denominators into denominatorInvs using batch inverse.

              // Start by computing the cumulative product.
              // Let (d_0, d_1, d_2, ..., d_{n-1}) be the values in denominators. After this loop
              // denominatorInvs will be (1, d_0, d_0 * d_1, ...) and prod will contain the value of
              // d_0 * ... * d_{n-1}.
              // Compute the offset between the partialProducts array and the input values array.
              let productsToValuesOffset := 0x320
              let prod := 1
              let partialProductEndPtr := 0x35a0
              for { let partialProductPtr := 0x3280 }
                  lt(partialProductPtr, partialProductEndPtr)
                  { partialProductPtr := add(partialProductPtr, 0x20) } {
                  mstore(partialProductPtr, prod)
                  // prod *= d_{i}.
                  prod := mulmod(prod,
                                 mload(add(partialProductPtr, productsToValuesOffset)),
                                 PRIME)
              }

              let firstPartialProductPtr := 0x3280
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
              let currentPartialProductPtr := 0x35a0
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
              // cpu/decode/opcode_rc/bit_0 = column0_row0 - (column0_row1 + column0_row1).
              let val := addmod(
                /*column0_row0*/ mload(0x560),
                sub(
                  PRIME,
                  addmod(/*column0_row1*/ mload(0x580), /*column0_row1*/ mload(0x580), PRIME)),
                PRIME)
              mstore(0x2420, val)
              }


              {
              // cpu/decode/opcode_rc/bit_2 = column0_row2 - (column0_row3 + column0_row3).
              let val := addmod(
                /*column0_row2*/ mload(0x5a0),
                sub(
                  PRIME,
                  addmod(/*column0_row3*/ mload(0x5c0), /*column0_row3*/ mload(0x5c0), PRIME)),
                PRIME)
              mstore(0x2440, val)
              }


              {
              // cpu/decode/opcode_rc/bit_4 = column0_row4 - (column0_row5 + column0_row5).
              let val := addmod(
                /*column0_row4*/ mload(0x5e0),
                sub(
                  PRIME,
                  addmod(/*column0_row5*/ mload(0x600), /*column0_row5*/ mload(0x600), PRIME)),
                PRIME)
              mstore(0x2460, val)
              }


              {
              // cpu/decode/opcode_rc/bit_3 = column0_row3 - (column0_row4 + column0_row4).
              let val := addmod(
                /*column0_row3*/ mload(0x5c0),
                sub(
                  PRIME,
                  addmod(/*column0_row4*/ mload(0x5e0), /*column0_row4*/ mload(0x5e0), PRIME)),
                PRIME)
              mstore(0x2480, val)
              }


              {
              // cpu/decode/flag_op1_base_op0_0 = 1 - (cpu__decode__opcode_rc__bit_2 + cpu__decode__opcode_rc__bit_4 + cpu__decode__opcode_rc__bit_3).
              let val := addmod(
                1,
                sub(
                  PRIME,
                  addmod(
                    addmod(
                      /*intermediate_value/cpu/decode/opcode_rc/bit_2*/ mload(0x2440),
                      /*intermediate_value/cpu/decode/opcode_rc/bit_4*/ mload(0x2460),
                      PRIME),
                    /*intermediate_value/cpu/decode/opcode_rc/bit_3*/ mload(0x2480),
                    PRIME)),
                PRIME)
              mstore(0x24a0, val)
              }


              {
              // cpu/decode/opcode_rc/bit_5 = column0_row5 - (column0_row6 + column0_row6).
              let val := addmod(
                /*column0_row5*/ mload(0x600),
                sub(
                  PRIME,
                  addmod(/*column0_row6*/ mload(0x620), /*column0_row6*/ mload(0x620), PRIME)),
                PRIME)
              mstore(0x24c0, val)
              }


              {
              // cpu/decode/opcode_rc/bit_6 = column0_row6 - (column0_row7 + column0_row7).
              let val := addmod(
                /*column0_row6*/ mload(0x620),
                sub(
                  PRIME,
                  addmod(/*column0_row7*/ mload(0x640), /*column0_row7*/ mload(0x640), PRIME)),
                PRIME)
              mstore(0x24e0, val)
              }


              {
              // cpu/decode/opcode_rc/bit_9 = column0_row9 - (column0_row10 + column0_row10).
              let val := addmod(
                /*column0_row9*/ mload(0x680),
                sub(
                  PRIME,
                  addmod(/*column0_row10*/ mload(0x6a0), /*column0_row10*/ mload(0x6a0), PRIME)),
                PRIME)
              mstore(0x2500, val)
              }


              {
              // cpu/decode/flag_res_op1_0 = 1 - (cpu__decode__opcode_rc__bit_5 + cpu__decode__opcode_rc__bit_6 + cpu__decode__opcode_rc__bit_9).
              let val := addmod(
                1,
                sub(
                  PRIME,
                  addmod(
                    addmod(
                      /*intermediate_value/cpu/decode/opcode_rc/bit_5*/ mload(0x24c0),
                      /*intermediate_value/cpu/decode/opcode_rc/bit_6*/ mload(0x24e0),
                      PRIME),
                    /*intermediate_value/cpu/decode/opcode_rc/bit_9*/ mload(0x2500),
                    PRIME)),
                PRIME)
              mstore(0x2520, val)
              }


              {
              // cpu/decode/opcode_rc/bit_7 = column0_row7 - (column0_row8 + column0_row8).
              let val := addmod(
                /*column0_row7*/ mload(0x640),
                sub(
                  PRIME,
                  addmod(/*column0_row8*/ mload(0x660), /*column0_row8*/ mload(0x660), PRIME)),
                PRIME)
              mstore(0x2540, val)
              }


              {
              // cpu/decode/opcode_rc/bit_8 = column0_row8 - (column0_row9 + column0_row9).
              let val := addmod(
                /*column0_row8*/ mload(0x660),
                sub(
                  PRIME,
                  addmod(/*column0_row9*/ mload(0x680), /*column0_row9*/ mload(0x680), PRIME)),
                PRIME)
              mstore(0x2560, val)
              }


              {
              // cpu/decode/flag_pc_update_regular_0 = 1 - (cpu__decode__opcode_rc__bit_7 + cpu__decode__opcode_rc__bit_8 + cpu__decode__opcode_rc__bit_9).
              let val := addmod(
                1,
                sub(
                  PRIME,
                  addmod(
                    addmod(
                      /*intermediate_value/cpu/decode/opcode_rc/bit_7*/ mload(0x2540),
                      /*intermediate_value/cpu/decode/opcode_rc/bit_8*/ mload(0x2560),
                      PRIME),
                    /*intermediate_value/cpu/decode/opcode_rc/bit_9*/ mload(0x2500),
                    PRIME)),
                PRIME)
              mstore(0x2580, val)
              }


              {
              // cpu/decode/opcode_rc/bit_12 = column0_row12 - (column0_row13 + column0_row13).
              let val := addmod(
                /*column0_row12*/ mload(0x6e0),
                sub(
                  PRIME,
                  addmod(/*column0_row13*/ mload(0x700), /*column0_row13*/ mload(0x700), PRIME)),
                PRIME)
              mstore(0x25a0, val)
              }


              {
              // cpu/decode/opcode_rc/bit_13 = column0_row13 - (column0_row14 + column0_row14).
              let val := addmod(
                /*column0_row13*/ mload(0x700),
                sub(
                  PRIME,
                  addmod(/*column0_row14*/ mload(0x720), /*column0_row14*/ mload(0x720), PRIME)),
                PRIME)
              mstore(0x25c0, val)
              }


              {
              // cpu/decode/fp_update_regular_0 = 1 - (cpu__decode__opcode_rc__bit_12 + cpu__decode__opcode_rc__bit_13).
              let val := addmod(
                1,
                sub(
                  PRIME,
                  addmod(
                    /*intermediate_value/cpu/decode/opcode_rc/bit_12*/ mload(0x25a0),
                    /*intermediate_value/cpu/decode/opcode_rc/bit_13*/ mload(0x25c0),
                    PRIME)),
                PRIME)
              mstore(0x25e0, val)
              }


              {
              // cpu/decode/opcode_rc/bit_1 = column0_row1 - (column0_row2 + column0_row2).
              let val := addmod(
                /*column0_row1*/ mload(0x580),
                sub(
                  PRIME,
                  addmod(/*column0_row2*/ mload(0x5a0), /*column0_row2*/ mload(0x5a0), PRIME)),
                PRIME)
              mstore(0x2600, val)
              }


              {
              // npc_reg_0 = column17_row0 + cpu__decode__opcode_rc__bit_2 + 1.
              let val := addmod(
                addmod(
                  /*column17_row0*/ mload(0x1160),
                  /*intermediate_value/cpu/decode/opcode_rc/bit_2*/ mload(0x2440),
                  PRIME),
                1,
                PRIME)
              mstore(0x2620, val)
              }


              {
              // cpu/decode/opcode_rc/bit_10 = column0_row10 - (column0_row11 + column0_row11).
              let val := addmod(
                /*column0_row10*/ mload(0x6a0),
                sub(
                  PRIME,
                  addmod(/*column0_row11*/ mload(0x6c0), /*column0_row11*/ mload(0x6c0), PRIME)),
                PRIME)
              mstore(0x2640, val)
              }


              {
              // cpu/decode/opcode_rc/bit_11 = column0_row11 - (column0_row12 + column0_row12).
              let val := addmod(
                /*column0_row11*/ mload(0x6c0),
                sub(
                  PRIME,
                  addmod(/*column0_row12*/ mload(0x6e0), /*column0_row12*/ mload(0x6e0), PRIME)),
                PRIME)
              mstore(0x2660, val)
              }


              {
              // cpu/decode/opcode_rc/bit_14 = column0_row14 - (column0_row15 + column0_row15).
              let val := addmod(
                /*column0_row14*/ mload(0x720),
                sub(
                  PRIME,
                  addmod(/*column0_row15*/ mload(0x740), /*column0_row15*/ mload(0x740), PRIME)),
                PRIME)
              mstore(0x2680, val)
              }


              {
              // memory/address_diff_0 = column18_row2 - column18_row0.
              let val := addmod(/*column18_row2*/ mload(0x1720), sub(PRIME, /*column18_row0*/ mload(0x16e0)), PRIME)
              mstore(0x26a0, val)
              }


              {
              // rc16/diff_0 = column19_row6 - column19_row2.
              let val := addmod(/*column19_row6*/ mload(0x1820), sub(PRIME, /*column19_row2*/ mload(0x17a0)), PRIME)
              mstore(0x26c0, val)
              }


              {
              // pedersen/hash0/ec_subset_sum/bit_0 = column3_row0 - (column3_row1 + column3_row1).
              let val := addmod(
                /*column3_row0*/ mload(0x880),
                sub(
                  PRIME,
                  addmod(/*column3_row1*/ mload(0x8a0), /*column3_row1*/ mload(0x8a0), PRIME)),
                PRIME)
              mstore(0x26e0, val)
              }


              {
              // pedersen/hash0/ec_subset_sum/bit_neg_0 = 1 - pedersen__hash0__ec_subset_sum__bit_0.
              let val := addmod(
                1,
                sub(PRIME, /*intermediate_value/pedersen/hash0/ec_subset_sum/bit_0*/ mload(0x26e0)),
                PRIME)
              mstore(0x2700, val)
              }


              {
              // pedersen/hash1/ec_subset_sum/bit_0 = column6_row0 - (column6_row1 + column6_row1).
              let val := addmod(
                /*column6_row0*/ mload(0xac0),
                sub(
                  PRIME,
                  addmod(/*column6_row1*/ mload(0xae0), /*column6_row1*/ mload(0xae0), PRIME)),
                PRIME)
              mstore(0x2720, val)
              }


              {
              // pedersen/hash1/ec_subset_sum/bit_neg_0 = 1 - pedersen__hash1__ec_subset_sum__bit_0.
              let val := addmod(
                1,
                sub(PRIME, /*intermediate_value/pedersen/hash1/ec_subset_sum/bit_0*/ mload(0x2720)),
                PRIME)
              mstore(0x2740, val)
              }


              {
              // pedersen/hash2/ec_subset_sum/bit_0 = column9_row0 - (column9_row1 + column9_row1).
              let val := addmod(
                /*column9_row0*/ mload(0xd00),
                sub(
                  PRIME,
                  addmod(/*column9_row1*/ mload(0xd20), /*column9_row1*/ mload(0xd20), PRIME)),
                PRIME)
              mstore(0x2760, val)
              }


              {
              // pedersen/hash2/ec_subset_sum/bit_neg_0 = 1 - pedersen__hash2__ec_subset_sum__bit_0.
              let val := addmod(
                1,
                sub(PRIME, /*intermediate_value/pedersen/hash2/ec_subset_sum/bit_0*/ mload(0x2760)),
                PRIME)
              mstore(0x2780, val)
              }


              {
              // pedersen/hash3/ec_subset_sum/bit_0 = column12_row0 - (column12_row1 + column12_row1).
              let val := addmod(
                /*column12_row0*/ mload(0xf40),
                sub(
                  PRIME,
                  addmod(/*column12_row1*/ mload(0xf60), /*column12_row1*/ mload(0xf60), PRIME)),
                PRIME)
              mstore(0x27a0, val)
              }


              {
              // pedersen/hash3/ec_subset_sum/bit_neg_0 = 1 - pedersen__hash3__ec_subset_sum__bit_0.
              let val := addmod(
                1,
                sub(PRIME, /*intermediate_value/pedersen/hash3/ec_subset_sum/bit_0*/ mload(0x27a0)),
                PRIME)
              mstore(0x27c0, val)
              }


              {
              // rc_builtin/value0_0 = column19_row12.
              let val := /*column19_row12*/ mload(0x18c0)
              mstore(0x27e0, val)
              }


              {
              // rc_builtin/value1_0 = rc_builtin__value0_0 * offset_size + column19_row28.
              let val := addmod(
                mulmod(
                  /*intermediate_value/rc_builtin/value0_0*/ mload(0x27e0),
                  /*offset_size*/ mload(0xa0),
                  PRIME),
                /*column19_row28*/ mload(0x1980),
                PRIME)
              mstore(0x2800, val)
              }


              {
              // rc_builtin/value2_0 = rc_builtin__value1_0 * offset_size + column19_row44.
              let val := addmod(
                mulmod(
                  /*intermediate_value/rc_builtin/value1_0*/ mload(0x2800),
                  /*offset_size*/ mload(0xa0),
                  PRIME),
                /*column19_row44*/ mload(0x19c0),
                PRIME)
              mstore(0x2820, val)
              }


              {
              // rc_builtin/value3_0 = rc_builtin__value2_0 * offset_size + column19_row60.
              let val := addmod(
                mulmod(
                  /*intermediate_value/rc_builtin/value2_0*/ mload(0x2820),
                  /*offset_size*/ mload(0xa0),
                  PRIME),
                /*column19_row60*/ mload(0x1a00),
                PRIME)
              mstore(0x2840, val)
              }


              {
              // rc_builtin/value4_0 = rc_builtin__value3_0 * offset_size + column19_row76.
              let val := addmod(
                mulmod(
                  /*intermediate_value/rc_builtin/value3_0*/ mload(0x2840),
                  /*offset_size*/ mload(0xa0),
                  PRIME),
                /*column19_row76*/ mload(0x1a40),
                PRIME)
              mstore(0x2860, val)
              }


              {
              // rc_builtin/value5_0 = rc_builtin__value4_0 * offset_size + column19_row92.
              let val := addmod(
                mulmod(
                  /*intermediate_value/rc_builtin/value4_0*/ mload(0x2860),
                  /*offset_size*/ mload(0xa0),
                  PRIME),
                /*column19_row92*/ mload(0x1a80),
                PRIME)
              mstore(0x2880, val)
              }


              {
              // rc_builtin/value6_0 = rc_builtin__value5_0 * offset_size + column19_row108.
              let val := addmod(
                mulmod(
                  /*intermediate_value/rc_builtin/value5_0*/ mload(0x2880),
                  /*offset_size*/ mload(0xa0),
                  PRIME),
                /*column19_row108*/ mload(0x1ac0),
                PRIME)
              mstore(0x28a0, val)
              }


              {
              // rc_builtin/value7_0 = rc_builtin__value6_0 * offset_size + column19_row124.
              let val := addmod(
                mulmod(
                  /*intermediate_value/rc_builtin/value6_0*/ mload(0x28a0),
                  /*offset_size*/ mload(0xa0),
                  PRIME),
                /*column19_row124*/ mload(0x1b00),
                PRIME)
              mstore(0x28c0, val)
              }


              {
              // ecdsa/signature0/doubling_key/x_squared = column20_row4 * column20_row4.
              let val := mulmod(/*column20_row4*/ mload(0x1e60), /*column20_row4*/ mload(0x1e60), PRIME)
              mstore(0x28e0, val)
              }


              {
              // ecdsa/signature0/exponentiate_generator/bit_0 = column20_row13 - (column20_row45 + column20_row45).
              let val := addmod(
                /*column20_row13*/ mload(0x1f40),
                sub(
                  PRIME,
                  addmod(/*column20_row45*/ mload(0x20a0), /*column20_row45*/ mload(0x20a0), PRIME)),
                PRIME)
              mstore(0x2900, val)
              }


              {
              // ecdsa/signature0/exponentiate_generator/bit_neg_0 = 1 - ecdsa__signature0__exponentiate_generator__bit_0.
              let val := addmod(
                1,
                sub(
                  PRIME,
                  /*intermediate_value/ecdsa/signature0/exponentiate_generator/bit_0*/ mload(0x2900)),
                PRIME)
              mstore(0x2920, val)
              }


              {
              // ecdsa/signature0/exponentiate_key/bit_0 = column20_row6 - (column20_row22 + column20_row22).
              let val := addmod(
                /*column20_row6*/ mload(0x1ea0),
                sub(
                  PRIME,
                  addmod(/*column20_row22*/ mload(0x2000), /*column20_row22*/ mload(0x2000), PRIME)),
                PRIME)
              mstore(0x2940, val)
              }


              {
              // ecdsa/signature0/exponentiate_key/bit_neg_0 = 1 - ecdsa__signature0__exponentiate_key__bit_0.
              let val := addmod(
                1,
                sub(
                  PRIME,
                  /*intermediate_value/ecdsa/signature0/exponentiate_key/bit_0*/ mload(0x2940)),
                PRIME)
              mstore(0x2960, val)
              }


              {
              // bitwise/sum_var_0_0 = column19_row1 + column19_row17 * 2 + column19_row33 * 4 + column19_row49 * 8 + column19_row65 * 18446744073709551616 + column19_row81 * 36893488147419103232 + column19_row97 * 73786976294838206464 + column19_row113 * 147573952589676412928.
              let val := addmod(
                addmod(
                  addmod(
                    addmod(
                      addmod(
                        addmod(
                          addmod(
                            /*column19_row1*/ mload(0x1780),
                            mulmod(/*column19_row17*/ mload(0x1920), 2, PRIME),
                            PRIME),
                          mulmod(/*column19_row33*/ mload(0x19a0), 4, PRIME),
                          PRIME),
                        mulmod(/*column19_row49*/ mload(0x19e0), 8, PRIME),
                        PRIME),
                      mulmod(/*column19_row65*/ mload(0x1a20), 18446744073709551616, PRIME),
                      PRIME),
                    mulmod(/*column19_row81*/ mload(0x1a60), 36893488147419103232, PRIME),
                    PRIME),
                  mulmod(/*column19_row97*/ mload(0x1aa0), 73786976294838206464, PRIME),
                  PRIME),
                mulmod(/*column19_row113*/ mload(0x1ae0), 147573952589676412928, PRIME),
                PRIME)
              mstore(0x2980, val)
              }


              {
              // bitwise/sum_var_8_0 = column19_row129 * 340282366920938463463374607431768211456 + column19_row145 * 680564733841876926926749214863536422912 + column19_row161 * 1361129467683753853853498429727072845824 + column19_row177 * 2722258935367507707706996859454145691648 + column19_row193 * 6277101735386680763835789423207666416102355444464034512896 + column19_row209 * 12554203470773361527671578846415332832204710888928069025792 + column19_row225 * 25108406941546723055343157692830665664409421777856138051584 + column19_row241 * 50216813883093446110686315385661331328818843555712276103168.
              let val := addmod(
                addmod(
                  addmod(
                    addmod(
                      addmod(
                        addmod(
                          addmod(
                            mulmod(/*column19_row129*/ mload(0x1b20), 340282366920938463463374607431768211456, PRIME),
                            mulmod(/*column19_row145*/ mload(0x1b40), 680564733841876926926749214863536422912, PRIME),
                            PRIME),
                          mulmod(/*column19_row161*/ mload(0x1b60), 1361129467683753853853498429727072845824, PRIME),
                          PRIME),
                        mulmod(/*column19_row177*/ mload(0x1b80), 2722258935367507707706996859454145691648, PRIME),
                        PRIME),
                      mulmod(
                        /*column19_row193*/ mload(0x1ba0),
                        6277101735386680763835789423207666416102355444464034512896,
                        PRIME),
                      PRIME),
                    mulmod(
                      /*column19_row209*/ mload(0x1bc0),
                      12554203470773361527671578846415332832204710888928069025792,
                      PRIME),
                    PRIME),
                  mulmod(
                    /*column19_row225*/ mload(0x1be0),
                    25108406941546723055343157692830665664409421777856138051584,
                    PRIME),
                  PRIME),
                mulmod(
                  /*column19_row241*/ mload(0x1c00),
                  50216813883093446110686315385661331328818843555712276103168,
                  PRIME),
                PRIME)
              mstore(0x29a0, val)
              }


              let composition_alpha_pow := 1
              let composition_alpha := /*composition_alpha*/ mload(0x540)
              {
              // Constraint expression for cpu/decode/opcode_rc/bit: cpu__decode__opcode_rc__bit_0 * cpu__decode__opcode_rc__bit_0 - cpu__decode__opcode_rc__bit_0.
              let val := addmod(
                mulmod(
                  /*intermediate_value/cpu/decode/opcode_rc/bit_0*/ mload(0x2420),
                  /*intermediate_value/cpu/decode/opcode_rc/bit_0*/ mload(0x2420),
                  PRIME),
                sub(PRIME, /*intermediate_value/cpu/decode/opcode_rc/bit_0*/ mload(0x2420)),
                PRIME)

              // Numerator: point^(trace_length / 16) - trace_generator^(15 * trace_length / 16).
              // val *= domains[4].
              val := mulmod(val, /*domains[4]*/ mload(0x2f40), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x3280), PRIME)

              // res += val * alpha ** 0.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/decode/opcode_rc/zero: column0_row0.
              let val := /*column0_row0*/ mload(0x560)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 16) - trace_generator^(15 * trace_length / 16).
              // val *= denominator_invs[1].
              val := mulmod(val, /*denominator_invs[1]*/ mload(0x32a0), PRIME)

              // res += val * alpha ** 1.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/decode/opcode_rc_input: column17_row1 - (((column0_row0 * offset_size + column19_row4) * offset_size + column19_row8) * offset_size + column19_row0).
              let val := addmod(
                /*column17_row1*/ mload(0x1180),
                sub(
                  PRIME,
                  addmod(
                    mulmod(
                      addmod(
                        mulmod(
                          addmod(
                            mulmod(/*column0_row0*/ mload(0x560), /*offset_size*/ mload(0xa0), PRIME),
                            /*column19_row4*/ mload(0x17e0),
                            PRIME),
                          /*offset_size*/ mload(0xa0),
                          PRIME),
                        /*column19_row8*/ mload(0x1860),
                        PRIME),
                      /*offset_size*/ mload(0xa0),
                      PRIME),
                    /*column19_row0*/ mload(0x1760),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x32c0), PRIME)

              // res += val * alpha ** 2.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/decode/flag_op1_base_op0_bit: cpu__decode__flag_op1_base_op0_0 * cpu__decode__flag_op1_base_op0_0 - cpu__decode__flag_op1_base_op0_0.
              let val := addmod(
                mulmod(
                  /*intermediate_value/cpu/decode/flag_op1_base_op0_0*/ mload(0x24a0),
                  /*intermediate_value/cpu/decode/flag_op1_base_op0_0*/ mload(0x24a0),
                  PRIME),
                sub(PRIME, /*intermediate_value/cpu/decode/flag_op1_base_op0_0*/ mload(0x24a0)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x32c0), PRIME)

              // res += val * alpha ** 3.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/decode/flag_res_op1_bit: cpu__decode__flag_res_op1_0 * cpu__decode__flag_res_op1_0 - cpu__decode__flag_res_op1_0.
              let val := addmod(
                mulmod(
                  /*intermediate_value/cpu/decode/flag_res_op1_0*/ mload(0x2520),
                  /*intermediate_value/cpu/decode/flag_res_op1_0*/ mload(0x2520),
                  PRIME),
                sub(PRIME, /*intermediate_value/cpu/decode/flag_res_op1_0*/ mload(0x2520)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x32c0), PRIME)

              // res += val * alpha ** 4.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/decode/flag_pc_update_regular_bit: cpu__decode__flag_pc_update_regular_0 * cpu__decode__flag_pc_update_regular_0 - cpu__decode__flag_pc_update_regular_0.
              let val := addmod(
                mulmod(
                  /*intermediate_value/cpu/decode/flag_pc_update_regular_0*/ mload(0x2580),
                  /*intermediate_value/cpu/decode/flag_pc_update_regular_0*/ mload(0x2580),
                  PRIME),
                sub(PRIME, /*intermediate_value/cpu/decode/flag_pc_update_regular_0*/ mload(0x2580)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x32c0), PRIME)

              // res += val * alpha ** 5.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/decode/fp_update_regular_bit: cpu__decode__fp_update_regular_0 * cpu__decode__fp_update_regular_0 - cpu__decode__fp_update_regular_0.
              let val := addmod(
                mulmod(
                  /*intermediate_value/cpu/decode/fp_update_regular_0*/ mload(0x25e0),
                  /*intermediate_value/cpu/decode/fp_update_regular_0*/ mload(0x25e0),
                  PRIME),
                sub(PRIME, /*intermediate_value/cpu/decode/fp_update_regular_0*/ mload(0x25e0)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x32c0), PRIME)

              // res += val * alpha ** 6.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/operands/mem_dst_addr: column17_row8 + half_offset_size - (cpu__decode__opcode_rc__bit_0 * column19_row11 + (1 - cpu__decode__opcode_rc__bit_0) * column19_row3 + column19_row0).
              let val := addmod(
                addmod(/*column17_row8*/ mload(0x1260), /*half_offset_size*/ mload(0xc0), PRIME),
                sub(
                  PRIME,
                  addmod(
                    addmod(
                      mulmod(
                        /*intermediate_value/cpu/decode/opcode_rc/bit_0*/ mload(0x2420),
                        /*column19_row11*/ mload(0x18a0),
                        PRIME),
                      mulmod(
                        addmod(
                          1,
                          sub(PRIME, /*intermediate_value/cpu/decode/opcode_rc/bit_0*/ mload(0x2420)),
                          PRIME),
                        /*column19_row3*/ mload(0x17c0),
                        PRIME),
                      PRIME),
                    /*column19_row0*/ mload(0x1760),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x32c0), PRIME)

              // res += val * alpha ** 7.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/operands/mem0_addr: column17_row4 + half_offset_size - (cpu__decode__opcode_rc__bit_1 * column19_row11 + (1 - cpu__decode__opcode_rc__bit_1) * column19_row3 + column19_row8).
              let val := addmod(
                addmod(/*column17_row4*/ mload(0x11e0), /*half_offset_size*/ mload(0xc0), PRIME),
                sub(
                  PRIME,
                  addmod(
                    addmod(
                      mulmod(
                        /*intermediate_value/cpu/decode/opcode_rc/bit_1*/ mload(0x2600),
                        /*column19_row11*/ mload(0x18a0),
                        PRIME),
                      mulmod(
                        addmod(
                          1,
                          sub(PRIME, /*intermediate_value/cpu/decode/opcode_rc/bit_1*/ mload(0x2600)),
                          PRIME),
                        /*column19_row3*/ mload(0x17c0),
                        PRIME),
                      PRIME),
                    /*column19_row8*/ mload(0x1860),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x32c0), PRIME)

              // res += val * alpha ** 8.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/operands/mem1_addr: column17_row12 + half_offset_size - (cpu__decode__opcode_rc__bit_2 * column17_row0 + cpu__decode__opcode_rc__bit_4 * column19_row3 + cpu__decode__opcode_rc__bit_3 * column19_row11 + cpu__decode__flag_op1_base_op0_0 * column17_row5 + column19_row4).
              let val := addmod(
                addmod(/*column17_row12*/ mload(0x12a0), /*half_offset_size*/ mload(0xc0), PRIME),
                sub(
                  PRIME,
                  addmod(
                    addmod(
                      addmod(
                        addmod(
                          mulmod(
                            /*intermediate_value/cpu/decode/opcode_rc/bit_2*/ mload(0x2440),
                            /*column17_row0*/ mload(0x1160),
                            PRIME),
                          mulmod(
                            /*intermediate_value/cpu/decode/opcode_rc/bit_4*/ mload(0x2460),
                            /*column19_row3*/ mload(0x17c0),
                            PRIME),
                          PRIME),
                        mulmod(
                          /*intermediate_value/cpu/decode/opcode_rc/bit_3*/ mload(0x2480),
                          /*column19_row11*/ mload(0x18a0),
                          PRIME),
                        PRIME),
                      mulmod(
                        /*intermediate_value/cpu/decode/flag_op1_base_op0_0*/ mload(0x24a0),
                        /*column17_row5*/ mload(0x1200),
                        PRIME),
                      PRIME),
                    /*column19_row4*/ mload(0x17e0),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x32c0), PRIME)

              // res += val * alpha ** 9.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/operands/ops_mul: column19_row7 - column17_row5 * column17_row13.
              let val := addmod(
                /*column19_row7*/ mload(0x1840),
                sub(
                  PRIME,
                  mulmod(/*column17_row5*/ mload(0x1200), /*column17_row13*/ mload(0x12c0), PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x32c0), PRIME)

              // res += val * alpha ** 10.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/operands/res: (1 - cpu__decode__opcode_rc__bit_9) * column19_row15 - (cpu__decode__opcode_rc__bit_5 * (column17_row5 + column17_row13) + cpu__decode__opcode_rc__bit_6 * column19_row7 + cpu__decode__flag_res_op1_0 * column17_row13).
              let val := addmod(
                mulmod(
                  addmod(
                    1,
                    sub(PRIME, /*intermediate_value/cpu/decode/opcode_rc/bit_9*/ mload(0x2500)),
                    PRIME),
                  /*column19_row15*/ mload(0x1900),
                  PRIME),
                sub(
                  PRIME,
                  addmod(
                    addmod(
                      mulmod(
                        /*intermediate_value/cpu/decode/opcode_rc/bit_5*/ mload(0x24c0),
                        addmod(/*column17_row5*/ mload(0x1200), /*column17_row13*/ mload(0x12c0), PRIME),
                        PRIME),
                      mulmod(
                        /*intermediate_value/cpu/decode/opcode_rc/bit_6*/ mload(0x24e0),
                        /*column19_row7*/ mload(0x1840),
                        PRIME),
                      PRIME),
                    mulmod(
                      /*intermediate_value/cpu/decode/flag_res_op1_0*/ mload(0x2520),
                      /*column17_row13*/ mload(0x12c0),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x32c0), PRIME)

              // res += val * alpha ** 11.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/update_registers/update_pc/tmp0: column20_row0 - cpu__decode__opcode_rc__bit_9 * column17_row9.
              let val := addmod(
                /*column20_row0*/ mload(0x1de0),
                sub(
                  PRIME,
                  mulmod(
                    /*intermediate_value/cpu/decode/opcode_rc/bit_9*/ mload(0x2500),
                    /*column17_row9*/ mload(0x1280),
                    PRIME)),
                PRIME)

              // Numerator: point - trace_generator^(16 * (trace_length / 16 - 1)).
              // val *= domains[22].
              val := mulmod(val, /*domains[22]*/ mload(0x3180), PRIME)
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x32c0), PRIME)

              // res += val * alpha ** 12.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/update_registers/update_pc/tmp1: column20_row8 - column20_row0 * column19_row15.
              let val := addmod(
                /*column20_row8*/ mload(0x1ec0),
                sub(
                  PRIME,
                  mulmod(/*column20_row0*/ mload(0x1de0), /*column19_row15*/ mload(0x1900), PRIME)),
                PRIME)

              // Numerator: point - trace_generator^(16 * (trace_length / 16 - 1)).
              // val *= domains[22].
              val := mulmod(val, /*domains[22]*/ mload(0x3180), PRIME)
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x32c0), PRIME)

              // res += val * alpha ** 13.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/update_registers/update_pc/pc_cond_negative: (1 - cpu__decode__opcode_rc__bit_9) * column17_row16 + column20_row0 * (column17_row16 - (column17_row0 + column17_row13)) - (cpu__decode__flag_pc_update_regular_0 * npc_reg_0 + cpu__decode__opcode_rc__bit_7 * column19_row15 + cpu__decode__opcode_rc__bit_8 * (column17_row0 + column19_row15)).
              let val := addmod(
                addmod(
                  mulmod(
                    addmod(
                      1,
                      sub(PRIME, /*intermediate_value/cpu/decode/opcode_rc/bit_9*/ mload(0x2500)),
                      PRIME),
                    /*column17_row16*/ mload(0x12e0),
                    PRIME),
                  mulmod(
                    /*column20_row0*/ mload(0x1de0),
                    addmod(
                      /*column17_row16*/ mload(0x12e0),
                      sub(
                        PRIME,
                        addmod(/*column17_row0*/ mload(0x1160), /*column17_row13*/ mload(0x12c0), PRIME)),
                      PRIME),
                    PRIME),
                  PRIME),
                sub(
                  PRIME,
                  addmod(
                    addmod(
                      mulmod(
                        /*intermediate_value/cpu/decode/flag_pc_update_regular_0*/ mload(0x2580),
                        /*intermediate_value/npc_reg_0*/ mload(0x2620),
                        PRIME),
                      mulmod(
                        /*intermediate_value/cpu/decode/opcode_rc/bit_7*/ mload(0x2540),
                        /*column19_row15*/ mload(0x1900),
                        PRIME),
                      PRIME),
                    mulmod(
                      /*intermediate_value/cpu/decode/opcode_rc/bit_8*/ mload(0x2560),
                      addmod(/*column17_row0*/ mload(0x1160), /*column19_row15*/ mload(0x1900), PRIME),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point - trace_generator^(16 * (trace_length / 16 - 1)).
              // val *= domains[22].
              val := mulmod(val, /*domains[22]*/ mload(0x3180), PRIME)
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x32c0), PRIME)

              // res += val * alpha ** 14.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/update_registers/update_pc/pc_cond_positive: (column20_row8 - cpu__decode__opcode_rc__bit_9) * (column17_row16 - npc_reg_0).
              let val := mulmod(
                addmod(
                  /*column20_row8*/ mload(0x1ec0),
                  sub(PRIME, /*intermediate_value/cpu/decode/opcode_rc/bit_9*/ mload(0x2500)),
                  PRIME),
                addmod(
                  /*column17_row16*/ mload(0x12e0),
                  sub(PRIME, /*intermediate_value/npc_reg_0*/ mload(0x2620)),
                  PRIME),
                PRIME)

              // Numerator: point - trace_generator^(16 * (trace_length / 16 - 1)).
              // val *= domains[22].
              val := mulmod(val, /*domains[22]*/ mload(0x3180), PRIME)
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x32c0), PRIME)

              // res += val * alpha ** 15.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/update_registers/update_ap/ap_update: column19_row19 - (column19_row3 + cpu__decode__opcode_rc__bit_10 * column19_row15 + cpu__decode__opcode_rc__bit_11 + cpu__decode__opcode_rc__bit_12 * 2).
              let val := addmod(
                /*column19_row19*/ mload(0x1940),
                sub(
                  PRIME,
                  addmod(
                    addmod(
                      addmod(
                        /*column19_row3*/ mload(0x17c0),
                        mulmod(
                          /*intermediate_value/cpu/decode/opcode_rc/bit_10*/ mload(0x2640),
                          /*column19_row15*/ mload(0x1900),
                          PRIME),
                        PRIME),
                      /*intermediate_value/cpu/decode/opcode_rc/bit_11*/ mload(0x2660),
                      PRIME),
                    mulmod(/*intermediate_value/cpu/decode/opcode_rc/bit_12*/ mload(0x25a0), 2, PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point - trace_generator^(16 * (trace_length / 16 - 1)).
              // val *= domains[22].
              val := mulmod(val, /*domains[22]*/ mload(0x3180), PRIME)
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x32c0), PRIME)

              // res += val * alpha ** 16.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/update_registers/update_fp/fp_update: column19_row27 - (cpu__decode__fp_update_regular_0 * column19_row11 + cpu__decode__opcode_rc__bit_13 * column17_row9 + cpu__decode__opcode_rc__bit_12 * (column19_row3 + 2)).
              let val := addmod(
                /*column19_row27*/ mload(0x1960),
                sub(
                  PRIME,
                  addmod(
                    addmod(
                      mulmod(
                        /*intermediate_value/cpu/decode/fp_update_regular_0*/ mload(0x25e0),
                        /*column19_row11*/ mload(0x18a0),
                        PRIME),
                      mulmod(
                        /*intermediate_value/cpu/decode/opcode_rc/bit_13*/ mload(0x25c0),
                        /*column17_row9*/ mload(0x1280),
                        PRIME),
                      PRIME),
                    mulmod(
                      /*intermediate_value/cpu/decode/opcode_rc/bit_12*/ mload(0x25a0),
                      addmod(/*column19_row3*/ mload(0x17c0), 2, PRIME),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point - trace_generator^(16 * (trace_length / 16 - 1)).
              // val *= domains[22].
              val := mulmod(val, /*domains[22]*/ mload(0x3180), PRIME)
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x32c0), PRIME)

              // res += val * alpha ** 17.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/opcodes/call/push_fp: cpu__decode__opcode_rc__bit_12 * (column17_row9 - column19_row11).
              let val := mulmod(
                /*intermediate_value/cpu/decode/opcode_rc/bit_12*/ mload(0x25a0),
                addmod(
                  /*column17_row9*/ mload(0x1280),
                  sub(PRIME, /*column19_row11*/ mload(0x18a0)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x32c0), PRIME)

              // res += val * alpha ** 18.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/opcodes/call/push_pc: cpu__decode__opcode_rc__bit_12 * (column17_row5 - (column17_row0 + cpu__decode__opcode_rc__bit_2 + 1)).
              let val := mulmod(
                /*intermediate_value/cpu/decode/opcode_rc/bit_12*/ mload(0x25a0),
                addmod(
                  /*column17_row5*/ mload(0x1200),
                  sub(
                    PRIME,
                    addmod(
                      addmod(
                        /*column17_row0*/ mload(0x1160),
                        /*intermediate_value/cpu/decode/opcode_rc/bit_2*/ mload(0x2440),
                        PRIME),
                      1,
                      PRIME)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x32c0), PRIME)

              // res += val * alpha ** 19.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/opcodes/call/off0: cpu__decode__opcode_rc__bit_12 * (column19_row0 - half_offset_size).
              let val := mulmod(
                /*intermediate_value/cpu/decode/opcode_rc/bit_12*/ mload(0x25a0),
                addmod(
                  /*column19_row0*/ mload(0x1760),
                  sub(PRIME, /*half_offset_size*/ mload(0xc0)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x32c0), PRIME)

              // res += val * alpha ** 20.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/opcodes/call/off1: cpu__decode__opcode_rc__bit_12 * (column19_row8 - (half_offset_size + 1)).
              let val := mulmod(
                /*intermediate_value/cpu/decode/opcode_rc/bit_12*/ mload(0x25a0),
                addmod(
                  /*column19_row8*/ mload(0x1860),
                  sub(PRIME, addmod(/*half_offset_size*/ mload(0xc0), 1, PRIME)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x32c0), PRIME)

              // res += val * alpha ** 21.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/opcodes/call/flags: cpu__decode__opcode_rc__bit_12 * (cpu__decode__opcode_rc__bit_12 + cpu__decode__opcode_rc__bit_12 + 1 + 1 - (cpu__decode__opcode_rc__bit_0 + cpu__decode__opcode_rc__bit_1 + 4)).
              let val := mulmod(
                /*intermediate_value/cpu/decode/opcode_rc/bit_12*/ mload(0x25a0),
                addmod(
                  addmod(
                    addmod(
                      addmod(
                        /*intermediate_value/cpu/decode/opcode_rc/bit_12*/ mload(0x25a0),
                        /*intermediate_value/cpu/decode/opcode_rc/bit_12*/ mload(0x25a0),
                        PRIME),
                      1,
                      PRIME),
                    1,
                    PRIME),
                  sub(
                    PRIME,
                    addmod(
                      addmod(
                        /*intermediate_value/cpu/decode/opcode_rc/bit_0*/ mload(0x2420),
                        /*intermediate_value/cpu/decode/opcode_rc/bit_1*/ mload(0x2600),
                        PRIME),
                      4,
                      PRIME)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x32c0), PRIME)

              // res += val * alpha ** 22.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/opcodes/ret/off0: cpu__decode__opcode_rc__bit_13 * (column19_row0 + 2 - half_offset_size).
              let val := mulmod(
                /*intermediate_value/cpu/decode/opcode_rc/bit_13*/ mload(0x25c0),
                addmod(
                  addmod(/*column19_row0*/ mload(0x1760), 2, PRIME),
                  sub(PRIME, /*half_offset_size*/ mload(0xc0)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x32c0), PRIME)

              // res += val * alpha ** 23.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/opcodes/ret/off2: cpu__decode__opcode_rc__bit_13 * (column19_row4 + 1 - half_offset_size).
              let val := mulmod(
                /*intermediate_value/cpu/decode/opcode_rc/bit_13*/ mload(0x25c0),
                addmod(
                  addmod(/*column19_row4*/ mload(0x17e0), 1, PRIME),
                  sub(PRIME, /*half_offset_size*/ mload(0xc0)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x32c0), PRIME)

              // res += val * alpha ** 24.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/opcodes/ret/flags: cpu__decode__opcode_rc__bit_13 * (cpu__decode__opcode_rc__bit_7 + cpu__decode__opcode_rc__bit_0 + cpu__decode__opcode_rc__bit_3 + cpu__decode__flag_res_op1_0 - 4).
              let val := mulmod(
                /*intermediate_value/cpu/decode/opcode_rc/bit_13*/ mload(0x25c0),
                addmod(
                  addmod(
                    addmod(
                      addmod(
                        /*intermediate_value/cpu/decode/opcode_rc/bit_7*/ mload(0x2540),
                        /*intermediate_value/cpu/decode/opcode_rc/bit_0*/ mload(0x2420),
                        PRIME),
                      /*intermediate_value/cpu/decode/opcode_rc/bit_3*/ mload(0x2480),
                      PRIME),
                    /*intermediate_value/cpu/decode/flag_res_op1_0*/ mload(0x2520),
                    PRIME),
                  sub(PRIME, 4),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x32c0), PRIME)

              // res += val * alpha ** 25.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for cpu/opcodes/assert_eq/assert_eq: cpu__decode__opcode_rc__bit_14 * (column17_row9 - column19_row15).
              let val := mulmod(
                /*intermediate_value/cpu/decode/opcode_rc/bit_14*/ mload(0x2680),
                addmod(
                  /*column17_row9*/ mload(0x1280),
                  sub(PRIME, /*column19_row15*/ mload(0x1900)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x32c0), PRIME)

              // res += val * alpha ** 26.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for initial_ap: column19_row3 - initial_ap.
              let val := addmod(/*column19_row3*/ mload(0x17c0), sub(PRIME, /*initial_ap*/ mload(0xe0)), PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point - 1.
              // val *= denominator_invs[4].
              val := mulmod(val, /*denominator_invs[4]*/ mload(0x3300), PRIME)

              // res += val * alpha ** 27.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for initial_fp: column19_row11 - initial_ap.
              let val := addmod(/*column19_row11*/ mload(0x18a0), sub(PRIME, /*initial_ap*/ mload(0xe0)), PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point - 1.
              // val *= denominator_invs[4].
              val := mulmod(val, /*denominator_invs[4]*/ mload(0x3300), PRIME)

              // res += val * alpha ** 28.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for initial_pc: column17_row0 - initial_pc.
              let val := addmod(/*column17_row0*/ mload(0x1160), sub(PRIME, /*initial_pc*/ mload(0x100)), PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point - 1.
              // val *= denominator_invs[4].
              val := mulmod(val, /*denominator_invs[4]*/ mload(0x3300), PRIME)

              // res += val * alpha ** 29.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for final_ap: column19_row3 - final_ap.
              let val := addmod(/*column19_row3*/ mload(0x17c0), sub(PRIME, /*final_ap*/ mload(0x120)), PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point - trace_generator^(16 * (trace_length / 16 - 1)).
              // val *= denominator_invs[3].
              val := mulmod(val, /*denominator_invs[3]*/ mload(0x32e0), PRIME)

              // res += val * alpha ** 30.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for final_fp: column19_row11 - initial_ap.
              let val := addmod(/*column19_row11*/ mload(0x18a0), sub(PRIME, /*initial_ap*/ mload(0xe0)), PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point - trace_generator^(16 * (trace_length / 16 - 1)).
              // val *= denominator_invs[3].
              val := mulmod(val, /*denominator_invs[3]*/ mload(0x32e0), PRIME)

              // res += val * alpha ** 31.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for final_pc: column17_row0 - final_pc.
              let val := addmod(/*column17_row0*/ mload(0x1160), sub(PRIME, /*final_pc*/ mload(0x140)), PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point - trace_generator^(16 * (trace_length / 16 - 1)).
              // val *= denominator_invs[3].
              val := mulmod(val, /*denominator_invs[3]*/ mload(0x32e0), PRIME)

              // res += val * alpha ** 32.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for memory/multi_column_perm/perm/init0: (memory/multi_column_perm/perm/interaction_elm - (column18_row0 + memory/multi_column_perm/hash_interaction_elm0 * column18_row1)) * column21_inter1_row0 + column17_row0 + memory/multi_column_perm/hash_interaction_elm0 * column17_row1 - memory/multi_column_perm/perm/interaction_elm.
              let val := addmod(
                addmod(
                  addmod(
                    mulmod(
                      addmod(
                        /*memory/multi_column_perm/perm/interaction_elm*/ mload(0x160),
                        sub(
                          PRIME,
                          addmod(
                            /*column18_row0*/ mload(0x16e0),
                            mulmod(
                              /*memory/multi_column_perm/hash_interaction_elm0*/ mload(0x180),
                              /*column18_row1*/ mload(0x1700),
                              PRIME),
                            PRIME)),
                        PRIME),
                      /*column21_inter1_row0*/ mload(0x2320),
                      PRIME),
                    /*column17_row0*/ mload(0x1160),
                    PRIME),
                  mulmod(
                    /*memory/multi_column_perm/hash_interaction_elm0*/ mload(0x180),
                    /*column17_row1*/ mload(0x1180),
                    PRIME),
                  PRIME),
                sub(PRIME, /*memory/multi_column_perm/perm/interaction_elm*/ mload(0x160)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point - 1.
              // val *= denominator_invs[4].
              val := mulmod(val, /*denominator_invs[4]*/ mload(0x3300), PRIME)

              // res += val * alpha ** 33.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for memory/multi_column_perm/perm/step0: (memory/multi_column_perm/perm/interaction_elm - (column18_row2 + memory/multi_column_perm/hash_interaction_elm0 * column18_row3)) * column21_inter1_row2 - (memory/multi_column_perm/perm/interaction_elm - (column17_row2 + memory/multi_column_perm/hash_interaction_elm0 * column17_row3)) * column21_inter1_row0.
              let val := addmod(
                mulmod(
                  addmod(
                    /*memory/multi_column_perm/perm/interaction_elm*/ mload(0x160),
                    sub(
                      PRIME,
                      addmod(
                        /*column18_row2*/ mload(0x1720),
                        mulmod(
                          /*memory/multi_column_perm/hash_interaction_elm0*/ mload(0x180),
                          /*column18_row3*/ mload(0x1740),
                          PRIME),
                        PRIME)),
                    PRIME),
                  /*column21_inter1_row2*/ mload(0x2360),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    addmod(
                      /*memory/multi_column_perm/perm/interaction_elm*/ mload(0x160),
                      sub(
                        PRIME,
                        addmod(
                          /*column17_row2*/ mload(0x11a0),
                          mulmod(
                            /*memory/multi_column_perm/hash_interaction_elm0*/ mload(0x180),
                            /*column17_row3*/ mload(0x11c0),
                            PRIME),
                          PRIME)),
                      PRIME),
                    /*column21_inter1_row0*/ mload(0x2320),
                    PRIME)),
                PRIME)

              // Numerator: point - trace_generator^(2 * (trace_length / 2 - 1)).
              // val *= domains[24].
              val := mulmod(val, /*domains[24]*/ mload(0x31c0), PRIME)
              // Denominator: point^(trace_length / 2) - 1.
              // val *= denominator_invs[5].
              val := mulmod(val, /*denominator_invs[5]*/ mload(0x3320), PRIME)

              // res += val * alpha ** 34.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for memory/multi_column_perm/perm/last: column21_inter1_row0 - memory/multi_column_perm/perm/public_memory_prod.
              let val := addmod(
                /*column21_inter1_row0*/ mload(0x2320),
                sub(PRIME, /*memory/multi_column_perm/perm/public_memory_prod*/ mload(0x1a0)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point - trace_generator^(2 * (trace_length / 2 - 1)).
              // val *= denominator_invs[6].
              val := mulmod(val, /*denominator_invs[6]*/ mload(0x3340), PRIME)

              // res += val * alpha ** 35.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for memory/diff_is_bit: memory__address_diff_0 * memory__address_diff_0 - memory__address_diff_0.
              let val := addmod(
                mulmod(
                  /*intermediate_value/memory/address_diff_0*/ mload(0x26a0),
                  /*intermediate_value/memory/address_diff_0*/ mload(0x26a0),
                  PRIME),
                sub(PRIME, /*intermediate_value/memory/address_diff_0*/ mload(0x26a0)),
                PRIME)

              // Numerator: point - trace_generator^(2 * (trace_length / 2 - 1)).
              // val *= domains[24].
              val := mulmod(val, /*domains[24]*/ mload(0x31c0), PRIME)
              // Denominator: point^(trace_length / 2) - 1.
              // val *= denominator_invs[5].
              val := mulmod(val, /*denominator_invs[5]*/ mload(0x3320), PRIME)

              // res += val * alpha ** 36.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for memory/is_func: (memory__address_diff_0 - 1) * (column18_row1 - column18_row3).
              let val := mulmod(
                addmod(/*intermediate_value/memory/address_diff_0*/ mload(0x26a0), sub(PRIME, 1), PRIME),
                addmod(/*column18_row1*/ mload(0x1700), sub(PRIME, /*column18_row3*/ mload(0x1740)), PRIME),
                PRIME)

              // Numerator: point - trace_generator^(2 * (trace_length / 2 - 1)).
              // val *= domains[24].
              val := mulmod(val, /*domains[24]*/ mload(0x31c0), PRIME)
              // Denominator: point^(trace_length / 2) - 1.
              // val *= denominator_invs[5].
              val := mulmod(val, /*denominator_invs[5]*/ mload(0x3320), PRIME)

              // res += val * alpha ** 37.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for memory/initial_addr: column18_row0 - 1.
              let val := addmod(/*column18_row0*/ mload(0x16e0), sub(PRIME, 1), PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point - 1.
              // val *= denominator_invs[4].
              val := mulmod(val, /*denominator_invs[4]*/ mload(0x3300), PRIME)

              // res += val * alpha ** 38.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for public_memory_addr_zero: column17_row2.
              let val := /*column17_row2*/ mload(0x11a0)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 8) - 1.
              // val *= denominator_invs[7].
              val := mulmod(val, /*denominator_invs[7]*/ mload(0x3360), PRIME)

              // res += val * alpha ** 39.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for public_memory_value_zero: column17_row3.
              let val := /*column17_row3*/ mload(0x11c0)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 8) - 1.
              // val *= denominator_invs[7].
              val := mulmod(val, /*denominator_invs[7]*/ mload(0x3360), PRIME)

              // res += val * alpha ** 40.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for rc16/perm/init0: (rc16/perm/interaction_elm - column19_row2) * column21_inter1_row1 + column19_row0 - rc16/perm/interaction_elm.
              let val := addmod(
                addmod(
                  mulmod(
                    addmod(
                      /*rc16/perm/interaction_elm*/ mload(0x1c0),
                      sub(PRIME, /*column19_row2*/ mload(0x17a0)),
                      PRIME),
                    /*column21_inter1_row1*/ mload(0x2340),
                    PRIME),
                  /*column19_row0*/ mload(0x1760),
                  PRIME),
                sub(PRIME, /*rc16/perm/interaction_elm*/ mload(0x1c0)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point - 1.
              // val *= denominator_invs[4].
              val := mulmod(val, /*denominator_invs[4]*/ mload(0x3300), PRIME)

              // res += val * alpha ** 41.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for rc16/perm/step0: (rc16/perm/interaction_elm - column19_row6) * column21_inter1_row5 - (rc16/perm/interaction_elm - column19_row4) * column21_inter1_row1.
              let val := addmod(
                mulmod(
                  addmod(
                    /*rc16/perm/interaction_elm*/ mload(0x1c0),
                    sub(PRIME, /*column19_row6*/ mload(0x1820)),
                    PRIME),
                  /*column21_inter1_row5*/ mload(0x23a0),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    addmod(
                      /*rc16/perm/interaction_elm*/ mload(0x1c0),
                      sub(PRIME, /*column19_row4*/ mload(0x17e0)),
                      PRIME),
                    /*column21_inter1_row1*/ mload(0x2340),
                    PRIME)),
                PRIME)

              // Numerator: point - trace_generator^(4 * (trace_length / 4 - 1)).
              // val *= domains[25].
              val := mulmod(val, /*domains[25]*/ mload(0x31e0), PRIME)
              // Denominator: point^(trace_length / 4) - 1.
              // val *= denominator_invs[8].
              val := mulmod(val, /*denominator_invs[8]*/ mload(0x3380), PRIME)

              // res += val * alpha ** 42.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for rc16/perm/last: column21_inter1_row1 - rc16/perm/public_memory_prod.
              let val := addmod(
                /*column21_inter1_row1*/ mload(0x2340),
                sub(PRIME, /*rc16/perm/public_memory_prod*/ mload(0x1e0)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point - trace_generator^(4 * (trace_length / 4 - 1)).
              // val *= denominator_invs[9].
              val := mulmod(val, /*denominator_invs[9]*/ mload(0x33a0), PRIME)

              // res += val * alpha ** 43.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for rc16/diff_is_bit: rc16__diff_0 * rc16__diff_0 - rc16__diff_0.
              let val := addmod(
                mulmod(
                  /*intermediate_value/rc16/diff_0*/ mload(0x26c0),
                  /*intermediate_value/rc16/diff_0*/ mload(0x26c0),
                  PRIME),
                sub(PRIME, /*intermediate_value/rc16/diff_0*/ mload(0x26c0)),
                PRIME)

              // Numerator: point - trace_generator^(4 * (trace_length / 4 - 1)).
              // val *= domains[25].
              val := mulmod(val, /*domains[25]*/ mload(0x31e0), PRIME)
              // Denominator: point^(trace_length / 4) - 1.
              // val *= denominator_invs[8].
              val := mulmod(val, /*denominator_invs[8]*/ mload(0x3380), PRIME)

              // res += val * alpha ** 44.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for rc16/minimum: column19_row2 - rc_min.
              let val := addmod(/*column19_row2*/ mload(0x17a0), sub(PRIME, /*rc_min*/ mload(0x200)), PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point - 1.
              // val *= denominator_invs[4].
              val := mulmod(val, /*denominator_invs[4]*/ mload(0x3300), PRIME)

              // res += val * alpha ** 45.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for rc16/maximum: column19_row2 - rc_max.
              let val := addmod(/*column19_row2*/ mload(0x17a0), sub(PRIME, /*rc_max*/ mload(0x220)), PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point - trace_generator^(4 * (trace_length / 4 - 1)).
              // val *= denominator_invs[9].
              val := mulmod(val, /*denominator_invs[9]*/ mload(0x33a0), PRIME)

              // res += val * alpha ** 46.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for diluted_check/permutation/init0: (diluted_check/permutation/interaction_elm - column19_row5) * column21_inter1_row7 + column19_row1 - diluted_check/permutation/interaction_elm.
              let val := addmod(
                addmod(
                  mulmod(
                    addmod(
                      /*diluted_check/permutation/interaction_elm*/ mload(0x240),
                      sub(PRIME, /*column19_row5*/ mload(0x1800)),
                      PRIME),
                    /*column21_inter1_row7*/ mload(0x23c0),
                    PRIME),
                  /*column19_row1*/ mload(0x1780),
                  PRIME),
                sub(PRIME, /*diluted_check/permutation/interaction_elm*/ mload(0x240)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point - 1.
              // val *= denominator_invs[4].
              val := mulmod(val, /*denominator_invs[4]*/ mload(0x3300), PRIME)

              // res += val * alpha ** 47.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for diluted_check/permutation/step0: (diluted_check/permutation/interaction_elm - column19_row13) * column21_inter1_row15 - (diluted_check/permutation/interaction_elm - column19_row9) * column21_inter1_row7.
              let val := addmod(
                mulmod(
                  addmod(
                    /*diluted_check/permutation/interaction_elm*/ mload(0x240),
                    sub(PRIME, /*column19_row13*/ mload(0x18e0)),
                    PRIME),
                  /*column21_inter1_row15*/ mload(0x2400),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    addmod(
                      /*diluted_check/permutation/interaction_elm*/ mload(0x240),
                      sub(PRIME, /*column19_row9*/ mload(0x1880)),
                      PRIME),
                    /*column21_inter1_row7*/ mload(0x23c0),
                    PRIME)),
                PRIME)

              // Numerator: point - trace_generator^(8 * (trace_length / 8 - 1)).
              // val *= domains[26].
              val := mulmod(val, /*domains[26]*/ mload(0x3200), PRIME)
              // Denominator: point^(trace_length / 8) - 1.
              // val *= denominator_invs[7].
              val := mulmod(val, /*denominator_invs[7]*/ mload(0x3360), PRIME)

              // res += val * alpha ** 48.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for diluted_check/permutation/last: column21_inter1_row7 - diluted_check/permutation/public_memory_prod.
              let val := addmod(
                /*column21_inter1_row7*/ mload(0x23c0),
                sub(PRIME, /*diluted_check/permutation/public_memory_prod*/ mload(0x260)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point - trace_generator^(8 * (trace_length / 8 - 1)).
              // val *= denominator_invs[10].
              val := mulmod(val, /*denominator_invs[10]*/ mload(0x33c0), PRIME)

              // res += val * alpha ** 49.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for diluted_check/init: column21_inter1_row3 - 1.
              let val := addmod(/*column21_inter1_row3*/ mload(0x2380), sub(PRIME, 1), PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point - 1.
              // val *= denominator_invs[4].
              val := mulmod(val, /*denominator_invs[4]*/ mload(0x3300), PRIME)

              // res += val * alpha ** 50.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for diluted_check/first_element: column19_row5 - diluted_check/first_elm.
              let val := addmod(
                /*column19_row5*/ mload(0x1800),
                sub(PRIME, /*diluted_check/first_elm*/ mload(0x280)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point - 1.
              // val *= denominator_invs[4].
              val := mulmod(val, /*denominator_invs[4]*/ mload(0x3300), PRIME)

              // res += val * alpha ** 51.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for diluted_check/step: column21_inter1_row11 - (column21_inter1_row3 * (1 + diluted_check/interaction_z * (column19_row13 - column19_row5)) + diluted_check/interaction_alpha * (column19_row13 - column19_row5) * (column19_row13 - column19_row5)).
              let val := addmod(
                /*column21_inter1_row11*/ mload(0x23e0),
                sub(
                  PRIME,
                  addmod(
                    mulmod(
                      /*column21_inter1_row3*/ mload(0x2380),
                      addmod(
                        1,
                        mulmod(
                          /*diluted_check/interaction_z*/ mload(0x2a0),
                          addmod(
                            /*column19_row13*/ mload(0x18e0),
                            sub(PRIME, /*column19_row5*/ mload(0x1800)),
                            PRIME),
                          PRIME),
                        PRIME),
                      PRIME),
                    mulmod(
                      mulmod(
                        /*diluted_check/interaction_alpha*/ mload(0x2c0),
                        addmod(
                          /*column19_row13*/ mload(0x18e0),
                          sub(PRIME, /*column19_row5*/ mload(0x1800)),
                          PRIME),
                        PRIME),
                      addmod(
                        /*column19_row13*/ mload(0x18e0),
                        sub(PRIME, /*column19_row5*/ mload(0x1800)),
                        PRIME),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point - trace_generator^(8 * (trace_length / 8 - 1)).
              // val *= domains[26].
              val := mulmod(val, /*domains[26]*/ mload(0x3200), PRIME)
              // Denominator: point^(trace_length / 8) - 1.
              // val *= denominator_invs[7].
              val := mulmod(val, /*denominator_invs[7]*/ mload(0x3360), PRIME)

              // res += val * alpha ** 52.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for diluted_check/last: column21_inter1_row3 - diluted_check/final_cum_val.
              let val := addmod(
                /*column21_inter1_row3*/ mload(0x2380),
                sub(PRIME, /*diluted_check/final_cum_val*/ mload(0x2e0)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point - trace_generator^(8 * (trace_length / 8 - 1)).
              // val *= denominator_invs[10].
              val := mulmod(val, /*denominator_invs[10]*/ mload(0x33c0), PRIME)

              // res += val * alpha ** 53.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash0/ec_subset_sum/bit_unpacking/last_one_is_zero: column14_row255 * (column3_row0 - (column3_row1 + column3_row1)).
              let val := mulmod(
                /*column14_row255*/ mload(0x10c0),
                addmod(
                  /*column3_row0*/ mload(0x880),
                  sub(
                    PRIME,
                    addmod(/*column3_row1*/ mload(0x8a0), /*column3_row1*/ mload(0x8a0), PRIME)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[11].
              val := mulmod(val, /*denominator_invs[11]*/ mload(0x33e0), PRIME)

              // res += val * alpha ** 54.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash0/ec_subset_sum/bit_unpacking/zeroes_between_ones0: column14_row255 * (column3_row1 - 3138550867693340381917894711603833208051177722232017256448 * column3_row192).
              let val := mulmod(
                /*column14_row255*/ mload(0x10c0),
                addmod(
                  /*column3_row1*/ mload(0x8a0),
                  sub(
                    PRIME,
                    mulmod(
                      3138550867693340381917894711603833208051177722232017256448,
                      /*column3_row192*/ mload(0x8c0),
                      PRIME)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[11].
              val := mulmod(val, /*denominator_invs[11]*/ mload(0x33e0), PRIME)

              // res += val * alpha ** 55.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash0/ec_subset_sum/bit_unpacking/cumulative_bit192: column14_row255 - column13_row255 * (column3_row192 - (column3_row193 + column3_row193)).
              let val := addmod(
                /*column14_row255*/ mload(0x10c0),
                sub(
                  PRIME,
                  mulmod(
                    /*column13_row255*/ mload(0x1080),
                    addmod(
                      /*column3_row192*/ mload(0x8c0),
                      sub(
                        PRIME,
                        addmod(/*column3_row193*/ mload(0x8e0), /*column3_row193*/ mload(0x8e0), PRIME)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[11].
              val := mulmod(val, /*denominator_invs[11]*/ mload(0x33e0), PRIME)

              // res += val * alpha ** 56.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash0/ec_subset_sum/bit_unpacking/zeroes_between_ones192: column13_row255 * (column3_row193 - 8 * column3_row196).
              let val := mulmod(
                /*column13_row255*/ mload(0x1080),
                addmod(
                  /*column3_row193*/ mload(0x8e0),
                  sub(PRIME, mulmod(8, /*column3_row196*/ mload(0x900), PRIME)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[11].
              val := mulmod(val, /*denominator_invs[11]*/ mload(0x33e0), PRIME)

              // res += val * alpha ** 57.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash0/ec_subset_sum/bit_unpacking/cumulative_bit196: column13_row255 - (column3_row251 - (column3_row252 + column3_row252)) * (column3_row196 - (column3_row197 + column3_row197)).
              let val := addmod(
                /*column13_row255*/ mload(0x1080),
                sub(
                  PRIME,
                  mulmod(
                    addmod(
                      /*column3_row251*/ mload(0x940),
                      sub(
                        PRIME,
                        addmod(/*column3_row252*/ mload(0x960), /*column3_row252*/ mload(0x960), PRIME)),
                      PRIME),
                    addmod(
                      /*column3_row196*/ mload(0x900),
                      sub(
                        PRIME,
                        addmod(/*column3_row197*/ mload(0x920), /*column3_row197*/ mload(0x920), PRIME)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[11].
              val := mulmod(val, /*denominator_invs[11]*/ mload(0x33e0), PRIME)

              // res += val * alpha ** 58.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash0/ec_subset_sum/bit_unpacking/zeroes_between_ones196: (column3_row251 - (column3_row252 + column3_row252)) * (column3_row197 - 18014398509481984 * column3_row251).
              let val := mulmod(
                addmod(
                  /*column3_row251*/ mload(0x940),
                  sub(
                    PRIME,
                    addmod(/*column3_row252*/ mload(0x960), /*column3_row252*/ mload(0x960), PRIME)),
                  PRIME),
                addmod(
                  /*column3_row197*/ mload(0x920),
                  sub(PRIME, mulmod(18014398509481984, /*column3_row251*/ mload(0x940), PRIME)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[11].
              val := mulmod(val, /*denominator_invs[11]*/ mload(0x33e0), PRIME)

              // res += val * alpha ** 59.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash0/ec_subset_sum/booleanity_test: pedersen__hash0__ec_subset_sum__bit_0 * (pedersen__hash0__ec_subset_sum__bit_0 - 1).
              let val := mulmod(
                /*intermediate_value/pedersen/hash0/ec_subset_sum/bit_0*/ mload(0x26e0),
                addmod(
                  /*intermediate_value/pedersen/hash0/ec_subset_sum/bit_0*/ mload(0x26e0),
                  sub(PRIME, 1),
                  PRIME),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[9].
              val := mulmod(val, /*domains[9]*/ mload(0x2fe0), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x3280), PRIME)

              // res += val * alpha ** 60.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash0/ec_subset_sum/bit_extraction_end: column3_row0.
              let val := /*column3_row0*/ mload(0x880)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - trace_generator^(63 * trace_length / 64).
              // val *= denominator_invs[13].
              val := mulmod(val, /*denominator_invs[13]*/ mload(0x3420), PRIME)

              // res += val * alpha ** 61.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash0/ec_subset_sum/zeros_tail: column3_row0.
              let val := /*column3_row0*/ mload(0x880)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= denominator_invs[12].
              val := mulmod(val, /*denominator_invs[12]*/ mload(0x3400), PRIME)

              // res += val * alpha ** 62.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash0/ec_subset_sum/add_points/slope: pedersen__hash0__ec_subset_sum__bit_0 * (column2_row0 - pedersen__points__y) - column13_row0 * (column1_row0 - pedersen__points__x).
              let val := addmod(
                mulmod(
                  /*intermediate_value/pedersen/hash0/ec_subset_sum/bit_0*/ mload(0x26e0),
                  addmod(
                    /*column2_row0*/ mload(0x800),
                    sub(PRIME, /*periodic_column/pedersen/points/y*/ mload(0x20)),
                    PRIME),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*column13_row0*/ mload(0x1060),
                    addmod(
                      /*column1_row0*/ mload(0x760),
                      sub(PRIME, /*periodic_column/pedersen/points/x*/ mload(0x0)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[9].
              val := mulmod(val, /*domains[9]*/ mload(0x2fe0), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x3280), PRIME)

              // res += val * alpha ** 63.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash0/ec_subset_sum/add_points/x: column13_row0 * column13_row0 - pedersen__hash0__ec_subset_sum__bit_0 * (column1_row0 + pedersen__points__x + column1_row1).
              let val := addmod(
                mulmod(/*column13_row0*/ mload(0x1060), /*column13_row0*/ mload(0x1060), PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*intermediate_value/pedersen/hash0/ec_subset_sum/bit_0*/ mload(0x26e0),
                    addmod(
                      addmod(
                        /*column1_row0*/ mload(0x760),
                        /*periodic_column/pedersen/points/x*/ mload(0x0),
                        PRIME),
                      /*column1_row1*/ mload(0x780),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[9].
              val := mulmod(val, /*domains[9]*/ mload(0x2fe0), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x3280), PRIME)

              // res += val * alpha ** 64.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash0/ec_subset_sum/add_points/y: pedersen__hash0__ec_subset_sum__bit_0 * (column2_row0 + column2_row1) - column13_row0 * (column1_row0 - column1_row1).
              let val := addmod(
                mulmod(
                  /*intermediate_value/pedersen/hash0/ec_subset_sum/bit_0*/ mload(0x26e0),
                  addmod(/*column2_row0*/ mload(0x800), /*column2_row1*/ mload(0x820), PRIME),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*column13_row0*/ mload(0x1060),
                    addmod(/*column1_row0*/ mload(0x760), sub(PRIME, /*column1_row1*/ mload(0x780)), PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[9].
              val := mulmod(val, /*domains[9]*/ mload(0x2fe0), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x3280), PRIME)

              // res += val * alpha ** 65.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash0/ec_subset_sum/copy_point/x: pedersen__hash0__ec_subset_sum__bit_neg_0 * (column1_row1 - column1_row0).
              let val := mulmod(
                /*intermediate_value/pedersen/hash0/ec_subset_sum/bit_neg_0*/ mload(0x2700),
                addmod(/*column1_row1*/ mload(0x780), sub(PRIME, /*column1_row0*/ mload(0x760)), PRIME),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[9].
              val := mulmod(val, /*domains[9]*/ mload(0x2fe0), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x3280), PRIME)

              // res += val * alpha ** 66.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash0/ec_subset_sum/copy_point/y: pedersen__hash0__ec_subset_sum__bit_neg_0 * (column2_row1 - column2_row0).
              let val := mulmod(
                /*intermediate_value/pedersen/hash0/ec_subset_sum/bit_neg_0*/ mload(0x2700),
                addmod(/*column2_row1*/ mload(0x820), sub(PRIME, /*column2_row0*/ mload(0x800)), PRIME),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[9].
              val := mulmod(val, /*domains[9]*/ mload(0x2fe0), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x3280), PRIME)

              // res += val * alpha ** 67.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash0/copy_point/x: column1_row256 - column1_row255.
              let val := addmod(/*column1_row256*/ mload(0x7c0), sub(PRIME, /*column1_row255*/ mload(0x7a0)), PRIME)

              // Numerator: point^(trace_length / 512) - trace_generator^(trace_length / 2).
              // val *= domains[11].
              val := mulmod(val, /*domains[11]*/ mload(0x3020), PRIME)
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[11].
              val := mulmod(val, /*denominator_invs[11]*/ mload(0x33e0), PRIME)

              // res += val * alpha ** 68.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash0/copy_point/y: column2_row256 - column2_row255.
              let val := addmod(/*column2_row256*/ mload(0x860), sub(PRIME, /*column2_row255*/ mload(0x840)), PRIME)

              // Numerator: point^(trace_length / 512) - trace_generator^(trace_length / 2).
              // val *= domains[11].
              val := mulmod(val, /*domains[11]*/ mload(0x3020), PRIME)
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[11].
              val := mulmod(val, /*denominator_invs[11]*/ mload(0x33e0), PRIME)

              // res += val * alpha ** 69.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash0/init/x: column1_row0 - pedersen/shift_point.x.
              let val := addmod(
                /*column1_row0*/ mload(0x760),
                sub(PRIME, /*pedersen/shift_point.x*/ mload(0x300)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[14].
              val := mulmod(val, /*denominator_invs[14]*/ mload(0x3440), PRIME)

              // res += val * alpha ** 70.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash0/init/y: column2_row0 - pedersen/shift_point.y.
              let val := addmod(
                /*column2_row0*/ mload(0x800),
                sub(PRIME, /*pedersen/shift_point.y*/ mload(0x320)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[14].
              val := mulmod(val, /*denominator_invs[14]*/ mload(0x3440), PRIME)

              // res += val * alpha ** 71.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash1/ec_subset_sum/bit_unpacking/last_one_is_zero: column16_row255 * (column6_row0 - (column6_row1 + column6_row1)).
              let val := mulmod(
                /*column16_row255*/ mload(0x1140),
                addmod(
                  /*column6_row0*/ mload(0xac0),
                  sub(
                    PRIME,
                    addmod(/*column6_row1*/ mload(0xae0), /*column6_row1*/ mload(0xae0), PRIME)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[11].
              val := mulmod(val, /*denominator_invs[11]*/ mload(0x33e0), PRIME)

              // res += val * alpha ** 72.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash1/ec_subset_sum/bit_unpacking/zeroes_between_ones0: column16_row255 * (column6_row1 - 3138550867693340381917894711603833208051177722232017256448 * column6_row192).
              let val := mulmod(
                /*column16_row255*/ mload(0x1140),
                addmod(
                  /*column6_row1*/ mload(0xae0),
                  sub(
                    PRIME,
                    mulmod(
                      3138550867693340381917894711603833208051177722232017256448,
                      /*column6_row192*/ mload(0xb00),
                      PRIME)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[11].
              val := mulmod(val, /*denominator_invs[11]*/ mload(0x33e0), PRIME)

              // res += val * alpha ** 73.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash1/ec_subset_sum/bit_unpacking/cumulative_bit192: column16_row255 - column15_row255 * (column6_row192 - (column6_row193 + column6_row193)).
              let val := addmod(
                /*column16_row255*/ mload(0x1140),
                sub(
                  PRIME,
                  mulmod(
                    /*column15_row255*/ mload(0x1100),
                    addmod(
                      /*column6_row192*/ mload(0xb00),
                      sub(
                        PRIME,
                        addmod(/*column6_row193*/ mload(0xb20), /*column6_row193*/ mload(0xb20), PRIME)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[11].
              val := mulmod(val, /*denominator_invs[11]*/ mload(0x33e0), PRIME)

              // res += val * alpha ** 74.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash1/ec_subset_sum/bit_unpacking/zeroes_between_ones192: column15_row255 * (column6_row193 - 8 * column6_row196).
              let val := mulmod(
                /*column15_row255*/ mload(0x1100),
                addmod(
                  /*column6_row193*/ mload(0xb20),
                  sub(PRIME, mulmod(8, /*column6_row196*/ mload(0xb40), PRIME)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[11].
              val := mulmod(val, /*denominator_invs[11]*/ mload(0x33e0), PRIME)

              // res += val * alpha ** 75.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash1/ec_subset_sum/bit_unpacking/cumulative_bit196: column15_row255 - (column6_row251 - (column6_row252 + column6_row252)) * (column6_row196 - (column6_row197 + column6_row197)).
              let val := addmod(
                /*column15_row255*/ mload(0x1100),
                sub(
                  PRIME,
                  mulmod(
                    addmod(
                      /*column6_row251*/ mload(0xb80),
                      sub(
                        PRIME,
                        addmod(/*column6_row252*/ mload(0xba0), /*column6_row252*/ mload(0xba0), PRIME)),
                      PRIME),
                    addmod(
                      /*column6_row196*/ mload(0xb40),
                      sub(
                        PRIME,
                        addmod(/*column6_row197*/ mload(0xb60), /*column6_row197*/ mload(0xb60), PRIME)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[11].
              val := mulmod(val, /*denominator_invs[11]*/ mload(0x33e0), PRIME)

              // res += val * alpha ** 76.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash1/ec_subset_sum/bit_unpacking/zeroes_between_ones196: (column6_row251 - (column6_row252 + column6_row252)) * (column6_row197 - 18014398509481984 * column6_row251).
              let val := mulmod(
                addmod(
                  /*column6_row251*/ mload(0xb80),
                  sub(
                    PRIME,
                    addmod(/*column6_row252*/ mload(0xba0), /*column6_row252*/ mload(0xba0), PRIME)),
                  PRIME),
                addmod(
                  /*column6_row197*/ mload(0xb60),
                  sub(PRIME, mulmod(18014398509481984, /*column6_row251*/ mload(0xb80), PRIME)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[11].
              val := mulmod(val, /*denominator_invs[11]*/ mload(0x33e0), PRIME)

              // res += val * alpha ** 77.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash1/ec_subset_sum/booleanity_test: pedersen__hash1__ec_subset_sum__bit_0 * (pedersen__hash1__ec_subset_sum__bit_0 - 1).
              let val := mulmod(
                /*intermediate_value/pedersen/hash1/ec_subset_sum/bit_0*/ mload(0x2720),
                addmod(
                  /*intermediate_value/pedersen/hash1/ec_subset_sum/bit_0*/ mload(0x2720),
                  sub(PRIME, 1),
                  PRIME),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[9].
              val := mulmod(val, /*domains[9]*/ mload(0x2fe0), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x3280), PRIME)

              // res += val * alpha ** 78.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash1/ec_subset_sum/bit_extraction_end: column6_row0.
              let val := /*column6_row0*/ mload(0xac0)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - trace_generator^(63 * trace_length / 64).
              // val *= denominator_invs[13].
              val := mulmod(val, /*denominator_invs[13]*/ mload(0x3420), PRIME)

              // res += val * alpha ** 79.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash1/ec_subset_sum/zeros_tail: column6_row0.
              let val := /*column6_row0*/ mload(0xac0)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= denominator_invs[12].
              val := mulmod(val, /*denominator_invs[12]*/ mload(0x3400), PRIME)

              // res += val * alpha ** 80.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash1/ec_subset_sum/add_points/slope: pedersen__hash1__ec_subset_sum__bit_0 * (column5_row0 - pedersen__points__y) - column14_row0 * (column4_row0 - pedersen__points__x).
              let val := addmod(
                mulmod(
                  /*intermediate_value/pedersen/hash1/ec_subset_sum/bit_0*/ mload(0x2720),
                  addmod(
                    /*column5_row0*/ mload(0xa40),
                    sub(PRIME, /*periodic_column/pedersen/points/y*/ mload(0x20)),
                    PRIME),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*column14_row0*/ mload(0x10a0),
                    addmod(
                      /*column4_row0*/ mload(0x9a0),
                      sub(PRIME, /*periodic_column/pedersen/points/x*/ mload(0x0)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[9].
              val := mulmod(val, /*domains[9]*/ mload(0x2fe0), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x3280), PRIME)

              // res += val * alpha ** 81.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash1/ec_subset_sum/add_points/x: column14_row0 * column14_row0 - pedersen__hash1__ec_subset_sum__bit_0 * (column4_row0 + pedersen__points__x + column4_row1).
              let val := addmod(
                mulmod(/*column14_row0*/ mload(0x10a0), /*column14_row0*/ mload(0x10a0), PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*intermediate_value/pedersen/hash1/ec_subset_sum/bit_0*/ mload(0x2720),
                    addmod(
                      addmod(
                        /*column4_row0*/ mload(0x9a0),
                        /*periodic_column/pedersen/points/x*/ mload(0x0),
                        PRIME),
                      /*column4_row1*/ mload(0x9c0),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[9].
              val := mulmod(val, /*domains[9]*/ mload(0x2fe0), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x3280), PRIME)

              // res += val * alpha ** 82.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash1/ec_subset_sum/add_points/y: pedersen__hash1__ec_subset_sum__bit_0 * (column5_row0 + column5_row1) - column14_row0 * (column4_row0 - column4_row1).
              let val := addmod(
                mulmod(
                  /*intermediate_value/pedersen/hash1/ec_subset_sum/bit_0*/ mload(0x2720),
                  addmod(/*column5_row0*/ mload(0xa40), /*column5_row1*/ mload(0xa60), PRIME),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*column14_row0*/ mload(0x10a0),
                    addmod(/*column4_row0*/ mload(0x9a0), sub(PRIME, /*column4_row1*/ mload(0x9c0)), PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[9].
              val := mulmod(val, /*domains[9]*/ mload(0x2fe0), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x3280), PRIME)

              // res += val * alpha ** 83.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash1/ec_subset_sum/copy_point/x: pedersen__hash1__ec_subset_sum__bit_neg_0 * (column4_row1 - column4_row0).
              let val := mulmod(
                /*intermediate_value/pedersen/hash1/ec_subset_sum/bit_neg_0*/ mload(0x2740),
                addmod(/*column4_row1*/ mload(0x9c0), sub(PRIME, /*column4_row0*/ mload(0x9a0)), PRIME),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[9].
              val := mulmod(val, /*domains[9]*/ mload(0x2fe0), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x3280), PRIME)

              // res += val * alpha ** 84.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash1/ec_subset_sum/copy_point/y: pedersen__hash1__ec_subset_sum__bit_neg_0 * (column5_row1 - column5_row0).
              let val := mulmod(
                /*intermediate_value/pedersen/hash1/ec_subset_sum/bit_neg_0*/ mload(0x2740),
                addmod(/*column5_row1*/ mload(0xa60), sub(PRIME, /*column5_row0*/ mload(0xa40)), PRIME),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[9].
              val := mulmod(val, /*domains[9]*/ mload(0x2fe0), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x3280), PRIME)

              // res += val * alpha ** 85.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash1/copy_point/x: column4_row256 - column4_row255.
              let val := addmod(/*column4_row256*/ mload(0xa00), sub(PRIME, /*column4_row255*/ mload(0x9e0)), PRIME)

              // Numerator: point^(trace_length / 512) - trace_generator^(trace_length / 2).
              // val *= domains[11].
              val := mulmod(val, /*domains[11]*/ mload(0x3020), PRIME)
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[11].
              val := mulmod(val, /*denominator_invs[11]*/ mload(0x33e0), PRIME)

              // res += val * alpha ** 86.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash1/copy_point/y: column5_row256 - column5_row255.
              let val := addmod(/*column5_row256*/ mload(0xaa0), sub(PRIME, /*column5_row255*/ mload(0xa80)), PRIME)

              // Numerator: point^(trace_length / 512) - trace_generator^(trace_length / 2).
              // val *= domains[11].
              val := mulmod(val, /*domains[11]*/ mload(0x3020), PRIME)
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[11].
              val := mulmod(val, /*denominator_invs[11]*/ mload(0x33e0), PRIME)

              // res += val * alpha ** 87.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash1/init/x: column4_row0 - pedersen/shift_point.x.
              let val := addmod(
                /*column4_row0*/ mload(0x9a0),
                sub(PRIME, /*pedersen/shift_point.x*/ mload(0x300)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[14].
              val := mulmod(val, /*denominator_invs[14]*/ mload(0x3440), PRIME)

              // res += val * alpha ** 88.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash1/init/y: column5_row0 - pedersen/shift_point.y.
              let val := addmod(
                /*column5_row0*/ mload(0xa40),
                sub(PRIME, /*pedersen/shift_point.y*/ mload(0x320)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[14].
              val := mulmod(val, /*denominator_invs[14]*/ mload(0x3440), PRIME)

              // res += val * alpha ** 89.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash2/ec_subset_sum/bit_unpacking/last_one_is_zero: column20_row147 * (column9_row0 - (column9_row1 + column9_row1)).
              let val := mulmod(
                /*column20_row147*/ mload(0x2100),
                addmod(
                  /*column9_row0*/ mload(0xd00),
                  sub(
                    PRIME,
                    addmod(/*column9_row1*/ mload(0xd20), /*column9_row1*/ mload(0xd20), PRIME)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[11].
              val := mulmod(val, /*denominator_invs[11]*/ mload(0x33e0), PRIME)

              // res += val * alpha ** 90.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash2/ec_subset_sum/bit_unpacking/zeroes_between_ones0: column20_row147 * (column9_row1 - 3138550867693340381917894711603833208051177722232017256448 * column9_row192).
              let val := mulmod(
                /*column20_row147*/ mload(0x2100),
                addmod(
                  /*column9_row1*/ mload(0xd20),
                  sub(
                    PRIME,
                    mulmod(
                      3138550867693340381917894711603833208051177722232017256448,
                      /*column9_row192*/ mload(0xd40),
                      PRIME)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[11].
              val := mulmod(val, /*denominator_invs[11]*/ mload(0x33e0), PRIME)

              // res += val * alpha ** 91.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash2/ec_subset_sum/bit_unpacking/cumulative_bit192: column20_row147 - column20_row19 * (column9_row192 - (column9_row193 + column9_row193)).
              let val := addmod(
                /*column20_row147*/ mload(0x2100),
                sub(
                  PRIME,
                  mulmod(
                    /*column20_row19*/ mload(0x1fa0),
                    addmod(
                      /*column9_row192*/ mload(0xd40),
                      sub(
                        PRIME,
                        addmod(/*column9_row193*/ mload(0xd60), /*column9_row193*/ mload(0xd60), PRIME)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[11].
              val := mulmod(val, /*denominator_invs[11]*/ mload(0x33e0), PRIME)

              // res += val * alpha ** 92.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash2/ec_subset_sum/bit_unpacking/zeroes_between_ones192: column20_row19 * (column9_row193 - 8 * column9_row196).
              let val := mulmod(
                /*column20_row19*/ mload(0x1fa0),
                addmod(
                  /*column9_row193*/ mload(0xd60),
                  sub(PRIME, mulmod(8, /*column9_row196*/ mload(0xd80), PRIME)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[11].
              val := mulmod(val, /*denominator_invs[11]*/ mload(0x33e0), PRIME)

              // res += val * alpha ** 93.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash2/ec_subset_sum/bit_unpacking/cumulative_bit196: column20_row19 - (column9_row251 - (column9_row252 + column9_row252)) * (column9_row196 - (column9_row197 + column9_row197)).
              let val := addmod(
                /*column20_row19*/ mload(0x1fa0),
                sub(
                  PRIME,
                  mulmod(
                    addmod(
                      /*column9_row251*/ mload(0xdc0),
                      sub(
                        PRIME,
                        addmod(/*column9_row252*/ mload(0xde0), /*column9_row252*/ mload(0xde0), PRIME)),
                      PRIME),
                    addmod(
                      /*column9_row196*/ mload(0xd80),
                      sub(
                        PRIME,
                        addmod(/*column9_row197*/ mload(0xda0), /*column9_row197*/ mload(0xda0), PRIME)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[11].
              val := mulmod(val, /*denominator_invs[11]*/ mload(0x33e0), PRIME)

              // res += val * alpha ** 94.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash2/ec_subset_sum/bit_unpacking/zeroes_between_ones196: (column9_row251 - (column9_row252 + column9_row252)) * (column9_row197 - 18014398509481984 * column9_row251).
              let val := mulmod(
                addmod(
                  /*column9_row251*/ mload(0xdc0),
                  sub(
                    PRIME,
                    addmod(/*column9_row252*/ mload(0xde0), /*column9_row252*/ mload(0xde0), PRIME)),
                  PRIME),
                addmod(
                  /*column9_row197*/ mload(0xda0),
                  sub(PRIME, mulmod(18014398509481984, /*column9_row251*/ mload(0xdc0), PRIME)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[11].
              val := mulmod(val, /*denominator_invs[11]*/ mload(0x33e0), PRIME)

              // res += val * alpha ** 95.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash2/ec_subset_sum/booleanity_test: pedersen__hash2__ec_subset_sum__bit_0 * (pedersen__hash2__ec_subset_sum__bit_0 - 1).
              let val := mulmod(
                /*intermediate_value/pedersen/hash2/ec_subset_sum/bit_0*/ mload(0x2760),
                addmod(
                  /*intermediate_value/pedersen/hash2/ec_subset_sum/bit_0*/ mload(0x2760),
                  sub(PRIME, 1),
                  PRIME),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[9].
              val := mulmod(val, /*domains[9]*/ mload(0x2fe0), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x3280), PRIME)

              // res += val * alpha ** 96.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash2/ec_subset_sum/bit_extraction_end: column9_row0.
              let val := /*column9_row0*/ mload(0xd00)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - trace_generator^(63 * trace_length / 64).
              // val *= denominator_invs[13].
              val := mulmod(val, /*denominator_invs[13]*/ mload(0x3420), PRIME)

              // res += val * alpha ** 97.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash2/ec_subset_sum/zeros_tail: column9_row0.
              let val := /*column9_row0*/ mload(0xd00)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= denominator_invs[12].
              val := mulmod(val, /*denominator_invs[12]*/ mload(0x3400), PRIME)

              // res += val * alpha ** 98.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash2/ec_subset_sum/add_points/slope: pedersen__hash2__ec_subset_sum__bit_0 * (column8_row0 - pedersen__points__y) - column15_row0 * (column7_row0 - pedersen__points__x).
              let val := addmod(
                mulmod(
                  /*intermediate_value/pedersen/hash2/ec_subset_sum/bit_0*/ mload(0x2760),
                  addmod(
                    /*column8_row0*/ mload(0xc80),
                    sub(PRIME, /*periodic_column/pedersen/points/y*/ mload(0x20)),
                    PRIME),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*column15_row0*/ mload(0x10e0),
                    addmod(
                      /*column7_row0*/ mload(0xbe0),
                      sub(PRIME, /*periodic_column/pedersen/points/x*/ mload(0x0)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[9].
              val := mulmod(val, /*domains[9]*/ mload(0x2fe0), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x3280), PRIME)

              // res += val * alpha ** 99.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash2/ec_subset_sum/add_points/x: column15_row0 * column15_row0 - pedersen__hash2__ec_subset_sum__bit_0 * (column7_row0 + pedersen__points__x + column7_row1).
              let val := addmod(
                mulmod(/*column15_row0*/ mload(0x10e0), /*column15_row0*/ mload(0x10e0), PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*intermediate_value/pedersen/hash2/ec_subset_sum/bit_0*/ mload(0x2760),
                    addmod(
                      addmod(
                        /*column7_row0*/ mload(0xbe0),
                        /*periodic_column/pedersen/points/x*/ mload(0x0),
                        PRIME),
                      /*column7_row1*/ mload(0xc00),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[9].
              val := mulmod(val, /*domains[9]*/ mload(0x2fe0), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x3280), PRIME)

              // res += val * alpha ** 100.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash2/ec_subset_sum/add_points/y: pedersen__hash2__ec_subset_sum__bit_0 * (column8_row0 + column8_row1) - column15_row0 * (column7_row0 - column7_row1).
              let val := addmod(
                mulmod(
                  /*intermediate_value/pedersen/hash2/ec_subset_sum/bit_0*/ mload(0x2760),
                  addmod(/*column8_row0*/ mload(0xc80), /*column8_row1*/ mload(0xca0), PRIME),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*column15_row0*/ mload(0x10e0),
                    addmod(/*column7_row0*/ mload(0xbe0), sub(PRIME, /*column7_row1*/ mload(0xc00)), PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[9].
              val := mulmod(val, /*domains[9]*/ mload(0x2fe0), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x3280), PRIME)

              // res += val * alpha ** 101.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash2/ec_subset_sum/copy_point/x: pedersen__hash2__ec_subset_sum__bit_neg_0 * (column7_row1 - column7_row0).
              let val := mulmod(
                /*intermediate_value/pedersen/hash2/ec_subset_sum/bit_neg_0*/ mload(0x2780),
                addmod(/*column7_row1*/ mload(0xc00), sub(PRIME, /*column7_row0*/ mload(0xbe0)), PRIME),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[9].
              val := mulmod(val, /*domains[9]*/ mload(0x2fe0), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x3280), PRIME)

              // res += val * alpha ** 102.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash2/ec_subset_sum/copy_point/y: pedersen__hash2__ec_subset_sum__bit_neg_0 * (column8_row1 - column8_row0).
              let val := mulmod(
                /*intermediate_value/pedersen/hash2/ec_subset_sum/bit_neg_0*/ mload(0x2780),
                addmod(/*column8_row1*/ mload(0xca0), sub(PRIME, /*column8_row0*/ mload(0xc80)), PRIME),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[9].
              val := mulmod(val, /*domains[9]*/ mload(0x2fe0), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x3280), PRIME)

              // res += val * alpha ** 103.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash2/copy_point/x: column7_row256 - column7_row255.
              let val := addmod(/*column7_row256*/ mload(0xc40), sub(PRIME, /*column7_row255*/ mload(0xc20)), PRIME)

              // Numerator: point^(trace_length / 512) - trace_generator^(trace_length / 2).
              // val *= domains[11].
              val := mulmod(val, /*domains[11]*/ mload(0x3020), PRIME)
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[11].
              val := mulmod(val, /*denominator_invs[11]*/ mload(0x33e0), PRIME)

              // res += val * alpha ** 104.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash2/copy_point/y: column8_row256 - column8_row255.
              let val := addmod(/*column8_row256*/ mload(0xce0), sub(PRIME, /*column8_row255*/ mload(0xcc0)), PRIME)

              // Numerator: point^(trace_length / 512) - trace_generator^(trace_length / 2).
              // val *= domains[11].
              val := mulmod(val, /*domains[11]*/ mload(0x3020), PRIME)
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[11].
              val := mulmod(val, /*denominator_invs[11]*/ mload(0x33e0), PRIME)

              // res += val * alpha ** 105.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash2/init/x: column7_row0 - pedersen/shift_point.x.
              let val := addmod(
                /*column7_row0*/ mload(0xbe0),
                sub(PRIME, /*pedersen/shift_point.x*/ mload(0x300)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[14].
              val := mulmod(val, /*denominator_invs[14]*/ mload(0x3440), PRIME)

              // res += val * alpha ** 106.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash2/init/y: column8_row0 - pedersen/shift_point.y.
              let val := addmod(
                /*column8_row0*/ mload(0xc80),
                sub(PRIME, /*pedersen/shift_point.y*/ mload(0x320)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[14].
              val := mulmod(val, /*denominator_invs[14]*/ mload(0x3440), PRIME)

              // res += val * alpha ** 107.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash3/ec_subset_sum/bit_unpacking/last_one_is_zero: column20_row211 * (column12_row0 - (column12_row1 + column12_row1)).
              let val := mulmod(
                /*column20_row211*/ mload(0x2120),
                addmod(
                  /*column12_row0*/ mload(0xf40),
                  sub(
                    PRIME,
                    addmod(/*column12_row1*/ mload(0xf60), /*column12_row1*/ mload(0xf60), PRIME)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[11].
              val := mulmod(val, /*denominator_invs[11]*/ mload(0x33e0), PRIME)

              // res += val * alpha ** 108.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash3/ec_subset_sum/bit_unpacking/zeroes_between_ones0: column20_row211 * (column12_row1 - 3138550867693340381917894711603833208051177722232017256448 * column12_row192).
              let val := mulmod(
                /*column20_row211*/ mload(0x2120),
                addmod(
                  /*column12_row1*/ mload(0xf60),
                  sub(
                    PRIME,
                    mulmod(
                      3138550867693340381917894711603833208051177722232017256448,
                      /*column12_row192*/ mload(0xf80),
                      PRIME)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[11].
              val := mulmod(val, /*denominator_invs[11]*/ mload(0x33e0), PRIME)

              // res += val * alpha ** 109.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash3/ec_subset_sum/bit_unpacking/cumulative_bit192: column20_row211 - column20_row83 * (column12_row192 - (column12_row193 + column12_row193)).
              let val := addmod(
                /*column20_row211*/ mload(0x2120),
                sub(
                  PRIME,
                  mulmod(
                    /*column20_row83*/ mload(0x20e0),
                    addmod(
                      /*column12_row192*/ mload(0xf80),
                      sub(
                        PRIME,
                        addmod(/*column12_row193*/ mload(0xfa0), /*column12_row193*/ mload(0xfa0), PRIME)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[11].
              val := mulmod(val, /*denominator_invs[11]*/ mload(0x33e0), PRIME)

              // res += val * alpha ** 110.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash3/ec_subset_sum/bit_unpacking/zeroes_between_ones192: column20_row83 * (column12_row193 - 8 * column12_row196).
              let val := mulmod(
                /*column20_row83*/ mload(0x20e0),
                addmod(
                  /*column12_row193*/ mload(0xfa0),
                  sub(PRIME, mulmod(8, /*column12_row196*/ mload(0xfc0), PRIME)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[11].
              val := mulmod(val, /*denominator_invs[11]*/ mload(0x33e0), PRIME)

              // res += val * alpha ** 111.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash3/ec_subset_sum/bit_unpacking/cumulative_bit196: column20_row83 - (column12_row251 - (column12_row252 + column12_row252)) * (column12_row196 - (column12_row197 + column12_row197)).
              let val := addmod(
                /*column20_row83*/ mload(0x20e0),
                sub(
                  PRIME,
                  mulmod(
                    addmod(
                      /*column12_row251*/ mload(0x1000),
                      sub(
                        PRIME,
                        addmod(/*column12_row252*/ mload(0x1020), /*column12_row252*/ mload(0x1020), PRIME)),
                      PRIME),
                    addmod(
                      /*column12_row196*/ mload(0xfc0),
                      sub(
                        PRIME,
                        addmod(/*column12_row197*/ mload(0xfe0), /*column12_row197*/ mload(0xfe0), PRIME)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[11].
              val := mulmod(val, /*denominator_invs[11]*/ mload(0x33e0), PRIME)

              // res += val * alpha ** 112.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash3/ec_subset_sum/bit_unpacking/zeroes_between_ones196: (column12_row251 - (column12_row252 + column12_row252)) * (column12_row197 - 18014398509481984 * column12_row251).
              let val := mulmod(
                addmod(
                  /*column12_row251*/ mload(0x1000),
                  sub(
                    PRIME,
                    addmod(/*column12_row252*/ mload(0x1020), /*column12_row252*/ mload(0x1020), PRIME)),
                  PRIME),
                addmod(
                  /*column12_row197*/ mload(0xfe0),
                  sub(PRIME, mulmod(18014398509481984, /*column12_row251*/ mload(0x1000), PRIME)),
                  PRIME),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[11].
              val := mulmod(val, /*denominator_invs[11]*/ mload(0x33e0), PRIME)

              // res += val * alpha ** 113.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash3/ec_subset_sum/booleanity_test: pedersen__hash3__ec_subset_sum__bit_0 * (pedersen__hash3__ec_subset_sum__bit_0 - 1).
              let val := mulmod(
                /*intermediate_value/pedersen/hash3/ec_subset_sum/bit_0*/ mload(0x27a0),
                addmod(
                  /*intermediate_value/pedersen/hash3/ec_subset_sum/bit_0*/ mload(0x27a0),
                  sub(PRIME, 1),
                  PRIME),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[9].
              val := mulmod(val, /*domains[9]*/ mload(0x2fe0), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x3280), PRIME)

              // res += val * alpha ** 114.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash3/ec_subset_sum/bit_extraction_end: column12_row0.
              let val := /*column12_row0*/ mload(0xf40)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - trace_generator^(63 * trace_length / 64).
              // val *= denominator_invs[13].
              val := mulmod(val, /*denominator_invs[13]*/ mload(0x3420), PRIME)

              // res += val * alpha ** 115.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash3/ec_subset_sum/zeros_tail: column12_row0.
              let val := /*column12_row0*/ mload(0xf40)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= denominator_invs[12].
              val := mulmod(val, /*denominator_invs[12]*/ mload(0x3400), PRIME)

              // res += val * alpha ** 116.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash3/ec_subset_sum/add_points/slope: pedersen__hash3__ec_subset_sum__bit_0 * (column11_row0 - pedersen__points__y) - column16_row0 * (column10_row0 - pedersen__points__x).
              let val := addmod(
                mulmod(
                  /*intermediate_value/pedersen/hash3/ec_subset_sum/bit_0*/ mload(0x27a0),
                  addmod(
                    /*column11_row0*/ mload(0xec0),
                    sub(PRIME, /*periodic_column/pedersen/points/y*/ mload(0x20)),
                    PRIME),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*column16_row0*/ mload(0x1120),
                    addmod(
                      /*column10_row0*/ mload(0xe20),
                      sub(PRIME, /*periodic_column/pedersen/points/x*/ mload(0x0)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[9].
              val := mulmod(val, /*domains[9]*/ mload(0x2fe0), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x3280), PRIME)

              // res += val * alpha ** 117.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash3/ec_subset_sum/add_points/x: column16_row0 * column16_row0 - pedersen__hash3__ec_subset_sum__bit_0 * (column10_row0 + pedersen__points__x + column10_row1).
              let val := addmod(
                mulmod(/*column16_row0*/ mload(0x1120), /*column16_row0*/ mload(0x1120), PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*intermediate_value/pedersen/hash3/ec_subset_sum/bit_0*/ mload(0x27a0),
                    addmod(
                      addmod(
                        /*column10_row0*/ mload(0xe20),
                        /*periodic_column/pedersen/points/x*/ mload(0x0),
                        PRIME),
                      /*column10_row1*/ mload(0xe40),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[9].
              val := mulmod(val, /*domains[9]*/ mload(0x2fe0), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x3280), PRIME)

              // res += val * alpha ** 118.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash3/ec_subset_sum/add_points/y: pedersen__hash3__ec_subset_sum__bit_0 * (column11_row0 + column11_row1) - column16_row0 * (column10_row0 - column10_row1).
              let val := addmod(
                mulmod(
                  /*intermediate_value/pedersen/hash3/ec_subset_sum/bit_0*/ mload(0x27a0),
                  addmod(/*column11_row0*/ mload(0xec0), /*column11_row1*/ mload(0xee0), PRIME),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*column16_row0*/ mload(0x1120),
                    addmod(/*column10_row0*/ mload(0xe20), sub(PRIME, /*column10_row1*/ mload(0xe40)), PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[9].
              val := mulmod(val, /*domains[9]*/ mload(0x2fe0), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x3280), PRIME)

              // res += val * alpha ** 119.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash3/ec_subset_sum/copy_point/x: pedersen__hash3__ec_subset_sum__bit_neg_0 * (column10_row1 - column10_row0).
              let val := mulmod(
                /*intermediate_value/pedersen/hash3/ec_subset_sum/bit_neg_0*/ mload(0x27c0),
                addmod(/*column10_row1*/ mload(0xe40), sub(PRIME, /*column10_row0*/ mload(0xe20)), PRIME),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[9].
              val := mulmod(val, /*domains[9]*/ mload(0x2fe0), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x3280), PRIME)

              // res += val * alpha ** 120.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash3/ec_subset_sum/copy_point/y: pedersen__hash3__ec_subset_sum__bit_neg_0 * (column11_row1 - column11_row0).
              let val := mulmod(
                /*intermediate_value/pedersen/hash3/ec_subset_sum/bit_neg_0*/ mload(0x27c0),
                addmod(/*column11_row1*/ mload(0xee0), sub(PRIME, /*column11_row0*/ mload(0xec0)), PRIME),
                PRIME)

              // Numerator: point^(trace_length / 256) - trace_generator^(255 * trace_length / 256).
              // val *= domains[9].
              val := mulmod(val, /*domains[9]*/ mload(0x2fe0), PRIME)
              // Denominator: point^trace_length - 1.
              // val *= denominator_invs[0].
              val := mulmod(val, /*denominator_invs[0]*/ mload(0x3280), PRIME)

              // res += val * alpha ** 121.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash3/copy_point/x: column10_row256 - column10_row255.
              let val := addmod(
                /*column10_row256*/ mload(0xe80),
                sub(PRIME, /*column10_row255*/ mload(0xe60)),
                PRIME)

              // Numerator: point^(trace_length / 512) - trace_generator^(trace_length / 2).
              // val *= domains[11].
              val := mulmod(val, /*domains[11]*/ mload(0x3020), PRIME)
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[11].
              val := mulmod(val, /*denominator_invs[11]*/ mload(0x33e0), PRIME)

              // res += val * alpha ** 122.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash3/copy_point/y: column11_row256 - column11_row255.
              let val := addmod(
                /*column11_row256*/ mload(0xf20),
                sub(PRIME, /*column11_row255*/ mload(0xf00)),
                PRIME)

              // Numerator: point^(trace_length / 512) - trace_generator^(trace_length / 2).
              // val *= domains[11].
              val := mulmod(val, /*domains[11]*/ mload(0x3020), PRIME)
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[11].
              val := mulmod(val, /*denominator_invs[11]*/ mload(0x33e0), PRIME)

              // res += val * alpha ** 123.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash3/init/x: column10_row0 - pedersen/shift_point.x.
              let val := addmod(
                /*column10_row0*/ mload(0xe20),
                sub(PRIME, /*pedersen/shift_point.x*/ mload(0x300)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[14].
              val := mulmod(val, /*denominator_invs[14]*/ mload(0x3440), PRIME)

              // res += val * alpha ** 124.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/hash3/init/y: column11_row0 - pedersen/shift_point.y.
              let val := addmod(
                /*column11_row0*/ mload(0xec0),
                sub(PRIME, /*pedersen/shift_point.y*/ mload(0x320)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[14].
              val := mulmod(val, /*denominator_invs[14]*/ mload(0x3440), PRIME)

              // res += val * alpha ** 125.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/input0_value0: column17_row7 - column3_row0.
              let val := addmod(/*column17_row7*/ mload(0x1240), sub(PRIME, /*column3_row0*/ mload(0x880)), PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[14].
              val := mulmod(val, /*denominator_invs[14]*/ mload(0x3440), PRIME)

              // res += val * alpha ** 126.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/input0_value1: column17_row135 - column6_row0.
              let val := addmod(/*column17_row135*/ mload(0x1420), sub(PRIME, /*column6_row0*/ mload(0xac0)), PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[14].
              val := mulmod(val, /*denominator_invs[14]*/ mload(0x3440), PRIME)

              // res += val * alpha ** 127.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/input0_value2: column17_row263 - column9_row0.
              let val := addmod(/*column17_row263*/ mload(0x14e0), sub(PRIME, /*column9_row0*/ mload(0xd00)), PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[14].
              val := mulmod(val, /*denominator_invs[14]*/ mload(0x3440), PRIME)

              // res += val * alpha ** 128.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/input0_value3: column17_row391 - column12_row0.
              let val := addmod(
                /*column17_row391*/ mload(0x1540),
                sub(PRIME, /*column12_row0*/ mload(0xf40)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[14].
              val := mulmod(val, /*denominator_invs[14]*/ mload(0x3440), PRIME)

              // res += val * alpha ** 129.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/input0_addr: column17_row134 - (column17_row38 + 1).
              let val := addmod(
                /*column17_row134*/ mload(0x1400),
                sub(PRIME, addmod(/*column17_row38*/ mload(0x1340), 1, PRIME)),
                PRIME)

              // Numerator: point - trace_generator^(128 * (trace_length / 128 - 1)).
              // val *= domains[27].
              val := mulmod(val, /*domains[27]*/ mload(0x3220), PRIME)
              // Denominator: point^(trace_length / 128) - 1.
              // val *= denominator_invs[15].
              val := mulmod(val, /*denominator_invs[15]*/ mload(0x3460), PRIME)

              // res += val * alpha ** 130.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/init_addr: column17_row6 - initial_pedersen_addr.
              let val := addmod(
                /*column17_row6*/ mload(0x1220),
                sub(PRIME, /*initial_pedersen_addr*/ mload(0x340)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point - 1.
              // val *= denominator_invs[4].
              val := mulmod(val, /*denominator_invs[4]*/ mload(0x3300), PRIME)

              // res += val * alpha ** 131.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/input1_value0: column17_row71 - column3_row256.
              let val := addmod(
                /*column17_row71*/ mload(0x13a0),
                sub(PRIME, /*column3_row256*/ mload(0x980)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[14].
              val := mulmod(val, /*denominator_invs[14]*/ mload(0x3440), PRIME)

              // res += val * alpha ** 132.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/input1_value1: column17_row199 - column6_row256.
              let val := addmod(
                /*column17_row199*/ mload(0x14a0),
                sub(PRIME, /*column6_row256*/ mload(0xbc0)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[14].
              val := mulmod(val, /*denominator_invs[14]*/ mload(0x3440), PRIME)

              // res += val * alpha ** 133.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/input1_value2: column17_row327 - column9_row256.
              let val := addmod(
                /*column17_row327*/ mload(0x1520),
                sub(PRIME, /*column9_row256*/ mload(0xe00)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[14].
              val := mulmod(val, /*denominator_invs[14]*/ mload(0x3440), PRIME)

              // res += val * alpha ** 134.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/input1_value3: column17_row455 - column12_row256.
              let val := addmod(
                /*column17_row455*/ mload(0x15a0),
                sub(PRIME, /*column12_row256*/ mload(0x1040)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[14].
              val := mulmod(val, /*denominator_invs[14]*/ mload(0x3440), PRIME)

              // res += val * alpha ** 135.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/input1_addr: column17_row70 - (column17_row6 + 1).
              let val := addmod(
                /*column17_row70*/ mload(0x1380),
                sub(PRIME, addmod(/*column17_row6*/ mload(0x1220), 1, PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 128) - 1.
              // val *= denominator_invs[15].
              val := mulmod(val, /*denominator_invs[15]*/ mload(0x3460), PRIME)

              // res += val * alpha ** 136.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/output_value0: column17_row39 - column1_row511.
              let val := addmod(
                /*column17_row39*/ mload(0x1360),
                sub(PRIME, /*column1_row511*/ mload(0x7e0)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[14].
              val := mulmod(val, /*denominator_invs[14]*/ mload(0x3440), PRIME)

              // res += val * alpha ** 137.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/output_value1: column17_row167 - column4_row511.
              let val := addmod(
                /*column17_row167*/ mload(0x1480),
                sub(PRIME, /*column4_row511*/ mload(0xa20)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[14].
              val := mulmod(val, /*denominator_invs[14]*/ mload(0x3440), PRIME)

              // res += val * alpha ** 138.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/output_value2: column17_row295 - column7_row511.
              let val := addmod(
                /*column17_row295*/ mload(0x1500),
                sub(PRIME, /*column7_row511*/ mload(0xc60)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[14].
              val := mulmod(val, /*denominator_invs[14]*/ mload(0x3440), PRIME)

              // res += val * alpha ** 139.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/output_value3: column17_row423 - column10_row511.
              let val := addmod(
                /*column17_row423*/ mload(0x1580),
                sub(PRIME, /*column10_row511*/ mload(0xea0)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 512) - 1.
              // val *= denominator_invs[14].
              val := mulmod(val, /*denominator_invs[14]*/ mload(0x3440), PRIME)

              // res += val * alpha ** 140.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for pedersen/output_addr: column17_row38 - (column17_row70 + 1).
              let val := addmod(
                /*column17_row38*/ mload(0x1340),
                sub(PRIME, addmod(/*column17_row70*/ mload(0x1380), 1, PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 128) - 1.
              // val *= denominator_invs[15].
              val := mulmod(val, /*denominator_invs[15]*/ mload(0x3460), PRIME)

              // res += val * alpha ** 141.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for rc_builtin/value: rc_builtin__value7_0 - column17_row103.
              let val := addmod(
                /*intermediate_value/rc_builtin/value7_0*/ mload(0x28c0),
                sub(PRIME, /*column17_row103*/ mload(0x13e0)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 128) - 1.
              // val *= denominator_invs[15].
              val := mulmod(val, /*denominator_invs[15]*/ mload(0x3460), PRIME)

              // res += val * alpha ** 142.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for rc_builtin/addr_step: column17_row230 - (column17_row102 + 1).
              let val := addmod(
                /*column17_row230*/ mload(0x14c0),
                sub(PRIME, addmod(/*column17_row102*/ mload(0x13c0), 1, PRIME)),
                PRIME)

              // Numerator: point - trace_generator^(128 * (trace_length / 128 - 1)).
              // val *= domains[27].
              val := mulmod(val, /*domains[27]*/ mload(0x3220), PRIME)
              // Denominator: point^(trace_length / 128) - 1.
              // val *= denominator_invs[15].
              val := mulmod(val, /*denominator_invs[15]*/ mload(0x3460), PRIME)

              // res += val * alpha ** 143.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for rc_builtin/init_addr: column17_row102 - initial_rc_addr.
              let val := addmod(
                /*column17_row102*/ mload(0x13c0),
                sub(PRIME, /*initial_rc_addr*/ mload(0x360)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point - 1.
              // val *= denominator_invs[4].
              val := mulmod(val, /*denominator_invs[4]*/ mload(0x3300), PRIME)

              // res += val * alpha ** 144.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/doubling_key/slope: ecdsa__signature0__doubling_key__x_squared + ecdsa__signature0__doubling_key__x_squared + ecdsa__signature0__doubling_key__x_squared + ecdsa/sig_config.alpha - (column20_row12 + column20_row12) * column20_row14.
              let val := addmod(
                addmod(
                  addmod(
                    addmod(
                      /*intermediate_value/ecdsa/signature0/doubling_key/x_squared*/ mload(0x28e0),
                      /*intermediate_value/ecdsa/signature0/doubling_key/x_squared*/ mload(0x28e0),
                      PRIME),
                    /*intermediate_value/ecdsa/signature0/doubling_key/x_squared*/ mload(0x28e0),
                    PRIME),
                  /*ecdsa/sig_config.alpha*/ mload(0x380),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    addmod(/*column20_row12*/ mload(0x1f20), /*column20_row12*/ mload(0x1f20), PRIME),
                    /*column20_row14*/ mload(0x1f60),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 4096) - trace_generator^(255 * trace_length / 256).
              // val *= domains[16].
              val := mulmod(val, /*domains[16]*/ mload(0x30c0), PRIME)
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x32c0), PRIME)

              // res += val * alpha ** 145.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/doubling_key/x: column20_row14 * column20_row14 - (column20_row4 + column20_row4 + column20_row20).
              let val := addmod(
                mulmod(/*column20_row14*/ mload(0x1f60), /*column20_row14*/ mload(0x1f60), PRIME),
                sub(
                  PRIME,
                  addmod(
                    addmod(/*column20_row4*/ mload(0x1e60), /*column20_row4*/ mload(0x1e60), PRIME),
                    /*column20_row20*/ mload(0x1fc0),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 4096) - trace_generator^(255 * trace_length / 256).
              // val *= domains[16].
              val := mulmod(val, /*domains[16]*/ mload(0x30c0), PRIME)
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x32c0), PRIME)

              // res += val * alpha ** 146.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/doubling_key/y: column20_row12 + column20_row28 - column20_row14 * (column20_row4 - column20_row20).
              let val := addmod(
                addmod(/*column20_row12*/ mload(0x1f20), /*column20_row28*/ mload(0x2040), PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*column20_row14*/ mload(0x1f60),
                    addmod(
                      /*column20_row4*/ mload(0x1e60),
                      sub(PRIME, /*column20_row20*/ mload(0x1fc0)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 4096) - trace_generator^(255 * trace_length / 256).
              // val *= domains[16].
              val := mulmod(val, /*domains[16]*/ mload(0x30c0), PRIME)
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x32c0), PRIME)

              // res += val * alpha ** 147.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/exponentiate_generator/booleanity_test: ecdsa__signature0__exponentiate_generator__bit_0 * (ecdsa__signature0__exponentiate_generator__bit_0 - 1).
              let val := mulmod(
                /*intermediate_value/ecdsa/signature0/exponentiate_generator/bit_0*/ mload(0x2900),
                addmod(
                  /*intermediate_value/ecdsa/signature0/exponentiate_generator/bit_0*/ mload(0x2900),
                  sub(PRIME, 1),
                  PRIME),
                PRIME)

              // Numerator: point^(trace_length / 8192) - trace_generator^(255 * trace_length / 256).
              // val *= domains[19].
              val := mulmod(val, /*domains[19]*/ mload(0x3120), PRIME)
              // Denominator: point^(trace_length / 32) - 1.
              // val *= denominator_invs[17].
              val := mulmod(val, /*denominator_invs[17]*/ mload(0x34a0), PRIME)

              // res += val * alpha ** 148.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/exponentiate_generator/bit_extraction_end: column20_row13.
              let val := /*column20_row13*/ mload(0x1f40)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 8192) - trace_generator^(251 * trace_length / 256).
              // val *= denominator_invs[19].
              val := mulmod(val, /*denominator_invs[19]*/ mload(0x34e0), PRIME)

              // res += val * alpha ** 149.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/exponentiate_generator/zeros_tail: column20_row13.
              let val := /*column20_row13*/ mload(0x1f40)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 8192) - trace_generator^(255 * trace_length / 256).
              // val *= denominator_invs[18].
              val := mulmod(val, /*denominator_invs[18]*/ mload(0x34c0), PRIME)

              // res += val * alpha ** 150.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/exponentiate_generator/add_points/slope: ecdsa__signature0__exponentiate_generator__bit_0 * (column20_row21 - ecdsa__generator_points__y) - column20_row29 * (column20_row5 - ecdsa__generator_points__x).
              let val := addmod(
                mulmod(
                  /*intermediate_value/ecdsa/signature0/exponentiate_generator/bit_0*/ mload(0x2900),
                  addmod(
                    /*column20_row21*/ mload(0x1fe0),
                    sub(PRIME, /*periodic_column/ecdsa/generator_points/y*/ mload(0x60)),
                    PRIME),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*column20_row29*/ mload(0x2060),
                    addmod(
                      /*column20_row5*/ mload(0x1e80),
                      sub(PRIME, /*periodic_column/ecdsa/generator_points/x*/ mload(0x40)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 8192) - trace_generator^(255 * trace_length / 256).
              // val *= domains[19].
              val := mulmod(val, /*domains[19]*/ mload(0x3120), PRIME)
              // Denominator: point^(trace_length / 32) - 1.
              // val *= denominator_invs[17].
              val := mulmod(val, /*denominator_invs[17]*/ mload(0x34a0), PRIME)

              // res += val * alpha ** 151.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/exponentiate_generator/add_points/x: column20_row29 * column20_row29 - ecdsa__signature0__exponentiate_generator__bit_0 * (column20_row5 + ecdsa__generator_points__x + column20_row37).
              let val := addmod(
                mulmod(/*column20_row29*/ mload(0x2060), /*column20_row29*/ mload(0x2060), PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*intermediate_value/ecdsa/signature0/exponentiate_generator/bit_0*/ mload(0x2900),
                    addmod(
                      addmod(
                        /*column20_row5*/ mload(0x1e80),
                        /*periodic_column/ecdsa/generator_points/x*/ mload(0x40),
                        PRIME),
                      /*column20_row37*/ mload(0x2080),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 8192) - trace_generator^(255 * trace_length / 256).
              // val *= domains[19].
              val := mulmod(val, /*domains[19]*/ mload(0x3120), PRIME)
              // Denominator: point^(trace_length / 32) - 1.
              // val *= denominator_invs[17].
              val := mulmod(val, /*denominator_invs[17]*/ mload(0x34a0), PRIME)

              // res += val * alpha ** 152.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/exponentiate_generator/add_points/y: ecdsa__signature0__exponentiate_generator__bit_0 * (column20_row21 + column20_row53) - column20_row29 * (column20_row5 - column20_row37).
              let val := addmod(
                mulmod(
                  /*intermediate_value/ecdsa/signature0/exponentiate_generator/bit_0*/ mload(0x2900),
                  addmod(/*column20_row21*/ mload(0x1fe0), /*column20_row53*/ mload(0x20c0), PRIME),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*column20_row29*/ mload(0x2060),
                    addmod(
                      /*column20_row5*/ mload(0x1e80),
                      sub(PRIME, /*column20_row37*/ mload(0x2080)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 8192) - trace_generator^(255 * trace_length / 256).
              // val *= domains[19].
              val := mulmod(val, /*domains[19]*/ mload(0x3120), PRIME)
              // Denominator: point^(trace_length / 32) - 1.
              // val *= denominator_invs[17].
              val := mulmod(val, /*denominator_invs[17]*/ mload(0x34a0), PRIME)

              // res += val * alpha ** 153.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/exponentiate_generator/add_points/x_diff_inv: column20_row3 * (column20_row5 - ecdsa__generator_points__x) - 1.
              let val := addmod(
                mulmod(
                  /*column20_row3*/ mload(0x1e40),
                  addmod(
                    /*column20_row5*/ mload(0x1e80),
                    sub(PRIME, /*periodic_column/ecdsa/generator_points/x*/ mload(0x40)),
                    PRIME),
                  PRIME),
                sub(PRIME, 1),
                PRIME)

              // Numerator: point^(trace_length / 8192) - trace_generator^(255 * trace_length / 256).
              // val *= domains[19].
              val := mulmod(val, /*domains[19]*/ mload(0x3120), PRIME)
              // Denominator: point^(trace_length / 32) - 1.
              // val *= denominator_invs[17].
              val := mulmod(val, /*denominator_invs[17]*/ mload(0x34a0), PRIME)

              // res += val * alpha ** 154.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/exponentiate_generator/copy_point/x: ecdsa__signature0__exponentiate_generator__bit_neg_0 * (column20_row37 - column20_row5).
              let val := mulmod(
                /*intermediate_value/ecdsa/signature0/exponentiate_generator/bit_neg_0*/ mload(0x2920),
                addmod(
                  /*column20_row37*/ mload(0x2080),
                  sub(PRIME, /*column20_row5*/ mload(0x1e80)),
                  PRIME),
                PRIME)

              // Numerator: point^(trace_length / 8192) - trace_generator^(255 * trace_length / 256).
              // val *= domains[19].
              val := mulmod(val, /*domains[19]*/ mload(0x3120), PRIME)
              // Denominator: point^(trace_length / 32) - 1.
              // val *= denominator_invs[17].
              val := mulmod(val, /*denominator_invs[17]*/ mload(0x34a0), PRIME)

              // res += val * alpha ** 155.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/exponentiate_generator/copy_point/y: ecdsa__signature0__exponentiate_generator__bit_neg_0 * (column20_row53 - column20_row21).
              let val := mulmod(
                /*intermediate_value/ecdsa/signature0/exponentiate_generator/bit_neg_0*/ mload(0x2920),
                addmod(
                  /*column20_row53*/ mload(0x20c0),
                  sub(PRIME, /*column20_row21*/ mload(0x1fe0)),
                  PRIME),
                PRIME)

              // Numerator: point^(trace_length / 8192) - trace_generator^(255 * trace_length / 256).
              // val *= domains[19].
              val := mulmod(val, /*domains[19]*/ mload(0x3120), PRIME)
              // Denominator: point^(trace_length / 32) - 1.
              // val *= denominator_invs[17].
              val := mulmod(val, /*denominator_invs[17]*/ mload(0x34a0), PRIME)

              // res += val * alpha ** 156.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/exponentiate_key/booleanity_test: ecdsa__signature0__exponentiate_key__bit_0 * (ecdsa__signature0__exponentiate_key__bit_0 - 1).
              let val := mulmod(
                /*intermediate_value/ecdsa/signature0/exponentiate_key/bit_0*/ mload(0x2940),
                addmod(
                  /*intermediate_value/ecdsa/signature0/exponentiate_key/bit_0*/ mload(0x2940),
                  sub(PRIME, 1),
                  PRIME),
                PRIME)

              // Numerator: point^(trace_length / 4096) - trace_generator^(255 * trace_length / 256).
              // val *= domains[16].
              val := mulmod(val, /*domains[16]*/ mload(0x30c0), PRIME)
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x32c0), PRIME)

              // res += val * alpha ** 157.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/exponentiate_key/bit_extraction_end: column20_row6.
              let val := /*column20_row6*/ mload(0x1ea0)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 4096) - trace_generator^(251 * trace_length / 256).
              // val *= denominator_invs[20].
              val := mulmod(val, /*denominator_invs[20]*/ mload(0x3500), PRIME)

              // res += val * alpha ** 158.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/exponentiate_key/zeros_tail: column20_row6.
              let val := /*column20_row6*/ mload(0x1ea0)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 4096) - trace_generator^(255 * trace_length / 256).
              // val *= denominator_invs[16].
              val := mulmod(val, /*denominator_invs[16]*/ mload(0x3480), PRIME)

              // res += val * alpha ** 159.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/exponentiate_key/add_points/slope: ecdsa__signature0__exponentiate_key__bit_0 * (column20_row10 - column20_row12) - column20_row1 * (column20_row2 - column20_row4).
              let val := addmod(
                mulmod(
                  /*intermediate_value/ecdsa/signature0/exponentiate_key/bit_0*/ mload(0x2940),
                  addmod(
                    /*column20_row10*/ mload(0x1f00),
                    sub(PRIME, /*column20_row12*/ mload(0x1f20)),
                    PRIME),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*column20_row1*/ mload(0x1e00),
                    addmod(/*column20_row2*/ mload(0x1e20), sub(PRIME, /*column20_row4*/ mload(0x1e60)), PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 4096) - trace_generator^(255 * trace_length / 256).
              // val *= domains[16].
              val := mulmod(val, /*domains[16]*/ mload(0x30c0), PRIME)
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x32c0), PRIME)

              // res += val * alpha ** 160.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/exponentiate_key/add_points/x: column20_row1 * column20_row1 - ecdsa__signature0__exponentiate_key__bit_0 * (column20_row2 + column20_row4 + column20_row18).
              let val := addmod(
                mulmod(/*column20_row1*/ mload(0x1e00), /*column20_row1*/ mload(0x1e00), PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*intermediate_value/ecdsa/signature0/exponentiate_key/bit_0*/ mload(0x2940),
                    addmod(
                      addmod(/*column20_row2*/ mload(0x1e20), /*column20_row4*/ mload(0x1e60), PRIME),
                      /*column20_row18*/ mload(0x1f80),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 4096) - trace_generator^(255 * trace_length / 256).
              // val *= domains[16].
              val := mulmod(val, /*domains[16]*/ mload(0x30c0), PRIME)
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x32c0), PRIME)

              // res += val * alpha ** 161.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/exponentiate_key/add_points/y: ecdsa__signature0__exponentiate_key__bit_0 * (column20_row10 + column20_row26) - column20_row1 * (column20_row2 - column20_row18).
              let val := addmod(
                mulmod(
                  /*intermediate_value/ecdsa/signature0/exponentiate_key/bit_0*/ mload(0x2940),
                  addmod(/*column20_row10*/ mload(0x1f00), /*column20_row26*/ mload(0x2020), PRIME),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*column20_row1*/ mload(0x1e00),
                    addmod(
                      /*column20_row2*/ mload(0x1e20),
                      sub(PRIME, /*column20_row18*/ mload(0x1f80)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 4096) - trace_generator^(255 * trace_length / 256).
              // val *= domains[16].
              val := mulmod(val, /*domains[16]*/ mload(0x30c0), PRIME)
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x32c0), PRIME)

              // res += val * alpha ** 162.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/exponentiate_key/add_points/x_diff_inv: column20_row9 * (column20_row2 - column20_row4) - 1.
              let val := addmod(
                mulmod(
                  /*column20_row9*/ mload(0x1ee0),
                  addmod(/*column20_row2*/ mload(0x1e20), sub(PRIME, /*column20_row4*/ mload(0x1e60)), PRIME),
                  PRIME),
                sub(PRIME, 1),
                PRIME)

              // Numerator: point^(trace_length / 4096) - trace_generator^(255 * trace_length / 256).
              // val *= domains[16].
              val := mulmod(val, /*domains[16]*/ mload(0x30c0), PRIME)
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x32c0), PRIME)

              // res += val * alpha ** 163.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/exponentiate_key/copy_point/x: ecdsa__signature0__exponentiate_key__bit_neg_0 * (column20_row18 - column20_row2).
              let val := mulmod(
                /*intermediate_value/ecdsa/signature0/exponentiate_key/bit_neg_0*/ mload(0x2960),
                addmod(
                  /*column20_row18*/ mload(0x1f80),
                  sub(PRIME, /*column20_row2*/ mload(0x1e20)),
                  PRIME),
                PRIME)

              // Numerator: point^(trace_length / 4096) - trace_generator^(255 * trace_length / 256).
              // val *= domains[16].
              val := mulmod(val, /*domains[16]*/ mload(0x30c0), PRIME)
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x32c0), PRIME)

              // res += val * alpha ** 164.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/exponentiate_key/copy_point/y: ecdsa__signature0__exponentiate_key__bit_neg_0 * (column20_row26 - column20_row10).
              let val := mulmod(
                /*intermediate_value/ecdsa/signature0/exponentiate_key/bit_neg_0*/ mload(0x2960),
                addmod(
                  /*column20_row26*/ mload(0x2020),
                  sub(PRIME, /*column20_row10*/ mload(0x1f00)),
                  PRIME),
                PRIME)

              // Numerator: point^(trace_length / 4096) - trace_generator^(255 * trace_length / 256).
              // val *= domains[16].
              val := mulmod(val, /*domains[16]*/ mload(0x30c0), PRIME)
              // Denominator: point^(trace_length / 16) - 1.
              // val *= denominator_invs[2].
              val := mulmod(val, /*denominator_invs[2]*/ mload(0x32c0), PRIME)

              // res += val * alpha ** 165.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/init_gen/x: column20_row5 - ecdsa/sig_config.shift_point.x.
              let val := addmod(
                /*column20_row5*/ mload(0x1e80),
                sub(PRIME, /*ecdsa/sig_config.shift_point.x*/ mload(0x3a0)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 8192) - 1.
              // val *= denominator_invs[21].
              val := mulmod(val, /*denominator_invs[21]*/ mload(0x3520), PRIME)

              // res += val * alpha ** 166.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/init_gen/y: column20_row21 + ecdsa/sig_config.shift_point.y.
              let val := addmod(
                /*column20_row21*/ mload(0x1fe0),
                /*ecdsa/sig_config.shift_point.y*/ mload(0x3c0),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 8192) - 1.
              // val *= denominator_invs[21].
              val := mulmod(val, /*denominator_invs[21]*/ mload(0x3520), PRIME)

              // res += val * alpha ** 167.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/init_key/x: column20_row2 - ecdsa/sig_config.shift_point.x.
              let val := addmod(
                /*column20_row2*/ mload(0x1e20),
                sub(PRIME, /*ecdsa/sig_config.shift_point.x*/ mload(0x3a0)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 4096) - 1.
              // val *= denominator_invs[22].
              val := mulmod(val, /*denominator_invs[22]*/ mload(0x3540), PRIME)

              // res += val * alpha ** 168.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/init_key/y: column20_row10 - ecdsa/sig_config.shift_point.y.
              let val := addmod(
                /*column20_row10*/ mload(0x1f00),
                sub(PRIME, /*ecdsa/sig_config.shift_point.y*/ mload(0x3c0)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 4096) - 1.
              // val *= denominator_invs[22].
              val := mulmod(val, /*denominator_invs[22]*/ mload(0x3540), PRIME)

              // res += val * alpha ** 169.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/add_results/slope: column20_row8181 - (column20_row4090 + column20_row8189 * (column20_row8165 - column20_row4082)).
              let val := addmod(
                /*column20_row8181*/ mload(0x22a0),
                sub(
                  PRIME,
                  addmod(
                    /*column20_row4090*/ mload(0x21a0),
                    mulmod(
                      /*column20_row8189*/ mload(0x2300),
                      addmod(
                        /*column20_row8165*/ mload(0x2240),
                        sub(PRIME, /*column20_row4082*/ mload(0x2160)),
                        PRIME),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 8192) - 1.
              // val *= denominator_invs[21].
              val := mulmod(val, /*denominator_invs[21]*/ mload(0x3520), PRIME)

              // res += val * alpha ** 170.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/add_results/x: column20_row8189 * column20_row8189 - (column20_row8165 + column20_row4082 + column20_row4100).
              let val := addmod(
                mulmod(/*column20_row8189*/ mload(0x2300), /*column20_row8189*/ mload(0x2300), PRIME),
                sub(
                  PRIME,
                  addmod(
                    addmod(/*column20_row8165*/ mload(0x2240), /*column20_row4082*/ mload(0x2160), PRIME),
                    /*column20_row4100*/ mload(0x21e0),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 8192) - 1.
              // val *= denominator_invs[21].
              val := mulmod(val, /*denominator_invs[21]*/ mload(0x3520), PRIME)

              // res += val * alpha ** 171.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/add_results/y: column20_row8181 + column20_row4108 - column20_row8189 * (column20_row8165 - column20_row4100).
              let val := addmod(
                addmod(/*column20_row8181*/ mload(0x22a0), /*column20_row4108*/ mload(0x2200), PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*column20_row8189*/ mload(0x2300),
                    addmod(
                      /*column20_row8165*/ mload(0x2240),
                      sub(PRIME, /*column20_row4100*/ mload(0x21e0)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 8192) - 1.
              // val *= denominator_invs[21].
              val := mulmod(val, /*denominator_invs[21]*/ mload(0x3520), PRIME)

              // res += val * alpha ** 172.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/add_results/x_diff_inv: column20_row8163 * (column20_row8165 - column20_row4082) - 1.
              let val := addmod(
                mulmod(
                  /*column20_row8163*/ mload(0x2220),
                  addmod(
                    /*column20_row8165*/ mload(0x2240),
                    sub(PRIME, /*column20_row4082*/ mload(0x2160)),
                    PRIME),
                  PRIME),
                sub(PRIME, 1),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 8192) - 1.
              // val *= denominator_invs[21].
              val := mulmod(val, /*denominator_invs[21]*/ mload(0x3520), PRIME)

              // res += val * alpha ** 173.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/extract_r/slope: column20_row8186 + ecdsa/sig_config.shift_point.y - column20_row4081 * (column20_row8178 - ecdsa/sig_config.shift_point.x).
              let val := addmod(
                addmod(
                  /*column20_row8186*/ mload(0x22e0),
                  /*ecdsa/sig_config.shift_point.y*/ mload(0x3c0),
                  PRIME),
                sub(
                  PRIME,
                  mulmod(
                    /*column20_row4081*/ mload(0x2140),
                    addmod(
                      /*column20_row8178*/ mload(0x2280),
                      sub(PRIME, /*ecdsa/sig_config.shift_point.x*/ mload(0x3a0)),
                      PRIME),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 8192) - 1.
              // val *= denominator_invs[21].
              val := mulmod(val, /*denominator_invs[21]*/ mload(0x3520), PRIME)

              // res += val * alpha ** 174.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/extract_r/x: column20_row4081 * column20_row4081 - (column20_row8178 + ecdsa/sig_config.shift_point.x + column20_row6).
              let val := addmod(
                mulmod(/*column20_row4081*/ mload(0x2140), /*column20_row4081*/ mload(0x2140), PRIME),
                sub(
                  PRIME,
                  addmod(
                    addmod(
                      /*column20_row8178*/ mload(0x2280),
                      /*ecdsa/sig_config.shift_point.x*/ mload(0x3a0),
                      PRIME),
                    /*column20_row6*/ mload(0x1ea0),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 8192) - 1.
              // val *= denominator_invs[21].
              val := mulmod(val, /*denominator_invs[21]*/ mload(0x3520), PRIME)

              // res += val * alpha ** 175.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/extract_r/x_diff_inv: column20_row8177 * (column20_row8178 - ecdsa/sig_config.shift_point.x) - 1.
              let val := addmod(
                mulmod(
                  /*column20_row8177*/ mload(0x2260),
                  addmod(
                    /*column20_row8178*/ mload(0x2280),
                    sub(PRIME, /*ecdsa/sig_config.shift_point.x*/ mload(0x3a0)),
                    PRIME),
                  PRIME),
                sub(PRIME, 1),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 8192) - 1.
              // val *= denominator_invs[21].
              val := mulmod(val, /*denominator_invs[21]*/ mload(0x3520), PRIME)

              // res += val * alpha ** 176.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/z_nonzero: column20_row13 * column20_row4089 - 1.
              let val := addmod(
                mulmod(/*column20_row13*/ mload(0x1f40), /*column20_row4089*/ mload(0x2180), PRIME),
                sub(PRIME, 1),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 8192) - 1.
              // val *= denominator_invs[21].
              val := mulmod(val, /*denominator_invs[21]*/ mload(0x3520), PRIME)

              // res += val * alpha ** 177.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/r_and_w_nonzero: column20_row6 * column20_row4094 - 1.
              let val := addmod(
                mulmod(/*column20_row6*/ mload(0x1ea0), /*column20_row4094*/ mload(0x21c0), PRIME),
                sub(PRIME, 1),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 4096) - 1.
              // val *= denominator_invs[22].
              val := mulmod(val, /*denominator_invs[22]*/ mload(0x3540), PRIME)

              // res += val * alpha ** 178.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/q_on_curve/x_squared: column20_row8185 - column20_row4 * column20_row4.
              let val := addmod(
                /*column20_row8185*/ mload(0x22c0),
                sub(
                  PRIME,
                  mulmod(/*column20_row4*/ mload(0x1e60), /*column20_row4*/ mload(0x1e60), PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 8192) - 1.
              // val *= denominator_invs[21].
              val := mulmod(val, /*denominator_invs[21]*/ mload(0x3520), PRIME)

              // res += val * alpha ** 179.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/signature0/q_on_curve/on_curve: column20_row12 * column20_row12 - (column20_row4 * column20_row8185 + ecdsa/sig_config.alpha * column20_row4 + ecdsa/sig_config.beta).
              let val := addmod(
                mulmod(/*column20_row12*/ mload(0x1f20), /*column20_row12*/ mload(0x1f20), PRIME),
                sub(
                  PRIME,
                  addmod(
                    addmod(
                      mulmod(/*column20_row4*/ mload(0x1e60), /*column20_row8185*/ mload(0x22c0), PRIME),
                      mulmod(/*ecdsa/sig_config.alpha*/ mload(0x380), /*column20_row4*/ mload(0x1e60), PRIME),
                      PRIME),
                    /*ecdsa/sig_config.beta*/ mload(0x3e0),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 8192) - 1.
              // val *= denominator_invs[21].
              val := mulmod(val, /*denominator_invs[21]*/ mload(0x3520), PRIME)

              // res += val * alpha ** 180.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/init_addr: column17_row22 - initial_ecdsa_addr.
              let val := addmod(
                /*column17_row22*/ mload(0x1300),
                sub(PRIME, /*initial_ecdsa_addr*/ mload(0x400)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point - 1.
              // val *= denominator_invs[4].
              val := mulmod(val, /*denominator_invs[4]*/ mload(0x3300), PRIME)

              // res += val * alpha ** 181.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/message_addr: column17_row4118 - (column17_row22 + 1).
              let val := addmod(
                /*column17_row4118*/ mload(0x1680),
                sub(PRIME, addmod(/*column17_row22*/ mload(0x1300), 1, PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 8192) - 1.
              // val *= denominator_invs[21].
              val := mulmod(val, /*denominator_invs[21]*/ mload(0x3520), PRIME)

              // res += val * alpha ** 182.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/pubkey_addr: column17_row8214 - (column17_row4118 + 1).
              let val := addmod(
                /*column17_row8214*/ mload(0x16c0),
                sub(PRIME, addmod(/*column17_row4118*/ mload(0x1680), 1, PRIME)),
                PRIME)

              // Numerator: point - trace_generator^(8192 * (trace_length / 8192 - 1)).
              // val *= domains[28].
              val := mulmod(val, /*domains[28]*/ mload(0x3240), PRIME)
              // Denominator: point^(trace_length / 8192) - 1.
              // val *= denominator_invs[21].
              val := mulmod(val, /*denominator_invs[21]*/ mload(0x3520), PRIME)

              // res += val * alpha ** 183.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/message_value0: column17_row4119 - column20_row13.
              let val := addmod(
                /*column17_row4119*/ mload(0x16a0),
                sub(PRIME, /*column20_row13*/ mload(0x1f40)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 8192) - 1.
              // val *= denominator_invs[21].
              val := mulmod(val, /*denominator_invs[21]*/ mload(0x3520), PRIME)

              // res += val * alpha ** 184.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for ecdsa/pubkey_value0: column17_row23 - column20_row4.
              let val := addmod(
                /*column17_row23*/ mload(0x1320),
                sub(PRIME, /*column20_row4*/ mload(0x1e60)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 8192) - 1.
              // val *= denominator_invs[21].
              val := mulmod(val, /*denominator_invs[21]*/ mload(0x3520), PRIME)

              // res += val * alpha ** 185.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for bitwise/init_var_pool_addr: column17_row150 - initial_bitwise_addr.
              let val := addmod(
                /*column17_row150*/ mload(0x1440),
                sub(PRIME, /*initial_bitwise_addr*/ mload(0x420)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point - 1.
              // val *= denominator_invs[4].
              val := mulmod(val, /*denominator_invs[4]*/ mload(0x3300), PRIME)

              // res += val * alpha ** 186.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for bitwise/step_var_pool_addr: column17_row406 - (column17_row150 + 1).
              let val := addmod(
                /*column17_row406*/ mload(0x1560),
                sub(PRIME, addmod(/*column17_row150*/ mload(0x1440), 1, PRIME)),
                PRIME)

              // Numerator: point^(trace_length / 1024) - trace_generator^(3 * trace_length / 4).
              // val *= domains[13].
              val := mulmod(val, /*domains[13]*/ mload(0x3060), PRIME)
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[11].
              val := mulmod(val, /*denominator_invs[11]*/ mload(0x33e0), PRIME)

              // res += val * alpha ** 187.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for bitwise/x_or_y_addr: column17_row534 - (column17_row918 + 1).
              let val := addmod(
                /*column17_row534*/ mload(0x15c0),
                sub(PRIME, addmod(/*column17_row918*/ mload(0x1620), 1, PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 1024) - 1.
              // val *= denominator_invs[23].
              val := mulmod(val, /*denominator_invs[23]*/ mload(0x3560), PRIME)

              // res += val * alpha ** 188.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for bitwise/next_var_pool_addr: column17_row1174 - (column17_row534 + 1).
              let val := addmod(
                /*column17_row1174*/ mload(0x1660),
                sub(PRIME, addmod(/*column17_row534*/ mload(0x15c0), 1, PRIME)),
                PRIME)

              // Numerator: point - trace_generator^(1024 * (trace_length / 1024 - 1)).
              // val *= domains[29].
              val := mulmod(val, /*domains[29]*/ mload(0x3260), PRIME)
              // Denominator: point^(trace_length / 1024) - 1.
              // val *= denominator_invs[23].
              val := mulmod(val, /*denominator_invs[23]*/ mload(0x3560), PRIME)

              // res += val * alpha ** 189.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for bitwise/partition: bitwise__sum_var_0_0 + bitwise__sum_var_8_0 - column17_row151.
              let val := addmod(
                addmod(
                  /*intermediate_value/bitwise/sum_var_0_0*/ mload(0x2980),
                  /*intermediate_value/bitwise/sum_var_8_0*/ mload(0x29a0),
                  PRIME),
                sub(PRIME, /*column17_row151*/ mload(0x1460)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 256) - 1.
              // val *= denominator_invs[11].
              val := mulmod(val, /*denominator_invs[11]*/ mload(0x33e0), PRIME)

              // res += val * alpha ** 190.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for bitwise/or_is_and_plus_xor: column17_row535 - (column17_row663 + column17_row919).
              let val := addmod(
                /*column17_row535*/ mload(0x15e0),
                sub(
                  PRIME,
                  addmod(/*column17_row663*/ mload(0x1600), /*column17_row919*/ mload(0x1640), PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 1024) - 1.
              // val *= denominator_invs[23].
              val := mulmod(val, /*denominator_invs[23]*/ mload(0x3560), PRIME)

              // res += val * alpha ** 191.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for bitwise/addition_is_xor_with_and: column19_row1 + column19_row257 - (column19_row769 + column19_row513 + column19_row513).
              let val := addmod(
                addmod(/*column19_row1*/ mload(0x1780), /*column19_row257*/ mload(0x1c20), PRIME),
                sub(
                  PRIME,
                  addmod(
                    addmod(/*column19_row769*/ mload(0x1d20), /*column19_row513*/ mload(0x1c60), PRIME),
                    /*column19_row513*/ mload(0x1c60),
                    PRIME)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: (point^(trace_length / 1024) - trace_generator^(trace_length / 64)) * (point^(trace_length / 1024) - trace_generator^(trace_length / 32)) * (point^(trace_length / 1024) - trace_generator^(3 * trace_length / 64)) * (point^(trace_length / 1024) - trace_generator^(trace_length / 16)) * (point^(trace_length / 1024) - trace_generator^(5 * trace_length / 64)) * (point^(trace_length / 1024) - trace_generator^(3 * trace_length / 32)) * (point^(trace_length / 1024) - trace_generator^(7 * trace_length / 64)) * (point^(trace_length / 1024) - trace_generator^(trace_length / 8)) * (point^(trace_length / 1024) - trace_generator^(9 * trace_length / 64)) * (point^(trace_length / 1024) - trace_generator^(5 * trace_length / 32)) * (point^(trace_length / 1024) - trace_generator^(11 * trace_length / 64)) * (point^(trace_length / 1024) - trace_generator^(3 * trace_length / 16)) * (point^(trace_length / 1024) - trace_generator^(13 * trace_length / 64)) * (point^(trace_length / 1024) - trace_generator^(7 * trace_length / 32)) * (point^(trace_length / 1024) - trace_generator^(15 * trace_length / 64)) * domain14.
              // val *= denominator_invs[24].
              val := mulmod(val, /*denominator_invs[24]*/ mload(0x3580), PRIME)

              // res += val * alpha ** 192.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for bitwise/unique_unpacking192: (column19_row705 + column19_row961) * 16 - column19_row9.
              let val := addmod(
                mulmod(
                  addmod(/*column19_row705*/ mload(0x1ca0), /*column19_row961*/ mload(0x1d60), PRIME),
                  16,
                  PRIME),
                sub(PRIME, /*column19_row9*/ mload(0x1880)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 1024) - 1.
              // val *= denominator_invs[23].
              val := mulmod(val, /*denominator_invs[23]*/ mload(0x3560), PRIME)

              // res += val * alpha ** 193.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for bitwise/unique_unpacking193: (column19_row721 + column19_row977) * 16 - column19_row521.
              let val := addmod(
                mulmod(
                  addmod(/*column19_row721*/ mload(0x1cc0), /*column19_row977*/ mload(0x1d80), PRIME),
                  16,
                  PRIME),
                sub(PRIME, /*column19_row521*/ mload(0x1c80)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 1024) - 1.
              // val *= denominator_invs[23].
              val := mulmod(val, /*denominator_invs[23]*/ mload(0x3560), PRIME)

              // res += val * alpha ** 194.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for bitwise/unique_unpacking194: (column19_row737 + column19_row993) * 16 - column19_row265.
              let val := addmod(
                mulmod(
                  addmod(/*column19_row737*/ mload(0x1ce0), /*column19_row993*/ mload(0x1da0), PRIME),
                  16,
                  PRIME),
                sub(PRIME, /*column19_row265*/ mload(0x1c40)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 1024) - 1.
              // val *= denominator_invs[23].
              val := mulmod(val, /*denominator_invs[23]*/ mload(0x3560), PRIME)

              // res += val * alpha ** 195.
              res := addmod(res, mulmod(val, composition_alpha_pow, PRIME), PRIME)
              composition_alpha_pow := mulmod(composition_alpha_pow, composition_alpha, PRIME)
              }

              {
              // Constraint expression for bitwise/unique_unpacking195: (column19_row753 + column19_row1009) * 256 - column19_row777.
              let val := addmod(
                mulmod(
                  addmod(/*column19_row753*/ mload(0x1d00), /*column19_row1009*/ mload(0x1dc0), PRIME),
                  256,
                  PRIME),
                sub(PRIME, /*column19_row777*/ mload(0x1d40)),
                PRIME)

              // Numerator: 1.
              // val *= 1.
              // Denominator: point^(trace_length / 1024) - 1.
              // val *= denominator_invs[23].
              val := mulmod(val, /*denominator_invs[23]*/ mload(0x3560), PRIME)

              // res += val * alpha ** 196.
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
