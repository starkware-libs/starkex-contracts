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
            let traceQueryResponses := /*traceQueryQesponses*/ add(context, 0x4b60)

            let compositionQueryResponses := /*composition_query_responses*/ add(context, 0xe160)

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
                let oods_alpha := /*oods_alpha*/ mload(add(context, 0x4b40))

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

                // res += c_2*(f_0(x) - f_0(g^4 * z)) / (x - g^4 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4 * z)^(-1)*/ mload(add(denominatorsPtr, 0x80)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[2]*/ mload(add(context, 0x2c20)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_3*(f_0(x) - f_0(g^8 * z)) / (x - g^8 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8 * z)^(-1)*/ mload(add(denominatorsPtr, 0x100)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[3]*/ mload(add(context, 0x2c40)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_4*(f_0(x) - f_0(g^12 * z)) / (x - g^12 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^12 * z)^(-1)*/ mload(add(denominatorsPtr, 0x180)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[4]*/ mload(add(context, 0x2c60)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_5*(f_0(x) - f_0(g^28 * z)) / (x - g^28 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^28 * z)^(-1)*/ mload(add(denominatorsPtr, 0x2e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[5]*/ mload(add(context, 0x2c80)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_6*(f_0(x) - f_0(g^44 * z)) / (x - g^44 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^44 * z)^(-1)*/ mload(add(denominatorsPtr, 0x380)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[6]*/ mload(add(context, 0x2ca0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_7*(f_0(x) - f_0(g^60 * z)) / (x - g^60 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^60 * z)^(-1)*/ mload(add(denominatorsPtr, 0x3e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[7]*/ mload(add(context, 0x2cc0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_8*(f_0(x) - f_0(g^76 * z)) / (x - g^76 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^76 * z)^(-1)*/ mload(add(denominatorsPtr, 0x440)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[8]*/ mload(add(context, 0x2ce0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_9*(f_0(x) - f_0(g^92 * z)) / (x - g^92 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^92 * z)^(-1)*/ mload(add(denominatorsPtr, 0x480)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[9]*/ mload(add(context, 0x2d00)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_10*(f_0(x) - f_0(g^108 * z)) / (x - g^108 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^108 * z)^(-1)*/ mload(add(denominatorsPtr, 0x4e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[10]*/ mload(add(context, 0x2d20)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_11*(f_0(x) - f_0(g^124 * z)) / (x - g^124 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^124 * z)^(-1)*/ mload(add(denominatorsPtr, 0x500)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[11]*/ mload(add(context, 0x2d40)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Mask items for column #1.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x20)), kMontgomeryRInv, PRIME)

                // res += c_12*(f_1(x) - f_1(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[12]*/ mload(add(context, 0x2d60)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_13*(f_1(x) - f_1(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[13]*/ mload(add(context, 0x2d80)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_14*(f_1(x) - f_1(g^2 * z)) / (x - g^2 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2 * z)^(-1)*/ mload(add(denominatorsPtr, 0x40)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[14]*/ mload(add(context, 0x2da0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_15*(f_1(x) - f_1(g^3 * z)) / (x - g^3 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3 * z)^(-1)*/ mload(add(denominatorsPtr, 0x60)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[15]*/ mload(add(context, 0x2dc0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_16*(f_1(x) - f_1(g^4 * z)) / (x - g^4 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4 * z)^(-1)*/ mload(add(denominatorsPtr, 0x80)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[16]*/ mload(add(context, 0x2de0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_17*(f_1(x) - f_1(g^5 * z)) / (x - g^5 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^5 * z)^(-1)*/ mload(add(denominatorsPtr, 0xa0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[17]*/ mload(add(context, 0x2e00)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_18*(f_1(x) - f_1(g^6 * z)) / (x - g^6 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^6 * z)^(-1)*/ mload(add(denominatorsPtr, 0xc0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[18]*/ mload(add(context, 0x2e20)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_19*(f_1(x) - f_1(g^7 * z)) / (x - g^7 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^7 * z)^(-1)*/ mload(add(denominatorsPtr, 0xe0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[19]*/ mload(add(context, 0x2e40)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_20*(f_1(x) - f_1(g^8 * z)) / (x - g^8 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8 * z)^(-1)*/ mload(add(denominatorsPtr, 0x100)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[20]*/ mload(add(context, 0x2e60)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_21*(f_1(x) - f_1(g^9 * z)) / (x - g^9 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^9 * z)^(-1)*/ mload(add(denominatorsPtr, 0x120)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[21]*/ mload(add(context, 0x2e80)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_22*(f_1(x) - f_1(g^10 * z)) / (x - g^10 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^10 * z)^(-1)*/ mload(add(denominatorsPtr, 0x140)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[22]*/ mload(add(context, 0x2ea0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_23*(f_1(x) - f_1(g^11 * z)) / (x - g^11 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^11 * z)^(-1)*/ mload(add(denominatorsPtr, 0x160)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[23]*/ mload(add(context, 0x2ec0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_24*(f_1(x) - f_1(g^12 * z)) / (x - g^12 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^12 * z)^(-1)*/ mload(add(denominatorsPtr, 0x180)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[24]*/ mload(add(context, 0x2ee0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_25*(f_1(x) - f_1(g^13 * z)) / (x - g^13 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^13 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[25]*/ mload(add(context, 0x2f00)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_26*(f_1(x) - f_1(g^14 * z)) / (x - g^14 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^14 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[26]*/ mload(add(context, 0x2f20)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_27*(f_1(x) - f_1(g^15 * z)) / (x - g^15 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^15 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[27]*/ mload(add(context, 0x2f40)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Mask items for column #2.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x40)), kMontgomeryRInv, PRIME)

                // res += c_28*(f_2(x) - f_2(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[28]*/ mload(add(context, 0x2f60)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_29*(f_2(x) - f_2(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[29]*/ mload(add(context, 0x2f80)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Mask items for column #3.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x60)), kMontgomeryRInv, PRIME)

                // res += c_30*(f_3(x) - f_3(z)) / (x - z).
                res := addmod(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[30]*/ mload(add(context, 0x2fa0)))),
                           PRIME),
                    PRIME)
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_31*(f_3(x) - f_3(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[31]*/ mload(add(context, 0x2fc0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_32*(f_3(x) - f_3(g^255 * z)) / (x - g^255 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^255 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[32]*/ mload(add(context, 0x2fe0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_33*(f_3(x) - f_3(g^256 * z)) / (x - g^256 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^256 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[33]*/ mload(add(context, 0x3000)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_34*(f_3(x) - f_3(g^511 * z)) / (x - g^511 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^511 * z)^(-1)*/ mload(add(denominatorsPtr, 0x7c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[34]*/ mload(add(context, 0x3020)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Mask items for column #4.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x80)), kMontgomeryRInv, PRIME)

                // res += c_35*(f_4(x) - f_4(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[35]*/ mload(add(context, 0x3040)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_36*(f_4(x) - f_4(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[36]*/ mload(add(context, 0x3060)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_37*(f_4(x) - f_4(g^255 * z)) / (x - g^255 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^255 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[37]*/ mload(add(context, 0x3080)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_38*(f_4(x) - f_4(g^256 * z)) / (x - g^256 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^256 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[38]*/ mload(add(context, 0x30a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Mask items for column #5.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0xa0)), kMontgomeryRInv, PRIME)

                // res += c_39*(f_5(x) - f_5(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[39]*/ mload(add(context, 0x30c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_40*(f_5(x) - f_5(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[40]*/ mload(add(context, 0x30e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_41*(f_5(x) - f_5(g^192 * z)) / (x - g^192 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^192 * z)^(-1)*/ mload(add(denominatorsPtr, 0x5a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[41]*/ mload(add(context, 0x3100)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_42*(f_5(x) - f_5(g^193 * z)) / (x - g^193 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^193 * z)^(-1)*/ mload(add(denominatorsPtr, 0x5c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[42]*/ mload(add(context, 0x3120)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_43*(f_5(x) - f_5(g^196 * z)) / (x - g^196 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^196 * z)^(-1)*/ mload(add(denominatorsPtr, 0x5e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[43]*/ mload(add(context, 0x3140)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_44*(f_5(x) - f_5(g^197 * z)) / (x - g^197 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^197 * z)^(-1)*/ mload(add(denominatorsPtr, 0x600)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[44]*/ mload(add(context, 0x3160)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_45*(f_5(x) - f_5(g^251 * z)) / (x - g^251 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^251 * z)^(-1)*/ mload(add(denominatorsPtr, 0x680)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[45]*/ mload(add(context, 0x3180)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_46*(f_5(x) - f_5(g^252 * z)) / (x - g^252 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^252 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[46]*/ mload(add(context, 0x31a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_47*(f_5(x) - f_5(g^256 * z)) / (x - g^256 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^256 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[47]*/ mload(add(context, 0x31c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Mask items for column #6.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0xc0)), kMontgomeryRInv, PRIME)

                // res += c_48*(f_6(x) - f_6(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[48]*/ mload(add(context, 0x31e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_49*(f_6(x) - f_6(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[49]*/ mload(add(context, 0x3200)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_50*(f_6(x) - f_6(g^255 * z)) / (x - g^255 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^255 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[50]*/ mload(add(context, 0x3220)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_51*(f_6(x) - f_6(g^256 * z)) / (x - g^256 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^256 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[51]*/ mload(add(context, 0x3240)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_52*(f_6(x) - f_6(g^511 * z)) / (x - g^511 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^511 * z)^(-1)*/ mload(add(denominatorsPtr, 0x7c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[52]*/ mload(add(context, 0x3260)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Mask items for column #7.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0xe0)), kMontgomeryRInv, PRIME)

                // res += c_53*(f_7(x) - f_7(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[53]*/ mload(add(context, 0x3280)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_54*(f_7(x) - f_7(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[54]*/ mload(add(context, 0x32a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_55*(f_7(x) - f_7(g^255 * z)) / (x - g^255 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^255 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[55]*/ mload(add(context, 0x32c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_56*(f_7(x) - f_7(g^256 * z)) / (x - g^256 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^256 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[56]*/ mload(add(context, 0x32e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Mask items for column #8.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x100)), kMontgomeryRInv, PRIME)

                // res += c_57*(f_8(x) - f_8(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[57]*/ mload(add(context, 0x3300)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_58*(f_8(x) - f_8(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[58]*/ mload(add(context, 0x3320)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_59*(f_8(x) - f_8(g^192 * z)) / (x - g^192 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^192 * z)^(-1)*/ mload(add(denominatorsPtr, 0x5a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[59]*/ mload(add(context, 0x3340)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_60*(f_8(x) - f_8(g^193 * z)) / (x - g^193 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^193 * z)^(-1)*/ mload(add(denominatorsPtr, 0x5c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[60]*/ mload(add(context, 0x3360)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_61*(f_8(x) - f_8(g^196 * z)) / (x - g^196 * z).
                res := addmod(
                    res,
                    mulmod(mulmod(/*(x - g^196 * z)^(-1)*/ mload(add(denominatorsPtr, 0x5e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[61]*/ mload(add(context, 0x3380)))),
                           PRIME),
                    PRIME)
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_62*(f_8(x) - f_8(g^197 * z)) / (x - g^197 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^197 * z)^(-1)*/ mload(add(denominatorsPtr, 0x600)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[62]*/ mload(add(context, 0x33a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_63*(f_8(x) - f_8(g^251 * z)) / (x - g^251 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^251 * z)^(-1)*/ mload(add(denominatorsPtr, 0x680)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[63]*/ mload(add(context, 0x33c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_64*(f_8(x) - f_8(g^252 * z)) / (x - g^252 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^252 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[64]*/ mload(add(context, 0x33e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_65*(f_8(x) - f_8(g^256 * z)) / (x - g^256 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^256 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[65]*/ mload(add(context, 0x3400)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Mask items for column #9.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x120)), kMontgomeryRInv, PRIME)

                // res += c_66*(f_9(x) - f_9(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[66]*/ mload(add(context, 0x3420)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_67*(f_9(x) - f_9(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[67]*/ mload(add(context, 0x3440)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_68*(f_9(x) - f_9(g^255 * z)) / (x - g^255 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^255 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[68]*/ mload(add(context, 0x3460)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_69*(f_9(x) - f_9(g^256 * z)) / (x - g^256 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^256 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[69]*/ mload(add(context, 0x3480)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_70*(f_9(x) - f_9(g^511 * z)) / (x - g^511 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^511 * z)^(-1)*/ mload(add(denominatorsPtr, 0x7c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[70]*/ mload(add(context, 0x34a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Mask items for column #10.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x140)), kMontgomeryRInv, PRIME)

                // res += c_71*(f_10(x) - f_10(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[71]*/ mload(add(context, 0x34c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_72*(f_10(x) - f_10(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[72]*/ mload(add(context, 0x34e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_73*(f_10(x) - f_10(g^255 * z)) / (x - g^255 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^255 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[73]*/ mload(add(context, 0x3500)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_74*(f_10(x) - f_10(g^256 * z)) / (x - g^256 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^256 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[74]*/ mload(add(context, 0x3520)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Mask items for column #11.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x160)), kMontgomeryRInv, PRIME)

                // res += c_75*(f_11(x) - f_11(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[75]*/ mload(add(context, 0x3540)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_76*(f_11(x) - f_11(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[76]*/ mload(add(context, 0x3560)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_77*(f_11(x) - f_11(g^192 * z)) / (x - g^192 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^192 * z)^(-1)*/ mload(add(denominatorsPtr, 0x5a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[77]*/ mload(add(context, 0x3580)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_78*(f_11(x) - f_11(g^193 * z)) / (x - g^193 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^193 * z)^(-1)*/ mload(add(denominatorsPtr, 0x5c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[78]*/ mload(add(context, 0x35a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_79*(f_11(x) - f_11(g^196 * z)) / (x - g^196 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^196 * z)^(-1)*/ mload(add(denominatorsPtr, 0x5e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[79]*/ mload(add(context, 0x35c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_80*(f_11(x) - f_11(g^197 * z)) / (x - g^197 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^197 * z)^(-1)*/ mload(add(denominatorsPtr, 0x600)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[80]*/ mload(add(context, 0x35e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_81*(f_11(x) - f_11(g^251 * z)) / (x - g^251 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^251 * z)^(-1)*/ mload(add(denominatorsPtr, 0x680)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[81]*/ mload(add(context, 0x3600)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_82*(f_11(x) - f_11(g^252 * z)) / (x - g^252 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^252 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[82]*/ mload(add(context, 0x3620)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_83*(f_11(x) - f_11(g^256 * z)) / (x - g^256 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^256 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[83]*/ mload(add(context, 0x3640)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Mask items for column #12.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x180)), kMontgomeryRInv, PRIME)

                // res += c_84*(f_12(x) - f_12(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[84]*/ mload(add(context, 0x3660)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_85*(f_12(x) - f_12(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[85]*/ mload(add(context, 0x3680)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_86*(f_12(x) - f_12(g^255 * z)) / (x - g^255 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^255 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[86]*/ mload(add(context, 0x36a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_87*(f_12(x) - f_12(g^256 * z)) / (x - g^256 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^256 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[87]*/ mload(add(context, 0x36c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_88*(f_12(x) - f_12(g^511 * z)) / (x - g^511 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^511 * z)^(-1)*/ mload(add(denominatorsPtr, 0x7c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[88]*/ mload(add(context, 0x36e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Mask items for column #13.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x1a0)), kMontgomeryRInv, PRIME)

                // res += c_89*(f_13(x) - f_13(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[89]*/ mload(add(context, 0x3700)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_90*(f_13(x) - f_13(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[90]*/ mload(add(context, 0x3720)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_91*(f_13(x) - f_13(g^255 * z)) / (x - g^255 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^255 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[91]*/ mload(add(context, 0x3740)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_92*(f_13(x) - f_13(g^256 * z)) / (x - g^256 * z).
                res := addmod(
                    res,
                    mulmod(mulmod(/*(x - g^256 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[92]*/ mload(add(context, 0x3760)))),
                           PRIME),
                    PRIME)
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Mask items for column #14.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x1c0)), kMontgomeryRInv, PRIME)

                // res += c_93*(f_14(x) - f_14(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[93]*/ mload(add(context, 0x3780)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_94*(f_14(x) - f_14(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[94]*/ mload(add(context, 0x37a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_95*(f_14(x) - f_14(g^192 * z)) / (x - g^192 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^192 * z)^(-1)*/ mload(add(denominatorsPtr, 0x5a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[95]*/ mload(add(context, 0x37c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_96*(f_14(x) - f_14(g^193 * z)) / (x - g^193 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^193 * z)^(-1)*/ mload(add(denominatorsPtr, 0x5c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[96]*/ mload(add(context, 0x37e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_97*(f_14(x) - f_14(g^196 * z)) / (x - g^196 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^196 * z)^(-1)*/ mload(add(denominatorsPtr, 0x5e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[97]*/ mload(add(context, 0x3800)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_98*(f_14(x) - f_14(g^197 * z)) / (x - g^197 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^197 * z)^(-1)*/ mload(add(denominatorsPtr, 0x600)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[98]*/ mload(add(context, 0x3820)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_99*(f_14(x) - f_14(g^251 * z)) / (x - g^251 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^251 * z)^(-1)*/ mload(add(denominatorsPtr, 0x680)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[99]*/ mload(add(context, 0x3840)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_100*(f_14(x) - f_14(g^252 * z)) / (x - g^252 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^252 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[100]*/ mload(add(context, 0x3860)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_101*(f_14(x) - f_14(g^256 * z)) / (x - g^256 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^256 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[101]*/ mload(add(context, 0x3880)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Mask items for column #15.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x1e0)), kMontgomeryRInv, PRIME)

                // res += c_102*(f_15(x) - f_15(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[102]*/ mload(add(context, 0x38a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_103*(f_15(x) - f_15(g^255 * z)) / (x - g^255 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^255 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[103]*/ mload(add(context, 0x38c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Mask items for column #16.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x200)), kMontgomeryRInv, PRIME)

                // res += c_104*(f_16(x) - f_16(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[104]*/ mload(add(context, 0x38e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_105*(f_16(x) - f_16(g^255 * z)) / (x - g^255 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^255 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[105]*/ mload(add(context, 0x3900)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Mask items for column #17.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x220)), kMontgomeryRInv, PRIME)

                // res += c_106*(f_17(x) - f_17(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[106]*/ mload(add(context, 0x3920)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_107*(f_17(x) - f_17(g^255 * z)) / (x - g^255 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^255 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[107]*/ mload(add(context, 0x3940)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Mask items for column #18.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x240)), kMontgomeryRInv, PRIME)

                // res += c_108*(f_18(x) - f_18(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[108]*/ mload(add(context, 0x3960)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_109*(f_18(x) - f_18(g^255 * z)) / (x - g^255 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^255 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[109]*/ mload(add(context, 0x3980)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Mask items for column #19.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x260)), kMontgomeryRInv, PRIME)

                // res += c_110*(f_19(x) - f_19(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[110]*/ mload(add(context, 0x39a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_111*(f_19(x) - f_19(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[111]*/ mload(add(context, 0x39c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_112*(f_19(x) - f_19(g^2 * z)) / (x - g^2 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2 * z)^(-1)*/ mload(add(denominatorsPtr, 0x40)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[112]*/ mload(add(context, 0x39e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_113*(f_19(x) - f_19(g^3 * z)) / (x - g^3 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3 * z)^(-1)*/ mload(add(denominatorsPtr, 0x60)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[113]*/ mload(add(context, 0x3a00)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_114*(f_19(x) - f_19(g^4 * z)) / (x - g^4 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4 * z)^(-1)*/ mload(add(denominatorsPtr, 0x80)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[114]*/ mload(add(context, 0x3a20)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_115*(f_19(x) - f_19(g^5 * z)) / (x - g^5 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^5 * z)^(-1)*/ mload(add(denominatorsPtr, 0xa0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[115]*/ mload(add(context, 0x3a40)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_116*(f_19(x) - f_19(g^6 * z)) / (x - g^6 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^6 * z)^(-1)*/ mload(add(denominatorsPtr, 0xc0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[116]*/ mload(add(context, 0x3a60)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_117*(f_19(x) - f_19(g^7 * z)) / (x - g^7 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^7 * z)^(-1)*/ mload(add(denominatorsPtr, 0xe0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[117]*/ mload(add(context, 0x3a80)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_118*(f_19(x) - f_19(g^8 * z)) / (x - g^8 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8 * z)^(-1)*/ mload(add(denominatorsPtr, 0x100)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[118]*/ mload(add(context, 0x3aa0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_119*(f_19(x) - f_19(g^9 * z)) / (x - g^9 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^9 * z)^(-1)*/ mload(add(denominatorsPtr, 0x120)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[119]*/ mload(add(context, 0x3ac0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_120*(f_19(x) - f_19(g^12 * z)) / (x - g^12 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^12 * z)^(-1)*/ mload(add(denominatorsPtr, 0x180)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[120]*/ mload(add(context, 0x3ae0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_121*(f_19(x) - f_19(g^13 * z)) / (x - g^13 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^13 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[121]*/ mload(add(context, 0x3b00)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_122*(f_19(x) - f_19(g^16 * z)) / (x - g^16 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16 * z)^(-1)*/ mload(add(denominatorsPtr, 0x200)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[122]*/ mload(add(context, 0x3b20)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_123*(f_19(x) - f_19(g^22 * z)) / (x - g^22 * z).
                res := addmod(
                    res,
                    mulmod(mulmod(/*(x - g^22 * z)^(-1)*/ mload(add(denominatorsPtr, 0x260)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[123]*/ mload(add(context, 0x3b40)))),
                           PRIME),
                    PRIME)
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_124*(f_19(x) - f_19(g^23 * z)) / (x - g^23 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^23 * z)^(-1)*/ mload(add(denominatorsPtr, 0x280)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[124]*/ mload(add(context, 0x3b60)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_125*(f_19(x) - f_19(g^38 * z)) / (x - g^38 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^38 * z)^(-1)*/ mload(add(denominatorsPtr, 0x340)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[125]*/ mload(add(context, 0x3b80)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_126*(f_19(x) - f_19(g^39 * z)) / (x - g^39 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^39 * z)^(-1)*/ mload(add(denominatorsPtr, 0x360)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[126]*/ mload(add(context, 0x3ba0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_127*(f_19(x) - f_19(g^70 * z)) / (x - g^70 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^70 * z)^(-1)*/ mload(add(denominatorsPtr, 0x400)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[127]*/ mload(add(context, 0x3bc0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_128*(f_19(x) - f_19(g^71 * z)) / (x - g^71 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^71 * z)^(-1)*/ mload(add(denominatorsPtr, 0x420)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[128]*/ mload(add(context, 0x3be0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_129*(f_19(x) - f_19(g^102 * z)) / (x - g^102 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^102 * z)^(-1)*/ mload(add(denominatorsPtr, 0x4a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[129]*/ mload(add(context, 0x3c00)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_130*(f_19(x) - f_19(g^103 * z)) / (x - g^103 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^103 * z)^(-1)*/ mload(add(denominatorsPtr, 0x4c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[130]*/ mload(add(context, 0x3c20)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_131*(f_19(x) - f_19(g^134 * z)) / (x - g^134 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^134 * z)^(-1)*/ mload(add(denominatorsPtr, 0x520)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[131]*/ mload(add(context, 0x3c40)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_132*(f_19(x) - f_19(g^135 * z)) / (x - g^135 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^135 * z)^(-1)*/ mload(add(denominatorsPtr, 0x540)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[132]*/ mload(add(context, 0x3c60)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_133*(f_19(x) - f_19(g^167 * z)) / (x - g^167 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^167 * z)^(-1)*/ mload(add(denominatorsPtr, 0x580)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[133]*/ mload(add(context, 0x3c80)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_134*(f_19(x) - f_19(g^199 * z)) / (x - g^199 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^199 * z)^(-1)*/ mload(add(denominatorsPtr, 0x620)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[134]*/ mload(add(context, 0x3ca0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_135*(f_19(x) - f_19(g^230 * z)) / (x - g^230 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^230 * z)^(-1)*/ mload(add(denominatorsPtr, 0x660)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[135]*/ mload(add(context, 0x3cc0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_136*(f_19(x) - f_19(g^263 * z)) / (x - g^263 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^263 * z)^(-1)*/ mload(add(denominatorsPtr, 0x700)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[136]*/ mload(add(context, 0x3ce0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_137*(f_19(x) - f_19(g^295 * z)) / (x - g^295 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^295 * z)^(-1)*/ mload(add(denominatorsPtr, 0x720)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[137]*/ mload(add(context, 0x3d00)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_138*(f_19(x) - f_19(g^327 * z)) / (x - g^327 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^327 * z)^(-1)*/ mload(add(denominatorsPtr, 0x740)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[138]*/ mload(add(context, 0x3d20)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_139*(f_19(x) - f_19(g^391 * z)) / (x - g^391 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^391 * z)^(-1)*/ mload(add(denominatorsPtr, 0x760)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[139]*/ mload(add(context, 0x3d40)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_140*(f_19(x) - f_19(g^423 * z)) / (x - g^423 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^423 * z)^(-1)*/ mload(add(denominatorsPtr, 0x780)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[140]*/ mload(add(context, 0x3d60)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_141*(f_19(x) - f_19(g^455 * z)) / (x - g^455 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^455 * z)^(-1)*/ mload(add(denominatorsPtr, 0x7a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[141]*/ mload(add(context, 0x3d80)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_142*(f_19(x) - f_19(g^4118 * z)) / (x - g^4118 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4118 * z)^(-1)*/ mload(add(denominatorsPtr, 0x8c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[142]*/ mload(add(context, 0x3da0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_143*(f_19(x) - f_19(g^4119 * z)) / (x - g^4119 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4119 * z)^(-1)*/ mload(add(denominatorsPtr, 0x8e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[143]*/ mload(add(context, 0x3dc0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_144*(f_19(x) - f_19(g^8214 * z)) / (x - g^8214 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8214 * z)^(-1)*/ mload(add(denominatorsPtr, 0xa00)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[144]*/ mload(add(context, 0x3de0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Mask items for column #20.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x280)), kMontgomeryRInv, PRIME)

                // res += c_145*(f_20(x) - f_20(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[145]*/ mload(add(context, 0x3e00)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_146*(f_20(x) - f_20(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[146]*/ mload(add(context, 0x3e20)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_147*(f_20(x) - f_20(g^2 * z)) / (x - g^2 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2 * z)^(-1)*/ mload(add(denominatorsPtr, 0x40)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[147]*/ mload(add(context, 0x3e40)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_148*(f_20(x) - f_20(g^3 * z)) / (x - g^3 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3 * z)^(-1)*/ mload(add(denominatorsPtr, 0x60)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[148]*/ mload(add(context, 0x3e60)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Mask items for column #21.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x2a0)), kMontgomeryRInv, PRIME)

                // res += c_149*(f_21(x) - f_21(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[149]*/ mload(add(context, 0x3e80)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_150*(f_21(x) - f_21(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[150]*/ mload(add(context, 0x3ea0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_151*(f_21(x) - f_21(g^2 * z)) / (x - g^2 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2 * z)^(-1)*/ mload(add(denominatorsPtr, 0x40)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[151]*/ mload(add(context, 0x3ec0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_152*(f_21(x) - f_21(g^3 * z)) / (x - g^3 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3 * z)^(-1)*/ mload(add(denominatorsPtr, 0x60)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[152]*/ mload(add(context, 0x3ee0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_153*(f_21(x) - f_21(g^4 * z)) / (x - g^4 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4 * z)^(-1)*/ mload(add(denominatorsPtr, 0x80)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[153]*/ mload(add(context, 0x3f00)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_154*(f_21(x) - f_21(g^5 * z)) / (x - g^5 * z).
                res := addmod(
                    res,
                    mulmod(mulmod(/*(x - g^5 * z)^(-1)*/ mload(add(denominatorsPtr, 0xa0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[154]*/ mload(add(context, 0x3f20)))),
                           PRIME),
                    PRIME)
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_155*(f_21(x) - f_21(g^6 * z)) / (x - g^6 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^6 * z)^(-1)*/ mload(add(denominatorsPtr, 0xc0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[155]*/ mload(add(context, 0x3f40)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_156*(f_21(x) - f_21(g^7 * z)) / (x - g^7 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^7 * z)^(-1)*/ mload(add(denominatorsPtr, 0xe0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[156]*/ mload(add(context, 0x3f60)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_157*(f_21(x) - f_21(g^8 * z)) / (x - g^8 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8 * z)^(-1)*/ mload(add(denominatorsPtr, 0x100)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[157]*/ mload(add(context, 0x3f80)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_158*(f_21(x) - f_21(g^9 * z)) / (x - g^9 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^9 * z)^(-1)*/ mload(add(denominatorsPtr, 0x120)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[158]*/ mload(add(context, 0x3fa0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_159*(f_21(x) - f_21(g^10 * z)) / (x - g^10 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^10 * z)^(-1)*/ mload(add(denominatorsPtr, 0x140)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[159]*/ mload(add(context, 0x3fc0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_160*(f_21(x) - f_21(g^11 * z)) / (x - g^11 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^11 * z)^(-1)*/ mload(add(denominatorsPtr, 0x160)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[160]*/ mload(add(context, 0x3fe0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_161*(f_21(x) - f_21(g^12 * z)) / (x - g^12 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^12 * z)^(-1)*/ mload(add(denominatorsPtr, 0x180)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[161]*/ mload(add(context, 0x4000)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_162*(f_21(x) - f_21(g^13 * z)) / (x - g^13 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^13 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[162]*/ mload(add(context, 0x4020)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_163*(f_21(x) - f_21(g^14 * z)) / (x - g^14 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^14 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[163]*/ mload(add(context, 0x4040)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_164*(f_21(x) - f_21(g^15 * z)) / (x - g^15 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^15 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[164]*/ mload(add(context, 0x4060)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_165*(f_21(x) - f_21(g^16 * z)) / (x - g^16 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16 * z)^(-1)*/ mload(add(denominatorsPtr, 0x200)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[165]*/ mload(add(context, 0x4080)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_166*(f_21(x) - f_21(g^17 * z)) / (x - g^17 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^17 * z)^(-1)*/ mload(add(denominatorsPtr, 0x220)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[166]*/ mload(add(context, 0x40a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_167*(f_21(x) - f_21(g^21 * z)) / (x - g^21 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^21 * z)^(-1)*/ mload(add(denominatorsPtr, 0x240)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[167]*/ mload(add(context, 0x40c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_168*(f_21(x) - f_21(g^22 * z)) / (x - g^22 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^22 * z)^(-1)*/ mload(add(denominatorsPtr, 0x260)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[168]*/ mload(add(context, 0x40e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_169*(f_21(x) - f_21(g^23 * z)) / (x - g^23 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^23 * z)^(-1)*/ mload(add(denominatorsPtr, 0x280)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[169]*/ mload(add(context, 0x4100)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_170*(f_21(x) - f_21(g^24 * z)) / (x - g^24 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^24 * z)^(-1)*/ mload(add(denominatorsPtr, 0x2a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[170]*/ mload(add(context, 0x4120)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_171*(f_21(x) - f_21(g^25 * z)) / (x - g^25 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^25 * z)^(-1)*/ mload(add(denominatorsPtr, 0x2c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[171]*/ mload(add(context, 0x4140)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_172*(f_21(x) - f_21(g^30 * z)) / (x - g^30 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^30 * z)^(-1)*/ mload(add(denominatorsPtr, 0x300)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[172]*/ mload(add(context, 0x4160)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_173*(f_21(x) - f_21(g^31 * z)) / (x - g^31 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^31 * z)^(-1)*/ mload(add(denominatorsPtr, 0x320)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[173]*/ mload(add(context, 0x4180)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_174*(f_21(x) - f_21(g^39 * z)) / (x - g^39 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^39 * z)^(-1)*/ mload(add(denominatorsPtr, 0x360)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[174]*/ mload(add(context, 0x41a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_175*(f_21(x) - f_21(g^47 * z)) / (x - g^47 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^47 * z)^(-1)*/ mload(add(denominatorsPtr, 0x3a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[175]*/ mload(add(context, 0x41c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_176*(f_21(x) - f_21(g^55 * z)) / (x - g^55 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^55 * z)^(-1)*/ mload(add(denominatorsPtr, 0x3c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[176]*/ mload(add(context, 0x41e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_177*(f_21(x) - f_21(g^4081 * z)) / (x - g^4081 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4081 * z)^(-1)*/ mload(add(denominatorsPtr, 0x7e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[177]*/ mload(add(context, 0x4200)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_178*(f_21(x) - f_21(g^4083 * z)) / (x - g^4083 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4083 * z)^(-1)*/ mload(add(denominatorsPtr, 0x800)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[178]*/ mload(add(context, 0x4220)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_179*(f_21(x) - f_21(g^4089 * z)) / (x - g^4089 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4089 * z)^(-1)*/ mload(add(denominatorsPtr, 0x820)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[179]*/ mload(add(context, 0x4240)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_180*(f_21(x) - f_21(g^4091 * z)) / (x - g^4091 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4091 * z)^(-1)*/ mload(add(denominatorsPtr, 0x840)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[180]*/ mload(add(context, 0x4260)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_181*(f_21(x) - f_21(g^4093 * z)) / (x - g^4093 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4093 * z)^(-1)*/ mload(add(denominatorsPtr, 0x860)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[181]*/ mload(add(context, 0x4280)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_182*(f_21(x) - f_21(g^4102 * z)) / (x - g^4102 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4102 * z)^(-1)*/ mload(add(denominatorsPtr, 0x880)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[182]*/ mload(add(context, 0x42a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_183*(f_21(x) - f_21(g^4110 * z)) / (x - g^4110 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4110 * z)^(-1)*/ mload(add(denominatorsPtr, 0x8a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[183]*/ mload(add(context, 0x42c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_184*(f_21(x) - f_21(g^8167 * z)) / (x - g^8167 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8167 * z)^(-1)*/ mload(add(denominatorsPtr, 0x920)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[184]*/ mload(add(context, 0x42e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_185*(f_21(x) - f_21(g^8177 * z)) / (x - g^8177 * z).
                res := addmod(
                    res,
                    mulmod(mulmod(/*(x - g^8177 * z)^(-1)*/ mload(add(denominatorsPtr, 0x940)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[185]*/ mload(add(context, 0x4300)))),
                           PRIME),
                    PRIME)
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_186*(f_21(x) - f_21(g^8179 * z)) / (x - g^8179 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8179 * z)^(-1)*/ mload(add(denominatorsPtr, 0x960)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[186]*/ mload(add(context, 0x4320)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_187*(f_21(x) - f_21(g^8183 * z)) / (x - g^8183 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8183 * z)^(-1)*/ mload(add(denominatorsPtr, 0x980)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[187]*/ mload(add(context, 0x4340)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_188*(f_21(x) - f_21(g^8185 * z)) / (x - g^8185 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8185 * z)^(-1)*/ mload(add(denominatorsPtr, 0x9a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[188]*/ mload(add(context, 0x4360)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_189*(f_21(x) - f_21(g^8187 * z)) / (x - g^8187 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8187 * z)^(-1)*/ mload(add(denominatorsPtr, 0x9c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[189]*/ mload(add(context, 0x4380)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_190*(f_21(x) - f_21(g^8191 * z)) / (x - g^8191 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8191 * z)^(-1)*/ mload(add(denominatorsPtr, 0x9e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[190]*/ mload(add(context, 0x43a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Mask items for column #22.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x2c0)), kMontgomeryRInv, PRIME)

                // res += c_191*(f_22(x) - f_22(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[191]*/ mload(add(context, 0x43c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_192*(f_22(x) - f_22(g^16 * z)) / (x - g^16 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16 * z)^(-1)*/ mload(add(denominatorsPtr, 0x200)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[192]*/ mload(add(context, 0x43e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_193*(f_22(x) - f_22(g^80 * z)) / (x - g^80 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^80 * z)^(-1)*/ mload(add(denominatorsPtr, 0x460)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[193]*/ mload(add(context, 0x4400)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_194*(f_22(x) - f_22(g^144 * z)) / (x - g^144 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^144 * z)^(-1)*/ mload(add(denominatorsPtr, 0x560)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[194]*/ mload(add(context, 0x4420)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_195*(f_22(x) - f_22(g^208 * z)) / (x - g^208 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^208 * z)^(-1)*/ mload(add(denominatorsPtr, 0x640)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[195]*/ mload(add(context, 0x4440)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_196*(f_22(x) - f_22(g^8160 * z)) / (x - g^8160 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8160 * z)^(-1)*/ mload(add(denominatorsPtr, 0x900)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[196]*/ mload(add(context, 0x4460)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Mask items for column #23.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x2e0)), kMontgomeryRInv, PRIME)

                // res += c_197*(f_23(x) - f_23(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[197]*/ mload(add(context, 0x4480)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_198*(f_23(x) - f_23(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[198]*/ mload(add(context, 0x44a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Mask items for column #24.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x300)), kMontgomeryRInv, PRIME)

                // res += c_199*(f_24(x) - f_24(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[199]*/ mload(add(context, 0x44c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_200*(f_24(x) - f_24(g^2 * z)) / (x - g^2 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2 * z)^(-1)*/ mload(add(denominatorsPtr, 0x40)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[200]*/ mload(add(context, 0x44e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Advance traceQueryResponses by amount read (0x20 * nTraceColumns).
                traceQueryResponses := add(traceQueryResponses, 0x320)

                // Composition constraints.

                {
                // Read the next element.
                let columnValue := mulmod(mload(compositionQueryResponses), kMontgomeryRInv, PRIME)
                // res += c_201*(h_0(x) - C_0(z^2)) / (x - z^2).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z^2)^(-1)*/ mload(add(denominatorsPtr, 0xa20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*composition_oods_values[0]*/ mload(add(context, 0x4500)))),
                           PRIME)
                )
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)}

                {
                // Read the next element.
                let columnValue := mulmod(mload(add(compositionQueryResponses, 0x20)), kMontgomeryRInv, PRIME)
                // res += c_202*(h_1(x) - C_1(z^2)) / (x - z^2).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z^2)^(-1)*/ mload(add(denominatorsPtr, 0xa20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*composition_oods_values[1]*/ mload(add(context, 0x4520)))),
                           PRIME)
                )
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)}

                // Advance compositionQueryResponses by amount read (0x20 * constraintDegree).
                compositionQueryResponses := add(compositionQueryResponses, 0x40)

                // Append the friValue, which is the sum of the out-of-domain-sampling boundary
                // constraints for the trace and composition polynomials, to the friQueue array.
                mstore(add(friQueue, 0x20), mod(res, PRIME))

                // Append the friInvPoint of the current query to the friQueue array.
                mstore(add(friQueue, 0x40), /*friInvPoint*/ mload(add(denominatorsPtr,0xa40)))

                // Advance denominatorsPtr by chunk size (0x20 * (2+N_ROWS_IN_MASK)).
                denominatorsPtr := add(denominatorsPtr, 0xa60)
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
        //    expmodsAndPoints[0:20] (.expmods) expmods used during calculations of the points below.
        //    expmodsAndPoints[20:101] (.points) points used during the denominators calculation.
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

            // expmodsAndPoints.expmods[2] = traceGenerator^4.
            mstore(add(expmodsAndPoints, 0x40),
                   mulmod(mload(add(expmodsAndPoints, 0x20)), // traceGenerator^3
                          traceGenerator, // traceGenerator^1
                          PRIME))

            // expmodsAndPoints.expmods[3] = traceGenerator^5.
            mstore(add(expmodsAndPoints, 0x60),
                   mulmod(mload(add(expmodsAndPoints, 0x40)), // traceGenerator^4
                          traceGenerator, // traceGenerator^1
                          PRIME))

            // expmodsAndPoints.expmods[4] = traceGenerator^6.
            mstore(add(expmodsAndPoints, 0x80),
                   mulmod(mload(add(expmodsAndPoints, 0x60)), // traceGenerator^5
                          traceGenerator, // traceGenerator^1
                          PRIME))

            // expmodsAndPoints.expmods[5] = traceGenerator^7.
            mstore(add(expmodsAndPoints, 0xa0),
                   mulmod(mload(add(expmodsAndPoints, 0x80)), // traceGenerator^6
                          traceGenerator, // traceGenerator^1
                          PRIME))

            // expmodsAndPoints.expmods[6] = traceGenerator^8.
            mstore(add(expmodsAndPoints, 0xc0),
                   mulmod(mload(add(expmodsAndPoints, 0xa0)), // traceGenerator^7
                          traceGenerator, // traceGenerator^1
                          PRIME))

            // expmodsAndPoints.expmods[7] = traceGenerator^9.
            mstore(add(expmodsAndPoints, 0xe0),
                   mulmod(mload(add(expmodsAndPoints, 0xc0)), // traceGenerator^8
                          traceGenerator, // traceGenerator^1
                          PRIME))

            // expmodsAndPoints.expmods[8] = traceGenerator^10.
            mstore(add(expmodsAndPoints, 0x100),
                   mulmod(mload(add(expmodsAndPoints, 0xe0)), // traceGenerator^9
                          traceGenerator, // traceGenerator^1
                          PRIME))

            // expmodsAndPoints.expmods[9] = traceGenerator^12.
            mstore(add(expmodsAndPoints, 0x120),
                   mulmod(mload(add(expmodsAndPoints, 0x100)), // traceGenerator^10
                          mload(expmodsAndPoints), // traceGenerator^2
                          PRIME))

            // expmodsAndPoints.expmods[10] = traceGenerator^16.
            mstore(add(expmodsAndPoints, 0x140),
                   mulmod(mload(add(expmodsAndPoints, 0x120)), // traceGenerator^12
                          mload(add(expmodsAndPoints, 0x40)), // traceGenerator^4
                          PRIME))

            // expmodsAndPoints.expmods[11] = traceGenerator^21.
            mstore(add(expmodsAndPoints, 0x160),
                   mulmod(mload(add(expmodsAndPoints, 0x140)), // traceGenerator^16
                          mload(add(expmodsAndPoints, 0x60)), // traceGenerator^5
                          PRIME))

            // expmodsAndPoints.expmods[12] = traceGenerator^22.
            mstore(add(expmodsAndPoints, 0x180),
                   mulmod(mload(add(expmodsAndPoints, 0x160)), // traceGenerator^21
                          traceGenerator, // traceGenerator^1
                          PRIME))

            // expmodsAndPoints.expmods[13] = traceGenerator^23.
            mstore(add(expmodsAndPoints, 0x1a0),
                   mulmod(mload(add(expmodsAndPoints, 0x180)), // traceGenerator^22
                          traceGenerator, // traceGenerator^1
                          PRIME))

            // expmodsAndPoints.expmods[14] = traceGenerator^25.
            mstore(add(expmodsAndPoints, 0x1c0),
                   mulmod(mload(add(expmodsAndPoints, 0x1a0)), // traceGenerator^23
                          mload(expmodsAndPoints), // traceGenerator^2
                          PRIME))

            // expmodsAndPoints.expmods[15] = traceGenerator^32.
            mstore(add(expmodsAndPoints, 0x1e0),
                   mulmod(mload(add(expmodsAndPoints, 0x1c0)), // traceGenerator^25
                          mload(add(expmodsAndPoints, 0xa0)), // traceGenerator^7
                          PRIME))

            // expmodsAndPoints.expmods[16] = traceGenerator^56.
            mstore(add(expmodsAndPoints, 0x200),
                   mulmod(mload(add(expmodsAndPoints, 0x1e0)), // traceGenerator^32
                          mulmod(mload(add(expmodsAndPoints, 0x1a0)), // traceGenerator^23
                                 traceGenerator, // traceGenerator^1
                                 PRIME),
                          PRIME))

            // expmodsAndPoints.expmods[17] = traceGenerator^64.
            mstore(add(expmodsAndPoints, 0x220),
                   mulmod(mload(add(expmodsAndPoints, 0x200)), // traceGenerator^56
                          mload(add(expmodsAndPoints, 0xc0)), // traceGenerator^8
                          PRIME))

            // expmodsAndPoints.expmods[18] = traceGenerator^3570.
            mstore(add(expmodsAndPoints, 0x240),
                   expmod(traceGenerator, 3570, PRIME))

            // expmodsAndPoints.expmods[19] = traceGenerator^4041.
            mstore(add(expmodsAndPoints, 0x260),
                   expmod(traceGenerator, 4041, PRIME))

            let oodsPoint := /*oods_point*/ mload(add(context, 0x2b40))
            {
              // point = -z.
              let point := sub(PRIME, oodsPoint)
              // Compute denominators for rows with nonconst mask expression.
              // We compute those first because for the const rows we modify the point variable.

              // Compute denominators for rows with const mask expression.

              // expmods_and_points.points[0] = -z.
              mstore(add(expmodsAndPoints, 0x280), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[1] = -(g * z).
              mstore(add(expmodsAndPoints, 0x2a0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[2] = -(g^2 * z).
              mstore(add(expmodsAndPoints, 0x2c0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[3] = -(g^3 * z).
              mstore(add(expmodsAndPoints, 0x2e0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[4] = -(g^4 * z).
              mstore(add(expmodsAndPoints, 0x300), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[5] = -(g^5 * z).
              mstore(add(expmodsAndPoints, 0x320), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[6] = -(g^6 * z).
              mstore(add(expmodsAndPoints, 0x340), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[7] = -(g^7 * z).
              mstore(add(expmodsAndPoints, 0x360), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[8] = -(g^8 * z).
              mstore(add(expmodsAndPoints, 0x380), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[9] = -(g^9 * z).
              mstore(add(expmodsAndPoints, 0x3a0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[10] = -(g^10 * z).
              mstore(add(expmodsAndPoints, 0x3c0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[11] = -(g^11 * z).
              mstore(add(expmodsAndPoints, 0x3e0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[12] = -(g^12 * z).
              mstore(add(expmodsAndPoints, 0x400), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[13] = -(g^13 * z).
              mstore(add(expmodsAndPoints, 0x420), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[14] = -(g^14 * z).
              mstore(add(expmodsAndPoints, 0x440), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[15] = -(g^15 * z).
              mstore(add(expmodsAndPoints, 0x460), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[16] = -(g^16 * z).
              mstore(add(expmodsAndPoints, 0x480), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[17] = -(g^17 * z).
              mstore(add(expmodsAndPoints, 0x4a0), point)

              // point *= g^4.
              point := mulmod(point, /*traceGenerator^4*/ mload(add(expmodsAndPoints, 0x40)), PRIME)
              // expmods_and_points.points[18] = -(g^21 * z).
              mstore(add(expmodsAndPoints, 0x4c0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[19] = -(g^22 * z).
              mstore(add(expmodsAndPoints, 0x4e0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[20] = -(g^23 * z).
              mstore(add(expmodsAndPoints, 0x500), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[21] = -(g^24 * z).
              mstore(add(expmodsAndPoints, 0x520), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[22] = -(g^25 * z).
              mstore(add(expmodsAndPoints, 0x540), point)

              // point *= g^3.
              point := mulmod(point, /*traceGenerator^3*/ mload(add(expmodsAndPoints, 0x20)), PRIME)
              // expmods_and_points.points[23] = -(g^28 * z).
              mstore(add(expmodsAndPoints, 0x560), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[24] = -(g^30 * z).
              mstore(add(expmodsAndPoints, 0x580), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[25] = -(g^31 * z).
              mstore(add(expmodsAndPoints, 0x5a0), point)

              // point *= g^7.
              point := mulmod(point, /*traceGenerator^7*/ mload(add(expmodsAndPoints, 0xa0)), PRIME)
              // expmods_and_points.points[26] = -(g^38 * z).
              mstore(add(expmodsAndPoints, 0x5c0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[27] = -(g^39 * z).
              mstore(add(expmodsAndPoints, 0x5e0), point)

              // point *= g^5.
              point := mulmod(point, /*traceGenerator^5*/ mload(add(expmodsAndPoints, 0x60)), PRIME)
              // expmods_and_points.points[28] = -(g^44 * z).
              mstore(add(expmodsAndPoints, 0x600), point)

              // point *= g^3.
              point := mulmod(point, /*traceGenerator^3*/ mload(add(expmodsAndPoints, 0x20)), PRIME)
              // expmods_and_points.points[29] = -(g^47 * z).
              mstore(add(expmodsAndPoints, 0x620), point)

              // point *= g^8.
              point := mulmod(point, /*traceGenerator^8*/ mload(add(expmodsAndPoints, 0xc0)), PRIME)
              // expmods_and_points.points[30] = -(g^55 * z).
              mstore(add(expmodsAndPoints, 0x640), point)

              // point *= g^5.
              point := mulmod(point, /*traceGenerator^5*/ mload(add(expmodsAndPoints, 0x60)), PRIME)
              // expmods_and_points.points[31] = -(g^60 * z).
              mstore(add(expmodsAndPoints, 0x660), point)

              // point *= g^10.
              point := mulmod(point, /*traceGenerator^10*/ mload(add(expmodsAndPoints, 0x100)), PRIME)
              // expmods_and_points.points[32] = -(g^70 * z).
              mstore(add(expmodsAndPoints, 0x680), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[33] = -(g^71 * z).
              mstore(add(expmodsAndPoints, 0x6a0), point)

              // point *= g^5.
              point := mulmod(point, /*traceGenerator^5*/ mload(add(expmodsAndPoints, 0x60)), PRIME)
              // expmods_and_points.points[34] = -(g^76 * z).
              mstore(add(expmodsAndPoints, 0x6c0), point)

              // point *= g^4.
              point := mulmod(point, /*traceGenerator^4*/ mload(add(expmodsAndPoints, 0x40)), PRIME)
              // expmods_and_points.points[35] = -(g^80 * z).
              mstore(add(expmodsAndPoints, 0x6e0), point)

              // point *= g^12.
              point := mulmod(point, /*traceGenerator^12*/ mload(add(expmodsAndPoints, 0x120)), PRIME)
              // expmods_and_points.points[36] = -(g^92 * z).
              mstore(add(expmodsAndPoints, 0x700), point)

              // point *= g^10.
              point := mulmod(point, /*traceGenerator^10*/ mload(add(expmodsAndPoints, 0x100)), PRIME)
              // expmods_and_points.points[37] = -(g^102 * z).
              mstore(add(expmodsAndPoints, 0x720), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[38] = -(g^103 * z).
              mstore(add(expmodsAndPoints, 0x740), point)

              // point *= g^5.
              point := mulmod(point, /*traceGenerator^5*/ mload(add(expmodsAndPoints, 0x60)), PRIME)
              // expmods_and_points.points[39] = -(g^108 * z).
              mstore(add(expmodsAndPoints, 0x760), point)

              // point *= g^16.
              point := mulmod(point, /*traceGenerator^16*/ mload(add(expmodsAndPoints, 0x140)), PRIME)
              // expmods_and_points.points[40] = -(g^124 * z).
              mstore(add(expmodsAndPoints, 0x780), point)

              // point *= g^10.
              point := mulmod(point, /*traceGenerator^10*/ mload(add(expmodsAndPoints, 0x100)), PRIME)
              // expmods_and_points.points[41] = -(g^134 * z).
              mstore(add(expmodsAndPoints, 0x7a0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[42] = -(g^135 * z).
              mstore(add(expmodsAndPoints, 0x7c0), point)

              // point *= g^9.
              point := mulmod(point, /*traceGenerator^9*/ mload(add(expmodsAndPoints, 0xe0)), PRIME)
              // expmods_and_points.points[43] = -(g^144 * z).
              mstore(add(expmodsAndPoints, 0x7e0), point)

              // point *= g^23.
              point := mulmod(point, /*traceGenerator^23*/ mload(add(expmodsAndPoints, 0x1a0)), PRIME)
              // expmods_and_points.points[44] = -(g^167 * z).
              mstore(add(expmodsAndPoints, 0x800), point)

              // point *= g^25.
              point := mulmod(point, /*traceGenerator^25*/ mload(add(expmodsAndPoints, 0x1c0)), PRIME)
              // expmods_and_points.points[45] = -(g^192 * z).
              mstore(add(expmodsAndPoints, 0x820), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[46] = -(g^193 * z).
              mstore(add(expmodsAndPoints, 0x840), point)

              // point *= g^3.
              point := mulmod(point, /*traceGenerator^3*/ mload(add(expmodsAndPoints, 0x20)), PRIME)
              // expmods_and_points.points[47] = -(g^196 * z).
              mstore(add(expmodsAndPoints, 0x860), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[48] = -(g^197 * z).
              mstore(add(expmodsAndPoints, 0x880), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[49] = -(g^199 * z).
              mstore(add(expmodsAndPoints, 0x8a0), point)

              // point *= g^9.
              point := mulmod(point, /*traceGenerator^9*/ mload(add(expmodsAndPoints, 0xe0)), PRIME)
              // expmods_and_points.points[50] = -(g^208 * z).
              mstore(add(expmodsAndPoints, 0x8c0), point)

              // point *= g^22.
              point := mulmod(point, /*traceGenerator^22*/ mload(add(expmodsAndPoints, 0x180)), PRIME)
              // expmods_and_points.points[51] = -(g^230 * z).
              mstore(add(expmodsAndPoints, 0x8e0), point)

              // point *= g^21.
              point := mulmod(point, /*traceGenerator^21*/ mload(add(expmodsAndPoints, 0x160)), PRIME)
              // expmods_and_points.points[52] = -(g^251 * z).
              mstore(add(expmodsAndPoints, 0x900), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[53] = -(g^252 * z).
              mstore(add(expmodsAndPoints, 0x920), point)

              // point *= g^3.
              point := mulmod(point, /*traceGenerator^3*/ mload(add(expmodsAndPoints, 0x20)), PRIME)
              // expmods_and_points.points[54] = -(g^255 * z).
              mstore(add(expmodsAndPoints, 0x940), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[55] = -(g^256 * z).
              mstore(add(expmodsAndPoints, 0x960), point)

              // point *= g^7.
              point := mulmod(point, /*traceGenerator^7*/ mload(add(expmodsAndPoints, 0xa0)), PRIME)
              // expmods_and_points.points[56] = -(g^263 * z).
              mstore(add(expmodsAndPoints, 0x980), point)

              // point *= g^32.
              point := mulmod(point, /*traceGenerator^32*/ mload(add(expmodsAndPoints, 0x1e0)), PRIME)
              // expmods_and_points.points[57] = -(g^295 * z).
              mstore(add(expmodsAndPoints, 0x9a0), point)

              // point *= g^32.
              point := mulmod(point, /*traceGenerator^32*/ mload(add(expmodsAndPoints, 0x1e0)), PRIME)
              // expmods_and_points.points[58] = -(g^327 * z).
              mstore(add(expmodsAndPoints, 0x9c0), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x220)), PRIME)
              // expmods_and_points.points[59] = -(g^391 * z).
              mstore(add(expmodsAndPoints, 0x9e0), point)

              // point *= g^32.
              point := mulmod(point, /*traceGenerator^32*/ mload(add(expmodsAndPoints, 0x1e0)), PRIME)
              // expmods_and_points.points[60] = -(g^423 * z).
              mstore(add(expmodsAndPoints, 0xa00), point)

              // point *= g^32.
              point := mulmod(point, /*traceGenerator^32*/ mload(add(expmodsAndPoints, 0x1e0)), PRIME)
              // expmods_and_points.points[61] = -(g^455 * z).
              mstore(add(expmodsAndPoints, 0xa20), point)

              // point *= g^56.
              point := mulmod(point, /*traceGenerator^56*/ mload(add(expmodsAndPoints, 0x200)), PRIME)
              // expmods_and_points.points[62] = -(g^511 * z).
              mstore(add(expmodsAndPoints, 0xa40), point)

              // point *= g^3570.
              point := mulmod(point, /*traceGenerator^3570*/ mload(add(expmodsAndPoints, 0x240)), PRIME)
              // expmods_and_points.points[63] = -(g^4081 * z).
              mstore(add(expmodsAndPoints, 0xa60), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[64] = -(g^4083 * z).
              mstore(add(expmodsAndPoints, 0xa80), point)

              // point *= g^6.
              point := mulmod(point, /*traceGenerator^6*/ mload(add(expmodsAndPoints, 0x80)), PRIME)
              // expmods_and_points.points[65] = -(g^4089 * z).
              mstore(add(expmodsAndPoints, 0xaa0), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[66] = -(g^4091 * z).
              mstore(add(expmodsAndPoints, 0xac0), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[67] = -(g^4093 * z).
              mstore(add(expmodsAndPoints, 0xae0), point)

              // point *= g^9.
              point := mulmod(point, /*traceGenerator^9*/ mload(add(expmodsAndPoints, 0xe0)), PRIME)
              // expmods_and_points.points[68] = -(g^4102 * z).
              mstore(add(expmodsAndPoints, 0xb00), point)

              // point *= g^8.
              point := mulmod(point, /*traceGenerator^8*/ mload(add(expmodsAndPoints, 0xc0)), PRIME)
              // expmods_and_points.points[69] = -(g^4110 * z).
              mstore(add(expmodsAndPoints, 0xb20), point)

              // point *= g^8.
              point := mulmod(point, /*traceGenerator^8*/ mload(add(expmodsAndPoints, 0xc0)), PRIME)
              // expmods_and_points.points[70] = -(g^4118 * z).
              mstore(add(expmodsAndPoints, 0xb40), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[71] = -(g^4119 * z).
              mstore(add(expmodsAndPoints, 0xb60), point)

              // point *= g^4041.
              point := mulmod(point, /*traceGenerator^4041*/ mload(add(expmodsAndPoints, 0x260)), PRIME)
              // expmods_and_points.points[72] = -(g^8160 * z).
              mstore(add(expmodsAndPoints, 0xb80), point)

              // point *= g^7.
              point := mulmod(point, /*traceGenerator^7*/ mload(add(expmodsAndPoints, 0xa0)), PRIME)
              // expmods_and_points.points[73] = -(g^8167 * z).
              mstore(add(expmodsAndPoints, 0xba0), point)

              // point *= g^10.
              point := mulmod(point, /*traceGenerator^10*/ mload(add(expmodsAndPoints, 0x100)), PRIME)
              // expmods_and_points.points[74] = -(g^8177 * z).
              mstore(add(expmodsAndPoints, 0xbc0), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[75] = -(g^8179 * z).
              mstore(add(expmodsAndPoints, 0xbe0), point)

              // point *= g^4.
              point := mulmod(point, /*traceGenerator^4*/ mload(add(expmodsAndPoints, 0x40)), PRIME)
              // expmods_and_points.points[76] = -(g^8183 * z).
              mstore(add(expmodsAndPoints, 0xc00), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[77] = -(g^8185 * z).
              mstore(add(expmodsAndPoints, 0xc20), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[78] = -(g^8187 * z).
              mstore(add(expmodsAndPoints, 0xc40), point)

              // point *= g^4.
              point := mulmod(point, /*traceGenerator^4*/ mload(add(expmodsAndPoints, 0x40)), PRIME)
              // expmods_and_points.points[79] = -(g^8191 * z).
              mstore(add(expmodsAndPoints, 0xc60), point)

              // point *= g^23.
              point := mulmod(point, /*traceGenerator^23*/ mload(add(expmodsAndPoints, 0x1a0)), PRIME)
              // expmods_and_points.points[80] = -(g^8214 * z).
              mstore(add(expmodsAndPoints, 0xc80), point)
            }

            let evalPointsPtr := /*oodsEvalPoints*/ add(context, 0x4540)
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
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x280)))
                mstore(productsPtr, partialProduct)
                mstore(valuesPtr, denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1: x - g * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x2a0)))
                mstore(add(productsPtr, 0x20), partialProduct)
                mstore(add(valuesPtr, 0x20), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 2: x - g^2 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x2c0)))
                mstore(add(productsPtr, 0x40), partialProduct)
                mstore(add(valuesPtr, 0x40), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 3: x - g^3 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x2e0)))
                mstore(add(productsPtr, 0x60), partialProduct)
                mstore(add(valuesPtr, 0x60), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 4: x - g^4 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x300)))
                mstore(add(productsPtr, 0x80), partialProduct)
                mstore(add(valuesPtr, 0x80), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 5: x - g^5 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x320)))
                mstore(add(productsPtr, 0xa0), partialProduct)
                mstore(add(valuesPtr, 0xa0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 6: x - g^6 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x340)))
                mstore(add(productsPtr, 0xc0), partialProduct)
                mstore(add(valuesPtr, 0xc0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 7: x - g^7 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x360)))
                mstore(add(productsPtr, 0xe0), partialProduct)
                mstore(add(valuesPtr, 0xe0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 8: x - g^8 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x380)))
                mstore(add(productsPtr, 0x100), partialProduct)
                mstore(add(valuesPtr, 0x100), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 9: x - g^9 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x3a0)))
                mstore(add(productsPtr, 0x120), partialProduct)
                mstore(add(valuesPtr, 0x120), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 10: x - g^10 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x3c0)))
                mstore(add(productsPtr, 0x140), partialProduct)
                mstore(add(valuesPtr, 0x140), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 11: x - g^11 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x3e0)))
                mstore(add(productsPtr, 0x160), partialProduct)
                mstore(add(valuesPtr, 0x160), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 12: x - g^12 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x400)))
                mstore(add(productsPtr, 0x180), partialProduct)
                mstore(add(valuesPtr, 0x180), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 13: x - g^13 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x420)))
                mstore(add(productsPtr, 0x1a0), partialProduct)
                mstore(add(valuesPtr, 0x1a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 14: x - g^14 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x440)))
                mstore(add(productsPtr, 0x1c0), partialProduct)
                mstore(add(valuesPtr, 0x1c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 15: x - g^15 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x460)))
                mstore(add(productsPtr, 0x1e0), partialProduct)
                mstore(add(valuesPtr, 0x1e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16: x - g^16 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x480)))
                mstore(add(productsPtr, 0x200), partialProduct)
                mstore(add(valuesPtr, 0x200), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 17: x - g^17 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x4a0)))
                mstore(add(productsPtr, 0x220), partialProduct)
                mstore(add(valuesPtr, 0x220), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 21: x - g^21 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x4c0)))
                mstore(add(productsPtr, 0x240), partialProduct)
                mstore(add(valuesPtr, 0x240), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 22: x - g^22 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x4e0)))
                mstore(add(productsPtr, 0x260), partialProduct)
                mstore(add(valuesPtr, 0x260), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 23: x - g^23 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x500)))
                mstore(add(productsPtr, 0x280), partialProduct)
                mstore(add(valuesPtr, 0x280), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 24: x - g^24 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x520)))
                mstore(add(productsPtr, 0x2a0), partialProduct)
                mstore(add(valuesPtr, 0x2a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 25: x - g^25 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x540)))
                mstore(add(productsPtr, 0x2c0), partialProduct)
                mstore(add(valuesPtr, 0x2c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 28: x - g^28 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x560)))
                mstore(add(productsPtr, 0x2e0), partialProduct)
                mstore(add(valuesPtr, 0x2e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 30: x - g^30 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x580)))
                mstore(add(productsPtr, 0x300), partialProduct)
                mstore(add(valuesPtr, 0x300), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 31: x - g^31 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x5a0)))
                mstore(add(productsPtr, 0x320), partialProduct)
                mstore(add(valuesPtr, 0x320), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 38: x - g^38 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x5c0)))
                mstore(add(productsPtr, 0x340), partialProduct)
                mstore(add(valuesPtr, 0x340), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 39: x - g^39 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x5e0)))
                mstore(add(productsPtr, 0x360), partialProduct)
                mstore(add(valuesPtr, 0x360), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 44: x - g^44 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x600)))
                mstore(add(productsPtr, 0x380), partialProduct)
                mstore(add(valuesPtr, 0x380), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 47: x - g^47 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x620)))
                mstore(add(productsPtr, 0x3a0), partialProduct)
                mstore(add(valuesPtr, 0x3a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 55: x - g^55 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x640)))
                mstore(add(productsPtr, 0x3c0), partialProduct)
                mstore(add(valuesPtr, 0x3c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 60: x - g^60 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x660)))
                mstore(add(productsPtr, 0x3e0), partialProduct)
                mstore(add(valuesPtr, 0x3e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 70: x - g^70 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x680)))
                mstore(add(productsPtr, 0x400), partialProduct)
                mstore(add(valuesPtr, 0x400), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 71: x - g^71 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x6a0)))
                mstore(add(productsPtr, 0x420), partialProduct)
                mstore(add(valuesPtr, 0x420), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 76: x - g^76 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x6c0)))
                mstore(add(productsPtr, 0x440), partialProduct)
                mstore(add(valuesPtr, 0x440), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 80: x - g^80 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x6e0)))
                mstore(add(productsPtr, 0x460), partialProduct)
                mstore(add(valuesPtr, 0x460), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 92: x - g^92 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x700)))
                mstore(add(productsPtr, 0x480), partialProduct)
                mstore(add(valuesPtr, 0x480), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 102: x - g^102 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x720)))
                mstore(add(productsPtr, 0x4a0), partialProduct)
                mstore(add(valuesPtr, 0x4a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 103: x - g^103 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x740)))
                mstore(add(productsPtr, 0x4c0), partialProduct)
                mstore(add(valuesPtr, 0x4c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 108: x - g^108 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x760)))
                mstore(add(productsPtr, 0x4e0), partialProduct)
                mstore(add(valuesPtr, 0x4e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 124: x - g^124 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x780)))
                mstore(add(productsPtr, 0x500), partialProduct)
                mstore(add(valuesPtr, 0x500), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 134: x - g^134 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x7a0)))
                mstore(add(productsPtr, 0x520), partialProduct)
                mstore(add(valuesPtr, 0x520), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 135: x - g^135 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x7c0)))
                mstore(add(productsPtr, 0x540), partialProduct)
                mstore(add(valuesPtr, 0x540), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 144: x - g^144 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x7e0)))
                mstore(add(productsPtr, 0x560), partialProduct)
                mstore(add(valuesPtr, 0x560), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 167: x - g^167 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x800)))
                mstore(add(productsPtr, 0x580), partialProduct)
                mstore(add(valuesPtr, 0x580), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 192: x - g^192 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x820)))
                mstore(add(productsPtr, 0x5a0), partialProduct)
                mstore(add(valuesPtr, 0x5a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 193: x - g^193 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x840)))
                mstore(add(productsPtr, 0x5c0), partialProduct)
                mstore(add(valuesPtr, 0x5c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 196: x - g^196 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x860)))
                mstore(add(productsPtr, 0x5e0), partialProduct)
                mstore(add(valuesPtr, 0x5e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 197: x - g^197 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x880)))
                mstore(add(productsPtr, 0x600), partialProduct)
                mstore(add(valuesPtr, 0x600), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 199: x - g^199 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x8a0)))
                mstore(add(productsPtr, 0x620), partialProduct)
                mstore(add(valuesPtr, 0x620), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 208: x - g^208 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x8c0)))
                mstore(add(productsPtr, 0x640), partialProduct)
                mstore(add(valuesPtr, 0x640), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 230: x - g^230 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x8e0)))
                mstore(add(productsPtr, 0x660), partialProduct)
                mstore(add(valuesPtr, 0x660), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 251: x - g^251 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x900)))
                mstore(add(productsPtr, 0x680), partialProduct)
                mstore(add(valuesPtr, 0x680), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 252: x - g^252 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x920)))
                mstore(add(productsPtr, 0x6a0), partialProduct)
                mstore(add(valuesPtr, 0x6a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 255: x - g^255 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x940)))
                mstore(add(productsPtr, 0x6c0), partialProduct)
                mstore(add(valuesPtr, 0x6c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 256: x - g^256 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x960)))
                mstore(add(productsPtr, 0x6e0), partialProduct)
                mstore(add(valuesPtr, 0x6e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 263: x - g^263 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x980)))
                mstore(add(productsPtr, 0x700), partialProduct)
                mstore(add(valuesPtr, 0x700), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 295: x - g^295 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x9a0)))
                mstore(add(productsPtr, 0x720), partialProduct)
                mstore(add(valuesPtr, 0x720), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 327: x - g^327 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x9c0)))
                mstore(add(productsPtr, 0x740), partialProduct)
                mstore(add(valuesPtr, 0x740), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 391: x - g^391 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x9e0)))
                mstore(add(productsPtr, 0x760), partialProduct)
                mstore(add(valuesPtr, 0x760), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 423: x - g^423 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xa00)))
                mstore(add(productsPtr, 0x780), partialProduct)
                mstore(add(valuesPtr, 0x780), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 455: x - g^455 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xa20)))
                mstore(add(productsPtr, 0x7a0), partialProduct)
                mstore(add(valuesPtr, 0x7a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 511: x - g^511 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xa40)))
                mstore(add(productsPtr, 0x7c0), partialProduct)
                mstore(add(valuesPtr, 0x7c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 4081: x - g^4081 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xa60)))
                mstore(add(productsPtr, 0x7e0), partialProduct)
                mstore(add(valuesPtr, 0x7e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 4083: x - g^4083 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xa80)))
                mstore(add(productsPtr, 0x800), partialProduct)
                mstore(add(valuesPtr, 0x800), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 4089: x - g^4089 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xaa0)))
                mstore(add(productsPtr, 0x820), partialProduct)
                mstore(add(valuesPtr, 0x820), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 4091: x - g^4091 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xac0)))
                mstore(add(productsPtr, 0x840), partialProduct)
                mstore(add(valuesPtr, 0x840), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 4093: x - g^4093 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xae0)))
                mstore(add(productsPtr, 0x860), partialProduct)
                mstore(add(valuesPtr, 0x860), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 4102: x - g^4102 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xb00)))
                mstore(add(productsPtr, 0x880), partialProduct)
                mstore(add(valuesPtr, 0x880), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 4110: x - g^4110 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xb20)))
                mstore(add(productsPtr, 0x8a0), partialProduct)
                mstore(add(valuesPtr, 0x8a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 4118: x - g^4118 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xb40)))
                mstore(add(productsPtr, 0x8c0), partialProduct)
                mstore(add(valuesPtr, 0x8c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 4119: x - g^4119 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xb60)))
                mstore(add(productsPtr, 0x8e0), partialProduct)
                mstore(add(valuesPtr, 0x8e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 8160: x - g^8160 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xb80)))
                mstore(add(productsPtr, 0x900), partialProduct)
                mstore(add(valuesPtr, 0x900), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 8167: x - g^8167 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xba0)))
                mstore(add(productsPtr, 0x920), partialProduct)
                mstore(add(valuesPtr, 0x920), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 8177: x - g^8177 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xbc0)))
                mstore(add(productsPtr, 0x940), partialProduct)
                mstore(add(valuesPtr, 0x940), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 8179: x - g^8179 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xbe0)))
                mstore(add(productsPtr, 0x960), partialProduct)
                mstore(add(valuesPtr, 0x960), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 8183: x - g^8183 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xc00)))
                mstore(add(productsPtr, 0x980), partialProduct)
                mstore(add(valuesPtr, 0x980), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 8185: x - g^8185 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xc20)))
                mstore(add(productsPtr, 0x9a0), partialProduct)
                mstore(add(valuesPtr, 0x9a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 8187: x - g^8187 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xc40)))
                mstore(add(productsPtr, 0x9c0), partialProduct)
                mstore(add(valuesPtr, 0x9c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 8191: x - g^8191 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xc60)))
                mstore(add(productsPtr, 0x9e0), partialProduct)
                mstore(add(valuesPtr, 0x9e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 8214: x - g^8214 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xc80)))
                mstore(add(productsPtr, 0xa00), partialProduct)
                mstore(add(valuesPtr, 0xa00), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate the denominator for the composition polynomial columns: x - z^2.
                let denominator := add(shiftedEvalPoint, minusPointPow)
                mstore(add(productsPtr, 0xa20), partialProduct)
                mstore(add(valuesPtr, 0xa20), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                // Add evalPoint to batch inverse inputs.
                // inverse(evalPoint) is going to be used by FRI.
                mstore(add(productsPtr, 0xa40), partialProduct)
                mstore(add(valuesPtr, 0xa40), evalPoint)
                partialProduct := mulmod(partialProduct, evalPoint, PRIME)

                // Advance pointers.
                productsPtr := add(productsPtr, 0xa60)
                valuesPtr := add(valuesPtr, 0xa60)
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
