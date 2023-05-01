// ---------- The following code was auto-generated. PLEASE DO NOT EDIT. ----------
// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

import "./MemoryMap.sol";
import "./StarkParameters.sol";

contract CpuOods is MemoryMap, StarkParameters {
    // For each query point we want to invert (2 + N_ROWS_IN_MASK) items:
    //  The query point itself (x).
    //  The denominator for the constraint polynomial (x-z^constraintDegree)
    //  [(x-(g^rowNumber)z) for rowNumber in mask].
    uint256 constant internal BATCH_INVERSE_CHUNK = (2 + N_ROWS_IN_MASK);

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
    fallback() external {
        // This funciton assumes that the calldata contains the context as defined in MemoryMap.sol.
        // Note that ctx is a variable size array so the first uint256 cell contrains it's length.
        uint256[] memory ctx;
        assembly {
            let ctxSize := mul(add(calldataload(0), 1), 0x20)
            ctx := mload(0x40)
            mstore(0x40, add(ctx, ctxSize))
            calldatacopy(ctx, 0, ctxSize)
        }
        uint256 n_queries = ctx[MM_N_UNIQUE_QUERIES];
        uint256[] memory batchInverseArray = new uint256[](2 * n_queries * BATCH_INVERSE_CHUNK);
        oodsPrepareInverses(ctx, batchInverseArray);

        uint256 kMontgomeryRInv = PrimeFieldElement0.K_MONTGOMERY_R_INV;

        assembly {
            let PRIME := 0x800000000000011000000000000000000000000000000000000000000000001
            let context := ctx
            let friQueue := /*friQueue*/ add(context, 0xdc0)
            let friQueueEnd := add(friQueue,  mul(n_queries, 0x60))
            let traceQueryResponses := /*traceQueryQesponses*/ add(context, 0x4240)

            let compositionQueryResponses := /*composition_query_responses*/ add(context, 0x7e40)

            // Set denominatorsPtr to point to the batchInverseOut array.
            // The content of batchInverseOut is described in oodsPrepareInverses.
            let denominatorsPtr := add(batchInverseArray, 0x20)

            for {} lt(friQueue, friQueueEnd) {friQueue := add(friQueue, 0x60)} {
                // res accumulates numbers modulo PRIME. Since 31*PRIME < 2**256, we may add up to
                // 31 numbers without fear of overflow, and use addmod modulo PRIME only every
                // 31 iterations, and once more at the very end.
                let res := 0

                // Trace constraints.
                let oods_alpha_pow := 1
                let oods_alpha := /*oods_alpha*/ mload(add(context, 0x4220))

                // Mask items for column #0.
                {
                // Read the next element.
                let columnValue := mulmod(mload(traceQueryResponses), kMontgomeryRInv, PRIME)

                // res += c_0*(f_0(x) - f_0(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[0]*/ mload(add(context, 0x2be0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_1*(f_0(x) - f_0(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[1]*/ mload(add(context, 0x2c00)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_2*(f_0(x) - f_0(g^2 * z)) / (x - g^2 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2 * z)^(-1)*/ mload(add(denominatorsPtr, 0x40)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[2]*/ mload(add(context, 0x2c20)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_3*(f_0(x) - f_0(g^3 * z)) / (x - g^3 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3 * z)^(-1)*/ mload(add(denominatorsPtr, 0x60)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[3]*/ mload(add(context, 0x2c40)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_4*(f_0(x) - f_0(g^4 * z)) / (x - g^4 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4 * z)^(-1)*/ mload(add(denominatorsPtr, 0x80)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[4]*/ mload(add(context, 0x2c60)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_5*(f_0(x) - f_0(g^5 * z)) / (x - g^5 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^5 * z)^(-1)*/ mload(add(denominatorsPtr, 0xa0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[5]*/ mload(add(context, 0x2c80)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_6*(f_0(x) - f_0(g^6 * z)) / (x - g^6 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^6 * z)^(-1)*/ mload(add(denominatorsPtr, 0xc0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[6]*/ mload(add(context, 0x2ca0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_7*(f_0(x) - f_0(g^7 * z)) / (x - g^7 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^7 * z)^(-1)*/ mload(add(denominatorsPtr, 0xe0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[7]*/ mload(add(context, 0x2cc0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_8*(f_0(x) - f_0(g^8 * z)) / (x - g^8 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8 * z)^(-1)*/ mload(add(denominatorsPtr, 0x100)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[8]*/ mload(add(context, 0x2ce0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_9*(f_0(x) - f_0(g^9 * z)) / (x - g^9 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^9 * z)^(-1)*/ mload(add(denominatorsPtr, 0x120)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[9]*/ mload(add(context, 0x2d00)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_10*(f_0(x) - f_0(g^10 * z)) / (x - g^10 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^10 * z)^(-1)*/ mload(add(denominatorsPtr, 0x140)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[10]*/ mload(add(context, 0x2d20)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_11*(f_0(x) - f_0(g^11 * z)) / (x - g^11 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^11 * z)^(-1)*/ mload(add(denominatorsPtr, 0x160)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[11]*/ mload(add(context, 0x2d40)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_12*(f_0(x) - f_0(g^12 * z)) / (x - g^12 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^12 * z)^(-1)*/ mload(add(denominatorsPtr, 0x180)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[12]*/ mload(add(context, 0x2d60)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_13*(f_0(x) - f_0(g^13 * z)) / (x - g^13 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^13 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[13]*/ mload(add(context, 0x2d80)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_14*(f_0(x) - f_0(g^14 * z)) / (x - g^14 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^14 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[14]*/ mload(add(context, 0x2da0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_15*(f_0(x) - f_0(g^15 * z)) / (x - g^15 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^15 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[15]*/ mload(add(context, 0x2dc0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Mask items for column #1.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x20)), kMontgomeryRInv, PRIME)

                // res += c_16*(f_1(x) - f_1(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[16]*/ mload(add(context, 0x2de0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_17*(f_1(x) - f_1(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[17]*/ mload(add(context, 0x2e00)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_18*(f_1(x) - f_1(g^255 * z)) / (x - g^255 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^255 * z)^(-1)*/ mload(add(denominatorsPtr, 0x680)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[18]*/ mload(add(context, 0x2e20)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_19*(f_1(x) - f_1(g^256 * z)) / (x - g^256 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^256 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[19]*/ mload(add(context, 0x2e40)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_20*(f_1(x) - f_1(g^511 * z)) / (x - g^511 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^511 * z)^(-1)*/ mload(add(denominatorsPtr, 0x760)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[20]*/ mload(add(context, 0x2e60)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Mask items for column #2.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x40)), kMontgomeryRInv, PRIME)

                // res += c_21*(f_2(x) - f_2(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[21]*/ mload(add(context, 0x2e80)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_22*(f_2(x) - f_2(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[22]*/ mload(add(context, 0x2ea0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_23*(f_2(x) - f_2(g^255 * z)) / (x - g^255 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^255 * z)^(-1)*/ mload(add(denominatorsPtr, 0x680)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[23]*/ mload(add(context, 0x2ec0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_24*(f_2(x) - f_2(g^256 * z)) / (x - g^256 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^256 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[24]*/ mload(add(context, 0x2ee0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Mask items for column #3.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x60)), kMontgomeryRInv, PRIME)

                // res += c_25*(f_3(x) - f_3(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[25]*/ mload(add(context, 0x2f00)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_26*(f_3(x) - f_3(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[26]*/ mload(add(context, 0x2f20)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_27*(f_3(x) - f_3(g^192 * z)) / (x - g^192 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^192 * z)^(-1)*/ mload(add(denominatorsPtr, 0x580)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[27]*/ mload(add(context, 0x2f40)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_28*(f_3(x) - f_3(g^193 * z)) / (x - g^193 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^193 * z)^(-1)*/ mload(add(denominatorsPtr, 0x5a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[28]*/ mload(add(context, 0x2f60)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_29*(f_3(x) - f_3(g^196 * z)) / (x - g^196 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^196 * z)^(-1)*/ mload(add(denominatorsPtr, 0x5c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[29]*/ mload(add(context, 0x2f80)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_30*(f_3(x) - f_3(g^197 * z)) / (x - g^197 * z).
                res := addmod(
                    res,
                    mulmod(mulmod(/*(x - g^197 * z)^(-1)*/ mload(add(denominatorsPtr, 0x5e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[30]*/ mload(add(context, 0x2fa0)))),
                           PRIME),
                    PRIME)
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_31*(f_3(x) - f_3(g^251 * z)) / (x - g^251 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^251 * z)^(-1)*/ mload(add(denominatorsPtr, 0x640)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[31]*/ mload(add(context, 0x2fc0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_32*(f_3(x) - f_3(g^252 * z)) / (x - g^252 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^252 * z)^(-1)*/ mload(add(denominatorsPtr, 0x660)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[32]*/ mload(add(context, 0x2fe0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_33*(f_3(x) - f_3(g^256 * z)) / (x - g^256 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^256 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[33]*/ mload(add(context, 0x3000)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Mask items for column #4.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x80)), kMontgomeryRInv, PRIME)

                // res += c_34*(f_4(x) - f_4(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[34]*/ mload(add(context, 0x3020)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_35*(f_4(x) - f_4(g^255 * z)) / (x - g^255 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^255 * z)^(-1)*/ mload(add(denominatorsPtr, 0x680)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[35]*/ mload(add(context, 0x3040)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Mask items for column #5.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0xa0)), kMontgomeryRInv, PRIME)

                // res += c_36*(f_5(x) - f_5(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[36]*/ mload(add(context, 0x3060)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_37*(f_5(x) - f_5(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[37]*/ mload(add(context, 0x3080)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_38*(f_5(x) - f_5(g^2 * z)) / (x - g^2 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2 * z)^(-1)*/ mload(add(denominatorsPtr, 0x40)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[38]*/ mload(add(context, 0x30a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_39*(f_5(x) - f_5(g^3 * z)) / (x - g^3 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3 * z)^(-1)*/ mload(add(denominatorsPtr, 0x60)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[39]*/ mload(add(context, 0x30c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_40*(f_5(x) - f_5(g^4 * z)) / (x - g^4 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4 * z)^(-1)*/ mload(add(denominatorsPtr, 0x80)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[40]*/ mload(add(context, 0x30e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_41*(f_5(x) - f_5(g^5 * z)) / (x - g^5 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^5 * z)^(-1)*/ mload(add(denominatorsPtr, 0xa0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[41]*/ mload(add(context, 0x3100)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_42*(f_5(x) - f_5(g^6 * z)) / (x - g^6 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^6 * z)^(-1)*/ mload(add(denominatorsPtr, 0xc0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[42]*/ mload(add(context, 0x3120)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_43*(f_5(x) - f_5(g^7 * z)) / (x - g^7 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^7 * z)^(-1)*/ mload(add(denominatorsPtr, 0xe0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[43]*/ mload(add(context, 0x3140)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_44*(f_5(x) - f_5(g^8 * z)) / (x - g^8 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8 * z)^(-1)*/ mload(add(denominatorsPtr, 0x100)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[44]*/ mload(add(context, 0x3160)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_45*(f_5(x) - f_5(g^9 * z)) / (x - g^9 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^9 * z)^(-1)*/ mload(add(denominatorsPtr, 0x120)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[45]*/ mload(add(context, 0x3180)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_46*(f_5(x) - f_5(g^12 * z)) / (x - g^12 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^12 * z)^(-1)*/ mload(add(denominatorsPtr, 0x180)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[46]*/ mload(add(context, 0x31a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_47*(f_5(x) - f_5(g^13 * z)) / (x - g^13 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^13 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[47]*/ mload(add(context, 0x31c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_48*(f_5(x) - f_5(g^16 * z)) / (x - g^16 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16 * z)^(-1)*/ mload(add(denominatorsPtr, 0x200)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[48]*/ mload(add(context, 0x31e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_49*(f_5(x) - f_5(g^70 * z)) / (x - g^70 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^70 * z)^(-1)*/ mload(add(denominatorsPtr, 0x380)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[49]*/ mload(add(context, 0x3200)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_50*(f_5(x) - f_5(g^71 * z)) / (x - g^71 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^71 * z)^(-1)*/ mload(add(denominatorsPtr, 0x3a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[50]*/ mload(add(context, 0x3220)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_51*(f_5(x) - f_5(g^134 * z)) / (x - g^134 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^134 * z)^(-1)*/ mload(add(denominatorsPtr, 0x4e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[51]*/ mload(add(context, 0x3240)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_52*(f_5(x) - f_5(g^135 * z)) / (x - g^135 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^135 * z)^(-1)*/ mload(add(denominatorsPtr, 0x500)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[52]*/ mload(add(context, 0x3260)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_53*(f_5(x) - f_5(g^262 * z)) / (x - g^262 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^262 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[53]*/ mload(add(context, 0x3280)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_54*(f_5(x) - f_5(g^263 * z)) / (x - g^263 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^263 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[54]*/ mload(add(context, 0x32a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_55*(f_5(x) - f_5(g^326 * z)) / (x - g^326 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^326 * z)^(-1)*/ mload(add(denominatorsPtr, 0x700)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[55]*/ mload(add(context, 0x32c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_56*(f_5(x) - f_5(g^390 * z)) / (x - g^390 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^390 * z)^(-1)*/ mload(add(denominatorsPtr, 0x720)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[56]*/ mload(add(context, 0x32e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_57*(f_5(x) - f_5(g^391 * z)) / (x - g^391 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^391 * z)^(-1)*/ mload(add(denominatorsPtr, 0x740)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[57]*/ mload(add(context, 0x3300)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_58*(f_5(x) - f_5(g^518 * z)) / (x - g^518 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^518 * z)^(-1)*/ mload(add(denominatorsPtr, 0x780)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[58]*/ mload(add(context, 0x3320)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_59*(f_5(x) - f_5(g^16774 * z)) / (x - g^16774 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16774 * z)^(-1)*/ mload(add(denominatorsPtr, 0x880)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[59]*/ mload(add(context, 0x3340)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_60*(f_5(x) - f_5(g^16775 * z)) / (x - g^16775 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16775 * z)^(-1)*/ mload(add(denominatorsPtr, 0x8a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[60]*/ mload(add(context, 0x3360)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_61*(f_5(x) - f_5(g^33158 * z)) / (x - g^33158 * z).
                res := addmod(
                    res,
                    mulmod(mulmod(/*(x - g^33158 * z)^(-1)*/ mload(add(denominatorsPtr, 0x9c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[61]*/ mload(add(context, 0x3380)))),
                           PRIME),
                    PRIME)
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Mask items for column #6.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0xc0)), kMontgomeryRInv, PRIME)

                // res += c_62*(f_6(x) - f_6(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[62]*/ mload(add(context, 0x33a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_63*(f_6(x) - f_6(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[63]*/ mload(add(context, 0x33c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_64*(f_6(x) - f_6(g^2 * z)) / (x - g^2 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2 * z)^(-1)*/ mload(add(denominatorsPtr, 0x40)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[64]*/ mload(add(context, 0x33e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_65*(f_6(x) - f_6(g^3 * z)) / (x - g^3 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3 * z)^(-1)*/ mload(add(denominatorsPtr, 0x60)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[65]*/ mload(add(context, 0x3400)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Mask items for column #7.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0xe0)), kMontgomeryRInv, PRIME)

                // res += c_66*(f_7(x) - f_7(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[66]*/ mload(add(context, 0x3420)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_67*(f_7(x) - f_7(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[67]*/ mload(add(context, 0x3440)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_68*(f_7(x) - f_7(g^2 * z)) / (x - g^2 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2 * z)^(-1)*/ mload(add(denominatorsPtr, 0x40)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[68]*/ mload(add(context, 0x3460)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_69*(f_7(x) - f_7(g^3 * z)) / (x - g^3 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3 * z)^(-1)*/ mload(add(denominatorsPtr, 0x60)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[69]*/ mload(add(context, 0x3480)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_70*(f_7(x) - f_7(g^4 * z)) / (x - g^4 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4 * z)^(-1)*/ mload(add(denominatorsPtr, 0x80)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[70]*/ mload(add(context, 0x34a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_71*(f_7(x) - f_7(g^5 * z)) / (x - g^5 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^5 * z)^(-1)*/ mload(add(denominatorsPtr, 0xa0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[71]*/ mload(add(context, 0x34c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_72*(f_7(x) - f_7(g^6 * z)) / (x - g^6 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^6 * z)^(-1)*/ mload(add(denominatorsPtr, 0xc0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[72]*/ mload(add(context, 0x34e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_73*(f_7(x) - f_7(g^7 * z)) / (x - g^7 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^7 * z)^(-1)*/ mload(add(denominatorsPtr, 0xe0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[73]*/ mload(add(context, 0x3500)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_74*(f_7(x) - f_7(g^8 * z)) / (x - g^8 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8 * z)^(-1)*/ mload(add(denominatorsPtr, 0x100)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[74]*/ mload(add(context, 0x3520)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_75*(f_7(x) - f_7(g^9 * z)) / (x - g^9 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^9 * z)^(-1)*/ mload(add(denominatorsPtr, 0x120)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[75]*/ mload(add(context, 0x3540)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_76*(f_7(x) - f_7(g^11 * z)) / (x - g^11 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^11 * z)^(-1)*/ mload(add(denominatorsPtr, 0x160)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[76]*/ mload(add(context, 0x3560)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_77*(f_7(x) - f_7(g^12 * z)) / (x - g^12 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^12 * z)^(-1)*/ mload(add(denominatorsPtr, 0x180)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[77]*/ mload(add(context, 0x3580)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_78*(f_7(x) - f_7(g^13 * z)) / (x - g^13 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^13 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[78]*/ mload(add(context, 0x35a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_79*(f_7(x) - f_7(g^15 * z)) / (x - g^15 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^15 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[79]*/ mload(add(context, 0x35c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_80*(f_7(x) - f_7(g^17 * z)) / (x - g^17 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^17 * z)^(-1)*/ mload(add(denominatorsPtr, 0x220)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[80]*/ mload(add(context, 0x35e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_81*(f_7(x) - f_7(g^23 * z)) / (x - g^23 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^23 * z)^(-1)*/ mload(add(denominatorsPtr, 0x240)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[81]*/ mload(add(context, 0x3600)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_82*(f_7(x) - f_7(g^25 * z)) / (x - g^25 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^25 * z)^(-1)*/ mload(add(denominatorsPtr, 0x260)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[82]*/ mload(add(context, 0x3620)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_83*(f_7(x) - f_7(g^31 * z)) / (x - g^31 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^31 * z)^(-1)*/ mload(add(denominatorsPtr, 0x280)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[83]*/ mload(add(context, 0x3640)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_84*(f_7(x) - f_7(g^39 * z)) / (x - g^39 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^39 * z)^(-1)*/ mload(add(denominatorsPtr, 0x2c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[84]*/ mload(add(context, 0x3660)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_85*(f_7(x) - f_7(g^44 * z)) / (x - g^44 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^44 * z)^(-1)*/ mload(add(denominatorsPtr, 0x2e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[85]*/ mload(add(context, 0x3680)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_86*(f_7(x) - f_7(g^47 * z)) / (x - g^47 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^47 * z)^(-1)*/ mload(add(denominatorsPtr, 0x300)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[86]*/ mload(add(context, 0x36a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_87*(f_7(x) - f_7(g^55 * z)) / (x - g^55 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^55 * z)^(-1)*/ mload(add(denominatorsPtr, 0x320)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[87]*/ mload(add(context, 0x36c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_88*(f_7(x) - f_7(g^63 * z)) / (x - g^63 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^63 * z)^(-1)*/ mload(add(denominatorsPtr, 0x340)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[88]*/ mload(add(context, 0x36e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_89*(f_7(x) - f_7(g^71 * z)) / (x - g^71 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^71 * z)^(-1)*/ mload(add(denominatorsPtr, 0x3a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[89]*/ mload(add(context, 0x3700)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_90*(f_7(x) - f_7(g^76 * z)) / (x - g^76 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^76 * z)^(-1)*/ mload(add(denominatorsPtr, 0x3c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[90]*/ mload(add(context, 0x3720)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_91*(f_7(x) - f_7(g^79 * z)) / (x - g^79 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^79 * z)^(-1)*/ mload(add(denominatorsPtr, 0x3e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[91]*/ mload(add(context, 0x3740)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_92*(f_7(x) - f_7(g^87 * z)) / (x - g^87 * z).
                res := addmod(
                    res,
                    mulmod(mulmod(/*(x - g^87 * z)^(-1)*/ mload(add(denominatorsPtr, 0x420)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[92]*/ mload(add(context, 0x3760)))),
                           PRIME),
                    PRIME)
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_93*(f_7(x) - f_7(g^103 * z)) / (x - g^103 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^103 * z)^(-1)*/ mload(add(denominatorsPtr, 0x460)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[93]*/ mload(add(context, 0x3780)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_94*(f_7(x) - f_7(g^108 * z)) / (x - g^108 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^108 * z)^(-1)*/ mload(add(denominatorsPtr, 0x480)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[94]*/ mload(add(context, 0x37a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_95*(f_7(x) - f_7(g^119 * z)) / (x - g^119 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^119 * z)^(-1)*/ mload(add(denominatorsPtr, 0x4a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[95]*/ mload(add(context, 0x37c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_96*(f_7(x) - f_7(g^140 * z)) / (x - g^140 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^140 * z)^(-1)*/ mload(add(denominatorsPtr, 0x520)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[96]*/ mload(add(context, 0x37e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_97*(f_7(x) - f_7(g^172 * z)) / (x - g^172 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^172 * z)^(-1)*/ mload(add(denominatorsPtr, 0x560)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[97]*/ mload(add(context, 0x3800)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_98*(f_7(x) - f_7(g^204 * z)) / (x - g^204 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^204 * z)^(-1)*/ mload(add(denominatorsPtr, 0x600)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[98]*/ mload(add(context, 0x3820)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_99*(f_7(x) - f_7(g^236 * z)) / (x - g^236 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^236 * z)^(-1)*/ mload(add(denominatorsPtr, 0x620)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[99]*/ mload(add(context, 0x3840)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_100*(f_7(x) - f_7(g^16343 * z)) / (x - g^16343 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16343 * z)^(-1)*/ mload(add(denominatorsPtr, 0x7a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[100]*/ mload(add(context, 0x3860)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_101*(f_7(x) - f_7(g^16351 * z)) / (x - g^16351 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16351 * z)^(-1)*/ mload(add(denominatorsPtr, 0x7c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[101]*/ mload(add(context, 0x3880)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_102*(f_7(x) - f_7(g^16367 * z)) / (x - g^16367 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16367 * z)^(-1)*/ mload(add(denominatorsPtr, 0x7e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[102]*/ mload(add(context, 0x38a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_103*(f_7(x) - f_7(g^16375 * z)) / (x - g^16375 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16375 * z)^(-1)*/ mload(add(denominatorsPtr, 0x800)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[103]*/ mload(add(context, 0x38c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_104*(f_7(x) - f_7(g^16383 * z)) / (x - g^16383 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16383 * z)^(-1)*/ mload(add(denominatorsPtr, 0x820)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[104]*/ mload(add(context, 0x38e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_105*(f_7(x) - f_7(g^16391 * z)) / (x - g^16391 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16391 * z)^(-1)*/ mload(add(denominatorsPtr, 0x840)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[105]*/ mload(add(context, 0x3900)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_106*(f_7(x) - f_7(g^16423 * z)) / (x - g^16423 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16423 * z)^(-1)*/ mload(add(denominatorsPtr, 0x860)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[106]*/ mload(add(context, 0x3920)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_107*(f_7(x) - f_7(g^32727 * z)) / (x - g^32727 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^32727 * z)^(-1)*/ mload(add(denominatorsPtr, 0x920)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[107]*/ mload(add(context, 0x3940)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_108*(f_7(x) - f_7(g^32735 * z)) / (x - g^32735 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^32735 * z)^(-1)*/ mload(add(denominatorsPtr, 0x940)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[108]*/ mload(add(context, 0x3960)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_109*(f_7(x) - f_7(g^32759 * z)) / (x - g^32759 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^32759 * z)^(-1)*/ mload(add(denominatorsPtr, 0x980)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[109]*/ mload(add(context, 0x3980)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_110*(f_7(x) - f_7(g^32767 * z)) / (x - g^32767 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^32767 * z)^(-1)*/ mload(add(denominatorsPtr, 0x9a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[110]*/ mload(add(context, 0x39a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Mask items for column #8.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x100)), kMontgomeryRInv, PRIME)

                // res += c_111*(f_8(x) - f_8(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[111]*/ mload(add(context, 0x39c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_112*(f_8(x) - f_8(g^16 * z)) / (x - g^16 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16 * z)^(-1)*/ mload(add(denominatorsPtr, 0x200)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[112]*/ mload(add(context, 0x39e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_113*(f_8(x) - f_8(g^32 * z)) / (x - g^32 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^32 * z)^(-1)*/ mload(add(denominatorsPtr, 0x2a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[113]*/ mload(add(context, 0x3a00)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_114*(f_8(x) - f_8(g^64 * z)) / (x - g^64 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^64 * z)^(-1)*/ mload(add(denominatorsPtr, 0x360)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[114]*/ mload(add(context, 0x3a20)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_115*(f_8(x) - f_8(g^80 * z)) / (x - g^80 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^80 * z)^(-1)*/ mload(add(denominatorsPtr, 0x400)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[115]*/ mload(add(context, 0x3a40)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_116*(f_8(x) - f_8(g^96 * z)) / (x - g^96 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^96 * z)^(-1)*/ mload(add(denominatorsPtr, 0x440)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[116]*/ mload(add(context, 0x3a60)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_117*(f_8(x) - f_8(g^128 * z)) / (x - g^128 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^128 * z)^(-1)*/ mload(add(denominatorsPtr, 0x4c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[117]*/ mload(add(context, 0x3a80)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_118*(f_8(x) - f_8(g^160 * z)) / (x - g^160 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^160 * z)^(-1)*/ mload(add(denominatorsPtr, 0x540)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[118]*/ mload(add(context, 0x3aa0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_119*(f_8(x) - f_8(g^192 * z)) / (x - g^192 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^192 * z)^(-1)*/ mload(add(denominatorsPtr, 0x580)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[119]*/ mload(add(context, 0x3ac0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_120*(f_8(x) - f_8(g^32640 * z)) / (x - g^32640 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^32640 * z)^(-1)*/ mload(add(denominatorsPtr, 0x8c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[120]*/ mload(add(context, 0x3ae0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_121*(f_8(x) - f_8(g^32656 * z)) / (x - g^32656 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^32656 * z)^(-1)*/ mload(add(denominatorsPtr, 0x8e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[121]*/ mload(add(context, 0x3b00)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_122*(f_8(x) - f_8(g^32704 * z)) / (x - g^32704 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^32704 * z)^(-1)*/ mload(add(denominatorsPtr, 0x900)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[122]*/ mload(add(context, 0x3b20)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_123*(f_8(x) - f_8(g^32736 * z)) / (x - g^32736 * z).
                res := addmod(
                    res,
                    mulmod(mulmod(/*(x - g^32736 * z)^(-1)*/ mload(add(denominatorsPtr, 0x960)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[123]*/ mload(add(context, 0x3b40)))),
                           PRIME),
                    PRIME)
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Mask items for column #9.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x120)), kMontgomeryRInv, PRIME)

                // res += c_124*(f_9(x) - f_9(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[124]*/ mload(add(context, 0x3b60)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_125*(f_9(x) - f_9(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[125]*/ mload(add(context, 0x3b80)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_126*(f_9(x) - f_9(g^2 * z)) / (x - g^2 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2 * z)^(-1)*/ mload(add(denominatorsPtr, 0x40)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[126]*/ mload(add(context, 0x3ba0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_127*(f_9(x) - f_9(g^5 * z)) / (x - g^5 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^5 * z)^(-1)*/ mload(add(denominatorsPtr, 0xa0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[127]*/ mload(add(context, 0x3bc0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Advance traceQueryResponses by amount read (0x20 * nTraceColumns).
                traceQueryResponses := add(traceQueryResponses, 0x140)

                // Composition constraints.

                {
                // Read the next element.
                let columnValue := mulmod(mload(compositionQueryResponses), kMontgomeryRInv, PRIME)
                // res += c_128*(h_0(x) - C_0(z^2)) / (x - z^2).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z^2)^(-1)*/ mload(add(denominatorsPtr, 0x9e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*composition_oods_values[0]*/ mload(add(context, 0x3be0)))),
                           PRIME)
                )
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)}

                {
                // Read the next element.
                let columnValue := mulmod(mload(add(compositionQueryResponses, 0x20)), kMontgomeryRInv, PRIME)
                // res += c_129*(h_1(x) - C_1(z^2)) / (x - z^2).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z^2)^(-1)*/ mload(add(denominatorsPtr, 0x9e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*composition_oods_values[1]*/ mload(add(context, 0x3c00)))),
                           PRIME)
                )
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)}

                // Advance compositionQueryResponses by amount read (0x20 * constraintDegree).
                compositionQueryResponses := add(compositionQueryResponses, 0x40)

                // Append the friValue, which is the sum of the out-of-domain-sampling boundary
                // constraints for the trace and composition polynomials, to the friQueue array.
                mstore(add(friQueue, 0x20), mod(res, PRIME))

                // Append the friInvPoint of the current query to the friQueue array.
                mstore(add(friQueue, 0x40), /*friInvPoint*/ mload(add(denominatorsPtr,0xa00)))

                // Advance denominatorsPtr by chunk size (0x20 * (2+N_ROWS_IN_MASK)).
                denominatorsPtr := add(denominatorsPtr, 0xa20)
            }
            return(/*friQueue*/ add(context, 0xdc0), 0x1200)
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
        //    expmodsAndPoints[0:22] (.expmods) expmods used during calculations of the points below.
        //    expmodsAndPoints[22:101] (.points) points used during the denominators calculation.
        uint256[101] memory expmodsAndPoints;
        assembly {
            function expmod(base, exponent, modulus) -> result {
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
              result := mload(p)
            }

            let traceGenerator := /*trace_generator*/ mload(add(context, 0x2b20))
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

            // expmodsAndPoints.expmods[2] = traceGenerator^5.
            mstore(add(expmodsAndPoints, 0x40),
                   mulmod(mload(add(expmodsAndPoints, 0x20)), // traceGenerator^3
                          mload(expmodsAndPoints), // traceGenerator^2
                          PRIME))

            // expmodsAndPoints.expmods[3] = traceGenerator^6.
            mstore(add(expmodsAndPoints, 0x60),
                   mulmod(mload(add(expmodsAndPoints, 0x40)), // traceGenerator^5
                          traceGenerator, // traceGenerator^1
                          PRIME))

            // expmodsAndPoints.expmods[4] = traceGenerator^7.
            mstore(add(expmodsAndPoints, 0x80),
                   mulmod(mload(add(expmodsAndPoints, 0x60)), // traceGenerator^6
                          traceGenerator, // traceGenerator^1
                          PRIME))

            // expmodsAndPoints.expmods[5] = traceGenerator^8.
            mstore(add(expmodsAndPoints, 0xa0),
                   mulmod(mload(add(expmodsAndPoints, 0x80)), // traceGenerator^7
                          traceGenerator, // traceGenerator^1
                          PRIME))

            // expmodsAndPoints.expmods[6] = traceGenerator^9.
            mstore(add(expmodsAndPoints, 0xc0),
                   mulmod(mload(add(expmodsAndPoints, 0xa0)), // traceGenerator^8
                          traceGenerator, // traceGenerator^1
                          PRIME))

            // expmodsAndPoints.expmods[7] = traceGenerator^11.
            mstore(add(expmodsAndPoints, 0xe0),
                   mulmod(mload(add(expmodsAndPoints, 0xc0)), // traceGenerator^9
                          mload(expmodsAndPoints), // traceGenerator^2
                          PRIME))

            // expmodsAndPoints.expmods[8] = traceGenerator^12.
            mstore(add(expmodsAndPoints, 0x100),
                   mulmod(mload(add(expmodsAndPoints, 0xe0)), // traceGenerator^11
                          traceGenerator, // traceGenerator^1
                          PRIME))

            // expmodsAndPoints.expmods[9] = traceGenerator^15.
            mstore(add(expmodsAndPoints, 0x120),
                   mulmod(mload(add(expmodsAndPoints, 0x100)), // traceGenerator^12
                          mload(add(expmodsAndPoints, 0x20)), // traceGenerator^3
                          PRIME))

            // expmodsAndPoints.expmods[10] = traceGenerator^16.
            mstore(add(expmodsAndPoints, 0x140),
                   mulmod(mload(add(expmodsAndPoints, 0x120)), // traceGenerator^15
                          traceGenerator, // traceGenerator^1
                          PRIME))

            // expmodsAndPoints.expmods[11] = traceGenerator^20.
            mstore(add(expmodsAndPoints, 0x160),
                   mulmod(mload(add(expmodsAndPoints, 0x120)), // traceGenerator^15
                          mload(add(expmodsAndPoints, 0x40)), // traceGenerator^5
                          PRIME))

            // expmodsAndPoints.expmods[12] = traceGenerator^23.
            mstore(add(expmodsAndPoints, 0x180),
                   mulmod(mload(add(expmodsAndPoints, 0x160)), // traceGenerator^20
                          mload(add(expmodsAndPoints, 0x20)), // traceGenerator^3
                          PRIME))

            // expmodsAndPoints.expmods[13] = traceGenerator^32.
            mstore(add(expmodsAndPoints, 0x1a0),
                   mulmod(mload(add(expmodsAndPoints, 0x180)), // traceGenerator^23
                          mload(add(expmodsAndPoints, 0xc0)), // traceGenerator^9
                          PRIME))

            // expmodsAndPoints.expmods[14] = traceGenerator^48.
            mstore(add(expmodsAndPoints, 0x1c0),
                   mulmod(mload(add(expmodsAndPoints, 0x1a0)), // traceGenerator^32
                          mload(add(expmodsAndPoints, 0x140)), // traceGenerator^16
                          PRIME))

            // expmodsAndPoints.expmods[15] = traceGenerator^63.
            mstore(add(expmodsAndPoints, 0x1e0),
                   mulmod(mload(add(expmodsAndPoints, 0x1c0)), // traceGenerator^48
                          mload(add(expmodsAndPoints, 0x120)), // traceGenerator^15
                          PRIME))

            // expmodsAndPoints.expmods[16] = traceGenerator^64.
            mstore(add(expmodsAndPoints, 0x200),
                   mulmod(mload(add(expmodsAndPoints, 0x1e0)), // traceGenerator^63
                          traceGenerator, // traceGenerator^1
                          PRIME))

            // expmodsAndPoints.expmods[17] = traceGenerator^120.
            mstore(add(expmodsAndPoints, 0x220),
                   mulmod(mload(add(expmodsAndPoints, 0x200)), // traceGenerator^64
                          mulmod(mload(add(expmodsAndPoints, 0x1c0)), // traceGenerator^48
                                 mload(add(expmodsAndPoints, 0xa0)), // traceGenerator^8
                                 PRIME),
                          PRIME))

            // expmodsAndPoints.expmods[18] = traceGenerator^351.
            mstore(add(expmodsAndPoints, 0x240),
                   mulmod(mload(add(expmodsAndPoints, 0x220)), // traceGenerator^120
                          mulmod(mload(add(expmodsAndPoints, 0x220)), // traceGenerator^120
                                 mulmod(mload(add(expmodsAndPoints, 0x1e0)), // traceGenerator^63
                                        mload(add(expmodsAndPoints, 0x1c0)), // traceGenerator^48
                                        PRIME),
                                 PRIME),
                          PRIME))

            // expmodsAndPoints.expmods[19] = traceGenerator^391.
            mstore(add(expmodsAndPoints, 0x260),
                   mulmod(mload(add(expmodsAndPoints, 0x240)), // traceGenerator^351
                          mulmod(mload(add(expmodsAndPoints, 0x1a0)), // traceGenerator^32
                                 mload(add(expmodsAndPoints, 0xa0)), // traceGenerator^8
                                 PRIME),
                          PRIME))

            // expmodsAndPoints.expmods[20] = traceGenerator^15825.
            mstore(add(expmodsAndPoints, 0x280),
                   expmod(traceGenerator, 15825, PRIME))

            // expmodsAndPoints.expmods[21] = traceGenerator^15865.
            mstore(add(expmodsAndPoints, 0x2a0),
                   mulmod(mload(add(expmodsAndPoints, 0x280)), // traceGenerator^15825
                          mulmod(mload(add(expmodsAndPoints, 0x1a0)), // traceGenerator^32
                                 mload(add(expmodsAndPoints, 0xa0)), // traceGenerator^8
                                 PRIME),
                          PRIME))

            let oodsPoint := /*oods_point*/ mload(add(context, 0x2b40))
            {
              // point = -z.
              let point := sub(PRIME, oodsPoint)
              // Compute denominators for rows with nonconst mask expression.
              // We compute those first because for the const rows we modify the point variable.

              // Compute denominators for rows with const mask expression.

              // expmods_and_points.points[0] = -z.
              mstore(add(expmodsAndPoints, 0x2c0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[1] = -(g * z).
              mstore(add(expmodsAndPoints, 0x2e0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[2] = -(g^2 * z).
              mstore(add(expmodsAndPoints, 0x300), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[3] = -(g^3 * z).
              mstore(add(expmodsAndPoints, 0x320), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[4] = -(g^4 * z).
              mstore(add(expmodsAndPoints, 0x340), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[5] = -(g^5 * z).
              mstore(add(expmodsAndPoints, 0x360), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[6] = -(g^6 * z).
              mstore(add(expmodsAndPoints, 0x380), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[7] = -(g^7 * z).
              mstore(add(expmodsAndPoints, 0x3a0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[8] = -(g^8 * z).
              mstore(add(expmodsAndPoints, 0x3c0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[9] = -(g^9 * z).
              mstore(add(expmodsAndPoints, 0x3e0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[10] = -(g^10 * z).
              mstore(add(expmodsAndPoints, 0x400), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[11] = -(g^11 * z).
              mstore(add(expmodsAndPoints, 0x420), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[12] = -(g^12 * z).
              mstore(add(expmodsAndPoints, 0x440), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[13] = -(g^13 * z).
              mstore(add(expmodsAndPoints, 0x460), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[14] = -(g^14 * z).
              mstore(add(expmodsAndPoints, 0x480), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[15] = -(g^15 * z).
              mstore(add(expmodsAndPoints, 0x4a0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[16] = -(g^16 * z).
              mstore(add(expmodsAndPoints, 0x4c0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[17] = -(g^17 * z).
              mstore(add(expmodsAndPoints, 0x4e0), point)

              // point *= g^6.
              point := mulmod(point, /*traceGenerator^6*/ mload(add(expmodsAndPoints, 0x60)), PRIME)
              // expmods_and_points.points[18] = -(g^23 * z).
              mstore(add(expmodsAndPoints, 0x500), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[19] = -(g^25 * z).
              mstore(add(expmodsAndPoints, 0x520), point)

              // point *= g^6.
              point := mulmod(point, /*traceGenerator^6*/ mload(add(expmodsAndPoints, 0x60)), PRIME)
              // expmods_and_points.points[20] = -(g^31 * z).
              mstore(add(expmodsAndPoints, 0x540), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[21] = -(g^32 * z).
              mstore(add(expmodsAndPoints, 0x560), point)

              // point *= g^7.
              point := mulmod(point, /*traceGenerator^7*/ mload(add(expmodsAndPoints, 0x80)), PRIME)
              // expmods_and_points.points[22] = -(g^39 * z).
              mstore(add(expmodsAndPoints, 0x580), point)

              // point *= g^5.
              point := mulmod(point, /*traceGenerator^5*/ mload(add(expmodsAndPoints, 0x40)), PRIME)
              // expmods_and_points.points[23] = -(g^44 * z).
              mstore(add(expmodsAndPoints, 0x5a0), point)

              // point *= g^3.
              point := mulmod(point, /*traceGenerator^3*/ mload(add(expmodsAndPoints, 0x20)), PRIME)
              // expmods_and_points.points[24] = -(g^47 * z).
              mstore(add(expmodsAndPoints, 0x5c0), point)

              // point *= g^8.
              point := mulmod(point, /*traceGenerator^8*/ mload(add(expmodsAndPoints, 0xa0)), PRIME)
              // expmods_and_points.points[25] = -(g^55 * z).
              mstore(add(expmodsAndPoints, 0x5e0), point)

              // point *= g^8.
              point := mulmod(point, /*traceGenerator^8*/ mload(add(expmodsAndPoints, 0xa0)), PRIME)
              // expmods_and_points.points[26] = -(g^63 * z).
              mstore(add(expmodsAndPoints, 0x600), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[27] = -(g^64 * z).
              mstore(add(expmodsAndPoints, 0x620), point)

              // point *= g^6.
              point := mulmod(point, /*traceGenerator^6*/ mload(add(expmodsAndPoints, 0x60)), PRIME)
              // expmods_and_points.points[28] = -(g^70 * z).
              mstore(add(expmodsAndPoints, 0x640), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[29] = -(g^71 * z).
              mstore(add(expmodsAndPoints, 0x660), point)

              // point *= g^5.
              point := mulmod(point, /*traceGenerator^5*/ mload(add(expmodsAndPoints, 0x40)), PRIME)
              // expmods_and_points.points[30] = -(g^76 * z).
              mstore(add(expmodsAndPoints, 0x680), point)

              // point *= g^3.
              point := mulmod(point, /*traceGenerator^3*/ mload(add(expmodsAndPoints, 0x20)), PRIME)
              // expmods_and_points.points[31] = -(g^79 * z).
              mstore(add(expmodsAndPoints, 0x6a0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[32] = -(g^80 * z).
              mstore(add(expmodsAndPoints, 0x6c0), point)

              // point *= g^7.
              point := mulmod(point, /*traceGenerator^7*/ mload(add(expmodsAndPoints, 0x80)), PRIME)
              // expmods_and_points.points[33] = -(g^87 * z).
              mstore(add(expmodsAndPoints, 0x6e0), point)

              // point *= g^9.
              point := mulmod(point, /*traceGenerator^9*/ mload(add(expmodsAndPoints, 0xc0)), PRIME)
              // expmods_and_points.points[34] = -(g^96 * z).
              mstore(add(expmodsAndPoints, 0x700), point)

              // point *= g^7.
              point := mulmod(point, /*traceGenerator^7*/ mload(add(expmodsAndPoints, 0x80)), PRIME)
              // expmods_and_points.points[35] = -(g^103 * z).
              mstore(add(expmodsAndPoints, 0x720), point)

              // point *= g^5.
              point := mulmod(point, /*traceGenerator^5*/ mload(add(expmodsAndPoints, 0x40)), PRIME)
              // expmods_and_points.points[36] = -(g^108 * z).
              mstore(add(expmodsAndPoints, 0x740), point)

              // point *= g^11.
              point := mulmod(point, /*traceGenerator^11*/ mload(add(expmodsAndPoints, 0xe0)), PRIME)
              // expmods_and_points.points[37] = -(g^119 * z).
              mstore(add(expmodsAndPoints, 0x760), point)

              // point *= g^9.
              point := mulmod(point, /*traceGenerator^9*/ mload(add(expmodsAndPoints, 0xc0)), PRIME)
              // expmods_and_points.points[38] = -(g^128 * z).
              mstore(add(expmodsAndPoints, 0x780), point)

              // point *= g^6.
              point := mulmod(point, /*traceGenerator^6*/ mload(add(expmodsAndPoints, 0x60)), PRIME)
              // expmods_and_points.points[39] = -(g^134 * z).
              mstore(add(expmodsAndPoints, 0x7a0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[40] = -(g^135 * z).
              mstore(add(expmodsAndPoints, 0x7c0), point)

              // point *= g^5.
              point := mulmod(point, /*traceGenerator^5*/ mload(add(expmodsAndPoints, 0x40)), PRIME)
              // expmods_and_points.points[41] = -(g^140 * z).
              mstore(add(expmodsAndPoints, 0x7e0), point)

              // point *= g^20.
              point := mulmod(point, /*traceGenerator^20*/ mload(add(expmodsAndPoints, 0x160)), PRIME)
              // expmods_and_points.points[42] = -(g^160 * z).
              mstore(add(expmodsAndPoints, 0x800), point)

              // point *= g^12.
              point := mulmod(point, /*traceGenerator^12*/ mload(add(expmodsAndPoints, 0x100)), PRIME)
              // expmods_and_points.points[43] = -(g^172 * z).
              mstore(add(expmodsAndPoints, 0x820), point)

              // point *= g^20.
              point := mulmod(point, /*traceGenerator^20*/ mload(add(expmodsAndPoints, 0x160)), PRIME)
              // expmods_and_points.points[44] = -(g^192 * z).
              mstore(add(expmodsAndPoints, 0x840), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[45] = -(g^193 * z).
              mstore(add(expmodsAndPoints, 0x860), point)

              // point *= g^3.
              point := mulmod(point, /*traceGenerator^3*/ mload(add(expmodsAndPoints, 0x20)), PRIME)
              // expmods_and_points.points[46] = -(g^196 * z).
              mstore(add(expmodsAndPoints, 0x880), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[47] = -(g^197 * z).
              mstore(add(expmodsAndPoints, 0x8a0), point)

              // point *= g^7.
              point := mulmod(point, /*traceGenerator^7*/ mload(add(expmodsAndPoints, 0x80)), PRIME)
              // expmods_and_points.points[48] = -(g^204 * z).
              mstore(add(expmodsAndPoints, 0x8c0), point)

              // point *= g^32.
              point := mulmod(point, /*traceGenerator^32*/ mload(add(expmodsAndPoints, 0x1a0)), PRIME)
              // expmods_and_points.points[49] = -(g^236 * z).
              mstore(add(expmodsAndPoints, 0x8e0), point)

              // point *= g^15.
              point := mulmod(point, /*traceGenerator^15*/ mload(add(expmodsAndPoints, 0x120)), PRIME)
              // expmods_and_points.points[50] = -(g^251 * z).
              mstore(add(expmodsAndPoints, 0x900), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[51] = -(g^252 * z).
              mstore(add(expmodsAndPoints, 0x920), point)

              // point *= g^3.
              point := mulmod(point, /*traceGenerator^3*/ mload(add(expmodsAndPoints, 0x20)), PRIME)
              // expmods_and_points.points[52] = -(g^255 * z).
              mstore(add(expmodsAndPoints, 0x940), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[53] = -(g^256 * z).
              mstore(add(expmodsAndPoints, 0x960), point)

              // point *= g^6.
              point := mulmod(point, /*traceGenerator^6*/ mload(add(expmodsAndPoints, 0x60)), PRIME)
              // expmods_and_points.points[54] = -(g^262 * z).
              mstore(add(expmodsAndPoints, 0x980), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[55] = -(g^263 * z).
              mstore(add(expmodsAndPoints, 0x9a0), point)

              // point *= g^63.
              point := mulmod(point, /*traceGenerator^63*/ mload(add(expmodsAndPoints, 0x1e0)), PRIME)
              // expmods_and_points.points[56] = -(g^326 * z).
              mstore(add(expmodsAndPoints, 0x9c0), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x200)), PRIME)
              // expmods_and_points.points[57] = -(g^390 * z).
              mstore(add(expmodsAndPoints, 0x9e0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[58] = -(g^391 * z).
              mstore(add(expmodsAndPoints, 0xa00), point)

              // point *= g^120.
              point := mulmod(point, /*traceGenerator^120*/ mload(add(expmodsAndPoints, 0x220)), PRIME)
              // expmods_and_points.points[59] = -(g^511 * z).
              mstore(add(expmodsAndPoints, 0xa20), point)

              // point *= g^7.
              point := mulmod(point, /*traceGenerator^7*/ mload(add(expmodsAndPoints, 0x80)), PRIME)
              // expmods_and_points.points[60] = -(g^518 * z).
              mstore(add(expmodsAndPoints, 0xa40), point)

              // point *= g^15825.
              point := mulmod(point, /*traceGenerator^15825*/ mload(add(expmodsAndPoints, 0x280)), PRIME)
              // expmods_and_points.points[61] = -(g^16343 * z).
              mstore(add(expmodsAndPoints, 0xa60), point)

              // point *= g^8.
              point := mulmod(point, /*traceGenerator^8*/ mload(add(expmodsAndPoints, 0xa0)), PRIME)
              // expmods_and_points.points[62] = -(g^16351 * z).
              mstore(add(expmodsAndPoints, 0xa80), point)

              // point *= g^16.
              point := mulmod(point, /*traceGenerator^16*/ mload(add(expmodsAndPoints, 0x140)), PRIME)
              // expmods_and_points.points[63] = -(g^16367 * z).
              mstore(add(expmodsAndPoints, 0xaa0), point)

              // point *= g^8.
              point := mulmod(point, /*traceGenerator^8*/ mload(add(expmodsAndPoints, 0xa0)), PRIME)
              // expmods_and_points.points[64] = -(g^16375 * z).
              mstore(add(expmodsAndPoints, 0xac0), point)

              // point *= g^8.
              point := mulmod(point, /*traceGenerator^8*/ mload(add(expmodsAndPoints, 0xa0)), PRIME)
              // expmods_and_points.points[65] = -(g^16383 * z).
              mstore(add(expmodsAndPoints, 0xae0), point)

              // point *= g^8.
              point := mulmod(point, /*traceGenerator^8*/ mload(add(expmodsAndPoints, 0xa0)), PRIME)
              // expmods_and_points.points[66] = -(g^16391 * z).
              mstore(add(expmodsAndPoints, 0xb00), point)

              // point *= g^32.
              point := mulmod(point, /*traceGenerator^32*/ mload(add(expmodsAndPoints, 0x1a0)), PRIME)
              // expmods_and_points.points[67] = -(g^16423 * z).
              mstore(add(expmodsAndPoints, 0xb20), point)

              // point *= g^351.
              point := mulmod(point, /*traceGenerator^351*/ mload(add(expmodsAndPoints, 0x240)), PRIME)
              // expmods_and_points.points[68] = -(g^16774 * z).
              mstore(add(expmodsAndPoints, 0xb40), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[69] = -(g^16775 * z).
              mstore(add(expmodsAndPoints, 0xb60), point)

              // point *= g^15865.
              point := mulmod(point, /*traceGenerator^15865*/ mload(add(expmodsAndPoints, 0x2a0)), PRIME)
              // expmods_and_points.points[70] = -(g^32640 * z).
              mstore(add(expmodsAndPoints, 0xb80), point)

              // point *= g^16.
              point := mulmod(point, /*traceGenerator^16*/ mload(add(expmodsAndPoints, 0x140)), PRIME)
              // expmods_and_points.points[71] = -(g^32656 * z).
              mstore(add(expmodsAndPoints, 0xba0), point)

              // point *= g^48.
              point := mulmod(point, /*traceGenerator^48*/ mload(add(expmodsAndPoints, 0x1c0)), PRIME)
              // expmods_and_points.points[72] = -(g^32704 * z).
              mstore(add(expmodsAndPoints, 0xbc0), point)

              // point *= g^23.
              point := mulmod(point, /*traceGenerator^23*/ mload(add(expmodsAndPoints, 0x180)), PRIME)
              // expmods_and_points.points[73] = -(g^32727 * z).
              mstore(add(expmodsAndPoints, 0xbe0), point)

              // point *= g^8.
              point := mulmod(point, /*traceGenerator^8*/ mload(add(expmodsAndPoints, 0xa0)), PRIME)
              // expmods_and_points.points[74] = -(g^32735 * z).
              mstore(add(expmodsAndPoints, 0xc00), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[75] = -(g^32736 * z).
              mstore(add(expmodsAndPoints, 0xc20), point)

              // point *= g^23.
              point := mulmod(point, /*traceGenerator^23*/ mload(add(expmodsAndPoints, 0x180)), PRIME)
              // expmods_and_points.points[76] = -(g^32759 * z).
              mstore(add(expmodsAndPoints, 0xc40), point)

              // point *= g^8.
              point := mulmod(point, /*traceGenerator^8*/ mload(add(expmodsAndPoints, 0xa0)), PRIME)
              // expmods_and_points.points[77] = -(g^32767 * z).
              mstore(add(expmodsAndPoints, 0xc60), point)

              // point *= g^391.
              point := mulmod(point, /*traceGenerator^391*/ mload(add(expmodsAndPoints, 0x260)), PRIME)
              // expmods_and_points.points[78] = -(g^33158 * z).
              mstore(add(expmodsAndPoints, 0xc80), point)
            }

            let evalPointsPtr := /*oodsEvalPoints*/ add(context, 0x3c20)
            let evalPointsEndPtr := add(
                evalPointsPtr,
                mul(/*n_unique_queries*/ mload(add(context, 0x140)), 0x20))

            // The batchInverseArray is split into two halves.
            // The first half is used for cumulative products and the second half for values to invert.
            // Consequently the products and values are half the array size apart.
            let productsPtr := add(batchInverseArray, 0x20)
            // Compute an offset in bytes to the middle of the array.
            let productsToValuesOffset := mul(
                /*batchInverseArray.length*/ mload(batchInverseArray),
                /*0x20 / 2*/ 0x10)
            let valuesPtr := add(productsPtr, productsToValuesOffset)
            let partialProduct := 1
            let minusPointPow := sub(PRIME, mulmod(oodsPoint, oodsPoint, PRIME))
            for {} lt(evalPointsPtr, evalPointsEndPtr)
                     {evalPointsPtr := add(evalPointsPtr, 0x20)} {
                let evalPoint := mload(evalPointsPtr)

                // Shift evalPoint to evaluation domain coset.
                let shiftedEvalPoint := mulmod(evalPoint, evalCosetOffset_, PRIME)

                {
                // Calculate denominator for row 0: x - z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x2c0)))
                mstore(productsPtr, partialProduct)
                mstore(valuesPtr, denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1: x - g * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x2e0)))
                mstore(add(productsPtr, 0x20), partialProduct)
                mstore(add(valuesPtr, 0x20), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 2: x - g^2 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x300)))
                mstore(add(productsPtr, 0x40), partialProduct)
                mstore(add(valuesPtr, 0x40), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 3: x - g^3 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x320)))
                mstore(add(productsPtr, 0x60), partialProduct)
                mstore(add(valuesPtr, 0x60), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 4: x - g^4 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x340)))
                mstore(add(productsPtr, 0x80), partialProduct)
                mstore(add(valuesPtr, 0x80), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 5: x - g^5 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x360)))
                mstore(add(productsPtr, 0xa0), partialProduct)
                mstore(add(valuesPtr, 0xa0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 6: x - g^6 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x380)))
                mstore(add(productsPtr, 0xc0), partialProduct)
                mstore(add(valuesPtr, 0xc0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 7: x - g^7 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x3a0)))
                mstore(add(productsPtr, 0xe0), partialProduct)
                mstore(add(valuesPtr, 0xe0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 8: x - g^8 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x3c0)))
                mstore(add(productsPtr, 0x100), partialProduct)
                mstore(add(valuesPtr, 0x100), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 9: x - g^9 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x3e0)))
                mstore(add(productsPtr, 0x120), partialProduct)
                mstore(add(valuesPtr, 0x120), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 10: x - g^10 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x400)))
                mstore(add(productsPtr, 0x140), partialProduct)
                mstore(add(valuesPtr, 0x140), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 11: x - g^11 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x420)))
                mstore(add(productsPtr, 0x160), partialProduct)
                mstore(add(valuesPtr, 0x160), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 12: x - g^12 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x440)))
                mstore(add(productsPtr, 0x180), partialProduct)
                mstore(add(valuesPtr, 0x180), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 13: x - g^13 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x460)))
                mstore(add(productsPtr, 0x1a0), partialProduct)
                mstore(add(valuesPtr, 0x1a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 14: x - g^14 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x480)))
                mstore(add(productsPtr, 0x1c0), partialProduct)
                mstore(add(valuesPtr, 0x1c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 15: x - g^15 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x4a0)))
                mstore(add(productsPtr, 0x1e0), partialProduct)
                mstore(add(valuesPtr, 0x1e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16: x - g^16 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x4c0)))
                mstore(add(productsPtr, 0x200), partialProduct)
                mstore(add(valuesPtr, 0x200), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 17: x - g^17 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x4e0)))
                mstore(add(productsPtr, 0x220), partialProduct)
                mstore(add(valuesPtr, 0x220), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 23: x - g^23 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x500)))
                mstore(add(productsPtr, 0x240), partialProduct)
                mstore(add(valuesPtr, 0x240), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 25: x - g^25 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x520)))
                mstore(add(productsPtr, 0x260), partialProduct)
                mstore(add(valuesPtr, 0x260), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 31: x - g^31 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x540)))
                mstore(add(productsPtr, 0x280), partialProduct)
                mstore(add(valuesPtr, 0x280), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 32: x - g^32 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x560)))
                mstore(add(productsPtr, 0x2a0), partialProduct)
                mstore(add(valuesPtr, 0x2a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 39: x - g^39 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x580)))
                mstore(add(productsPtr, 0x2c0), partialProduct)
                mstore(add(valuesPtr, 0x2c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 44: x - g^44 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x5a0)))
                mstore(add(productsPtr, 0x2e0), partialProduct)
                mstore(add(valuesPtr, 0x2e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 47: x - g^47 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x5c0)))
                mstore(add(productsPtr, 0x300), partialProduct)
                mstore(add(valuesPtr, 0x300), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 55: x - g^55 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x5e0)))
                mstore(add(productsPtr, 0x320), partialProduct)
                mstore(add(valuesPtr, 0x320), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 63: x - g^63 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x600)))
                mstore(add(productsPtr, 0x340), partialProduct)
                mstore(add(valuesPtr, 0x340), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 64: x - g^64 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x620)))
                mstore(add(productsPtr, 0x360), partialProduct)
                mstore(add(valuesPtr, 0x360), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 70: x - g^70 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x640)))
                mstore(add(productsPtr, 0x380), partialProduct)
                mstore(add(valuesPtr, 0x380), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 71: x - g^71 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x660)))
                mstore(add(productsPtr, 0x3a0), partialProduct)
                mstore(add(valuesPtr, 0x3a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 76: x - g^76 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x680)))
                mstore(add(productsPtr, 0x3c0), partialProduct)
                mstore(add(valuesPtr, 0x3c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 79: x - g^79 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x6a0)))
                mstore(add(productsPtr, 0x3e0), partialProduct)
                mstore(add(valuesPtr, 0x3e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 80: x - g^80 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x6c0)))
                mstore(add(productsPtr, 0x400), partialProduct)
                mstore(add(valuesPtr, 0x400), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 87: x - g^87 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x6e0)))
                mstore(add(productsPtr, 0x420), partialProduct)
                mstore(add(valuesPtr, 0x420), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 96: x - g^96 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x700)))
                mstore(add(productsPtr, 0x440), partialProduct)
                mstore(add(valuesPtr, 0x440), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 103: x - g^103 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x720)))
                mstore(add(productsPtr, 0x460), partialProduct)
                mstore(add(valuesPtr, 0x460), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 108: x - g^108 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x740)))
                mstore(add(productsPtr, 0x480), partialProduct)
                mstore(add(valuesPtr, 0x480), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 119: x - g^119 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x760)))
                mstore(add(productsPtr, 0x4a0), partialProduct)
                mstore(add(valuesPtr, 0x4a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 128: x - g^128 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x780)))
                mstore(add(productsPtr, 0x4c0), partialProduct)
                mstore(add(valuesPtr, 0x4c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 134: x - g^134 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x7a0)))
                mstore(add(productsPtr, 0x4e0), partialProduct)
                mstore(add(valuesPtr, 0x4e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 135: x - g^135 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x7c0)))
                mstore(add(productsPtr, 0x500), partialProduct)
                mstore(add(valuesPtr, 0x500), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 140: x - g^140 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x7e0)))
                mstore(add(productsPtr, 0x520), partialProduct)
                mstore(add(valuesPtr, 0x520), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 160: x - g^160 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x800)))
                mstore(add(productsPtr, 0x540), partialProduct)
                mstore(add(valuesPtr, 0x540), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 172: x - g^172 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x820)))
                mstore(add(productsPtr, 0x560), partialProduct)
                mstore(add(valuesPtr, 0x560), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 192: x - g^192 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x840)))
                mstore(add(productsPtr, 0x580), partialProduct)
                mstore(add(valuesPtr, 0x580), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 193: x - g^193 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x860)))
                mstore(add(productsPtr, 0x5a0), partialProduct)
                mstore(add(valuesPtr, 0x5a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 196: x - g^196 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x880)))
                mstore(add(productsPtr, 0x5c0), partialProduct)
                mstore(add(valuesPtr, 0x5c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 197: x - g^197 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x8a0)))
                mstore(add(productsPtr, 0x5e0), partialProduct)
                mstore(add(valuesPtr, 0x5e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 204: x - g^204 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x8c0)))
                mstore(add(productsPtr, 0x600), partialProduct)
                mstore(add(valuesPtr, 0x600), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 236: x - g^236 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x8e0)))
                mstore(add(productsPtr, 0x620), partialProduct)
                mstore(add(valuesPtr, 0x620), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 251: x - g^251 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x900)))
                mstore(add(productsPtr, 0x640), partialProduct)
                mstore(add(valuesPtr, 0x640), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 252: x - g^252 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x920)))
                mstore(add(productsPtr, 0x660), partialProduct)
                mstore(add(valuesPtr, 0x660), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 255: x - g^255 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x940)))
                mstore(add(productsPtr, 0x680), partialProduct)
                mstore(add(valuesPtr, 0x680), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 256: x - g^256 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x960)))
                mstore(add(productsPtr, 0x6a0), partialProduct)
                mstore(add(valuesPtr, 0x6a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 262: x - g^262 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x980)))
                mstore(add(productsPtr, 0x6c0), partialProduct)
                mstore(add(valuesPtr, 0x6c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 263: x - g^263 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x9a0)))
                mstore(add(productsPtr, 0x6e0), partialProduct)
                mstore(add(valuesPtr, 0x6e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 326: x - g^326 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x9c0)))
                mstore(add(productsPtr, 0x700), partialProduct)
                mstore(add(valuesPtr, 0x700), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 390: x - g^390 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x9e0)))
                mstore(add(productsPtr, 0x720), partialProduct)
                mstore(add(valuesPtr, 0x720), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 391: x - g^391 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xa00)))
                mstore(add(productsPtr, 0x740), partialProduct)
                mstore(add(valuesPtr, 0x740), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 511: x - g^511 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xa20)))
                mstore(add(productsPtr, 0x760), partialProduct)
                mstore(add(valuesPtr, 0x760), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 518: x - g^518 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xa40)))
                mstore(add(productsPtr, 0x780), partialProduct)
                mstore(add(valuesPtr, 0x780), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16343: x - g^16343 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xa60)))
                mstore(add(productsPtr, 0x7a0), partialProduct)
                mstore(add(valuesPtr, 0x7a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16351: x - g^16351 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xa80)))
                mstore(add(productsPtr, 0x7c0), partialProduct)
                mstore(add(valuesPtr, 0x7c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16367: x - g^16367 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xaa0)))
                mstore(add(productsPtr, 0x7e0), partialProduct)
                mstore(add(valuesPtr, 0x7e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16375: x - g^16375 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xac0)))
                mstore(add(productsPtr, 0x800), partialProduct)
                mstore(add(valuesPtr, 0x800), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16383: x - g^16383 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xae0)))
                mstore(add(productsPtr, 0x820), partialProduct)
                mstore(add(valuesPtr, 0x820), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16391: x - g^16391 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xb00)))
                mstore(add(productsPtr, 0x840), partialProduct)
                mstore(add(valuesPtr, 0x840), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16423: x - g^16423 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xb20)))
                mstore(add(productsPtr, 0x860), partialProduct)
                mstore(add(valuesPtr, 0x860), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16774: x - g^16774 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xb40)))
                mstore(add(productsPtr, 0x880), partialProduct)
                mstore(add(valuesPtr, 0x880), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16775: x - g^16775 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xb60)))
                mstore(add(productsPtr, 0x8a0), partialProduct)
                mstore(add(valuesPtr, 0x8a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 32640: x - g^32640 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xb80)))
                mstore(add(productsPtr, 0x8c0), partialProduct)
                mstore(add(valuesPtr, 0x8c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 32656: x - g^32656 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xba0)))
                mstore(add(productsPtr, 0x8e0), partialProduct)
                mstore(add(valuesPtr, 0x8e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 32704: x - g^32704 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xbc0)))
                mstore(add(productsPtr, 0x900), partialProduct)
                mstore(add(valuesPtr, 0x900), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 32727: x - g^32727 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xbe0)))
                mstore(add(productsPtr, 0x920), partialProduct)
                mstore(add(valuesPtr, 0x920), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 32735: x - g^32735 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xc00)))
                mstore(add(productsPtr, 0x940), partialProduct)
                mstore(add(valuesPtr, 0x940), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 32736: x - g^32736 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xc20)))
                mstore(add(productsPtr, 0x960), partialProduct)
                mstore(add(valuesPtr, 0x960), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 32759: x - g^32759 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xc40)))
                mstore(add(productsPtr, 0x980), partialProduct)
                mstore(add(valuesPtr, 0x980), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 32767: x - g^32767 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xc60)))
                mstore(add(productsPtr, 0x9a0), partialProduct)
                mstore(add(valuesPtr, 0x9a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 33158: x - g^33158 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xc80)))
                mstore(add(productsPtr, 0x9c0), partialProduct)
                mstore(add(valuesPtr, 0x9c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate the denominator for the composition polynomial columns: x - z^2.
                let denominator := add(shiftedEvalPoint, minusPointPow)
                mstore(add(productsPtr, 0x9e0), partialProduct)
                mstore(add(valuesPtr, 0x9e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                // Add evalPoint to batch inverse inputs.
                // inverse(evalPoint) is going to be used by FRI.
                mstore(add(productsPtr, 0xa00), partialProduct)
                mstore(add(valuesPtr, 0xa00), evalPoint)
                partialProduct := mulmod(partialProduct, evalPoint, PRIME)

                // Advance pointers.
                productsPtr := add(productsPtr, 0xa20)
                valuesPtr := add(valuesPtr, 0xa20)
            }

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
