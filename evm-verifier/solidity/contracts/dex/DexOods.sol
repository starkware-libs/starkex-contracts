// ---------- The following code was auto-generated. PLEASE DO NOT EDIT. ----------
pragma solidity ^0.5.2;

import "./MemoryMap.sol";
import "./StarkParameters.sol";

contract DexOods is MemoryMap, StarkParameters {
    // For each query point we want to invert (2 + N_ROWS_IN_MASK) items:
    //  The query point itself (x).
    //  The denominator for the constraint polynomial (x-z^constraintDegree)
    //  [(x-(g^rowNumber)z) for rowNumber in mask].
    uint256 constant internal BATCH_INVERSE_CHUNK = (2 + N_ROWS_IN_MASK);
    uint256 constant internal BATCH_INVERSE_SIZE = MAX_N_QUERIES * BATCH_INVERSE_CHUNK;

    /*
      Builds and sums boundary constraints that check that the prover provided the proper evaluations
      out of domain evaluations for the trace and composition columns.

      The inputs to this function are:
          The verifier context.

      The boundary constraints for the trace enforce claims of the form f(g^k*z) = c by
      requiring the quotient (f(x) - c)/(x-g^k*z) to be a low degree polynomial.

      The boundary constraints for the composition enforce claims of the form h(z^d) = c by
      requiring the quotient (h(x) - c)/(x-z^d) to be a low degree polynomial.
      Where:
            f is a trace column.
            h is a composition column.
            z is the out of domain sampling point.
            g is the trace generator
            k is the offset in the mask.
            d is the degree of the composition polynomial.
            c is the evaluation sent by the prover.
    */
    function() external {
        // This funciton assumes that the calldata contains the context as defined in MemoryMap.sol.
        // Note that ctx is a variable size array so the first uint256 cell contrains it's length.
        uint256[] memory ctx;
        assembly {
            let ctxSize := mul(add(calldataload(0), 1), 0x20)
            ctx := mload(0x40)
            mstore(0x40, add(ctx, ctxSize))
            calldatacopy(ctx, 0, ctxSize)
        }
        uint256[] memory batchInverseArray = new uint256[](2 * BATCH_INVERSE_SIZE);

        oodsPrepareInverses(ctx, batchInverseArray);

        uint256 kMontgomeryRInv_ = PrimeFieldElement0.K_MONTGOMERY_R_INV;

        assembly {
            let PRIME := 0x800000000000011000000000000000000000000000000000000000000000001
            let kMontgomeryRInv := kMontgomeryRInv_
            let context := ctx
            let friQueue := /*friQueue*/ add(context, 0xda0)
            let friQueueEnd := add(friQueue,  mul(/*n_unique_queries*/ mload(add(context, 0x120)), 0x60))
            let traceQueryResponses := /*traceQueryQesponses*/ add(context, 0x8fe0)

            let compositionQueryResponses := /*composition_query_responses*/ add(context, 0xfbe0)

            // Set denominatorsPtr to point to the batchInverseOut array.
            // The content of batchInverseOut is described in oodsPrepareInverses.
            let denominatorsPtr := add(batchInverseArray, 0x20)

            for {} lt(friQueue, friQueueEnd) {friQueue := add(friQueue, 0x60)} {
                // res accumulates numbers modulo PRIME. Since 31*PRIME < 2**256, we may add up to
                // 31 numbers without fear of overflow, and use addmod modulo PRIME only every
                // 31 iterations, and once more at the very end.
                let res := 0

                // Trace constraints.

                // Mask items for column #0.
                {
                // Read the next element.
                let columnValue := mulmod(mload(traceQueryResponses), kMontgomeryRInv, PRIME)

                // res += c_0*(f_0(x) - f_0(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[0]*/ mload(add(context, 0x7780)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[0]*/ mload(add(context, 0x5920)))),
                           PRIME))

                // res += c_1*(f_0(x) - f_0(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  /*oods_coefficients[1]*/ mload(add(context, 0x77a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[1]*/ mload(add(context, 0x5940)))),
                           PRIME))

                // res += c_2*(f_0(x) - f_0(g^255 * z)) / (x - g^255 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^255 * z)^(-1)*/ mload(add(denominatorsPtr, 0x380)),
                                  /*oods_coefficients[2]*/ mload(add(context, 0x77c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[2]*/ mload(add(context, 0x5960)))),
                           PRIME))

                // res += c_3*(f_0(x) - f_0(g^256 * z)) / (x - g^256 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^256 * z)^(-1)*/ mload(add(denominatorsPtr, 0x3a0)),
                                  /*oods_coefficients[3]*/ mload(add(context, 0x77e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[3]*/ mload(add(context, 0x5980)))),
                           PRIME))

                // res += c_4*(f_0(x) - f_0(g^511 * z)) / (x - g^511 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^511 * z)^(-1)*/ mload(add(denominatorsPtr, 0x3c0)),
                                  /*oods_coefficients[4]*/ mload(add(context, 0x7800)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[4]*/ mload(add(context, 0x59a0)))),
                           PRIME))

                // res += c_5*(f_0(x) - f_0(g^(512 * (vaults_path_length - 1) + 511) * z)) / (x - g^(512 * (vaults_path_length - 1) + 511) * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^(512 * (vaults_path_length - 1) + 511) * z)^(-1)*/ mload(add(denominatorsPtr, 0xf60)),
                                  /*oods_coefficients[5]*/ mload(add(context, 0x7820)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[5]*/ mload(add(context, 0x59c0)))),
                           PRIME))

                // res += c_6*(f_0(x) - f_0(g^(512 * (vaults_path_length - 1) + 16895) * z)) / (x - g^(512 * (vaults_path_length - 1) + 16895) * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^(512 * (vaults_path_length - 1) + 16895) * z)^(-1)*/ mload(add(denominatorsPtr, 0xf80)),
                                  /*oods_coefficients[6]*/ mload(add(context, 0x7840)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[6]*/ mload(add(context, 0x59e0)))),
                           PRIME))
                }

                // Mask items for column #1.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x20)), kMontgomeryRInv, PRIME)

                // res += c_7*(f_1(x) - f_1(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[7]*/ mload(add(context, 0x7860)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[7]*/ mload(add(context, 0x5a00)))),
                           PRIME))

                // res += c_8*(f_1(x) - f_1(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  /*oods_coefficients[8]*/ mload(add(context, 0x7880)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[8]*/ mload(add(context, 0x5a20)))),
                           PRIME))

                // res += c_9*(f_1(x) - f_1(g^255 * z)) / (x - g^255 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^255 * z)^(-1)*/ mload(add(denominatorsPtr, 0x380)),
                                  /*oods_coefficients[9]*/ mload(add(context, 0x78a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[9]*/ mload(add(context, 0x5a40)))),
                           PRIME))

                // res += c_10*(f_1(x) - f_1(g^256 * z)) / (x - g^256 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^256 * z)^(-1)*/ mload(add(denominatorsPtr, 0x3a0)),
                                  /*oods_coefficients[10]*/ mload(add(context, 0x78c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[10]*/ mload(add(context, 0x5a60)))),
                           PRIME))
                }

                // Mask items for column #2.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x40)), kMontgomeryRInv, PRIME)

                // res += c_11*(f_2(x) - f_2(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[11]*/ mload(add(context, 0x78e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[11]*/ mload(add(context, 0x5a80)))),
                           PRIME))
                }

                // Mask items for column #3.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x60)), kMontgomeryRInv, PRIME)

                // res += c_12*(f_3(x) - f_3(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[12]*/ mload(add(context, 0x7900)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[12]*/ mload(add(context, 0x5aa0)))),
                           PRIME))

                // res += c_13*(f_3(x) - f_3(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  /*oods_coefficients[13]*/ mload(add(context, 0x7920)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[13]*/ mload(add(context, 0x5ac0)))),
                           PRIME))

                // res += c_14*(f_3(x) - f_3(g^256 * z)) / (x - g^256 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^256 * z)^(-1)*/ mload(add(denominatorsPtr, 0x3a0)),
                                  /*oods_coefficients[14]*/ mload(add(context, 0x7940)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[14]*/ mload(add(context, 0x5ae0)))),
                           PRIME))

                // res += c_15*(f_3(x) - f_3(g^512 * z)) / (x - g^512 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^512 * z)^(-1)*/ mload(add(denominatorsPtr, 0x3e0)),
                                  /*oods_coefficients[15]*/ mload(add(context, 0x7960)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[15]*/ mload(add(context, 0x5b00)))),
                           PRIME))

                // res += c_16*(f_3(x) - f_3(g^768 * z)) / (x - g^768 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^768 * z)^(-1)*/ mload(add(denominatorsPtr, 0x420)),
                                  /*oods_coefficients[16]*/ mload(add(context, 0x7980)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[16]*/ mload(add(context, 0x5b20)))),
                           PRIME))
                }

                // Mask items for column #4.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x80)), kMontgomeryRInv, PRIME)

                // res += c_17*(f_4(x) - f_4(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[17]*/ mload(add(context, 0x79a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[17]*/ mload(add(context, 0x5b40)))),
                           PRIME))

                // res += c_18*(f_4(x) - f_4(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  /*oods_coefficients[18]*/ mload(add(context, 0x79c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[18]*/ mload(add(context, 0x5b60)))),
                           PRIME))

                // res += c_19*(f_4(x) - f_4(g^255 * z)) / (x - g^255 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^255 * z)^(-1)*/ mload(add(denominatorsPtr, 0x380)),
                                  /*oods_coefficients[19]*/ mload(add(context, 0x79e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[19]*/ mload(add(context, 0x5b80)))),
                           PRIME))

                // res += c_20*(f_4(x) - f_4(g^256 * z)) / (x - g^256 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^256 * z)^(-1)*/ mload(add(denominatorsPtr, 0x3a0)),
                                  /*oods_coefficients[20]*/ mload(add(context, 0x7a00)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[20]*/ mload(add(context, 0x5ba0)))),
                           PRIME))

                // res += c_21*(f_4(x) - f_4(g^511 * z)) / (x - g^511 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^511 * z)^(-1)*/ mload(add(denominatorsPtr, 0x3c0)),
                                  /*oods_coefficients[21]*/ mload(add(context, 0x7a20)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[21]*/ mload(add(context, 0x5bc0)))),
                           PRIME))

                // res += c_22*(f_4(x) - f_4(g^(512 * (vaults_path_length - 1) + 49663) * z)) / (x - g^(512 * (vaults_path_length - 1) + 49663) * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^(512 * (vaults_path_length - 1) + 49663) * z)^(-1)*/ mload(add(denominatorsPtr, 0xfa0)),
                                  /*oods_coefficients[22]*/ mload(add(context, 0x7a40)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[22]*/ mload(add(context, 0x5be0)))),
                           PRIME))

                // res += c_23*(f_4(x) - f_4(g^(512 * (vaults_path_length - 1) + 511) * z)) / (x - g^(512 * (vaults_path_length - 1) + 511) * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^(512 * (vaults_path_length - 1) + 511) * z)^(-1)*/ mload(add(denominatorsPtr, 0xf60)),
                                  /*oods_coefficients[23]*/ mload(add(context, 0x7a60)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[23]*/ mload(add(context, 0x5c00)))),
                           PRIME))
                }

                // Mask items for column #5.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0xa0)), kMontgomeryRInv, PRIME)

                // res += c_24*(f_5(x) - f_5(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[24]*/ mload(add(context, 0x7a80)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[24]*/ mload(add(context, 0x5c20)))),
                           PRIME))

                // res += c_25*(f_5(x) - f_5(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  /*oods_coefficients[25]*/ mload(add(context, 0x7aa0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[25]*/ mload(add(context, 0x5c40)))),
                           PRIME))

                // res += c_26*(f_5(x) - f_5(g^255 * z)) / (x - g^255 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^255 * z)^(-1)*/ mload(add(denominatorsPtr, 0x380)),
                                  /*oods_coefficients[26]*/ mload(add(context, 0x7ac0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[26]*/ mload(add(context, 0x5c60)))),
                           PRIME))

                // res += c_27*(f_5(x) - f_5(g^256 * z)) / (x - g^256 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^256 * z)^(-1)*/ mload(add(denominatorsPtr, 0x3a0)),
                                  /*oods_coefficients[27]*/ mload(add(context, 0x7ae0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[27]*/ mload(add(context, 0x5c80)))),
                           PRIME))
                }

                // Mask items for column #6.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0xc0)), kMontgomeryRInv, PRIME)

                // res += c_28*(f_6(x) - f_6(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[28]*/ mload(add(context, 0x7b00)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[28]*/ mload(add(context, 0x5ca0)))),
                           PRIME))
                }

                // Mask items for column #7.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0xe0)), kMontgomeryRInv, PRIME)

                // res += c_29*(f_7(x) - f_7(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[29]*/ mload(add(context, 0x7b20)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[29]*/ mload(add(context, 0x5cc0)))),
                           PRIME))

                // res += c_30*(f_7(x) - f_7(g * z)) / (x - g * z).
                res := addmod(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  /*oods_coefficients[30]*/ mload(add(context, 0x7b40)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[30]*/ mload(add(context, 0x5ce0)))),
                           PRIME),
                    PRIME)

                // res += c_31*(f_7(x) - f_7(g^256 * z)) / (x - g^256 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^256 * z)^(-1)*/ mload(add(denominatorsPtr, 0x3a0)),
                                  /*oods_coefficients[31]*/ mload(add(context, 0x7b60)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[31]*/ mload(add(context, 0x5d00)))),
                           PRIME))

                // res += c_32*(f_7(x) - f_7(g^512 * z)) / (x - g^512 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^512 * z)^(-1)*/ mload(add(denominatorsPtr, 0x3e0)),
                                  /*oods_coefficients[32]*/ mload(add(context, 0x7b80)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[32]*/ mload(add(context, 0x5d20)))),
                           PRIME))

                // res += c_33*(f_7(x) - f_7(g^768 * z)) / (x - g^768 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^768 * z)^(-1)*/ mload(add(denominatorsPtr, 0x420)),
                                  /*oods_coefficients[33]*/ mload(add(context, 0x7ba0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[33]*/ mload(add(context, 0x5d40)))),
                           PRIME))
                }

                // Mask items for column #8.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x100)), kMontgomeryRInv, PRIME)

                // res += c_34*(f_8(x) - f_8(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[34]*/ mload(add(context, 0x7bc0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[34]*/ mload(add(context, 0x5d60)))),
                           PRIME))

                // res += c_35*(f_8(x) - f_8(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  /*oods_coefficients[35]*/ mload(add(context, 0x7be0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[35]*/ mload(add(context, 0x5d80)))),
                           PRIME))

                // res += c_36*(f_8(x) - f_8(g^255 * z)) / (x - g^255 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^255 * z)^(-1)*/ mload(add(denominatorsPtr, 0x380)),
                                  /*oods_coefficients[36]*/ mload(add(context, 0x7c00)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[36]*/ mload(add(context, 0x5da0)))),
                           PRIME))

                // res += c_37*(f_8(x) - f_8(g^256 * z)) / (x - g^256 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^256 * z)^(-1)*/ mload(add(denominatorsPtr, 0x3a0)),
                                  /*oods_coefficients[37]*/ mload(add(context, 0x7c20)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[37]*/ mload(add(context, 0x5dc0)))),
                           PRIME))

                // res += c_38*(f_8(x) - f_8(g^511 * z)) / (x - g^511 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^511 * z)^(-1)*/ mload(add(denominatorsPtr, 0x3c0)),
                                  /*oods_coefficients[38]*/ mload(add(context, 0x7c40)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[38]*/ mload(add(context, 0x5de0)))),
                           PRIME))

                // res += c_39*(f_8(x) - f_8(g^32255 * z)) / (x - g^32255 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^32255 * z)^(-1)*/ mload(add(denominatorsPtr, 0xa40)),
                                  /*oods_coefficients[39]*/ mload(add(context, 0x7c60)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[39]*/ mload(add(context, 0x5e00)))),
                           PRIME))

                // res += c_40*(f_8(x) - f_8(g^65023 * z)) / (x - g^65023 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^65023 * z)^(-1)*/ mload(add(denominatorsPtr, 0xec0)),
                                  /*oods_coefficients[40]*/ mload(add(context, 0x7c80)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[40]*/ mload(add(context, 0x5e20)))),
                           PRIME))
                }

                // Mask items for column #9.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x120)), kMontgomeryRInv, PRIME)

                // res += c_41*(f_9(x) - f_9(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[41]*/ mload(add(context, 0x7ca0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[41]*/ mload(add(context, 0x5e40)))),
                           PRIME))

                // res += c_42*(f_9(x) - f_9(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  /*oods_coefficients[42]*/ mload(add(context, 0x7cc0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[42]*/ mload(add(context, 0x5e60)))),
                           PRIME))

                // res += c_43*(f_9(x) - f_9(g^255 * z)) / (x - g^255 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^255 * z)^(-1)*/ mload(add(denominatorsPtr, 0x380)),
                                  /*oods_coefficients[43]*/ mload(add(context, 0x7ce0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[43]*/ mload(add(context, 0x5e80)))),
                           PRIME))

                // res += c_44*(f_9(x) - f_9(g^256 * z)) / (x - g^256 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^256 * z)^(-1)*/ mload(add(denominatorsPtr, 0x3a0)),
                                  /*oods_coefficients[44]*/ mload(add(context, 0x7d00)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[44]*/ mload(add(context, 0x5ea0)))),
                           PRIME))
                }

                // Mask items for column #10.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x140)), kMontgomeryRInv, PRIME)

                // res += c_45*(f_10(x) - f_10(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[45]*/ mload(add(context, 0x7d20)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[45]*/ mload(add(context, 0x5ec0)))),
                           PRIME))

                // res += c_46*(f_10(x) - f_10(g^255 * z)) / (x - g^255 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^255 * z)^(-1)*/ mload(add(denominatorsPtr, 0x380)),
                                  /*oods_coefficients[46]*/ mload(add(context, 0x7d40)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[46]*/ mload(add(context, 0x5ee0)))),
                           PRIME))

                // res += c_47*(f_10(x) - f_10(g^511 * z)) / (x - g^511 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^511 * z)^(-1)*/ mload(add(denominatorsPtr, 0x3c0)),
                                  /*oods_coefficients[47]*/ mload(add(context, 0x7d60)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[47]*/ mload(add(context, 0x5f00)))),
                           PRIME))

                // res += c_48*(f_10(x) - f_10(g^767 * z)) / (x - g^767 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^767 * z)^(-1)*/ mload(add(denominatorsPtr, 0x400)),
                                  /*oods_coefficients[48]*/ mload(add(context, 0x7d80)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[48]*/ mload(add(context, 0x5f20)))),
                           PRIME))

                // res += c_49*(f_10(x) - f_10(g^2559 * z)) / (x - g^2559 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2559 * z)^(-1)*/ mload(add(denominatorsPtr, 0x5c0)),
                                  /*oods_coefficients[49]*/ mload(add(context, 0x7da0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[49]*/ mload(add(context, 0x5f40)))),
                           PRIME))

                // res += c_50*(f_10(x) - f_10(g^4607 * z)) / (x - g^4607 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4607 * z)^(-1)*/ mload(add(denominatorsPtr, 0x660)),
                                  /*oods_coefficients[50]*/ mload(add(context, 0x7dc0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[50]*/ mload(add(context, 0x5f60)))),
                           PRIME))

                // res += c_51*(f_10(x) - f_10(g^6655 * z)) / (x - g^6655 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^6655 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6a0)),
                                  /*oods_coefficients[51]*/ mload(add(context, 0x7de0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[51]*/ mload(add(context, 0x5f80)))),
                           PRIME))

                // res += c_52*(f_10(x) - f_10(g^8703 * z)) / (x - g^8703 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8703 * z)^(-1)*/ mload(add(denominatorsPtr, 0x740)),
                                  /*oods_coefficients[52]*/ mload(add(context, 0x7e00)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[52]*/ mload(add(context, 0x5fa0)))),
                           PRIME))

                // res += c_53*(f_10(x) - f_10(g^10751 * z)) / (x - g^10751 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^10751 * z)^(-1)*/ mload(add(denominatorsPtr, 0x780)),
                                  /*oods_coefficients[53]*/ mload(add(context, 0x7e20)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[53]*/ mload(add(context, 0x5fc0)))),
                           PRIME))

                // res += c_54*(f_10(x) - f_10(g^14847 * z)) / (x - g^14847 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^14847 * z)^(-1)*/ mload(add(denominatorsPtr, 0x800)),
                                  /*oods_coefficients[54]*/ mload(add(context, 0x7e40)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[54]*/ mload(add(context, 0x5fe0)))),
                           PRIME))

                // res += c_55*(f_10(x) - f_10(g^16639 * z)) / (x - g^16639 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16639 * z)^(-1)*/ mload(add(denominatorsPtr, 0x900)),
                                  /*oods_coefficients[55]*/ mload(add(context, 0x7e60)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[55]*/ mload(add(context, 0x6000)))),
                           PRIME))

                // res += c_56*(f_10(x) - f_10(g^23039 * z)) / (x - g^23039 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^23039 * z)^(-1)*/ mload(add(denominatorsPtr, 0x960)),
                                  /*oods_coefficients[56]*/ mload(add(context, 0x7e80)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[56]*/ mload(add(context, 0x6020)))),
                           PRIME))

                // res += c_57*(f_10(x) - f_10(g^27135 * z)) / (x - g^27135 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^27135 * z)^(-1)*/ mload(add(denominatorsPtr, 0x9c0)),
                                  /*oods_coefficients[57]*/ mload(add(context, 0x7ea0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[57]*/ mload(add(context, 0x6040)))),
                           PRIME))

                // res += c_58*(f_10(x) - f_10(g^31231 * z)) / (x - g^31231 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^31231 * z)^(-1)*/ mload(add(denominatorsPtr, 0xa20)),
                                  /*oods_coefficients[58]*/ mload(add(context, 0x7ec0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[58]*/ mload(add(context, 0x6060)))),
                           PRIME))

                // res += c_59*(f_10(x) - f_10(g^33023 * z)) / (x - g^33023 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^33023 * z)^(-1)*/ mload(add(denominatorsPtr, 0xbc0)),
                                  /*oods_coefficients[59]*/ mload(add(context, 0x7ee0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[59]*/ mload(add(context, 0x6080)))),
                           PRIME))

                // res += c_60*(f_10(x) - f_10(g^47615 * z)) / (x - g^47615 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^47615 * z)^(-1)*/ mload(add(denominatorsPtr, 0xd40)),
                                  /*oods_coefficients[60]*/ mload(add(context, 0x7f00)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[60]*/ mload(add(context, 0x60a0)))),
                           PRIME))

                // res += c_61*(f_10(x) - f_10(g^63999 * z)) / (x - g^63999 * z).
                res := addmod(
                    res,
                    mulmod(mulmod(/*(x - g^63999 * z)^(-1)*/ mload(add(denominatorsPtr, 0xea0)),
                                  /*oods_coefficients[61]*/ mload(add(context, 0x7f20)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[61]*/ mload(add(context, 0x60c0)))),
                           PRIME),
                    PRIME)

                // res += c_62*(f_10(x) - f_10(g^80383 * z)) / (x - g^80383 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^80383 * z)^(-1)*/ mload(add(denominatorsPtr, 0xf40)),
                                  /*oods_coefficients[62]*/ mload(add(context, 0x7f40)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[62]*/ mload(add(context, 0x60e0)))),
                           PRIME))
                }

                // Mask items for column #11.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x160)), kMontgomeryRInv, PRIME)

                // res += c_63*(f_11(x) - f_11(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[63]*/ mload(add(context, 0x7f60)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[63]*/ mload(add(context, 0x6100)))),
                           PRIME))

                // res += c_64*(f_11(x) - f_11(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  /*oods_coefficients[64]*/ mload(add(context, 0x7f80)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[64]*/ mload(add(context, 0x6120)))),
                           PRIME))

                // res += c_65*(f_11(x) - f_11(g^256 * z)) / (x - g^256 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^256 * z)^(-1)*/ mload(add(denominatorsPtr, 0x3a0)),
                                  /*oods_coefficients[65]*/ mload(add(context, 0x7fa0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[65]*/ mload(add(context, 0x6140)))),
                           PRIME))

                // res += c_66*(f_11(x) - f_11(g^512 * z)) / (x - g^512 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^512 * z)^(-1)*/ mload(add(denominatorsPtr, 0x3e0)),
                                  /*oods_coefficients[66]*/ mload(add(context, 0x7fc0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[66]*/ mload(add(context, 0x6160)))),
                           PRIME))

                // res += c_67*(f_11(x) - f_11(g^768 * z)) / (x - g^768 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^768 * z)^(-1)*/ mload(add(denominatorsPtr, 0x420)),
                                  /*oods_coefficients[67]*/ mload(add(context, 0x7fe0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[67]*/ mload(add(context, 0x6180)))),
                           PRIME))
                }

                // Mask items for column #12.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x180)), kMontgomeryRInv, PRIME)

                // res += c_68*(f_12(x) - f_12(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[68]*/ mload(add(context, 0x8000)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[68]*/ mload(add(context, 0x61a0)))),
                           PRIME))

                // res += c_69*(f_12(x) - f_12(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  /*oods_coefficients[69]*/ mload(add(context, 0x8020)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[69]*/ mload(add(context, 0x61c0)))),
                           PRIME))

                // res += c_70*(f_12(x) - f_12(g^255 * z)) / (x - g^255 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^255 * z)^(-1)*/ mload(add(denominatorsPtr, 0x380)),
                                  /*oods_coefficients[70]*/ mload(add(context, 0x8040)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[70]*/ mload(add(context, 0x61e0)))),
                           PRIME))

                // res += c_71*(f_12(x) - f_12(g^256 * z)) / (x - g^256 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^256 * z)^(-1)*/ mload(add(denominatorsPtr, 0x3a0)),
                                  /*oods_coefficients[71]*/ mload(add(context, 0x8060)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[71]*/ mload(add(context, 0x6200)))),
                           PRIME))

                // res += c_72*(f_12(x) - f_12(g^511 * z)) / (x - g^511 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^511 * z)^(-1)*/ mload(add(denominatorsPtr, 0x3c0)),
                                  /*oods_coefficients[72]*/ mload(add(context, 0x8080)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[72]*/ mload(add(context, 0x6220)))),
                           PRIME))

                // res += c_73*(f_12(x) - f_12(g^32255 * z)) / (x - g^32255 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^32255 * z)^(-1)*/ mload(add(denominatorsPtr, 0xa40)),
                                  /*oods_coefficients[73]*/ mload(add(context, 0x80a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[73]*/ mload(add(context, 0x6240)))),
                           PRIME))

                // res += c_74*(f_12(x) - f_12(g^65023 * z)) / (x - g^65023 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^65023 * z)^(-1)*/ mload(add(denominatorsPtr, 0xec0)),
                                  /*oods_coefficients[74]*/ mload(add(context, 0x80c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[74]*/ mload(add(context, 0x6260)))),
                           PRIME))
                }

                // Mask items for column #13.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x1a0)), kMontgomeryRInv, PRIME)

                // res += c_75*(f_13(x) - f_13(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[75]*/ mload(add(context, 0x80e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[75]*/ mload(add(context, 0x6280)))),
                           PRIME))

                // res += c_76*(f_13(x) - f_13(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  /*oods_coefficients[76]*/ mload(add(context, 0x8100)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[76]*/ mload(add(context, 0x62a0)))),
                           PRIME))

                // res += c_77*(f_13(x) - f_13(g^255 * z)) / (x - g^255 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^255 * z)^(-1)*/ mload(add(denominatorsPtr, 0x380)),
                                  /*oods_coefficients[77]*/ mload(add(context, 0x8120)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[77]*/ mload(add(context, 0x62c0)))),
                           PRIME))

                // res += c_78*(f_13(x) - f_13(g^256 * z)) / (x - g^256 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^256 * z)^(-1)*/ mload(add(denominatorsPtr, 0x3a0)),
                                  /*oods_coefficients[78]*/ mload(add(context, 0x8140)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[78]*/ mload(add(context, 0x62e0)))),
                           PRIME))
                }

                // Mask items for column #14.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x1c0)), kMontgomeryRInv, PRIME)

                // res += c_79*(f_14(x) - f_14(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[79]*/ mload(add(context, 0x8160)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[79]*/ mload(add(context, 0x6300)))),
                           PRIME))

                // res += c_80*(f_14(x) - f_14(g^255 * z)) / (x - g^255 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^255 * z)^(-1)*/ mload(add(denominatorsPtr, 0x380)),
                                  /*oods_coefficients[80]*/ mload(add(context, 0x8180)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[80]*/ mload(add(context, 0x6320)))),
                           PRIME))

                // res += c_81*(f_14(x) - f_14(g^511 * z)) / (x - g^511 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^511 * z)^(-1)*/ mload(add(denominatorsPtr, 0x3c0)),
                                  /*oods_coefficients[81]*/ mload(add(context, 0x81a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[81]*/ mload(add(context, 0x6340)))),
                           PRIME))

                // res += c_82*(f_14(x) - f_14(g^767 * z)) / (x - g^767 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^767 * z)^(-1)*/ mload(add(denominatorsPtr, 0x400)),
                                  /*oods_coefficients[82]*/ mload(add(context, 0x81c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[82]*/ mload(add(context, 0x6360)))),
                           PRIME))

                // res += c_83*(f_14(x) - f_14(g^1023 * z)) / (x - g^1023 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^1023 * z)^(-1)*/ mload(add(denominatorsPtr, 0x4a0)),
                                  /*oods_coefficients[83]*/ mload(add(context, 0x81e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[83]*/ mload(add(context, 0x6380)))),
                           PRIME))

                // res += c_84*(f_14(x) - f_14(g^1279 * z)) / (x - g^1279 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^1279 * z)^(-1)*/ mload(add(denominatorsPtr, 0x520)),
                                  /*oods_coefficients[84]*/ mload(add(context, 0x8200)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[84]*/ mload(add(context, 0x63a0)))),
                           PRIME))

                // res += c_85*(f_14(x) - f_14(g^1535 * z)) / (x - g^1535 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^1535 * z)^(-1)*/ mload(add(denominatorsPtr, 0x540)),
                                  /*oods_coefficients[85]*/ mload(add(context, 0x8220)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[85]*/ mload(add(context, 0x63c0)))),
                           PRIME))

                // res += c_86*(f_14(x) - f_14(g^16639 * z)) / (x - g^16639 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16639 * z)^(-1)*/ mload(add(denominatorsPtr, 0x900)),
                                  /*oods_coefficients[86]*/ mload(add(context, 0x8240)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[86]*/ mload(add(context, 0x63e0)))),
                           PRIME))

                // res += c_87*(f_14(x) - f_14(g^33023 * z)) / (x - g^33023 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^33023 * z)^(-1)*/ mload(add(denominatorsPtr, 0xbc0)),
                                  /*oods_coefficients[87]*/ mload(add(context, 0x8260)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[87]*/ mload(add(context, 0x6400)))),
                           PRIME))

                // res += c_88*(f_14(x) - f_14(g^33279 * z)) / (x - g^33279 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^33279 * z)^(-1)*/ mload(add(denominatorsPtr, 0xbe0)),
                                  /*oods_coefficients[88]*/ mload(add(context, 0x8280)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[88]*/ mload(add(context, 0x6420)))),
                           PRIME))

                // res += c_89*(f_14(x) - f_14(g^49407 * z)) / (x - g^49407 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^49407 * z)^(-1)*/ mload(add(denominatorsPtr, 0xdc0)),
                                  /*oods_coefficients[89]*/ mload(add(context, 0x82a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[89]*/ mload(add(context, 0x6440)))),
                           PRIME))
                }

                // Mask items for column #15.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x1e0)), kMontgomeryRInv, PRIME)

                // res += c_90*(f_15(x) - f_15(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[90]*/ mload(add(context, 0x82c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[90]*/ mload(add(context, 0x6460)))),
                           PRIME))

                // res += c_91*(f_15(x) - f_15(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  /*oods_coefficients[91]*/ mload(add(context, 0x82e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[91]*/ mload(add(context, 0x6480)))),
                           PRIME))

                // res += c_92*(f_15(x) - f_15(g^256 * z)) / (x - g^256 * z).
                res := addmod(
                    res,
                    mulmod(mulmod(/*(x - g^256 * z)^(-1)*/ mload(add(denominatorsPtr, 0x3a0)),
                                  /*oods_coefficients[92]*/ mload(add(context, 0x8300)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[92]*/ mload(add(context, 0x64a0)))),
                           PRIME),
                    PRIME)

                // res += c_93*(f_15(x) - f_15(g^512 * z)) / (x - g^512 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^512 * z)^(-1)*/ mload(add(denominatorsPtr, 0x3e0)),
                                  /*oods_coefficients[93]*/ mload(add(context, 0x8320)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[93]*/ mload(add(context, 0x64c0)))),
                           PRIME))

                // res += c_94*(f_15(x) - f_15(g^768 * z)) / (x - g^768 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^768 * z)^(-1)*/ mload(add(denominatorsPtr, 0x420)),
                                  /*oods_coefficients[94]*/ mload(add(context, 0x8340)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[94]*/ mload(add(context, 0x64e0)))),
                           PRIME))
                }

                // Mask items for column #16.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x200)), kMontgomeryRInv, PRIME)

                // res += c_95*(f_16(x) - f_16(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[95]*/ mload(add(context, 0x8360)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[95]*/ mload(add(context, 0x6500)))),
                           PRIME))

                // res += c_96*(f_16(x) - f_16(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  /*oods_coefficients[96]*/ mload(add(context, 0x8380)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[96]*/ mload(add(context, 0x6520)))),
                           PRIME))

                // res += c_97*(f_16(x) - f_16(g^2 * z)) / (x - g^2 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2 * z)^(-1)*/ mload(add(denominatorsPtr, 0x40)),
                                  /*oods_coefficients[97]*/ mload(add(context, 0x83a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[97]*/ mload(add(context, 0x6540)))),
                           PRIME))

                // res += c_98*(f_16(x) - f_16(g^3 * z)) / (x - g^3 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3 * z)^(-1)*/ mload(add(denominatorsPtr, 0x60)),
                                  /*oods_coefficients[98]*/ mload(add(context, 0x83c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[98]*/ mload(add(context, 0x6560)))),
                           PRIME))

                // res += c_99*(f_16(x) - f_16(g^4 * z)) / (x - g^4 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4 * z)^(-1)*/ mload(add(denominatorsPtr, 0x80)),
                                  /*oods_coefficients[99]*/ mload(add(context, 0x83e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[99]*/ mload(add(context, 0x6580)))),
                           PRIME))

                // res += c_100*(f_16(x) - f_16(g^6 * z)) / (x - g^6 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^6 * z)^(-1)*/ mload(add(denominatorsPtr, 0xa0)),
                                  /*oods_coefficients[100]*/ mload(add(context, 0x8400)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[100]*/ mload(add(context, 0x65a0)))),
                           PRIME))

                // res += c_101*(f_16(x) - f_16(g^7 * z)) / (x - g^7 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^7 * z)^(-1)*/ mload(add(denominatorsPtr, 0xc0)),
                                  /*oods_coefficients[101]*/ mload(add(context, 0x8420)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[101]*/ mload(add(context, 0x65c0)))),
                           PRIME))

                // res += c_102*(f_16(x) - f_16(g^1020 * z)) / (x - g^1020 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^1020 * z)^(-1)*/ mload(add(denominatorsPtr, 0x440)),
                                  /*oods_coefficients[102]*/ mload(add(context, 0x8440)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[102]*/ mload(add(context, 0x65e0)))),
                           PRIME))

                // res += c_103*(f_16(x) - f_16(g^1021 * z)) / (x - g^1021 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^1021 * z)^(-1)*/ mload(add(denominatorsPtr, 0x460)),
                                  /*oods_coefficients[103]*/ mload(add(context, 0x8460)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[103]*/ mload(add(context, 0x6600)))),
                           PRIME))

                // res += c_104*(f_16(x) - f_16(g^1022 * z)) / (x - g^1022 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^1022 * z)^(-1)*/ mload(add(denominatorsPtr, 0x480)),
                                  /*oods_coefficients[104]*/ mload(add(context, 0x8480)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[104]*/ mload(add(context, 0x6620)))),
                           PRIME))

                // res += c_105*(f_16(x) - f_16(g^1024 * z)) / (x - g^1024 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^1024 * z)^(-1)*/ mload(add(denominatorsPtr, 0x4c0)),
                                  /*oods_coefficients[105]*/ mload(add(context, 0x84a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[105]*/ mload(add(context, 0x6640)))),
                           PRIME))

                // res += c_106*(f_16(x) - f_16(g^1026 * z)) / (x - g^1026 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^1026 * z)^(-1)*/ mload(add(denominatorsPtr, 0x4e0)),
                                  /*oods_coefficients[106]*/ mload(add(context, 0x84c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[106]*/ mload(add(context, 0x6660)))),
                           PRIME))

                // res += c_107*(f_16(x) - f_16(g^1027 * z)) / (x - g^1027 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^1027 * z)^(-1)*/ mload(add(denominatorsPtr, 0x500)),
                                  /*oods_coefficients[107]*/ mload(add(context, 0x84e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[107]*/ mload(add(context, 0x6680)))),
                           PRIME))

                // res += c_108*(f_16(x) - f_16(g^2044 * z)) / (x - g^2044 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2044 * z)^(-1)*/ mload(add(denominatorsPtr, 0x560)),
                                  /*oods_coefficients[108]*/ mload(add(context, 0x8500)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[108]*/ mload(add(context, 0x66a0)))),
                           PRIME))

                // res += c_109*(f_16(x) - f_16(g^2045 * z)) / (x - g^2045 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2045 * z)^(-1)*/ mload(add(denominatorsPtr, 0x580)),
                                  /*oods_coefficients[109]*/ mload(add(context, 0x8520)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[109]*/ mload(add(context, 0x66c0)))),
                           PRIME))

                // res += c_110*(f_16(x) - f_16(g^2051 * z)) / (x - g^2051 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2051 * z)^(-1)*/ mload(add(denominatorsPtr, 0x5a0)),
                                  /*oods_coefficients[110]*/ mload(add(context, 0x8540)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[110]*/ mload(add(context, 0x66e0)))),
                           PRIME))

                // res += c_111*(f_16(x) - f_16(g^3075 * z)) / (x - g^3075 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3075 * z)^(-1)*/ mload(add(denominatorsPtr, 0x5e0)),
                                  /*oods_coefficients[111]*/ mload(add(context, 0x8560)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[111]*/ mload(add(context, 0x6700)))),
                           PRIME))

                // res += c_112*(f_16(x) - f_16(g^4092 * z)) / (x - g^4092 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4092 * z)^(-1)*/ mload(add(denominatorsPtr, 0x600)),
                                  /*oods_coefficients[112]*/ mload(add(context, 0x8580)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[112]*/ mload(add(context, 0x6720)))),
                           PRIME))

                // res += c_113*(f_16(x) - f_16(g^4099 * z)) / (x - g^4099 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4099 * z)^(-1)*/ mload(add(denominatorsPtr, 0x640)),
                                  /*oods_coefficients[113]*/ mload(add(context, 0x85a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[113]*/ mload(add(context, 0x6740)))),
                           PRIME))

                // res += c_114*(f_16(x) - f_16(g^5123 * z)) / (x - g^5123 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^5123 * z)^(-1)*/ mload(add(denominatorsPtr, 0x680)),
                                  /*oods_coefficients[114]*/ mload(add(context, 0x85c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[114]*/ mload(add(context, 0x6760)))),
                           PRIME))

                // res += c_115*(f_16(x) - f_16(g^7171 * z)) / (x - g^7171 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^7171 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6c0)),
                                  /*oods_coefficients[115]*/ mload(add(context, 0x85e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[115]*/ mload(add(context, 0x6780)))),
                           PRIME))

                // res += c_116*(f_16(x) - f_16(g^8188 * z)) / (x - g^8188 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8188 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6e0)),
                                  /*oods_coefficients[116]*/ mload(add(context, 0x8600)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[116]*/ mload(add(context, 0x67a0)))),
                           PRIME))

                // res += c_117*(f_16(x) - f_16(g^8195 * z)) / (x - g^8195 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8195 * z)^(-1)*/ mload(add(denominatorsPtr, 0x720)),
                                  /*oods_coefficients[117]*/ mload(add(context, 0x8620)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[117]*/ mload(add(context, 0x67c0)))),
                           PRIME))

                // res += c_118*(f_16(x) - f_16(g^9219 * z)) / (x - g^9219 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^9219 * z)^(-1)*/ mload(add(denominatorsPtr, 0x760)),
                                  /*oods_coefficients[118]*/ mload(add(context, 0x8640)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[118]*/ mload(add(context, 0x67e0)))),
                           PRIME))

                // res += c_119*(f_16(x) - f_16(g^11267 * z)) / (x - g^11267 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^11267 * z)^(-1)*/ mload(add(denominatorsPtr, 0x7a0)),
                                  /*oods_coefficients[119]*/ mload(add(context, 0x8660)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[119]*/ mload(add(context, 0x6800)))),
                           PRIME))

                // res += c_120*(f_16(x) - f_16(g^12284 * z)) / (x - g^12284 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^12284 * z)^(-1)*/ mload(add(denominatorsPtr, 0x7c0)),
                                  /*oods_coefficients[120]*/ mload(add(context, 0x8680)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[120]*/ mload(add(context, 0x6820)))),
                           PRIME))

                // res += c_121*(f_16(x) - f_16(g^19459 * z)) / (x - g^19459 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^19459 * z)^(-1)*/ mload(add(denominatorsPtr, 0x920)),
                                  /*oods_coefficients[121]*/ mload(add(context, 0x86a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[121]*/ mload(add(context, 0x6840)))),
                           PRIME))

                // res += c_122*(f_16(x) - f_16(g^27651 * z)) / (x - g^27651 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^27651 * z)^(-1)*/ mload(add(denominatorsPtr, 0x9e0)),
                                  /*oods_coefficients[122]*/ mload(add(context, 0x86c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[122]*/ mload(add(context, 0x6860)))),
                           PRIME))

                // res += c_123*(f_16(x) - f_16(g^33789 * z)) / (x - g^33789 * z).
                res := addmod(
                    res,
                    mulmod(mulmod(/*(x - g^33789 * z)^(-1)*/ mload(add(denominatorsPtr, 0xc00)),
                                  /*oods_coefficients[123]*/ mload(add(context, 0x86e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[123]*/ mload(add(context, 0x6880)))),
                           PRIME),
                    PRIME)

                // res += c_124*(f_16(x) - f_16(g^35843 * z)) / (x - g^35843 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^35843 * z)^(-1)*/ mload(add(denominatorsPtr, 0xc20)),
                                  /*oods_coefficients[124]*/ mload(add(context, 0x8700)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[124]*/ mload(add(context, 0x68a0)))),
                           PRIME))

                // res += c_125*(f_16(x) - f_16(g^36867 * z)) / (x - g^36867 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^36867 * z)^(-1)*/ mload(add(denominatorsPtr, 0xc60)),
                                  /*oods_coefficients[125]*/ mload(add(context, 0x8720)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[125]*/ mload(add(context, 0x68c0)))),
                           PRIME))

                // res += c_126*(f_16(x) - f_16(g^37891 * z)) / (x - g^37891 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^37891 * z)^(-1)*/ mload(add(denominatorsPtr, 0xc80)),
                                  /*oods_coefficients[126]*/ mload(add(context, 0x8740)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[126]*/ mload(add(context, 0x68e0)))),
                           PRIME))

                // res += c_127*(f_16(x) - f_16(g^39939 * z)) / (x - g^39939 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^39939 * z)^(-1)*/ mload(add(denominatorsPtr, 0xca0)),
                                  /*oods_coefficients[127]*/ mload(add(context, 0x8760)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[127]*/ mload(add(context, 0x6900)))),
                           PRIME))

                // res += c_128*(f_16(x) - f_16(g^40956 * z)) / (x - g^40956 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^40956 * z)^(-1)*/ mload(add(denominatorsPtr, 0xcc0)),
                                  /*oods_coefficients[128]*/ mload(add(context, 0x8780)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[128]*/ mload(add(context, 0x6920)))),
                           PRIME))

                // res += c_129*(f_16(x) - f_16(g^44035 * z)) / (x - g^44035 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^44035 * z)^(-1)*/ mload(add(denominatorsPtr, 0xd00)),
                                  /*oods_coefficients[129]*/ mload(add(context, 0x87a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[129]*/ mload(add(context, 0x6940)))),
                           PRIME))

                // res += c_130*(f_16(x) - f_16(g^52227 * z)) / (x - g^52227 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^52227 * z)^(-1)*/ mload(add(denominatorsPtr, 0xde0)),
                                  /*oods_coefficients[130]*/ mload(add(context, 0x87c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[130]*/ mload(add(context, 0x6960)))),
                           PRIME))

                // res += c_131*(f_16(x) - f_16(g^60419 * z)) / (x - g^60419 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^60419 * z)^(-1)*/ mload(add(denominatorsPtr, 0xe60)),
                                  /*oods_coefficients[131]*/ mload(add(context, 0x87e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[131]*/ mload(add(context, 0x6980)))),
                           PRIME))
                }

                // Mask items for column #17.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x220)), kMontgomeryRInv, PRIME)

                // res += c_132*(f_17(x) - f_17(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[132]*/ mload(add(context, 0x8800)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[132]*/ mload(add(context, 0x69a0)))),
                           PRIME))

                // res += c_133*(f_17(x) - f_17(g^4 * z)) / (x - g^4 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4 * z)^(-1)*/ mload(add(denominatorsPtr, 0x80)),
                                  /*oods_coefficients[133]*/ mload(add(context, 0x8820)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[133]*/ mload(add(context, 0x69c0)))),
                           PRIME))

                // res += c_134*(f_17(x) - f_17(g^8 * z)) / (x - g^8 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8 * z)^(-1)*/ mload(add(denominatorsPtr, 0xe0)),
                                  /*oods_coefficients[134]*/ mload(add(context, 0x8840)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[134]*/ mload(add(context, 0x69e0)))),
                           PRIME))

                // res += c_135*(f_17(x) - f_17(g^16 * z)) / (x - g^16 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16 * z)^(-1)*/ mload(add(denominatorsPtr, 0x100)),
                                  /*oods_coefficients[135]*/ mload(add(context, 0x8860)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[135]*/ mload(add(context, 0x6a00)))),
                           PRIME))

                // res += c_136*(f_17(x) - f_17(g^20 * z)) / (x - g^20 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^20 * z)^(-1)*/ mload(add(denominatorsPtr, 0x120)),
                                  /*oods_coefficients[136]*/ mload(add(context, 0x8880)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[136]*/ mload(add(context, 0x6a20)))),
                           PRIME))

                // res += c_137*(f_17(x) - f_17(g^24 * z)) / (x - g^24 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^24 * z)^(-1)*/ mload(add(denominatorsPtr, 0x140)),
                                  /*oods_coefficients[137]*/ mload(add(context, 0x88a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[137]*/ mload(add(context, 0x6a40)))),
                           PRIME))

                // res += c_138*(f_17(x) - f_17(g^32 * z)) / (x - g^32 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^32 * z)^(-1)*/ mload(add(denominatorsPtr, 0x160)),
                                  /*oods_coefficients[138]*/ mload(add(context, 0x88c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[138]*/ mload(add(context, 0x6a60)))),
                           PRIME))

                // res += c_139*(f_17(x) - f_17(g^36 * z)) / (x - g^36 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^36 * z)^(-1)*/ mload(add(denominatorsPtr, 0x180)),
                                  /*oods_coefficients[139]*/ mload(add(context, 0x88e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[139]*/ mload(add(context, 0x6a80)))),
                           PRIME))

                // res += c_140*(f_17(x) - f_17(g^40 * z)) / (x - g^40 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^40 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1a0)),
                                  /*oods_coefficients[140]*/ mload(add(context, 0x8900)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[140]*/ mload(add(context, 0x6aa0)))),
                           PRIME))

                // res += c_141*(f_17(x) - f_17(g^48 * z)) / (x - g^48 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^48 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1c0)),
                                  /*oods_coefficients[141]*/ mload(add(context, 0x8920)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[141]*/ mload(add(context, 0x6ac0)))),
                           PRIME))

                // res += c_142*(f_17(x) - f_17(g^52 * z)) / (x - g^52 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^52 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1e0)),
                                  /*oods_coefficients[142]*/ mload(add(context, 0x8940)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[142]*/ mload(add(context, 0x6ae0)))),
                           PRIME))

                // res += c_143*(f_17(x) - f_17(g^56 * z)) / (x - g^56 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^56 * z)^(-1)*/ mload(add(denominatorsPtr, 0x200)),
                                  /*oods_coefficients[143]*/ mload(add(context, 0x8960)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[143]*/ mload(add(context, 0x6b00)))),
                           PRIME))

                // res += c_144*(f_17(x) - f_17(g^64 * z)) / (x - g^64 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^64 * z)^(-1)*/ mload(add(denominatorsPtr, 0x220)),
                                  /*oods_coefficients[144]*/ mload(add(context, 0x8980)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[144]*/ mload(add(context, 0x6b20)))),
                           PRIME))

                // res += c_145*(f_17(x) - f_17(g^72 * z)) / (x - g^72 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^72 * z)^(-1)*/ mload(add(denominatorsPtr, 0x240)),
                                  /*oods_coefficients[145]*/ mload(add(context, 0x89a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[145]*/ mload(add(context, 0x6b40)))),
                           PRIME))

                // res += c_146*(f_17(x) - f_17(g^80 * z)) / (x - g^80 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^80 * z)^(-1)*/ mload(add(denominatorsPtr, 0x260)),
                                  /*oods_coefficients[146]*/ mload(add(context, 0x89c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[146]*/ mload(add(context, 0x6b60)))),
                           PRIME))

                // res += c_147*(f_17(x) - f_17(g^84 * z)) / (x - g^84 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^84 * z)^(-1)*/ mload(add(denominatorsPtr, 0x280)),
                                  /*oods_coefficients[147]*/ mload(add(context, 0x89e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[147]*/ mload(add(context, 0x6b80)))),
                           PRIME))

                // res += c_148*(f_17(x) - f_17(g^96 * z)) / (x - g^96 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^96 * z)^(-1)*/ mload(add(denominatorsPtr, 0x2a0)),
                                  /*oods_coefficients[148]*/ mload(add(context, 0x8a00)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[148]*/ mload(add(context, 0x6ba0)))),
                           PRIME))

                // res += c_149*(f_17(x) - f_17(g^100 * z)) / (x - g^100 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^100 * z)^(-1)*/ mload(add(denominatorsPtr, 0x2c0)),
                                  /*oods_coefficients[149]*/ mload(add(context, 0x8a20)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[149]*/ mload(add(context, 0x6bc0)))),
                           PRIME))

                // res += c_150*(f_17(x) - f_17(g^104 * z)) / (x - g^104 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^104 * z)^(-1)*/ mload(add(denominatorsPtr, 0x2e0)),
                                  /*oods_coefficients[150]*/ mload(add(context, 0x8a40)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[150]*/ mload(add(context, 0x6be0)))),
                           PRIME))

                // res += c_151*(f_17(x) - f_17(g^120 * z)) / (x - g^120 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^120 * z)^(-1)*/ mload(add(denominatorsPtr, 0x300)),
                                  /*oods_coefficients[151]*/ mload(add(context, 0x8a60)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[151]*/ mload(add(context, 0x6c00)))),
                           PRIME))

                // res += c_152*(f_17(x) - f_17(g^164 * z)) / (x - g^164 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^164 * z)^(-1)*/ mload(add(denominatorsPtr, 0x320)),
                                  /*oods_coefficients[152]*/ mload(add(context, 0x8a80)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[152]*/ mload(add(context, 0x6c20)))),
                           PRIME))

                // res += c_153*(f_17(x) - f_17(g^212 * z)) / (x - g^212 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^212 * z)^(-1)*/ mload(add(denominatorsPtr, 0x340)),
                                  /*oods_coefficients[153]*/ mload(add(context, 0x8aa0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[153]*/ mload(add(context, 0x6c40)))),
                           PRIME))

                // res += c_154*(f_17(x) - f_17(g^228 * z)) / (x - g^228 * z).
                res := addmod(
                    res,
                    mulmod(mulmod(/*(x - g^228 * z)^(-1)*/ mload(add(denominatorsPtr, 0x360)),
                                  /*oods_coefficients[154]*/ mload(add(context, 0x8ac0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[154]*/ mload(add(context, 0x6c60)))),
                           PRIME),
                    PRIME)

                // res += c_155*(f_17(x) - f_17(g^4096 * z)) / (x - g^4096 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4096 * z)^(-1)*/ mload(add(denominatorsPtr, 0x620)),
                                  /*oods_coefficients[155]*/ mload(add(context, 0x8ae0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[155]*/ mload(add(context, 0x6c80)))),
                           PRIME))

                // res += c_156*(f_17(x) - f_17(g^8192 * z)) / (x - g^8192 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8192 * z)^(-1)*/ mload(add(denominatorsPtr, 0x700)),
                                  /*oods_coefficients[156]*/ mload(add(context, 0x8b00)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[156]*/ mload(add(context, 0x6ca0)))),
                           PRIME))

                // res += c_157*(f_17(x) - f_17(g^12288 * z)) / (x - g^12288 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^12288 * z)^(-1)*/ mload(add(denominatorsPtr, 0x7e0)),
                                  /*oods_coefficients[157]*/ mload(add(context, 0x8b20)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[157]*/ mload(add(context, 0x6cc0)))),
                           PRIME))

                // res += c_158*(f_17(x) - f_17(g^16324 * z)) / (x - g^16324 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16324 * z)^(-1)*/ mload(add(denominatorsPtr, 0x820)),
                                  /*oods_coefficients[158]*/ mload(add(context, 0x8b40)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[158]*/ mload(add(context, 0x6ce0)))),
                           PRIME))

                // res += c_159*(f_17(x) - f_17(g^16328 * z)) / (x - g^16328 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16328 * z)^(-1)*/ mload(add(denominatorsPtr, 0x840)),
                                  /*oods_coefficients[159]*/ mload(add(context, 0x8b60)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[159]*/ mload(add(context, 0x6d00)))),
                           PRIME))

                // res += c_160*(f_17(x) - f_17(g^16344 * z)) / (x - g^16344 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16344 * z)^(-1)*/ mload(add(denominatorsPtr, 0x860)),
                                  /*oods_coefficients[160]*/ mload(add(context, 0x8b80)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[160]*/ mload(add(context, 0x6d20)))),
                           PRIME))

                // res += c_161*(f_17(x) - f_17(g^16360 * z)) / (x - g^16360 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16360 * z)^(-1)*/ mload(add(denominatorsPtr, 0x880)),
                                  /*oods_coefficients[161]*/ mload(add(context, 0x8ba0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[161]*/ mload(add(context, 0x6d40)))),
                           PRIME))

                // res += c_162*(f_17(x) - f_17(g^16368 * z)) / (x - g^16368 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16368 * z)^(-1)*/ mload(add(denominatorsPtr, 0x8a0)),
                                  /*oods_coefficients[162]*/ mload(add(context, 0x8bc0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[162]*/ mload(add(context, 0x6d60)))),
                           PRIME))

                // res += c_163*(f_17(x) - f_17(g^16400 * z)) / (x - g^16400 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16400 * z)^(-1)*/ mload(add(denominatorsPtr, 0x8c0)),
                                  /*oods_coefficients[163]*/ mload(add(context, 0x8be0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[163]*/ mload(add(context, 0x6d80)))),
                           PRIME))

                // res += c_164*(f_17(x) - f_17(g^16416 * z)) / (x - g^16416 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16416 * z)^(-1)*/ mload(add(denominatorsPtr, 0x8e0)),
                                  /*oods_coefficients[164]*/ mload(add(context, 0x8c00)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[164]*/ mload(add(context, 0x6da0)))),
                           PRIME))

                // res += c_165*(f_17(x) - f_17(g^20480 * z)) / (x - g^20480 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^20480 * z)^(-1)*/ mload(add(denominatorsPtr, 0x940)),
                                  /*oods_coefficients[165]*/ mload(add(context, 0x8c20)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[165]*/ mload(add(context, 0x6dc0)))),
                           PRIME))

                // res += c_166*(f_17(x) - f_17(g^24148 * z)) / (x - g^24148 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^24148 * z)^(-1)*/ mload(add(denominatorsPtr, 0x980)),
                                  /*oods_coefficients[166]*/ mload(add(context, 0x8c40)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[166]*/ mload(add(context, 0x6de0)))),
                           PRIME))

                // res += c_167*(f_17(x) - f_17(g^24576 * z)) / (x - g^24576 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^24576 * z)^(-1)*/ mload(add(denominatorsPtr, 0x9a0)),
                                  /*oods_coefficients[167]*/ mload(add(context, 0x8c60)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[167]*/ mload(add(context, 0x6e00)))),
                           PRIME))

                // res += c_168*(f_17(x) - f_17(g^28672 * z)) / (x - g^28672 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^28672 * z)^(-1)*/ mload(add(denominatorsPtr, 0xa00)),
                                  /*oods_coefficients[168]*/ mload(add(context, 0x8c80)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[168]*/ mload(add(context, 0x6e20)))),
                           PRIME))

                // res += c_169*(f_17(x) - f_17(g^32660 * z)) / (x - g^32660 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^32660 * z)^(-1)*/ mload(add(denominatorsPtr, 0xa60)),
                                  /*oods_coefficients[169]*/ mload(add(context, 0x8ca0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[169]*/ mload(add(context, 0x6e40)))),
                           PRIME))

                // res += c_170*(f_17(x) - f_17(g^32676 * z)) / (x - g^32676 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^32676 * z)^(-1)*/ mload(add(denominatorsPtr, 0xa80)),
                                  /*oods_coefficients[170]*/ mload(add(context, 0x8cc0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[170]*/ mload(add(context, 0x6e60)))),
                           PRIME))

                // res += c_171*(f_17(x) - f_17(g^32692 * z)) / (x - g^32692 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^32692 * z)^(-1)*/ mload(add(denominatorsPtr, 0xaa0)),
                                  /*oods_coefficients[171]*/ mload(add(context, 0x8ce0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[171]*/ mload(add(context, 0x6e80)))),
                           PRIME))

                // res += c_172*(f_17(x) - f_17(g^32708 * z)) / (x - g^32708 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^32708 * z)^(-1)*/ mload(add(denominatorsPtr, 0xac0)),
                                  /*oods_coefficients[172]*/ mload(add(context, 0x8d00)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[172]*/ mload(add(context, 0x6ea0)))),
                           PRIME))

                // res += c_173*(f_17(x) - f_17(g^32712 * z)) / (x - g^32712 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^32712 * z)^(-1)*/ mload(add(denominatorsPtr, 0xae0)),
                                  /*oods_coefficients[173]*/ mload(add(context, 0x8d20)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[173]*/ mload(add(context, 0x6ec0)))),
                           PRIME))

                // res += c_174*(f_17(x) - f_17(g^32728 * z)) / (x - g^32728 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^32728 * z)^(-1)*/ mload(add(denominatorsPtr, 0xb00)),
                                  /*oods_coefficients[174]*/ mload(add(context, 0x8d40)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[174]*/ mload(add(context, 0x6ee0)))),
                           PRIME))

                // res += c_175*(f_17(x) - f_17(g^32740 * z)) / (x - g^32740 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^32740 * z)^(-1)*/ mload(add(denominatorsPtr, 0xb20)),
                                  /*oods_coefficients[175]*/ mload(add(context, 0x8d60)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[175]*/ mload(add(context, 0x6f00)))),
                           PRIME))

                // res += c_176*(f_17(x) - f_17(g^32744 * z)) / (x - g^32744 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^32744 * z)^(-1)*/ mload(add(denominatorsPtr, 0xb40)),
                                  /*oods_coefficients[176]*/ mload(add(context, 0x8d80)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[176]*/ mload(add(context, 0x6f20)))),
                           PRIME))

                // res += c_177*(f_17(x) - f_17(g^32752 * z)) / (x - g^32752 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^32752 * z)^(-1)*/ mload(add(denominatorsPtr, 0xb60)),
                                  /*oods_coefficients[177]*/ mload(add(context, 0x8da0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[177]*/ mload(add(context, 0x6f40)))),
                           PRIME))

                // res += c_178*(f_17(x) - f_17(g^32800 * z)) / (x - g^32800 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^32800 * z)^(-1)*/ mload(add(denominatorsPtr, 0xb80)),
                                  /*oods_coefficients[178]*/ mload(add(context, 0x8dc0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[178]*/ mload(add(context, 0x6f60)))),
                           PRIME))

                // res += c_179*(f_17(x) - f_17(g^32852 * z)) / (x - g^32852 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^32852 * z)^(-1)*/ mload(add(denominatorsPtr, 0xba0)),
                                  /*oods_coefficients[179]*/ mload(add(context, 0x8de0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[179]*/ mload(add(context, 0x6f80)))),
                           PRIME))

                // res += c_180*(f_17(x) - f_17(g^36864 * z)) / (x - g^36864 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^36864 * z)^(-1)*/ mload(add(denominatorsPtr, 0xc40)),
                                  /*oods_coefficients[180]*/ mload(add(context, 0x8e00)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[180]*/ mload(add(context, 0x6fa0)))),
                           PRIME))

                // res += c_181*(f_17(x) - f_17(g^40960 * z)) / (x - g^40960 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^40960 * z)^(-1)*/ mload(add(denominatorsPtr, 0xce0)),
                                  /*oods_coefficients[181]*/ mload(add(context, 0x8e20)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[181]*/ mload(add(context, 0x6fc0)))),
                           PRIME))

                // res += c_182*(f_17(x) - f_17(g^45056 * z)) / (x - g^45056 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^45056 * z)^(-1)*/ mload(add(denominatorsPtr, 0xd20)),
                                  /*oods_coefficients[182]*/ mload(add(context, 0x8e40)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[182]*/ mload(add(context, 0x6fe0)))),
                           PRIME))

                // res += c_183*(f_17(x) - f_17(g^49092 * z)) / (x - g^49092 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^49092 * z)^(-1)*/ mload(add(denominatorsPtr, 0xd60)),
                                  /*oods_coefficients[183]*/ mload(add(context, 0x8e60)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[183]*/ mload(add(context, 0x7000)))),
                           PRIME))

                // res += c_184*(f_17(x) - f_17(g^49112 * z)) / (x - g^49112 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^49112 * z)^(-1)*/ mload(add(denominatorsPtr, 0xd80)),
                                  /*oods_coefficients[184]*/ mload(add(context, 0x8e80)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[184]*/ mload(add(context, 0x7020)))),
                           PRIME))

                // res += c_185*(f_17(x) - f_17(g^49136 * z)) / (x - g^49136 * z).
                res := addmod(
                    res,
                    mulmod(mulmod(/*(x - g^49136 * z)^(-1)*/ mload(add(denominatorsPtr, 0xda0)),
                                  /*oods_coefficients[185]*/ mload(add(context, 0x8ea0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[185]*/ mload(add(context, 0x7040)))),
                           PRIME),
                    PRIME)

                // res += c_186*(f_17(x) - f_17(g^53248 * z)) / (x - g^53248 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^53248 * z)^(-1)*/ mload(add(denominatorsPtr, 0xe00)),
                                  /*oods_coefficients[186]*/ mload(add(context, 0x8ec0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[186]*/ mload(add(context, 0x7060)))),
                           PRIME))

                // res += c_187*(f_17(x) - f_17(g^56916 * z)) / (x - g^56916 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^56916 * z)^(-1)*/ mload(add(denominatorsPtr, 0xe20)),
                                  /*oods_coefficients[187]*/ mload(add(context, 0x8ee0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[187]*/ mload(add(context, 0x7080)))),
                           PRIME))

                // res += c_188*(f_17(x) - f_17(g^57344 * z)) / (x - g^57344 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^57344 * z)^(-1)*/ mload(add(denominatorsPtr, 0xe40)),
                                  /*oods_coefficients[188]*/ mload(add(context, 0x8f00)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[188]*/ mload(add(context, 0x70a0)))),
                           PRIME))

                // res += c_189*(f_17(x) - f_17(g^61440 * z)) / (x - g^61440 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^61440 * z)^(-1)*/ mload(add(denominatorsPtr, 0xe80)),
                                  /*oods_coefficients[189]*/ mload(add(context, 0x8f20)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[189]*/ mload(add(context, 0x70c0)))),
                           PRIME))

                // res += c_190*(f_17(x) - f_17(g^65476 * z)) / (x - g^65476 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^65476 * z)^(-1)*/ mload(add(denominatorsPtr, 0xee0)),
                                  /*oods_coefficients[190]*/ mload(add(context, 0x8f40)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[190]*/ mload(add(context, 0x70e0)))),
                           PRIME))

                // res += c_191*(f_17(x) - f_17(g^65496 * z)) / (x - g^65496 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^65496 * z)^(-1)*/ mload(add(denominatorsPtr, 0xf00)),
                                  /*oods_coefficients[191]*/ mload(add(context, 0x8f60)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[191]*/ mload(add(context, 0x7100)))),
                           PRIME))

                // res += c_192*(f_17(x) - f_17(g^65520 * z)) / (x - g^65520 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^65520 * z)^(-1)*/ mload(add(denominatorsPtr, 0xf20)),
                                  /*oods_coefficients[192]*/ mload(add(context, 0x8f80)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[192]*/ mload(add(context, 0x7120)))),
                           PRIME))
                }

                // Advance traceQueryResponses by amount read (0x20 * nTraceColumns).
                traceQueryResponses := add(traceQueryResponses, 0x240)

                // Composition constraints.

                {
                // Read the next element.
                let columnValue := mulmod(mload(compositionQueryResponses), kMontgomeryRInv, PRIME)
                // res += c_193*(h_0(x) - C_0(z^2)) / (x - z^2).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z^2)^(-1)*/ mload(add(denominatorsPtr, 0xfc0)),
                                  /*oods_coefficients[193]*/ mload(add(context, 0x8fa0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*composition_oods_values[0]*/ mload(add(context, 0x7140)))),
                           PRIME))
                }

                {
                // Read the next element.
                let columnValue := mulmod(mload(add(compositionQueryResponses, 0x20)), kMontgomeryRInv, PRIME)
                // res += c_194*(h_1(x) - C_1(z^2)) / (x - z^2).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z^2)^(-1)*/ mload(add(denominatorsPtr, 0xfc0)),
                                  /*oods_coefficients[194]*/ mload(add(context, 0x8fc0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*composition_oods_values[1]*/ mload(add(context, 0x7160)))),
                           PRIME))
                }

                // Advance compositionQueryResponses by amount read (0x20 * constraintDegree).
                compositionQueryResponses := add(compositionQueryResponses, 0x40)

                // Append the friValue, which is the sum of the out-of-domain-sampling boundary
                // constraints for the trace and composition polynomials, to the friQueue array.
                mstore(add(friQueue, 0x20), mod(res, PRIME))

                // Append the friInvPoint of the current query to the friQueue array.
                mstore(add(friQueue, 0x40), /*friInvPoint*/ mload(add(denominatorsPtr,0xfe0)))

                // Advance denominatorsPtr by chunk size (0x20 * (2+N_ROWS_IN_MASK)).
                denominatorsPtr := add(denominatorsPtr, 0x1000)
            }
            return(/*friQueue*/ add(context, 0xda0), 0x1200)
        }
    }

    /*
      Computes and performs batch inverse on all the denominators required for the out of domain
      sampling boundary constraints.

      Since the friEvalPoints are calculated during the computation of the denominators
      this function also adds those to the batch inverse in prepartion for the fri that follows.

      After this function returns, the batch_inverse_out array holds #queries
      chunks of size (2 + N_ROWS_IN_MASK) with the following structure:
      0..(N_ROWS_IN_MASK-1):   [(x - g^i * z)^(-1) for i in rowsInMask]
      N_ROWS_IN_MASK:          (x - z^constraintDegree)^-1
      N_ROWS_IN_MASK+1:        friEvalPointInv.
    */
    function oodsPrepareInverses(
        uint256[] memory context, uint256[] memory batchInverseArray)
        internal view {
        uint256 evalCosetOffset_ = PrimeFieldElement0.GENERATOR_VAL;
        // The array expmodsAndPoints stores subexpressions that are needed
        // for the denominators computation.
        // The array is segmented as follows:
        //    expmodsAndPoints[0:40] (.expmods) expmods used during calculations of the points below.
        //    expmodsAndPoints[40:166] (.points) points used during the denominators calculation.
        uint256[166] memory expmodsAndPoints;
        assembly {
            function expmod(base, exponent, modulus) -> res {
              let p := mload(0x40)
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

            let traceGenerator := /*trace_generator*/ mload(add(context, 0x2be0))
            let PRIME := 0x800000000000011000000000000000000000000000000000000000000000001

            // Prepare expmods for computations of trace generator powers.

            // expmodsAndPoints.expmods[0] = traceGenerator^2.
            mstore(expmodsAndPoints,
                   mulmod(traceGenerator, // traceGenerator^1
                          traceGenerator, // traceGenerator^1
                          PRIME))

            // expmodsAndPoints.expmods[1] = traceGenerator^3.
            mstore(add(expmodsAndPoints, 0x20),
                   mulmod(mload(expmodsAndPoints), // traceGenerator^2
                          traceGenerator, // traceGenerator^1
                          PRIME))

            // expmodsAndPoints.expmods[2] = traceGenerator^4.
            mstore(add(expmodsAndPoints, 0x40),
                   mulmod(mload(add(expmodsAndPoints, 0x20)), // traceGenerator^3
                          traceGenerator, // traceGenerator^1
                          PRIME))

            // expmodsAndPoints.expmods[3] = traceGenerator^6.
            mstore(add(expmodsAndPoints, 0x60),
                   mulmod(mload(add(expmodsAndPoints, 0x40)), // traceGenerator^4
                          mload(expmodsAndPoints), // traceGenerator^2
                          PRIME))

            // expmodsAndPoints.expmods[4] = traceGenerator^8.
            mstore(add(expmodsAndPoints, 0x80),
                   mulmod(mload(add(expmodsAndPoints, 0x60)), // traceGenerator^6
                          mload(expmodsAndPoints), // traceGenerator^2
                          PRIME))

            // expmodsAndPoints.expmods[5] = traceGenerator^12.
            mstore(add(expmodsAndPoints, 0xa0),
                   mulmod(mload(add(expmodsAndPoints, 0x80)), // traceGenerator^8
                          mload(add(expmodsAndPoints, 0x40)), // traceGenerator^4
                          PRIME))

            // expmodsAndPoints.expmods[6] = traceGenerator^16.
            mstore(add(expmodsAndPoints, 0xc0),
                   mulmod(mload(add(expmodsAndPoints, 0xa0)), // traceGenerator^12
                          mload(add(expmodsAndPoints, 0x40)), // traceGenerator^4
                          PRIME))

            // expmodsAndPoints.expmods[7] = traceGenerator^20.
            mstore(add(expmodsAndPoints, 0xe0),
                   mulmod(mload(add(expmodsAndPoints, 0xc0)), // traceGenerator^16
                          mload(add(expmodsAndPoints, 0x40)), // traceGenerator^4
                          PRIME))

            // expmodsAndPoints.expmods[8] = traceGenerator^24.
            mstore(add(expmodsAndPoints, 0x100),
                   mulmod(mload(add(expmodsAndPoints, 0xe0)), // traceGenerator^20
                          mload(add(expmodsAndPoints, 0x40)), // traceGenerator^4
                          PRIME))

            // expmodsAndPoints.expmods[9] = traceGenerator^27.
            mstore(add(expmodsAndPoints, 0x120),
                   mulmod(mload(add(expmodsAndPoints, 0x100)), // traceGenerator^24
                          mload(add(expmodsAndPoints, 0x20)), // traceGenerator^3
                          PRIME))

            // expmodsAndPoints.expmods[10] = traceGenerator^32.
            mstore(add(expmodsAndPoints, 0x140),
                   mulmod(mload(add(expmodsAndPoints, 0x100)), // traceGenerator^24
                          mload(add(expmodsAndPoints, 0x80)), // traceGenerator^8
                          PRIME))

            // expmodsAndPoints.expmods[11] = traceGenerator^44.
            mstore(add(expmodsAndPoints, 0x160),
                   mulmod(mload(add(expmodsAndPoints, 0x140)), // traceGenerator^32
                          mload(add(expmodsAndPoints, 0xa0)), // traceGenerator^12
                          PRIME))

            // expmodsAndPoints.expmods[12] = traceGenerator^48.
            mstore(add(expmodsAndPoints, 0x180),
                   mulmod(mload(add(expmodsAndPoints, 0x160)), // traceGenerator^44
                          mload(add(expmodsAndPoints, 0x40)), // traceGenerator^4
                          PRIME))

            // expmodsAndPoints.expmods[13] = traceGenerator^52.
            mstore(add(expmodsAndPoints, 0x1a0),
                   mulmod(mload(add(expmodsAndPoints, 0x180)), // traceGenerator^48
                          mload(add(expmodsAndPoints, 0x40)), // traceGenerator^4
                          PRIME))

            // expmodsAndPoints.expmods[14] = traceGenerator^171.
            mstore(add(expmodsAndPoints, 0x1c0),
                   mulmod(mload(add(expmodsAndPoints, 0x1a0)), // traceGenerator^52
                          mulmod(mload(add(expmodsAndPoints, 0x180)), // traceGenerator^48
                                 mulmod(mload(add(expmodsAndPoints, 0x160)), // traceGenerator^44
                                        mload(add(expmodsAndPoints, 0x120)), // traceGenerator^27
                                        PRIME),
                                 PRIME),
                          PRIME))

            // expmodsAndPoints.expmods[15] = traceGenerator^223.
            mstore(add(expmodsAndPoints, 0x1e0),
                   mulmod(mload(add(expmodsAndPoints, 0x1c0)), // traceGenerator^171
                          mload(add(expmodsAndPoints, 0x1a0)), // traceGenerator^52
                          PRIME))

            // expmodsAndPoints.expmods[16] = traceGenerator^252.
            mstore(add(expmodsAndPoints, 0x200),
                   mulmod(mload(add(expmodsAndPoints, 0x1e0)), // traceGenerator^223
                          mulmod(mload(add(expmodsAndPoints, 0x120)), // traceGenerator^27
                                 mload(expmodsAndPoints), // traceGenerator^2
                                 PRIME),
                          PRIME))

            // expmodsAndPoints.expmods[17] = traceGenerator^255.
            mstore(add(expmodsAndPoints, 0x220),
                   mulmod(mload(add(expmodsAndPoints, 0x200)), // traceGenerator^252
                          mload(add(expmodsAndPoints, 0x20)), // traceGenerator^3
                          PRIME))

            // expmodsAndPoints.expmods[18] = traceGenerator^256.
            mstore(add(expmodsAndPoints, 0x240),
                   mulmod(mload(add(expmodsAndPoints, 0x220)), // traceGenerator^255
                          traceGenerator, // traceGenerator^1
                          PRIME))

            // expmodsAndPoints.expmods[19] = traceGenerator^271.
            mstore(add(expmodsAndPoints, 0x260),
                   mulmod(mload(add(expmodsAndPoints, 0x220)), // traceGenerator^255
                          mload(add(expmodsAndPoints, 0xc0)), // traceGenerator^16
                          PRIME))

            // expmodsAndPoints.expmods[20] = traceGenerator^405.
            mstore(add(expmodsAndPoints, 0x280),
                   mulmod(mload(add(expmodsAndPoints, 0x1e0)), // traceGenerator^223
                          mulmod(mload(add(expmodsAndPoints, 0x1c0)), // traceGenerator^171
                                 mulmod(mload(add(expmodsAndPoints, 0x80)), // traceGenerator^8
                                        mload(add(expmodsAndPoints, 0x20)), // traceGenerator^3
                                        PRIME),
                                 PRIME),
                          PRIME))

            // expmodsAndPoints.expmods[21] = traceGenerator^428.
            mstore(add(expmodsAndPoints, 0x2a0),
                   mulmod(mload(add(expmodsAndPoints, 0x240)), // traceGenerator^256
                          mulmod(mload(add(expmodsAndPoints, 0x1c0)), // traceGenerator^171
                                 traceGenerator, // traceGenerator^1
                                 PRIME),
                          PRIME))

            // expmodsAndPoints.expmods[22] = traceGenerator^453.
            mstore(add(expmodsAndPoints, 0x2c0),
                   mulmod(mload(add(expmodsAndPoints, 0x280)), // traceGenerator^405
                          mload(add(expmodsAndPoints, 0x180)), // traceGenerator^48
                          PRIME))

            // expmodsAndPoints.expmods[23] = traceGenerator^508.
            mstore(add(expmodsAndPoints, 0x2e0),
                   mulmod(mload(add(expmodsAndPoints, 0x240)), // traceGenerator^256
                          mload(add(expmodsAndPoints, 0x200)), // traceGenerator^252
                          PRIME))

            // expmodsAndPoints.expmods[24] = traceGenerator^509.
            mstore(add(expmodsAndPoints, 0x300),
                   mulmod(mload(add(expmodsAndPoints, 0x2e0)), // traceGenerator^508
                          traceGenerator, // traceGenerator^1
                          PRIME))

            // expmodsAndPoints.expmods[25] = traceGenerator^510.
            mstore(add(expmodsAndPoints, 0x320),
                   mulmod(mload(add(expmodsAndPoints, 0x300)), // traceGenerator^509
                          traceGenerator, // traceGenerator^1
                          PRIME))

            // expmodsAndPoints.expmods[26] = traceGenerator^516.
            mstore(add(expmodsAndPoints, 0x340),
                   mulmod(mload(add(expmodsAndPoints, 0x320)), // traceGenerator^510
                          mload(add(expmodsAndPoints, 0x60)), // traceGenerator^6
                          PRIME))

            // expmodsAndPoints.expmods[27] = traceGenerator^1017.
            mstore(add(expmodsAndPoints, 0x360),
                   mulmod(mload(add(expmodsAndPoints, 0x300)), // traceGenerator^509
                          mload(add(expmodsAndPoints, 0x2e0)), // traceGenerator^508
                          PRIME))

            // expmodsAndPoints.expmods[28] = traceGenerator^1021.
            mstore(add(expmodsAndPoints, 0x380),
                   mulmod(mload(add(expmodsAndPoints, 0x360)), // traceGenerator^1017
                          mload(add(expmodsAndPoints, 0x40)), // traceGenerator^4
                          PRIME))

            // expmodsAndPoints.expmods[29] = traceGenerator^1024.
            mstore(add(expmodsAndPoints, 0x3a0),
                   mulmod(mload(add(expmodsAndPoints, 0x380)), // traceGenerator^1021
                          mload(add(expmodsAndPoints, 0x20)), // traceGenerator^3
                          PRIME))

            // expmodsAndPoints.expmods[30] = traceGenerator^1109.
            mstore(add(expmodsAndPoints, 0x3c0),
                   mulmod(mload(add(expmodsAndPoints, 0x380)), // traceGenerator^1021
                          mulmod(mload(add(expmodsAndPoints, 0x160)), // traceGenerator^44
                                 mload(add(expmodsAndPoints, 0x160)), // traceGenerator^44
                                 PRIME),
                          PRIME))

            // expmodsAndPoints.expmods[31] = traceGenerator^1477.
            mstore(add(expmodsAndPoints, 0x3e0),
                   mulmod(mload(add(expmodsAndPoints, 0x3a0)), // traceGenerator^1024
                          mload(add(expmodsAndPoints, 0x2c0)), // traceGenerator^453
                          PRIME))

            // expmodsAndPoints.expmods[32] = traceGenerator^1532.
            mstore(add(expmodsAndPoints, 0x400),
                   mulmod(mload(add(expmodsAndPoints, 0x3a0)), // traceGenerator^1024
                          mload(add(expmodsAndPoints, 0x2e0)), // traceGenerator^508
                          PRIME))

            // expmodsAndPoints.expmods[33] = traceGenerator^2048.
            mstore(add(expmodsAndPoints, 0x420),
                   mulmod(mload(add(expmodsAndPoints, 0x400)), // traceGenerator^1532
                          mload(add(expmodsAndPoints, 0x340)), // traceGenerator^516
                          PRIME))

            // expmodsAndPoints.expmods[34] = traceGenerator^2054.
            mstore(add(expmodsAndPoints, 0x440),
                   mulmod(mload(add(expmodsAndPoints, 0x420)), // traceGenerator^2048
                          mload(add(expmodsAndPoints, 0x60)), // traceGenerator^6
                          PRIME))

            // expmodsAndPoints.expmods[35] = traceGenerator^2559.
            mstore(add(expmodsAndPoints, 0x460),
                   mulmod(mload(add(expmodsAndPoints, 0x420)), // traceGenerator^2048
                          mulmod(mload(add(expmodsAndPoints, 0x320)), // traceGenerator^510
                                 traceGenerator, // traceGenerator^1
                                 PRIME),
                          PRIME))

            // expmodsAndPoints.expmods[36] = traceGenerator^2820.
            mstore(add(expmodsAndPoints, 0x480),
                   mulmod(mload(add(expmodsAndPoints, 0x460)), // traceGenerator^2559
                          mulmod(mload(add(expmodsAndPoints, 0x220)), // traceGenerator^255
                                 mload(add(expmodsAndPoints, 0x60)), // traceGenerator^6
                                 PRIME),
                          PRIME))

            // expmodsAndPoints.expmods[37] = traceGenerator^3075.
            mstore(add(expmodsAndPoints, 0x4a0),
                   mulmod(mload(add(expmodsAndPoints, 0x480)), // traceGenerator^2820
                          mload(add(expmodsAndPoints, 0x220)), // traceGenerator^255
                          PRIME))

            // expmodsAndPoints.expmods[38] = traceGenerator^3668.
            mstore(add(expmodsAndPoints, 0x4c0),
                   mulmod(mload(add(expmodsAndPoints, 0x460)), // traceGenerator^2559
                          mload(add(expmodsAndPoints, 0x3c0)), // traceGenerator^1109
                          PRIME))

            // expmodsAndPoints.expmods[39] = traceGenerator^14863.
            mstore(add(expmodsAndPoints, 0x4e0),
                   mulmod(mload(add(expmodsAndPoints, 0x4a0)), // traceGenerator^3075
                          mulmod(mload(add(expmodsAndPoints, 0x4a0)), // traceGenerator^3075
                                 mulmod(mload(add(expmodsAndPoints, 0x4a0)), // traceGenerator^3075
                                        mulmod(mload(add(expmodsAndPoints, 0x4a0)), // traceGenerator^3075
                                               mulmod(mload(add(expmodsAndPoints, 0x460)), // traceGenerator^2559
                                                      mload(add(expmodsAndPoints, 0x40)), // traceGenerator^4
                                                      PRIME),
                                               PRIME),
                                        PRIME),
                                 PRIME),
                          PRIME))

            let oodsPoint := /*oods_point*/ mload(add(context, 0x2c00))
            {
              // point = -z.
              let point := sub(PRIME, oodsPoint)
              // Compute denominators for rows with nonconst mask expression.
              // We compute those first because for the const rows we modify the point variable.

              // expmods_and_points.points[123] = -(g^(512 * (vaults_path_length - 1) + 511) * z).
              mstore(add(expmodsAndPoints, 0x1460), mulmod(
                point,
                expmod(traceGenerator, add(mul(512, sub(/*vaults_path_length*/ mload(add(context, 0x2a00)), 1)), 511), PRIME),
                PRIME))

              // expmods_and_points.points[124] = -(g^(512 * (vaults_path_length - 1) + 16895) * z).
              mstore(add(expmodsAndPoints, 0x1480), mulmod(
                point,
                expmod(traceGenerator, add(mul(512, sub(/*vaults_path_length*/ mload(add(context, 0x2a00)), 1)), 16895), PRIME),
                PRIME))

              // expmods_and_points.points[125] = -(g^(512 * (vaults_path_length - 1) + 49663) * z).
              mstore(add(expmodsAndPoints, 0x14a0), mulmod(
                point,
                expmod(traceGenerator, add(mul(512, sub(/*vaults_path_length*/ mload(add(context, 0x2a00)), 1)), 49663), PRIME),
                PRIME))

              // Compute denominators for rows with const mask expression.

              // expmods_and_points.points[0] = -z.
              mstore(add(expmodsAndPoints, 0x500), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[1] = -(g * z).
              mstore(add(expmodsAndPoints, 0x520), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[2] = -(g^2 * z).
              mstore(add(expmodsAndPoints, 0x540), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[3] = -(g^3 * z).
              mstore(add(expmodsAndPoints, 0x560), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[4] = -(g^4 * z).
              mstore(add(expmodsAndPoints, 0x580), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[5] = -(g^6 * z).
              mstore(add(expmodsAndPoints, 0x5a0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[6] = -(g^7 * z).
              mstore(add(expmodsAndPoints, 0x5c0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[7] = -(g^8 * z).
              mstore(add(expmodsAndPoints, 0x5e0), point)

              // point *= g^8.
              point := mulmod(point, /*traceGenerator^8*/ mload(add(expmodsAndPoints, 0x80)), PRIME)
              // expmods_and_points.points[8] = -(g^16 * z).
              mstore(add(expmodsAndPoints, 0x600), point)

              // point *= g^4.
              point := mulmod(point, /*traceGenerator^4*/ mload(add(expmodsAndPoints, 0x40)), PRIME)
              // expmods_and_points.points[9] = -(g^20 * z).
              mstore(add(expmodsAndPoints, 0x620), point)

              // point *= g^4.
              point := mulmod(point, /*traceGenerator^4*/ mload(add(expmodsAndPoints, 0x40)), PRIME)
              // expmods_and_points.points[10] = -(g^24 * z).
              mstore(add(expmodsAndPoints, 0x640), point)

              // point *= g^8.
              point := mulmod(point, /*traceGenerator^8*/ mload(add(expmodsAndPoints, 0x80)), PRIME)
              // expmods_and_points.points[11] = -(g^32 * z).
              mstore(add(expmodsAndPoints, 0x660), point)

              // point *= g^4.
              point := mulmod(point, /*traceGenerator^4*/ mload(add(expmodsAndPoints, 0x40)), PRIME)
              // expmods_and_points.points[12] = -(g^36 * z).
              mstore(add(expmodsAndPoints, 0x680), point)

              // point *= g^4.
              point := mulmod(point, /*traceGenerator^4*/ mload(add(expmodsAndPoints, 0x40)), PRIME)
              // expmods_and_points.points[13] = -(g^40 * z).
              mstore(add(expmodsAndPoints, 0x6a0), point)

              // point *= g^8.
              point := mulmod(point, /*traceGenerator^8*/ mload(add(expmodsAndPoints, 0x80)), PRIME)
              // expmods_and_points.points[14] = -(g^48 * z).
              mstore(add(expmodsAndPoints, 0x6c0), point)

              // point *= g^4.
              point := mulmod(point, /*traceGenerator^4*/ mload(add(expmodsAndPoints, 0x40)), PRIME)
              // expmods_and_points.points[15] = -(g^52 * z).
              mstore(add(expmodsAndPoints, 0x6e0), point)

              // point *= g^4.
              point := mulmod(point, /*traceGenerator^4*/ mload(add(expmodsAndPoints, 0x40)), PRIME)
              // expmods_and_points.points[16] = -(g^56 * z).
              mstore(add(expmodsAndPoints, 0x700), point)

              // point *= g^8.
              point := mulmod(point, /*traceGenerator^8*/ mload(add(expmodsAndPoints, 0x80)), PRIME)
              // expmods_and_points.points[17] = -(g^64 * z).
              mstore(add(expmodsAndPoints, 0x720), point)

              // point *= g^8.
              point := mulmod(point, /*traceGenerator^8*/ mload(add(expmodsAndPoints, 0x80)), PRIME)
              // expmods_and_points.points[18] = -(g^72 * z).
              mstore(add(expmodsAndPoints, 0x740), point)

              // point *= g^8.
              point := mulmod(point, /*traceGenerator^8*/ mload(add(expmodsAndPoints, 0x80)), PRIME)
              // expmods_and_points.points[19] = -(g^80 * z).
              mstore(add(expmodsAndPoints, 0x760), point)

              // point *= g^4.
              point := mulmod(point, /*traceGenerator^4*/ mload(add(expmodsAndPoints, 0x40)), PRIME)
              // expmods_and_points.points[20] = -(g^84 * z).
              mstore(add(expmodsAndPoints, 0x780), point)

              // point *= g^12.
              point := mulmod(point, /*traceGenerator^12*/ mload(add(expmodsAndPoints, 0xa0)), PRIME)
              // expmods_and_points.points[21] = -(g^96 * z).
              mstore(add(expmodsAndPoints, 0x7a0), point)

              // point *= g^4.
              point := mulmod(point, /*traceGenerator^4*/ mload(add(expmodsAndPoints, 0x40)), PRIME)
              // expmods_and_points.points[22] = -(g^100 * z).
              mstore(add(expmodsAndPoints, 0x7c0), point)

              // point *= g^4.
              point := mulmod(point, /*traceGenerator^4*/ mload(add(expmodsAndPoints, 0x40)), PRIME)
              // expmods_and_points.points[23] = -(g^104 * z).
              mstore(add(expmodsAndPoints, 0x7e0), point)

              // point *= g^16.
              point := mulmod(point, /*traceGenerator^16*/ mload(add(expmodsAndPoints, 0xc0)), PRIME)
              // expmods_and_points.points[24] = -(g^120 * z).
              mstore(add(expmodsAndPoints, 0x800), point)

              // point *= g^44.
              point := mulmod(point, /*traceGenerator^44*/ mload(add(expmodsAndPoints, 0x160)), PRIME)
              // expmods_and_points.points[25] = -(g^164 * z).
              mstore(add(expmodsAndPoints, 0x820), point)

              // point *= g^48.
              point := mulmod(point, /*traceGenerator^48*/ mload(add(expmodsAndPoints, 0x180)), PRIME)
              // expmods_and_points.points[26] = -(g^212 * z).
              mstore(add(expmodsAndPoints, 0x840), point)

              // point *= g^16.
              point := mulmod(point, /*traceGenerator^16*/ mload(add(expmodsAndPoints, 0xc0)), PRIME)
              // expmods_and_points.points[27] = -(g^228 * z).
              mstore(add(expmodsAndPoints, 0x860), point)

              // point *= g^27.
              point := mulmod(point, /*traceGenerator^27*/ mload(add(expmodsAndPoints, 0x120)), PRIME)
              // expmods_and_points.points[28] = -(g^255 * z).
              mstore(add(expmodsAndPoints, 0x880), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[29] = -(g^256 * z).
              mstore(add(expmodsAndPoints, 0x8a0), point)

              // point *= g^255.
              point := mulmod(point, /*traceGenerator^255*/ mload(add(expmodsAndPoints, 0x220)), PRIME)
              // expmods_and_points.points[30] = -(g^511 * z).
              mstore(add(expmodsAndPoints, 0x8c0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[31] = -(g^512 * z).
              mstore(add(expmodsAndPoints, 0x8e0), point)

              // point *= g^255.
              point := mulmod(point, /*traceGenerator^255*/ mload(add(expmodsAndPoints, 0x220)), PRIME)
              // expmods_and_points.points[32] = -(g^767 * z).
              mstore(add(expmodsAndPoints, 0x900), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[33] = -(g^768 * z).
              mstore(add(expmodsAndPoints, 0x920), point)

              // point *= g^252.
              point := mulmod(point, /*traceGenerator^252*/ mload(add(expmodsAndPoints, 0x200)), PRIME)
              // expmods_and_points.points[34] = -(g^1020 * z).
              mstore(add(expmodsAndPoints, 0x940), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[35] = -(g^1021 * z).
              mstore(add(expmodsAndPoints, 0x960), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[36] = -(g^1022 * z).
              mstore(add(expmodsAndPoints, 0x980), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[37] = -(g^1023 * z).
              mstore(add(expmodsAndPoints, 0x9a0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[38] = -(g^1024 * z).
              mstore(add(expmodsAndPoints, 0x9c0), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[39] = -(g^1026 * z).
              mstore(add(expmodsAndPoints, 0x9e0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[40] = -(g^1027 * z).
              mstore(add(expmodsAndPoints, 0xa00), point)

              // point *= g^252.
              point := mulmod(point, /*traceGenerator^252*/ mload(add(expmodsAndPoints, 0x200)), PRIME)
              // expmods_and_points.points[41] = -(g^1279 * z).
              mstore(add(expmodsAndPoints, 0xa20), point)

              // point *= g^256.
              point := mulmod(point, /*traceGenerator^256*/ mload(add(expmodsAndPoints, 0x240)), PRIME)
              // expmods_and_points.points[42] = -(g^1535 * z).
              mstore(add(expmodsAndPoints, 0xa40), point)

              // point *= g^509.
              point := mulmod(point, /*traceGenerator^509*/ mload(add(expmodsAndPoints, 0x300)), PRIME)
              // expmods_and_points.points[43] = -(g^2044 * z).
              mstore(add(expmodsAndPoints, 0xa60), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[44] = -(g^2045 * z).
              mstore(add(expmodsAndPoints, 0xa80), point)

              // point *= g^6.
              point := mulmod(point, /*traceGenerator^6*/ mload(add(expmodsAndPoints, 0x60)), PRIME)
              // expmods_and_points.points[45] = -(g^2051 * z).
              mstore(add(expmodsAndPoints, 0xaa0), point)

              // point *= g^508.
              point := mulmod(point, /*traceGenerator^508*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[46] = -(g^2559 * z).
              mstore(add(expmodsAndPoints, 0xac0), point)

              // point *= g^516.
              point := mulmod(point, /*traceGenerator^516*/ mload(add(expmodsAndPoints, 0x340)), PRIME)
              // expmods_and_points.points[47] = -(g^3075 * z).
              mstore(add(expmodsAndPoints, 0xae0), point)

              // point *= g^1017.
              point := mulmod(point, /*traceGenerator^1017*/ mload(add(expmodsAndPoints, 0x360)), PRIME)
              // expmods_and_points.points[48] = -(g^4092 * z).
              mstore(add(expmodsAndPoints, 0xb00), point)

              // point *= g^4.
              point := mulmod(point, /*traceGenerator^4*/ mload(add(expmodsAndPoints, 0x40)), PRIME)
              // expmods_and_points.points[49] = -(g^4096 * z).
              mstore(add(expmodsAndPoints, 0xb20), point)

              // point *= g^3.
              point := mulmod(point, /*traceGenerator^3*/ mload(add(expmodsAndPoints, 0x20)), PRIME)
              // expmods_and_points.points[50] = -(g^4099 * z).
              mstore(add(expmodsAndPoints, 0xb40), point)

              // point *= g^508.
              point := mulmod(point, /*traceGenerator^508*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[51] = -(g^4607 * z).
              mstore(add(expmodsAndPoints, 0xb60), point)

              // point *= g^516.
              point := mulmod(point, /*traceGenerator^516*/ mload(add(expmodsAndPoints, 0x340)), PRIME)
              // expmods_and_points.points[52] = -(g^5123 * z).
              mstore(add(expmodsAndPoints, 0xb80), point)

              // point *= g^1532.
              point := mulmod(point, /*traceGenerator^1532*/ mload(add(expmodsAndPoints, 0x400)), PRIME)
              // expmods_and_points.points[53] = -(g^6655 * z).
              mstore(add(expmodsAndPoints, 0xba0), point)

              // point *= g^516.
              point := mulmod(point, /*traceGenerator^516*/ mload(add(expmodsAndPoints, 0x340)), PRIME)
              // expmods_and_points.points[54] = -(g^7171 * z).
              mstore(add(expmodsAndPoints, 0xbc0), point)

              // point *= g^1017.
              point := mulmod(point, /*traceGenerator^1017*/ mload(add(expmodsAndPoints, 0x360)), PRIME)
              // expmods_and_points.points[55] = -(g^8188 * z).
              mstore(add(expmodsAndPoints, 0xbe0), point)

              // point *= g^4.
              point := mulmod(point, /*traceGenerator^4*/ mload(add(expmodsAndPoints, 0x40)), PRIME)
              // expmods_and_points.points[56] = -(g^8192 * z).
              mstore(add(expmodsAndPoints, 0xc00), point)

              // point *= g^3.
              point := mulmod(point, /*traceGenerator^3*/ mload(add(expmodsAndPoints, 0x20)), PRIME)
              // expmods_and_points.points[57] = -(g^8195 * z).
              mstore(add(expmodsAndPoints, 0xc20), point)

              // point *= g^508.
              point := mulmod(point, /*traceGenerator^508*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[58] = -(g^8703 * z).
              mstore(add(expmodsAndPoints, 0xc40), point)

              // point *= g^516.
              point := mulmod(point, /*traceGenerator^516*/ mload(add(expmodsAndPoints, 0x340)), PRIME)
              // expmods_and_points.points[59] = -(g^9219 * z).
              mstore(add(expmodsAndPoints, 0xc60), point)

              // point *= g^1532.
              point := mulmod(point, /*traceGenerator^1532*/ mload(add(expmodsAndPoints, 0x400)), PRIME)
              // expmods_and_points.points[60] = -(g^10751 * z).
              mstore(add(expmodsAndPoints, 0xc80), point)

              // point *= g^516.
              point := mulmod(point, /*traceGenerator^516*/ mload(add(expmodsAndPoints, 0x340)), PRIME)
              // expmods_and_points.points[61] = -(g^11267 * z).
              mstore(add(expmodsAndPoints, 0xca0), point)

              // point *= g^1017.
              point := mulmod(point, /*traceGenerator^1017*/ mload(add(expmodsAndPoints, 0x360)), PRIME)
              // expmods_and_points.points[62] = -(g^12284 * z).
              mstore(add(expmodsAndPoints, 0xcc0), point)

              // point *= g^4.
              point := mulmod(point, /*traceGenerator^4*/ mload(add(expmodsAndPoints, 0x40)), PRIME)
              // expmods_and_points.points[63] = -(g^12288 * z).
              mstore(add(expmodsAndPoints, 0xce0), point)

              // point *= g^2559.
              point := mulmod(point, /*traceGenerator^2559*/ mload(add(expmodsAndPoints, 0x460)), PRIME)
              // expmods_and_points.points[64] = -(g^14847 * z).
              mstore(add(expmodsAndPoints, 0xd00), point)

              // point *= g^1477.
              point := mulmod(point, /*traceGenerator^1477*/ mload(add(expmodsAndPoints, 0x3e0)), PRIME)
              // expmods_and_points.points[65] = -(g^16324 * z).
              mstore(add(expmodsAndPoints, 0xd20), point)

              // point *= g^4.
              point := mulmod(point, /*traceGenerator^4*/ mload(add(expmodsAndPoints, 0x40)), PRIME)
              // expmods_and_points.points[66] = -(g^16328 * z).
              mstore(add(expmodsAndPoints, 0xd40), point)

              // point *= g^16.
              point := mulmod(point, /*traceGenerator^16*/ mload(add(expmodsAndPoints, 0xc0)), PRIME)
              // expmods_and_points.points[67] = -(g^16344 * z).
              mstore(add(expmodsAndPoints, 0xd60), point)

              // point *= g^16.
              point := mulmod(point, /*traceGenerator^16*/ mload(add(expmodsAndPoints, 0xc0)), PRIME)
              // expmods_and_points.points[68] = -(g^16360 * z).
              mstore(add(expmodsAndPoints, 0xd80), point)

              // point *= g^8.
              point := mulmod(point, /*traceGenerator^8*/ mload(add(expmodsAndPoints, 0x80)), PRIME)
              // expmods_and_points.points[69] = -(g^16368 * z).
              mstore(add(expmodsAndPoints, 0xda0), point)

              // point *= g^32.
              point := mulmod(point, /*traceGenerator^32*/ mload(add(expmodsAndPoints, 0x140)), PRIME)
              // expmods_and_points.points[70] = -(g^16400 * z).
              mstore(add(expmodsAndPoints, 0xdc0), point)

              // point *= g^16.
              point := mulmod(point, /*traceGenerator^16*/ mload(add(expmodsAndPoints, 0xc0)), PRIME)
              // expmods_and_points.points[71] = -(g^16416 * z).
              mstore(add(expmodsAndPoints, 0xde0), point)

              // point *= g^223.
              point := mulmod(point, /*traceGenerator^223*/ mload(add(expmodsAndPoints, 0x1e0)), PRIME)
              // expmods_and_points.points[72] = -(g^16639 * z).
              mstore(add(expmodsAndPoints, 0xe00), point)

              // point *= g^2820.
              point := mulmod(point, /*traceGenerator^2820*/ mload(add(expmodsAndPoints, 0x480)), PRIME)
              // expmods_and_points.points[73] = -(g^19459 * z).
              mstore(add(expmodsAndPoints, 0xe20), point)

              // point *= g^1021.
              point := mulmod(point, /*traceGenerator^1021*/ mload(add(expmodsAndPoints, 0x380)), PRIME)
              // expmods_and_points.points[74] = -(g^20480 * z).
              mstore(add(expmodsAndPoints, 0xe40), point)

              // point *= g^2559.
              point := mulmod(point, /*traceGenerator^2559*/ mload(add(expmodsAndPoints, 0x460)), PRIME)
              // expmods_and_points.points[75] = -(g^23039 * z).
              mstore(add(expmodsAndPoints, 0xe60), point)

              // point *= g^1109.
              point := mulmod(point, /*traceGenerator^1109*/ mload(add(expmodsAndPoints, 0x3c0)), PRIME)
              // expmods_and_points.points[76] = -(g^24148 * z).
              mstore(add(expmodsAndPoints, 0xe80), point)

              // point *= g^428.
              point := mulmod(point, /*traceGenerator^428*/ mload(add(expmodsAndPoints, 0x2a0)), PRIME)
              // expmods_and_points.points[77] = -(g^24576 * z).
              mstore(add(expmodsAndPoints, 0xea0), point)

              // point *= g^2559.
              point := mulmod(point, /*traceGenerator^2559*/ mload(add(expmodsAndPoints, 0x460)), PRIME)
              // expmods_and_points.points[78] = -(g^27135 * z).
              mstore(add(expmodsAndPoints, 0xec0), point)

              // point *= g^516.
              point := mulmod(point, /*traceGenerator^516*/ mload(add(expmodsAndPoints, 0x340)), PRIME)
              // expmods_and_points.points[79] = -(g^27651 * z).
              mstore(add(expmodsAndPoints, 0xee0), point)

              // point *= g^1021.
              point := mulmod(point, /*traceGenerator^1021*/ mload(add(expmodsAndPoints, 0x380)), PRIME)
              // expmods_and_points.points[80] = -(g^28672 * z).
              mstore(add(expmodsAndPoints, 0xf00), point)

              // point *= g^2559.
              point := mulmod(point, /*traceGenerator^2559*/ mload(add(expmodsAndPoints, 0x460)), PRIME)
              // expmods_and_points.points[81] = -(g^31231 * z).
              mstore(add(expmodsAndPoints, 0xf20), point)

              // point *= g^1024.
              point := mulmod(point, /*traceGenerator^1024*/ mload(add(expmodsAndPoints, 0x3a0)), PRIME)
              // expmods_and_points.points[82] = -(g^32255 * z).
              mstore(add(expmodsAndPoints, 0xf40), point)

              // point *= g^405.
              point := mulmod(point, /*traceGenerator^405*/ mload(add(expmodsAndPoints, 0x280)), PRIME)
              // expmods_and_points.points[83] = -(g^32660 * z).
              mstore(add(expmodsAndPoints, 0xf60), point)

              // point *= g^16.
              point := mulmod(point, /*traceGenerator^16*/ mload(add(expmodsAndPoints, 0xc0)), PRIME)
              // expmods_and_points.points[84] = -(g^32676 * z).
              mstore(add(expmodsAndPoints, 0xf80), point)

              // point *= g^16.
              point := mulmod(point, /*traceGenerator^16*/ mload(add(expmodsAndPoints, 0xc0)), PRIME)
              // expmods_and_points.points[85] = -(g^32692 * z).
              mstore(add(expmodsAndPoints, 0xfa0), point)

              // point *= g^16.
              point := mulmod(point, /*traceGenerator^16*/ mload(add(expmodsAndPoints, 0xc0)), PRIME)
              // expmods_and_points.points[86] = -(g^32708 * z).
              mstore(add(expmodsAndPoints, 0xfc0), point)

              // point *= g^4.
              point := mulmod(point, /*traceGenerator^4*/ mload(add(expmodsAndPoints, 0x40)), PRIME)
              // expmods_and_points.points[87] = -(g^32712 * z).
              mstore(add(expmodsAndPoints, 0xfe0), point)

              // point *= g^16.
              point := mulmod(point, /*traceGenerator^16*/ mload(add(expmodsAndPoints, 0xc0)), PRIME)
              // expmods_and_points.points[88] = -(g^32728 * z).
              mstore(add(expmodsAndPoints, 0x1000), point)

              // point *= g^12.
              point := mulmod(point, /*traceGenerator^12*/ mload(add(expmodsAndPoints, 0xa0)), PRIME)
              // expmods_and_points.points[89] = -(g^32740 * z).
              mstore(add(expmodsAndPoints, 0x1020), point)

              // point *= g^4.
              point := mulmod(point, /*traceGenerator^4*/ mload(add(expmodsAndPoints, 0x40)), PRIME)
              // expmods_and_points.points[90] = -(g^32744 * z).
              mstore(add(expmodsAndPoints, 0x1040), point)

              // point *= g^8.
              point := mulmod(point, /*traceGenerator^8*/ mload(add(expmodsAndPoints, 0x80)), PRIME)
              // expmods_and_points.points[91] = -(g^32752 * z).
              mstore(add(expmodsAndPoints, 0x1060), point)

              // point *= g^48.
              point := mulmod(point, /*traceGenerator^48*/ mload(add(expmodsAndPoints, 0x180)), PRIME)
              // expmods_and_points.points[92] = -(g^32800 * z).
              mstore(add(expmodsAndPoints, 0x1080), point)

              // point *= g^52.
              point := mulmod(point, /*traceGenerator^52*/ mload(add(expmodsAndPoints, 0x1a0)), PRIME)
              // expmods_and_points.points[93] = -(g^32852 * z).
              mstore(add(expmodsAndPoints, 0x10a0), point)

              // point *= g^171.
              point := mulmod(point, /*traceGenerator^171*/ mload(add(expmodsAndPoints, 0x1c0)), PRIME)
              // expmods_and_points.points[94] = -(g^33023 * z).
              mstore(add(expmodsAndPoints, 0x10c0), point)

              // point *= g^256.
              point := mulmod(point, /*traceGenerator^256*/ mload(add(expmodsAndPoints, 0x240)), PRIME)
              // expmods_and_points.points[95] = -(g^33279 * z).
              mstore(add(expmodsAndPoints, 0x10e0), point)

              // point *= g^510.
              point := mulmod(point, /*traceGenerator^510*/ mload(add(expmodsAndPoints, 0x320)), PRIME)
              // expmods_and_points.points[96] = -(g^33789 * z).
              mstore(add(expmodsAndPoints, 0x1100), point)

              // point *= g^2054.
              point := mulmod(point, /*traceGenerator^2054*/ mload(add(expmodsAndPoints, 0x440)), PRIME)
              // expmods_and_points.points[97] = -(g^35843 * z).
              mstore(add(expmodsAndPoints, 0x1120), point)

              // point *= g^1021.
              point := mulmod(point, /*traceGenerator^1021*/ mload(add(expmodsAndPoints, 0x380)), PRIME)
              // expmods_and_points.points[98] = -(g^36864 * z).
              mstore(add(expmodsAndPoints, 0x1140), point)

              // point *= g^3.
              point := mulmod(point, /*traceGenerator^3*/ mload(add(expmodsAndPoints, 0x20)), PRIME)
              // expmods_and_points.points[99] = -(g^36867 * z).
              mstore(add(expmodsAndPoints, 0x1160), point)

              // point *= g^1024.
              point := mulmod(point, /*traceGenerator^1024*/ mload(add(expmodsAndPoints, 0x3a0)), PRIME)
              // expmods_and_points.points[100] = -(g^37891 * z).
              mstore(add(expmodsAndPoints, 0x1180), point)

              // point *= g^2048.
              point := mulmod(point, /*traceGenerator^2048*/ mload(add(expmodsAndPoints, 0x420)), PRIME)
              // expmods_and_points.points[101] = -(g^39939 * z).
              mstore(add(expmodsAndPoints, 0x11a0), point)

              // point *= g^1017.
              point := mulmod(point, /*traceGenerator^1017*/ mload(add(expmodsAndPoints, 0x360)), PRIME)
              // expmods_and_points.points[102] = -(g^40956 * z).
              mstore(add(expmodsAndPoints, 0x11c0), point)

              // point *= g^4.
              point := mulmod(point, /*traceGenerator^4*/ mload(add(expmodsAndPoints, 0x40)), PRIME)
              // expmods_and_points.points[103] = -(g^40960 * z).
              mstore(add(expmodsAndPoints, 0x11e0), point)

              // point *= g^3075.
              point := mulmod(point, /*traceGenerator^3075*/ mload(add(expmodsAndPoints, 0x4a0)), PRIME)
              // expmods_and_points.points[104] = -(g^44035 * z).
              mstore(add(expmodsAndPoints, 0x1200), point)

              // point *= g^1021.
              point := mulmod(point, /*traceGenerator^1021*/ mload(add(expmodsAndPoints, 0x380)), PRIME)
              // expmods_and_points.points[105] = -(g^45056 * z).
              mstore(add(expmodsAndPoints, 0x1220), point)

              // point *= g^2559.
              point := mulmod(point, /*traceGenerator^2559*/ mload(add(expmodsAndPoints, 0x460)), PRIME)
              // expmods_and_points.points[106] = -(g^47615 * z).
              mstore(add(expmodsAndPoints, 0x1240), point)

              // point *= g^1477.
              point := mulmod(point, /*traceGenerator^1477*/ mload(add(expmodsAndPoints, 0x3e0)), PRIME)
              // expmods_and_points.points[107] = -(g^49092 * z).
              mstore(add(expmodsAndPoints, 0x1260), point)

              // point *= g^20.
              point := mulmod(point, /*traceGenerator^20*/ mload(add(expmodsAndPoints, 0xe0)), PRIME)
              // expmods_and_points.points[108] = -(g^49112 * z).
              mstore(add(expmodsAndPoints, 0x1280), point)

              // point *= g^24.
              point := mulmod(point, /*traceGenerator^24*/ mload(add(expmodsAndPoints, 0x100)), PRIME)
              // expmods_and_points.points[109] = -(g^49136 * z).
              mstore(add(expmodsAndPoints, 0x12a0), point)

              // point *= g^271.
              point := mulmod(point, /*traceGenerator^271*/ mload(add(expmodsAndPoints, 0x260)), PRIME)
              // expmods_and_points.points[110] = -(g^49407 * z).
              mstore(add(expmodsAndPoints, 0x12c0), point)

              // point *= g^2820.
              point := mulmod(point, /*traceGenerator^2820*/ mload(add(expmodsAndPoints, 0x480)), PRIME)
              // expmods_and_points.points[111] = -(g^52227 * z).
              mstore(add(expmodsAndPoints, 0x12e0), point)

              // point *= g^1021.
              point := mulmod(point, /*traceGenerator^1021*/ mload(add(expmodsAndPoints, 0x380)), PRIME)
              // expmods_and_points.points[112] = -(g^53248 * z).
              mstore(add(expmodsAndPoints, 0x1300), point)

              // point *= g^3668.
              point := mulmod(point, /*traceGenerator^3668*/ mload(add(expmodsAndPoints, 0x4c0)), PRIME)
              // expmods_and_points.points[113] = -(g^56916 * z).
              mstore(add(expmodsAndPoints, 0x1320), point)

              // point *= g^428.
              point := mulmod(point, /*traceGenerator^428*/ mload(add(expmodsAndPoints, 0x2a0)), PRIME)
              // expmods_and_points.points[114] = -(g^57344 * z).
              mstore(add(expmodsAndPoints, 0x1340), point)

              // point *= g^3075.
              point := mulmod(point, /*traceGenerator^3075*/ mload(add(expmodsAndPoints, 0x4a0)), PRIME)
              // expmods_and_points.points[115] = -(g^60419 * z).
              mstore(add(expmodsAndPoints, 0x1360), point)

              // point *= g^1021.
              point := mulmod(point, /*traceGenerator^1021*/ mload(add(expmodsAndPoints, 0x380)), PRIME)
              // expmods_and_points.points[116] = -(g^61440 * z).
              mstore(add(expmodsAndPoints, 0x1380), point)

              // point *= g^2559.
              point := mulmod(point, /*traceGenerator^2559*/ mload(add(expmodsAndPoints, 0x460)), PRIME)
              // expmods_and_points.points[117] = -(g^63999 * z).
              mstore(add(expmodsAndPoints, 0x13a0), point)

              // point *= g^1024.
              point := mulmod(point, /*traceGenerator^1024*/ mload(add(expmodsAndPoints, 0x3a0)), PRIME)
              // expmods_and_points.points[118] = -(g^65023 * z).
              mstore(add(expmodsAndPoints, 0x13c0), point)

              // point *= g^453.
              point := mulmod(point, /*traceGenerator^453*/ mload(add(expmodsAndPoints, 0x2c0)), PRIME)
              // expmods_and_points.points[119] = -(g^65476 * z).
              mstore(add(expmodsAndPoints, 0x13e0), point)

              // point *= g^20.
              point := mulmod(point, /*traceGenerator^20*/ mload(add(expmodsAndPoints, 0xe0)), PRIME)
              // expmods_and_points.points[120] = -(g^65496 * z).
              mstore(add(expmodsAndPoints, 0x1400), point)

              // point *= g^24.
              point := mulmod(point, /*traceGenerator^24*/ mload(add(expmodsAndPoints, 0x100)), PRIME)
              // expmods_and_points.points[121] = -(g^65520 * z).
              mstore(add(expmodsAndPoints, 0x1420), point)

              // point *= g^14863.
              point := mulmod(point, /*traceGenerator^14863*/ mload(add(expmodsAndPoints, 0x4e0)), PRIME)
              // expmods_and_points.points[122] = -(g^80383 * z).
              mstore(add(expmodsAndPoints, 0x1440), point)
            }


            let evalPointsPtr := /*oodsEvalPoints*/ add(context, 0x7180)
            let evalPointsEndPtr := add(evalPointsPtr,
                                           mul(/*n_unique_queries*/ mload(add(context, 0x120)), 0x20))
            let productsPtr := add(batchInverseArray, 0x20)
            let valuesPtr := add(add(batchInverseArray, 0x20), 0x30000)
            let partialProduct := 1
            let minusPointPow := sub(PRIME, mulmod(oodsPoint, oodsPoint, PRIME))
            for {} lt(evalPointsPtr, evalPointsEndPtr)
                     {evalPointsPtr := add(evalPointsPtr, 0x20)} {
                let evalPoint := mload(evalPointsPtr)

                // Shift evalPoint to evaluation domain coset.
                let shiftedEvalPoint := mulmod(evalPoint, evalCosetOffset_, PRIME)

                {
                // Calculate denominator for row 0: x - z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x500)))
                mstore(productsPtr, partialProduct)
                mstore(valuesPtr, denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1: x - g * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x520)))
                mstore(add(productsPtr, 0x20), partialProduct)
                mstore(add(valuesPtr, 0x20), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 2: x - g^2 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x540)))
                mstore(add(productsPtr, 0x40), partialProduct)
                mstore(add(valuesPtr, 0x40), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 3: x - g^3 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x560)))
                mstore(add(productsPtr, 0x60), partialProduct)
                mstore(add(valuesPtr, 0x60), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 4: x - g^4 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x580)))
                mstore(add(productsPtr, 0x80), partialProduct)
                mstore(add(valuesPtr, 0x80), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 6: x - g^6 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x5a0)))
                mstore(add(productsPtr, 0xa0), partialProduct)
                mstore(add(valuesPtr, 0xa0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 7: x - g^7 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x5c0)))
                mstore(add(productsPtr, 0xc0), partialProduct)
                mstore(add(valuesPtr, 0xc0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 8: x - g^8 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x5e0)))
                mstore(add(productsPtr, 0xe0), partialProduct)
                mstore(add(valuesPtr, 0xe0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16: x - g^16 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x600)))
                mstore(add(productsPtr, 0x100), partialProduct)
                mstore(add(valuesPtr, 0x100), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 20: x - g^20 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x620)))
                mstore(add(productsPtr, 0x120), partialProduct)
                mstore(add(valuesPtr, 0x120), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 24: x - g^24 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x640)))
                mstore(add(productsPtr, 0x140), partialProduct)
                mstore(add(valuesPtr, 0x140), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 32: x - g^32 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x660)))
                mstore(add(productsPtr, 0x160), partialProduct)
                mstore(add(valuesPtr, 0x160), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 36: x - g^36 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x680)))
                mstore(add(productsPtr, 0x180), partialProduct)
                mstore(add(valuesPtr, 0x180), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 40: x - g^40 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x6a0)))
                mstore(add(productsPtr, 0x1a0), partialProduct)
                mstore(add(valuesPtr, 0x1a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 48: x - g^48 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x6c0)))
                mstore(add(productsPtr, 0x1c0), partialProduct)
                mstore(add(valuesPtr, 0x1c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 52: x - g^52 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x6e0)))
                mstore(add(productsPtr, 0x1e0), partialProduct)
                mstore(add(valuesPtr, 0x1e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 56: x - g^56 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x700)))
                mstore(add(productsPtr, 0x200), partialProduct)
                mstore(add(valuesPtr, 0x200), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 64: x - g^64 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x720)))
                mstore(add(productsPtr, 0x220), partialProduct)
                mstore(add(valuesPtr, 0x220), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 72: x - g^72 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x740)))
                mstore(add(productsPtr, 0x240), partialProduct)
                mstore(add(valuesPtr, 0x240), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 80: x - g^80 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x760)))
                mstore(add(productsPtr, 0x260), partialProduct)
                mstore(add(valuesPtr, 0x260), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 84: x - g^84 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x780)))
                mstore(add(productsPtr, 0x280), partialProduct)
                mstore(add(valuesPtr, 0x280), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 96: x - g^96 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x7a0)))
                mstore(add(productsPtr, 0x2a0), partialProduct)
                mstore(add(valuesPtr, 0x2a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 100: x - g^100 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x7c0)))
                mstore(add(productsPtr, 0x2c0), partialProduct)
                mstore(add(valuesPtr, 0x2c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 104: x - g^104 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x7e0)))
                mstore(add(productsPtr, 0x2e0), partialProduct)
                mstore(add(valuesPtr, 0x2e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 120: x - g^120 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x800)))
                mstore(add(productsPtr, 0x300), partialProduct)
                mstore(add(valuesPtr, 0x300), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 164: x - g^164 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x820)))
                mstore(add(productsPtr, 0x320), partialProduct)
                mstore(add(valuesPtr, 0x320), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 212: x - g^212 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x840)))
                mstore(add(productsPtr, 0x340), partialProduct)
                mstore(add(valuesPtr, 0x340), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 228: x - g^228 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x860)))
                mstore(add(productsPtr, 0x360), partialProduct)
                mstore(add(valuesPtr, 0x360), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 255: x - g^255 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x880)))
                mstore(add(productsPtr, 0x380), partialProduct)
                mstore(add(valuesPtr, 0x380), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 256: x - g^256 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x8a0)))
                mstore(add(productsPtr, 0x3a0), partialProduct)
                mstore(add(valuesPtr, 0x3a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 511: x - g^511 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x8c0)))
                mstore(add(productsPtr, 0x3c0), partialProduct)
                mstore(add(valuesPtr, 0x3c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 512: x - g^512 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x8e0)))
                mstore(add(productsPtr, 0x3e0), partialProduct)
                mstore(add(valuesPtr, 0x3e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 767: x - g^767 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x900)))
                mstore(add(productsPtr, 0x400), partialProduct)
                mstore(add(valuesPtr, 0x400), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 768: x - g^768 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x920)))
                mstore(add(productsPtr, 0x420), partialProduct)
                mstore(add(valuesPtr, 0x420), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1020: x - g^1020 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x940)))
                mstore(add(productsPtr, 0x440), partialProduct)
                mstore(add(valuesPtr, 0x440), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1021: x - g^1021 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x960)))
                mstore(add(productsPtr, 0x460), partialProduct)
                mstore(add(valuesPtr, 0x460), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1022: x - g^1022 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x980)))
                mstore(add(productsPtr, 0x480), partialProduct)
                mstore(add(valuesPtr, 0x480), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1023: x - g^1023 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x9a0)))
                mstore(add(productsPtr, 0x4a0), partialProduct)
                mstore(add(valuesPtr, 0x4a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1024: x - g^1024 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x9c0)))
                mstore(add(productsPtr, 0x4c0), partialProduct)
                mstore(add(valuesPtr, 0x4c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1026: x - g^1026 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x9e0)))
                mstore(add(productsPtr, 0x4e0), partialProduct)
                mstore(add(valuesPtr, 0x4e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1027: x - g^1027 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xa00)))
                mstore(add(productsPtr, 0x500), partialProduct)
                mstore(add(valuesPtr, 0x500), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1279: x - g^1279 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xa20)))
                mstore(add(productsPtr, 0x520), partialProduct)
                mstore(add(valuesPtr, 0x520), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1535: x - g^1535 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xa40)))
                mstore(add(productsPtr, 0x540), partialProduct)
                mstore(add(valuesPtr, 0x540), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 2044: x - g^2044 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xa60)))
                mstore(add(productsPtr, 0x560), partialProduct)
                mstore(add(valuesPtr, 0x560), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 2045: x - g^2045 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xa80)))
                mstore(add(productsPtr, 0x580), partialProduct)
                mstore(add(valuesPtr, 0x580), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 2051: x - g^2051 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xaa0)))
                mstore(add(productsPtr, 0x5a0), partialProduct)
                mstore(add(valuesPtr, 0x5a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 2559: x - g^2559 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xac0)))
                mstore(add(productsPtr, 0x5c0), partialProduct)
                mstore(add(valuesPtr, 0x5c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 3075: x - g^3075 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xae0)))
                mstore(add(productsPtr, 0x5e0), partialProduct)
                mstore(add(valuesPtr, 0x5e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 4092: x - g^4092 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xb00)))
                mstore(add(productsPtr, 0x600), partialProduct)
                mstore(add(valuesPtr, 0x600), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 4096: x - g^4096 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xb20)))
                mstore(add(productsPtr, 0x620), partialProduct)
                mstore(add(valuesPtr, 0x620), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 4099: x - g^4099 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xb40)))
                mstore(add(productsPtr, 0x640), partialProduct)
                mstore(add(valuesPtr, 0x640), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 4607: x - g^4607 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xb60)))
                mstore(add(productsPtr, 0x660), partialProduct)
                mstore(add(valuesPtr, 0x660), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 5123: x - g^5123 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xb80)))
                mstore(add(productsPtr, 0x680), partialProduct)
                mstore(add(valuesPtr, 0x680), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 6655: x - g^6655 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xba0)))
                mstore(add(productsPtr, 0x6a0), partialProduct)
                mstore(add(valuesPtr, 0x6a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 7171: x - g^7171 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xbc0)))
                mstore(add(productsPtr, 0x6c0), partialProduct)
                mstore(add(valuesPtr, 0x6c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 8188: x - g^8188 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xbe0)))
                mstore(add(productsPtr, 0x6e0), partialProduct)
                mstore(add(valuesPtr, 0x6e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 8192: x - g^8192 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xc00)))
                mstore(add(productsPtr, 0x700), partialProduct)
                mstore(add(valuesPtr, 0x700), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 8195: x - g^8195 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xc20)))
                mstore(add(productsPtr, 0x720), partialProduct)
                mstore(add(valuesPtr, 0x720), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 8703: x - g^8703 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xc40)))
                mstore(add(productsPtr, 0x740), partialProduct)
                mstore(add(valuesPtr, 0x740), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 9219: x - g^9219 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xc60)))
                mstore(add(productsPtr, 0x760), partialProduct)
                mstore(add(valuesPtr, 0x760), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 10751: x - g^10751 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xc80)))
                mstore(add(productsPtr, 0x780), partialProduct)
                mstore(add(valuesPtr, 0x780), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 11267: x - g^11267 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xca0)))
                mstore(add(productsPtr, 0x7a0), partialProduct)
                mstore(add(valuesPtr, 0x7a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 12284: x - g^12284 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xcc0)))
                mstore(add(productsPtr, 0x7c0), partialProduct)
                mstore(add(valuesPtr, 0x7c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 12288: x - g^12288 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xce0)))
                mstore(add(productsPtr, 0x7e0), partialProduct)
                mstore(add(valuesPtr, 0x7e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 14847: x - g^14847 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xd00)))
                mstore(add(productsPtr, 0x800), partialProduct)
                mstore(add(valuesPtr, 0x800), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16324: x - g^16324 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xd20)))
                mstore(add(productsPtr, 0x820), partialProduct)
                mstore(add(valuesPtr, 0x820), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16328: x - g^16328 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xd40)))
                mstore(add(productsPtr, 0x840), partialProduct)
                mstore(add(valuesPtr, 0x840), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16344: x - g^16344 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xd60)))
                mstore(add(productsPtr, 0x860), partialProduct)
                mstore(add(valuesPtr, 0x860), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16360: x - g^16360 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xd80)))
                mstore(add(productsPtr, 0x880), partialProduct)
                mstore(add(valuesPtr, 0x880), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16368: x - g^16368 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xda0)))
                mstore(add(productsPtr, 0x8a0), partialProduct)
                mstore(add(valuesPtr, 0x8a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16400: x - g^16400 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xdc0)))
                mstore(add(productsPtr, 0x8c0), partialProduct)
                mstore(add(valuesPtr, 0x8c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16416: x - g^16416 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xde0)))
                mstore(add(productsPtr, 0x8e0), partialProduct)
                mstore(add(valuesPtr, 0x8e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16639: x - g^16639 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xe00)))
                mstore(add(productsPtr, 0x900), partialProduct)
                mstore(add(valuesPtr, 0x900), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 19459: x - g^19459 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xe20)))
                mstore(add(productsPtr, 0x920), partialProduct)
                mstore(add(valuesPtr, 0x920), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 20480: x - g^20480 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xe40)))
                mstore(add(productsPtr, 0x940), partialProduct)
                mstore(add(valuesPtr, 0x940), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 23039: x - g^23039 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xe60)))
                mstore(add(productsPtr, 0x960), partialProduct)
                mstore(add(valuesPtr, 0x960), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 24148: x - g^24148 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xe80)))
                mstore(add(productsPtr, 0x980), partialProduct)
                mstore(add(valuesPtr, 0x980), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 24576: x - g^24576 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xea0)))
                mstore(add(productsPtr, 0x9a0), partialProduct)
                mstore(add(valuesPtr, 0x9a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 27135: x - g^27135 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xec0)))
                mstore(add(productsPtr, 0x9c0), partialProduct)
                mstore(add(valuesPtr, 0x9c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 27651: x - g^27651 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xee0)))
                mstore(add(productsPtr, 0x9e0), partialProduct)
                mstore(add(valuesPtr, 0x9e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 28672: x - g^28672 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xf00)))
                mstore(add(productsPtr, 0xa00), partialProduct)
                mstore(add(valuesPtr, 0xa00), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 31231: x - g^31231 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xf20)))
                mstore(add(productsPtr, 0xa20), partialProduct)
                mstore(add(valuesPtr, 0xa20), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 32255: x - g^32255 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xf40)))
                mstore(add(productsPtr, 0xa40), partialProduct)
                mstore(add(valuesPtr, 0xa40), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 32660: x - g^32660 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xf60)))
                mstore(add(productsPtr, 0xa60), partialProduct)
                mstore(add(valuesPtr, 0xa60), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 32676: x - g^32676 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xf80)))
                mstore(add(productsPtr, 0xa80), partialProduct)
                mstore(add(valuesPtr, 0xa80), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 32692: x - g^32692 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xfa0)))
                mstore(add(productsPtr, 0xaa0), partialProduct)
                mstore(add(valuesPtr, 0xaa0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 32708: x - g^32708 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xfc0)))
                mstore(add(productsPtr, 0xac0), partialProduct)
                mstore(add(valuesPtr, 0xac0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 32712: x - g^32712 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xfe0)))
                mstore(add(productsPtr, 0xae0), partialProduct)
                mstore(add(valuesPtr, 0xae0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 32728: x - g^32728 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1000)))
                mstore(add(productsPtr, 0xb00), partialProduct)
                mstore(add(valuesPtr, 0xb00), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 32740: x - g^32740 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1020)))
                mstore(add(productsPtr, 0xb20), partialProduct)
                mstore(add(valuesPtr, 0xb20), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 32744: x - g^32744 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1040)))
                mstore(add(productsPtr, 0xb40), partialProduct)
                mstore(add(valuesPtr, 0xb40), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 32752: x - g^32752 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1060)))
                mstore(add(productsPtr, 0xb60), partialProduct)
                mstore(add(valuesPtr, 0xb60), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 32800: x - g^32800 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1080)))
                mstore(add(productsPtr, 0xb80), partialProduct)
                mstore(add(valuesPtr, 0xb80), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 32852: x - g^32852 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x10a0)))
                mstore(add(productsPtr, 0xba0), partialProduct)
                mstore(add(valuesPtr, 0xba0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 33023: x - g^33023 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x10c0)))
                mstore(add(productsPtr, 0xbc0), partialProduct)
                mstore(add(valuesPtr, 0xbc0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 33279: x - g^33279 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x10e0)))
                mstore(add(productsPtr, 0xbe0), partialProduct)
                mstore(add(valuesPtr, 0xbe0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 33789: x - g^33789 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1100)))
                mstore(add(productsPtr, 0xc00), partialProduct)
                mstore(add(valuesPtr, 0xc00), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 35843: x - g^35843 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1120)))
                mstore(add(productsPtr, 0xc20), partialProduct)
                mstore(add(valuesPtr, 0xc20), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 36864: x - g^36864 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1140)))
                mstore(add(productsPtr, 0xc40), partialProduct)
                mstore(add(valuesPtr, 0xc40), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 36867: x - g^36867 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1160)))
                mstore(add(productsPtr, 0xc60), partialProduct)
                mstore(add(valuesPtr, 0xc60), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 37891: x - g^37891 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1180)))
                mstore(add(productsPtr, 0xc80), partialProduct)
                mstore(add(valuesPtr, 0xc80), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 39939: x - g^39939 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x11a0)))
                mstore(add(productsPtr, 0xca0), partialProduct)
                mstore(add(valuesPtr, 0xca0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 40956: x - g^40956 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x11c0)))
                mstore(add(productsPtr, 0xcc0), partialProduct)
                mstore(add(valuesPtr, 0xcc0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 40960: x - g^40960 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x11e0)))
                mstore(add(productsPtr, 0xce0), partialProduct)
                mstore(add(valuesPtr, 0xce0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 44035: x - g^44035 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1200)))
                mstore(add(productsPtr, 0xd00), partialProduct)
                mstore(add(valuesPtr, 0xd00), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 45056: x - g^45056 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1220)))
                mstore(add(productsPtr, 0xd20), partialProduct)
                mstore(add(valuesPtr, 0xd20), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 47615: x - g^47615 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1240)))
                mstore(add(productsPtr, 0xd40), partialProduct)
                mstore(add(valuesPtr, 0xd40), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 49092: x - g^49092 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1260)))
                mstore(add(productsPtr, 0xd60), partialProduct)
                mstore(add(valuesPtr, 0xd60), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 49112: x - g^49112 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1280)))
                mstore(add(productsPtr, 0xd80), partialProduct)
                mstore(add(valuesPtr, 0xd80), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 49136: x - g^49136 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x12a0)))
                mstore(add(productsPtr, 0xda0), partialProduct)
                mstore(add(valuesPtr, 0xda0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 49407: x - g^49407 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x12c0)))
                mstore(add(productsPtr, 0xdc0), partialProduct)
                mstore(add(valuesPtr, 0xdc0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 52227: x - g^52227 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x12e0)))
                mstore(add(productsPtr, 0xde0), partialProduct)
                mstore(add(valuesPtr, 0xde0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 53248: x - g^53248 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1300)))
                mstore(add(productsPtr, 0xe00), partialProduct)
                mstore(add(valuesPtr, 0xe00), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 56916: x - g^56916 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1320)))
                mstore(add(productsPtr, 0xe20), partialProduct)
                mstore(add(valuesPtr, 0xe20), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 57344: x - g^57344 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1340)))
                mstore(add(productsPtr, 0xe40), partialProduct)
                mstore(add(valuesPtr, 0xe40), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 60419: x - g^60419 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1360)))
                mstore(add(productsPtr, 0xe60), partialProduct)
                mstore(add(valuesPtr, 0xe60), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 61440: x - g^61440 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1380)))
                mstore(add(productsPtr, 0xe80), partialProduct)
                mstore(add(valuesPtr, 0xe80), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 63999: x - g^63999 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x13a0)))
                mstore(add(productsPtr, 0xea0), partialProduct)
                mstore(add(valuesPtr, 0xea0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 65023: x - g^65023 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x13c0)))
                mstore(add(productsPtr, 0xec0), partialProduct)
                mstore(add(valuesPtr, 0xec0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 65476: x - g^65476 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x13e0)))
                mstore(add(productsPtr, 0xee0), partialProduct)
                mstore(add(valuesPtr, 0xee0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 65496: x - g^65496 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1400)))
                mstore(add(productsPtr, 0xf00), partialProduct)
                mstore(add(valuesPtr, 0xf00), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 65520: x - g^65520 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1420)))
                mstore(add(productsPtr, 0xf20), partialProduct)
                mstore(add(valuesPtr, 0xf20), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 80383: x - g^80383 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1440)))
                mstore(add(productsPtr, 0xf40), partialProduct)
                mstore(add(valuesPtr, 0xf40), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 512 * (vaults_path_length - 1) + 511: x - g^(512 * (vaults_path_length - 1) + 511) * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1460)))
                mstore(add(productsPtr, 0xf60), partialProduct)
                mstore(add(valuesPtr, 0xf60), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 512 * (vaults_path_length - 1) + 16895: x - g^(512 * (vaults_path_length - 1) + 16895) * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1480)))
                mstore(add(productsPtr, 0xf80), partialProduct)
                mstore(add(valuesPtr, 0xf80), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 512 * (vaults_path_length - 1) + 49663: x - g^(512 * (vaults_path_length - 1) + 49663) * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x14a0)))
                mstore(add(productsPtr, 0xfa0), partialProduct)
                mstore(add(valuesPtr, 0xfa0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate the denominator for the composition polynomial columns: x - z^2.
                let denominator := add(shiftedEvalPoint, minusPointPow)
                mstore(add(productsPtr, 0xfc0), partialProduct)
                mstore(add(valuesPtr, 0xfc0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                // Add evalPoint to batch inverse inputs.
                // inverse(evalPoint) is going to be used by FRI.
                mstore(add(productsPtr, 0xfe0), partialProduct)
                mstore(add(valuesPtr, 0xfe0), evalPoint)
                partialProduct := mulmod(partialProduct, evalPoint, PRIME)

                // Advance pointers.
                productsPtr := add(productsPtr, 0x1000)
                valuesPtr := add(valuesPtr, 0x1000)
            }

            let productsToValuesOffset := 0x30000
            let firstPartialProductPtr := add(batchInverseArray, 0x20)
            // Compute the inverse of the product.
            let prodInv := expmod(partialProduct, sub(PRIME, 2), PRIME)

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
            let currentPartialProductPtr := productsPtr
            // Loop in blocks of size 8 as much as possible: we can loop over a full block as long as
            // currentPartialProductPtr >= firstPartialProductPtr + 8*0x20, or equivalently,
            // currentPartialProductPtr > firstPartialProductPtr + 7*0x20.
            // We use the latter comparison since there is no >= evm opcode.
            let midPartialProductPtr := add(firstPartialProductPtr, 0xe0)
            for { } gt(currentPartialProductPtr, midPartialProductPtr) { } {
                currentPartialProductPtr := sub(currentPartialProductPtr, 0x20)
                // Store 1/d_{i} = (d_0 * ... * d_{i-1}) * 1/(d_0 * ... * d_{i}).
                mstore(currentPartialProductPtr,
                       mulmod(mload(currentPartialProductPtr), prodInv, PRIME))
                // Update prodInv to be 1/(d_0 * ... * d_{i-1}) by multiplying by d_i.
                prodInv := mulmod(prodInv,
                                   mload(add(currentPartialProductPtr, productsToValuesOffset)),
                                   PRIME)

                currentPartialProductPtr := sub(currentPartialProductPtr, 0x20)
                // Store 1/d_{i} = (d_0 * ... * d_{i-1}) * 1/(d_0 * ... * d_{i}).
                mstore(currentPartialProductPtr,
                       mulmod(mload(currentPartialProductPtr), prodInv, PRIME))
                // Update prodInv to be 1/(d_0 * ... * d_{i-1}) by multiplying by d_i.
                prodInv := mulmod(prodInv,
                                   mload(add(currentPartialProductPtr, productsToValuesOffset)),
                                   PRIME)

                currentPartialProductPtr := sub(currentPartialProductPtr, 0x20)
                // Store 1/d_{i} = (d_0 * ... * d_{i-1}) * 1/(d_0 * ... * d_{i}).
                mstore(currentPartialProductPtr,
                       mulmod(mload(currentPartialProductPtr), prodInv, PRIME))
                // Update prodInv to be 1/(d_0 * ... * d_{i-1}) by multiplying by d_i.
                prodInv := mulmod(prodInv,
                                   mload(add(currentPartialProductPtr, productsToValuesOffset)),
                                   PRIME)

                currentPartialProductPtr := sub(currentPartialProductPtr, 0x20)
                // Store 1/d_{i} = (d_0 * ... * d_{i-1}) * 1/(d_0 * ... * d_{i}).
                mstore(currentPartialProductPtr,
                       mulmod(mload(currentPartialProductPtr), prodInv, PRIME))
                // Update prodInv to be 1/(d_0 * ... * d_{i-1}) by multiplying by d_i.
                prodInv := mulmod(prodInv,
                                   mload(add(currentPartialProductPtr, productsToValuesOffset)),
                                   PRIME)

                currentPartialProductPtr := sub(currentPartialProductPtr, 0x20)
                // Store 1/d_{i} = (d_0 * ... * d_{i-1}) * 1/(d_0 * ... * d_{i}).
                mstore(currentPartialProductPtr,
                       mulmod(mload(currentPartialProductPtr), prodInv, PRIME))
                // Update prodInv to be 1/(d_0 * ... * d_{i-1}) by multiplying by d_i.
                prodInv := mulmod(prodInv,
                                   mload(add(currentPartialProductPtr, productsToValuesOffset)),
                                   PRIME)

                currentPartialProductPtr := sub(currentPartialProductPtr, 0x20)
                // Store 1/d_{i} = (d_0 * ... * d_{i-1}) * 1/(d_0 * ... * d_{i}).
                mstore(currentPartialProductPtr,
                       mulmod(mload(currentPartialProductPtr), prodInv, PRIME))
                // Update prodInv to be 1/(d_0 * ... * d_{i-1}) by multiplying by d_i.
                prodInv := mulmod(prodInv,
                                   mload(add(currentPartialProductPtr, productsToValuesOffset)),
                                   PRIME)

                currentPartialProductPtr := sub(currentPartialProductPtr, 0x20)
                // Store 1/d_{i} = (d_0 * ... * d_{i-1}) * 1/(d_0 * ... * d_{i}).
                mstore(currentPartialProductPtr,
                       mulmod(mload(currentPartialProductPtr), prodInv, PRIME))
                // Update prodInv to be 1/(d_0 * ... * d_{i-1}) by multiplying by d_i.
                prodInv := mulmod(prodInv,
                                   mload(add(currentPartialProductPtr, productsToValuesOffset)),
                                   PRIME)

                currentPartialProductPtr := sub(currentPartialProductPtr, 0x20)
                // Store 1/d_{i} = (d_0 * ... * d_{i-1}) * 1/(d_0 * ... * d_{i}).
                mstore(currentPartialProductPtr,
                       mulmod(mload(currentPartialProductPtr), prodInv, PRIME))
                // Update prodInv to be 1/(d_0 * ... * d_{i-1}) by multiplying by d_i.
                prodInv := mulmod(prodInv,
                                   mload(add(currentPartialProductPtr, productsToValuesOffset)),
                                   PRIME)
            }

            // Loop over the remainder.
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
    }
}
// ---------- End of auto-generated code. ----------
