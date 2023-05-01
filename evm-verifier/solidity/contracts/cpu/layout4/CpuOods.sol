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
            let traceQueryResponses := /*traceQueryQesponses*/ add(context, 0x4340)

            let compositionQueryResponses := /*composition_query_responses*/ add(context, 0x7f40)

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
                let oods_alpha := /*oods_alpha*/ mload(add(context, 0x4320))

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
                           add(columnValue, sub(PRIME, /*oods_values[0]*/ mload(add(context, 0x2c40)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_1*(f_0(x) - f_0(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[1]*/ mload(add(context, 0x2c60)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_2*(f_0(x) - f_0(g^2 * z)) / (x - g^2 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2 * z)^(-1)*/ mload(add(denominatorsPtr, 0x40)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[2]*/ mload(add(context, 0x2c80)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_3*(f_0(x) - f_0(g^3 * z)) / (x - g^3 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3 * z)^(-1)*/ mload(add(denominatorsPtr, 0x60)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[3]*/ mload(add(context, 0x2ca0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_4*(f_0(x) - f_0(g^4 * z)) / (x - g^4 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4 * z)^(-1)*/ mload(add(denominatorsPtr, 0x80)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[4]*/ mload(add(context, 0x2cc0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_5*(f_0(x) - f_0(g^5 * z)) / (x - g^5 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^5 * z)^(-1)*/ mload(add(denominatorsPtr, 0xa0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[5]*/ mload(add(context, 0x2ce0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_6*(f_0(x) - f_0(g^6 * z)) / (x - g^6 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^6 * z)^(-1)*/ mload(add(denominatorsPtr, 0xc0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[6]*/ mload(add(context, 0x2d00)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_7*(f_0(x) - f_0(g^7 * z)) / (x - g^7 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^7 * z)^(-1)*/ mload(add(denominatorsPtr, 0xe0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[7]*/ mload(add(context, 0x2d20)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_8*(f_0(x) - f_0(g^8 * z)) / (x - g^8 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8 * z)^(-1)*/ mload(add(denominatorsPtr, 0x100)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[8]*/ mload(add(context, 0x2d40)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_9*(f_0(x) - f_0(g^9 * z)) / (x - g^9 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^9 * z)^(-1)*/ mload(add(denominatorsPtr, 0x120)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[9]*/ mload(add(context, 0x2d60)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_10*(f_0(x) - f_0(g^10 * z)) / (x - g^10 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^10 * z)^(-1)*/ mload(add(denominatorsPtr, 0x140)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[10]*/ mload(add(context, 0x2d80)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_11*(f_0(x) - f_0(g^11 * z)) / (x - g^11 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^11 * z)^(-1)*/ mload(add(denominatorsPtr, 0x160)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[11]*/ mload(add(context, 0x2da0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_12*(f_0(x) - f_0(g^12 * z)) / (x - g^12 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^12 * z)^(-1)*/ mload(add(denominatorsPtr, 0x180)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[12]*/ mload(add(context, 0x2dc0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_13*(f_0(x) - f_0(g^13 * z)) / (x - g^13 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^13 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[13]*/ mload(add(context, 0x2de0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_14*(f_0(x) - f_0(g^14 * z)) / (x - g^14 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^14 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[14]*/ mload(add(context, 0x2e00)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_15*(f_0(x) - f_0(g^15 * z)) / (x - g^15 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^15 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[15]*/ mload(add(context, 0x2e20)))),
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
                           add(columnValue, sub(PRIME, /*oods_values[16]*/ mload(add(context, 0x2e40)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_17*(f_1(x) - f_1(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[17]*/ mload(add(context, 0x2e60)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_18*(f_1(x) - f_1(g^2 * z)) / (x - g^2 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2 * z)^(-1)*/ mload(add(denominatorsPtr, 0x40)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[18]*/ mload(add(context, 0x2e80)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_19*(f_1(x) - f_1(g^4 * z)) / (x - g^4 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4 * z)^(-1)*/ mload(add(denominatorsPtr, 0x80)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[19]*/ mload(add(context, 0x2ea0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_20*(f_1(x) - f_1(g^6 * z)) / (x - g^6 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^6 * z)^(-1)*/ mload(add(denominatorsPtr, 0xc0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[20]*/ mload(add(context, 0x2ec0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_21*(f_1(x) - f_1(g^8 * z)) / (x - g^8 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8 * z)^(-1)*/ mload(add(denominatorsPtr, 0x100)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[21]*/ mload(add(context, 0x2ee0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_22*(f_1(x) - f_1(g^10 * z)) / (x - g^10 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^10 * z)^(-1)*/ mload(add(denominatorsPtr, 0x140)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[22]*/ mload(add(context, 0x2f00)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_23*(f_1(x) - f_1(g^12 * z)) / (x - g^12 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^12 * z)^(-1)*/ mload(add(denominatorsPtr, 0x180)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[23]*/ mload(add(context, 0x2f20)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_24*(f_1(x) - f_1(g^14 * z)) / (x - g^14 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^14 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[24]*/ mload(add(context, 0x2f40)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_25*(f_1(x) - f_1(g^16 * z)) / (x - g^16 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16 * z)^(-1)*/ mload(add(denominatorsPtr, 0x200)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[25]*/ mload(add(context, 0x2f60)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_26*(f_1(x) - f_1(g^18 * z)) / (x - g^18 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^18 * z)^(-1)*/ mload(add(denominatorsPtr, 0x240)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[26]*/ mload(add(context, 0x2f80)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_27*(f_1(x) - f_1(g^20 * z)) / (x - g^20 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^20 * z)^(-1)*/ mload(add(denominatorsPtr, 0x260)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[27]*/ mload(add(context, 0x2fa0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_28*(f_1(x) - f_1(g^22 * z)) / (x - g^22 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^22 * z)^(-1)*/ mload(add(denominatorsPtr, 0x280)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[28]*/ mload(add(context, 0x2fc0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_29*(f_1(x) - f_1(g^24 * z)) / (x - g^24 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^24 * z)^(-1)*/ mload(add(denominatorsPtr, 0x2a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[29]*/ mload(add(context, 0x2fe0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_30*(f_1(x) - f_1(g^26 * z)) / (x - g^26 * z).
                res := addmod(
                    res,
                    mulmod(mulmod(/*(x - g^26 * z)^(-1)*/ mload(add(denominatorsPtr, 0x2e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[30]*/ mload(add(context, 0x3000)))),
                           PRIME),
                    PRIME)
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_31*(f_1(x) - f_1(g^28 * z)) / (x - g^28 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^28 * z)^(-1)*/ mload(add(denominatorsPtr, 0x320)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[31]*/ mload(add(context, 0x3020)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_32*(f_1(x) - f_1(g^30 * z)) / (x - g^30 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^30 * z)^(-1)*/ mload(add(denominatorsPtr, 0x340)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[32]*/ mload(add(context, 0x3040)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_33*(f_1(x) - f_1(g^32 * z)) / (x - g^32 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^32 * z)^(-1)*/ mload(add(denominatorsPtr, 0x360)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[33]*/ mload(add(context, 0x3060)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_34*(f_1(x) - f_1(g^33 * z)) / (x - g^33 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^33 * z)^(-1)*/ mload(add(denominatorsPtr, 0x380)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[34]*/ mload(add(context, 0x3080)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_35*(f_1(x) - f_1(g^64 * z)) / (x - g^64 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^64 * z)^(-1)*/ mload(add(denominatorsPtr, 0x440)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[35]*/ mload(add(context, 0x30a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_36*(f_1(x) - f_1(g^65 * z)) / (x - g^65 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^65 * z)^(-1)*/ mload(add(denominatorsPtr, 0x460)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[36]*/ mload(add(context, 0x30c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_37*(f_1(x) - f_1(g^88 * z)) / (x - g^88 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^88 * z)^(-1)*/ mload(add(denominatorsPtr, 0x4e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[37]*/ mload(add(context, 0x30e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_38*(f_1(x) - f_1(g^90 * z)) / (x - g^90 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^90 * z)^(-1)*/ mload(add(denominatorsPtr, 0x500)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[38]*/ mload(add(context, 0x3100)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_39*(f_1(x) - f_1(g^92 * z)) / (x - g^92 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^92 * z)^(-1)*/ mload(add(denominatorsPtr, 0x540)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[39]*/ mload(add(context, 0x3120)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_40*(f_1(x) - f_1(g^94 * z)) / (x - g^94 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^94 * z)^(-1)*/ mload(add(denominatorsPtr, 0x560)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[40]*/ mload(add(context, 0x3140)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_41*(f_1(x) - f_1(g^96 * z)) / (x - g^96 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^96 * z)^(-1)*/ mload(add(denominatorsPtr, 0x580)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[41]*/ mload(add(context, 0x3160)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_42*(f_1(x) - f_1(g^97 * z)) / (x - g^97 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^97 * z)^(-1)*/ mload(add(denominatorsPtr, 0x5a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[42]*/ mload(add(context, 0x3180)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_43*(f_1(x) - f_1(g^120 * z)) / (x - g^120 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^120 * z)^(-1)*/ mload(add(denominatorsPtr, 0x5e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[43]*/ mload(add(context, 0x31a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_44*(f_1(x) - f_1(g^122 * z)) / (x - g^122 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^122 * z)^(-1)*/ mload(add(denominatorsPtr, 0x600)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[44]*/ mload(add(context, 0x31c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_45*(f_1(x) - f_1(g^124 * z)) / (x - g^124 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^124 * z)^(-1)*/ mload(add(denominatorsPtr, 0x640)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[45]*/ mload(add(context, 0x31e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_46*(f_1(x) - f_1(g^126 * z)) / (x - g^126 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^126 * z)^(-1)*/ mload(add(denominatorsPtr, 0x660)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[46]*/ mload(add(context, 0x3200)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Mask items for column #2.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x40)), kMontgomeryRInv, PRIME)

                // res += c_47*(f_2(x) - f_2(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[47]*/ mload(add(context, 0x3220)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_48*(f_2(x) - f_2(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[48]*/ mload(add(context, 0x3240)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Mask items for column #3.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x60)), kMontgomeryRInv, PRIME)

                // res += c_49*(f_3(x) - f_3(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[49]*/ mload(add(context, 0x3260)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_50*(f_3(x) - f_3(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[50]*/ mload(add(context, 0x3280)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_51*(f_3(x) - f_3(g^2 * z)) / (x - g^2 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2 * z)^(-1)*/ mload(add(denominatorsPtr, 0x40)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[51]*/ mload(add(context, 0x32a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_52*(f_3(x) - f_3(g^3 * z)) / (x - g^3 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3 * z)^(-1)*/ mload(add(denominatorsPtr, 0x60)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[52]*/ mload(add(context, 0x32c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_53*(f_3(x) - f_3(g^4 * z)) / (x - g^4 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4 * z)^(-1)*/ mload(add(denominatorsPtr, 0x80)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[53]*/ mload(add(context, 0x32e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_54*(f_3(x) - f_3(g^5 * z)) / (x - g^5 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^5 * z)^(-1)*/ mload(add(denominatorsPtr, 0xa0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[54]*/ mload(add(context, 0x3300)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_55*(f_3(x) - f_3(g^8 * z)) / (x - g^8 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8 * z)^(-1)*/ mload(add(denominatorsPtr, 0x100)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[55]*/ mload(add(context, 0x3320)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_56*(f_3(x) - f_3(g^9 * z)) / (x - g^9 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^9 * z)^(-1)*/ mload(add(denominatorsPtr, 0x120)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[56]*/ mload(add(context, 0x3340)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_57*(f_3(x) - f_3(g^10 * z)) / (x - g^10 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^10 * z)^(-1)*/ mload(add(denominatorsPtr, 0x140)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[57]*/ mload(add(context, 0x3360)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_58*(f_3(x) - f_3(g^11 * z)) / (x - g^11 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^11 * z)^(-1)*/ mload(add(denominatorsPtr, 0x160)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[58]*/ mload(add(context, 0x3380)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_59*(f_3(x) - f_3(g^12 * z)) / (x - g^12 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^12 * z)^(-1)*/ mload(add(denominatorsPtr, 0x180)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[59]*/ mload(add(context, 0x33a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_60*(f_3(x) - f_3(g^13 * z)) / (x - g^13 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^13 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[60]*/ mload(add(context, 0x33c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_61*(f_3(x) - f_3(g^16 * z)) / (x - g^16 * z).
                res := addmod(
                    res,
                    mulmod(mulmod(/*(x - g^16 * z)^(-1)*/ mload(add(denominatorsPtr, 0x200)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[61]*/ mload(add(context, 0x33e0)))),
                           PRIME),
                    PRIME)
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_62*(f_3(x) - f_3(g^26 * z)) / (x - g^26 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^26 * z)^(-1)*/ mload(add(denominatorsPtr, 0x2e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[62]*/ mload(add(context, 0x3400)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_63*(f_3(x) - f_3(g^27 * z)) / (x - g^27 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^27 * z)^(-1)*/ mload(add(denominatorsPtr, 0x300)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[63]*/ mload(add(context, 0x3420)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_64*(f_3(x) - f_3(g^42 * z)) / (x - g^42 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^42 * z)^(-1)*/ mload(add(denominatorsPtr, 0x3a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[64]*/ mload(add(context, 0x3440)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_65*(f_3(x) - f_3(g^43 * z)) / (x - g^43 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^43 * z)^(-1)*/ mload(add(denominatorsPtr, 0x3c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[65]*/ mload(add(context, 0x3460)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_66*(f_3(x) - f_3(g^58 * z)) / (x - g^58 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^58 * z)^(-1)*/ mload(add(denominatorsPtr, 0x400)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[66]*/ mload(add(context, 0x3480)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_67*(f_3(x) - f_3(g^74 * z)) / (x - g^74 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^74 * z)^(-1)*/ mload(add(denominatorsPtr, 0x480)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[67]*/ mload(add(context, 0x34a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_68*(f_3(x) - f_3(g^75 * z)) / (x - g^75 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^75 * z)^(-1)*/ mload(add(denominatorsPtr, 0x4a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[68]*/ mload(add(context, 0x34c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_69*(f_3(x) - f_3(g^91 * z)) / (x - g^91 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^91 * z)^(-1)*/ mload(add(denominatorsPtr, 0x520)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[69]*/ mload(add(context, 0x34e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_70*(f_3(x) - f_3(g^122 * z)) / (x - g^122 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^122 * z)^(-1)*/ mload(add(denominatorsPtr, 0x600)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[70]*/ mload(add(context, 0x3500)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_71*(f_3(x) - f_3(g^123 * z)) / (x - g^123 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^123 * z)^(-1)*/ mload(add(denominatorsPtr, 0x620)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[71]*/ mload(add(context, 0x3520)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_72*(f_3(x) - f_3(g^154 * z)) / (x - g^154 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^154 * z)^(-1)*/ mload(add(denominatorsPtr, 0x680)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[72]*/ mload(add(context, 0x3540)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_73*(f_3(x) - f_3(g^202 * z)) / (x - g^202 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^202 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[73]*/ mload(add(context, 0x3560)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_74*(f_3(x) - f_3(g^522 * z)) / (x - g^522 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^522 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[74]*/ mload(add(context, 0x3580)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_75*(f_3(x) - f_3(g^523 * z)) / (x - g^523 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^523 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[75]*/ mload(add(context, 0x35a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_76*(f_3(x) - f_3(g^1034 * z)) / (x - g^1034 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^1034 * z)^(-1)*/ mload(add(denominatorsPtr, 0x880)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[76]*/ mload(add(context, 0x35c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_77*(f_3(x) - f_3(g^1035 * z)) / (x - g^1035 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^1035 * z)^(-1)*/ mload(add(denominatorsPtr, 0x8a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[77]*/ mload(add(context, 0x35e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_78*(f_3(x) - f_3(g^2058 * z)) / (x - g^2058 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2058 * z)^(-1)*/ mload(add(denominatorsPtr, 0x8e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[78]*/ mload(add(context, 0x3600)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Mask items for column #4.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x80)), kMontgomeryRInv, PRIME)

                // res += c_79*(f_4(x) - f_4(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[79]*/ mload(add(context, 0x3620)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_80*(f_4(x) - f_4(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[80]*/ mload(add(context, 0x3640)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_81*(f_4(x) - f_4(g^2 * z)) / (x - g^2 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2 * z)^(-1)*/ mload(add(denominatorsPtr, 0x40)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[81]*/ mload(add(context, 0x3660)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_82*(f_4(x) - f_4(g^3 * z)) / (x - g^3 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3 * z)^(-1)*/ mload(add(denominatorsPtr, 0x60)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[82]*/ mload(add(context, 0x3680)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Mask items for column #5.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0xa0)), kMontgomeryRInv, PRIME)

                // res += c_83*(f_5(x) - f_5(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[83]*/ mload(add(context, 0x36a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_84*(f_5(x) - f_5(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[84]*/ mload(add(context, 0x36c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_85*(f_5(x) - f_5(g^2 * z)) / (x - g^2 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2 * z)^(-1)*/ mload(add(denominatorsPtr, 0x40)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[85]*/ mload(add(context, 0x36e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_86*(f_5(x) - f_5(g^3 * z)) / (x - g^3 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3 * z)^(-1)*/ mload(add(denominatorsPtr, 0x60)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[86]*/ mload(add(context, 0x3700)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_87*(f_5(x) - f_5(g^4 * z)) / (x - g^4 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4 * z)^(-1)*/ mload(add(denominatorsPtr, 0x80)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[87]*/ mload(add(context, 0x3720)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_88*(f_5(x) - f_5(g^5 * z)) / (x - g^5 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^5 * z)^(-1)*/ mload(add(denominatorsPtr, 0xa0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[88]*/ mload(add(context, 0x3740)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_89*(f_5(x) - f_5(g^6 * z)) / (x - g^6 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^6 * z)^(-1)*/ mload(add(denominatorsPtr, 0xc0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[89]*/ mload(add(context, 0x3760)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_90*(f_5(x) - f_5(g^7 * z)) / (x - g^7 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^7 * z)^(-1)*/ mload(add(denominatorsPtr, 0xe0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[90]*/ mload(add(context, 0x3780)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_91*(f_5(x) - f_5(g^8 * z)) / (x - g^8 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8 * z)^(-1)*/ mload(add(denominatorsPtr, 0x100)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[91]*/ mload(add(context, 0x37a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_92*(f_5(x) - f_5(g^12 * z)) / (x - g^12 * z).
                res := addmod(
                    res,
                    mulmod(mulmod(/*(x - g^12 * z)^(-1)*/ mload(add(denominatorsPtr, 0x180)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[92]*/ mload(add(context, 0x37c0)))),
                           PRIME),
                    PRIME)
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_93*(f_5(x) - f_5(g^28 * z)) / (x - g^28 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^28 * z)^(-1)*/ mload(add(denominatorsPtr, 0x320)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[93]*/ mload(add(context, 0x37e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_94*(f_5(x) - f_5(g^44 * z)) / (x - g^44 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^44 * z)^(-1)*/ mload(add(denominatorsPtr, 0x3e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[94]*/ mload(add(context, 0x3800)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_95*(f_5(x) - f_5(g^60 * z)) / (x - g^60 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^60 * z)^(-1)*/ mload(add(denominatorsPtr, 0x420)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[95]*/ mload(add(context, 0x3820)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_96*(f_5(x) - f_5(g^76 * z)) / (x - g^76 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^76 * z)^(-1)*/ mload(add(denominatorsPtr, 0x4c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[96]*/ mload(add(context, 0x3840)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_97*(f_5(x) - f_5(g^92 * z)) / (x - g^92 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^92 * z)^(-1)*/ mload(add(denominatorsPtr, 0x540)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[97]*/ mload(add(context, 0x3860)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_98*(f_5(x) - f_5(g^108 * z)) / (x - g^108 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^108 * z)^(-1)*/ mload(add(denominatorsPtr, 0x5c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[98]*/ mload(add(context, 0x3880)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_99*(f_5(x) - f_5(g^124 * z)) / (x - g^124 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^124 * z)^(-1)*/ mload(add(denominatorsPtr, 0x640)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[99]*/ mload(add(context, 0x38a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_100*(f_5(x) - f_5(g^1021 * z)) / (x - g^1021 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^1021 * z)^(-1)*/ mload(add(denominatorsPtr, 0x7c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[100]*/ mload(add(context, 0x38c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_101*(f_5(x) - f_5(g^1023 * z)) / (x - g^1023 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^1023 * z)^(-1)*/ mload(add(denominatorsPtr, 0x800)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[101]*/ mload(add(context, 0x38e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_102*(f_5(x) - f_5(g^1025 * z)) / (x - g^1025 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^1025 * z)^(-1)*/ mload(add(denominatorsPtr, 0x840)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[102]*/ mload(add(context, 0x3900)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_103*(f_5(x) - f_5(g^1027 * z)) / (x - g^1027 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^1027 * z)^(-1)*/ mload(add(denominatorsPtr, 0x860)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[103]*/ mload(add(context, 0x3920)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_104*(f_5(x) - f_5(g^2045 * z)) / (x - g^2045 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2045 * z)^(-1)*/ mload(add(denominatorsPtr, 0x8c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[104]*/ mload(add(context, 0x3940)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Mask items for column #6.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0xc0)), kMontgomeryRInv, PRIME)

                // res += c_105*(f_6(x) - f_6(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[105]*/ mload(add(context, 0x3960)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_106*(f_6(x) - f_6(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[106]*/ mload(add(context, 0x3980)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_107*(f_6(x) - f_6(g^2 * z)) / (x - g^2 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2 * z)^(-1)*/ mload(add(denominatorsPtr, 0x40)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[107]*/ mload(add(context, 0x39a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_108*(f_6(x) - f_6(g^3 * z)) / (x - g^3 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3 * z)^(-1)*/ mload(add(denominatorsPtr, 0x60)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[108]*/ mload(add(context, 0x39c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_109*(f_6(x) - f_6(g^4 * z)) / (x - g^4 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4 * z)^(-1)*/ mload(add(denominatorsPtr, 0x80)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[109]*/ mload(add(context, 0x39e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_110*(f_6(x) - f_6(g^5 * z)) / (x - g^5 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^5 * z)^(-1)*/ mload(add(denominatorsPtr, 0xa0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[110]*/ mload(add(context, 0x3a00)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_111*(f_6(x) - f_6(g^7 * z)) / (x - g^7 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^7 * z)^(-1)*/ mload(add(denominatorsPtr, 0xe0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[111]*/ mload(add(context, 0x3a20)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_112*(f_6(x) - f_6(g^9 * z)) / (x - g^9 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^9 * z)^(-1)*/ mload(add(denominatorsPtr, 0x120)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[112]*/ mload(add(context, 0x3a40)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_113*(f_6(x) - f_6(g^11 * z)) / (x - g^11 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^11 * z)^(-1)*/ mload(add(denominatorsPtr, 0x160)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[113]*/ mload(add(context, 0x3a60)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_114*(f_6(x) - f_6(g^13 * z)) / (x - g^13 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^13 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[114]*/ mload(add(context, 0x3a80)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_115*(f_6(x) - f_6(g^17 * z)) / (x - g^17 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^17 * z)^(-1)*/ mload(add(denominatorsPtr, 0x220)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[115]*/ mload(add(context, 0x3aa0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_116*(f_6(x) - f_6(g^25 * z)) / (x - g^25 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^25 * z)^(-1)*/ mload(add(denominatorsPtr, 0x2c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[116]*/ mload(add(context, 0x3ac0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_117*(f_6(x) - f_6(g^768 * z)) / (x - g^768 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^768 * z)^(-1)*/ mload(add(denominatorsPtr, 0x700)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[117]*/ mload(add(context, 0x3ae0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_118*(f_6(x) - f_6(g^772 * z)) / (x - g^772 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^772 * z)^(-1)*/ mload(add(denominatorsPtr, 0x720)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[118]*/ mload(add(context, 0x3b00)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_119*(f_6(x) - f_6(g^784 * z)) / (x - g^784 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^784 * z)^(-1)*/ mload(add(denominatorsPtr, 0x740)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[119]*/ mload(add(context, 0x3b20)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_120*(f_6(x) - f_6(g^788 * z)) / (x - g^788 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^788 * z)^(-1)*/ mload(add(denominatorsPtr, 0x760)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[120]*/ mload(add(context, 0x3b40)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_121*(f_6(x) - f_6(g^1004 * z)) / (x - g^1004 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^1004 * z)^(-1)*/ mload(add(denominatorsPtr, 0x780)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[121]*/ mload(add(context, 0x3b60)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_122*(f_6(x) - f_6(g^1008 * z)) / (x - g^1008 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^1008 * z)^(-1)*/ mload(add(denominatorsPtr, 0x7a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[122]*/ mload(add(context, 0x3b80)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_123*(f_6(x) - f_6(g^1022 * z)) / (x - g^1022 * z).
                res := addmod(
                    res,
                    mulmod(mulmod(/*(x - g^1022 * z)^(-1)*/ mload(add(denominatorsPtr, 0x7e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[123]*/ mload(add(context, 0x3ba0)))),
                           PRIME),
                    PRIME)
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_124*(f_6(x) - f_6(g^1024 * z)) / (x - g^1024 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^1024 * z)^(-1)*/ mload(add(denominatorsPtr, 0x820)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[124]*/ mload(add(context, 0x3bc0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Mask items for column #7.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0xe0)), kMontgomeryRInv, PRIME)

                // res += c_125*(f_7(x) - f_7(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[125]*/ mload(add(context, 0x3be0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_126*(f_7(x) - f_7(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[126]*/ mload(add(context, 0x3c00)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Mask items for column #8.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x100)), kMontgomeryRInv, PRIME)

                // res += c_127*(f_8(x) - f_8(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[127]*/ mload(add(context, 0x3c20)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_128*(f_8(x) - f_8(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[128]*/ mload(add(context, 0x3c40)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Mask items for column #9.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x120)), kMontgomeryRInv, PRIME)

                // res += c_129*(f_9(x) - f_9(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[129]*/ mload(add(context, 0x3c60)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_130*(f_9(x) - f_9(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[130]*/ mload(add(context, 0x3c80)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_131*(f_9(x) - f_9(g^2 * z)) / (x - g^2 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2 * z)^(-1)*/ mload(add(denominatorsPtr, 0x40)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[131]*/ mload(add(context, 0x3ca0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_132*(f_9(x) - f_9(g^5 * z)) / (x - g^5 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^5 * z)^(-1)*/ mload(add(denominatorsPtr, 0xa0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[132]*/ mload(add(context, 0x3cc0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Advance traceQueryResponses by amount read (0x20 * nTraceColumns).
                traceQueryResponses := add(traceQueryResponses, 0x140)

                // Composition constraints.

                {
                // Read the next element.
                let columnValue := mulmod(mload(compositionQueryResponses), kMontgomeryRInv, PRIME)
                // res += c_133*(h_0(x) - C_0(z^2)) / (x - z^2).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z^2)^(-1)*/ mload(add(denominatorsPtr, 0x900)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*composition_oods_values[0]*/ mload(add(context, 0x3ce0)))),
                           PRIME)
                )
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)}

                {
                // Read the next element.
                let columnValue := mulmod(mload(add(compositionQueryResponses, 0x20)), kMontgomeryRInv, PRIME)
                // res += c_134*(h_1(x) - C_1(z^2)) / (x - z^2).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z^2)^(-1)*/ mload(add(denominatorsPtr, 0x900)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*composition_oods_values[1]*/ mload(add(context, 0x3d00)))),
                           PRIME)
                )
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)}

                // Advance compositionQueryResponses by amount read (0x20 * constraintDegree).
                compositionQueryResponses := add(compositionQueryResponses, 0x40)

                // Append the friValue, which is the sum of the out-of-domain-sampling boundary
                // constraints for the trace and composition polynomials, to the friQueue array.
                mstore(add(friQueue, 0x20), mod(res, PRIME))

                // Append the friInvPoint of the current query to the friQueue array.
                mstore(add(friQueue, 0x40), /*friInvPoint*/ mload(add(denominatorsPtr,0x920)))

                // Advance denominatorsPtr by chunk size (0x20 * (2+N_ROWS_IN_MASK)).
                denominatorsPtr := add(denominatorsPtr, 0x940)
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
        //    expmodsAndPoints[0:14] (.expmods) expmods used during calculations of the points below.
        //    expmodsAndPoints[14:86] (.points) points used during the denominators calculation.
        uint256[86] memory expmodsAndPoints;
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

            // expmodsAndPoints.expmods[1] = traceGenerator^4.
            mstore(add(expmodsAndPoints, 0x20),
                   mulmod(mload(expmodsAndPoints), // traceGenerator^2
                          mload(expmodsAndPoints), // traceGenerator^2
                          PRIME))

            // expmodsAndPoints.expmods[2] = traceGenerator^7.
            mstore(add(expmodsAndPoints, 0x40),
                   mulmod(mload(add(expmodsAndPoints, 0x20)), // traceGenerator^4
                          mulmod(mload(expmodsAndPoints), // traceGenerator^2
                                 traceGenerator, // traceGenerator^1
                                 PRIME),
                          PRIME))

            // expmodsAndPoints.expmods[3] = traceGenerator^9.
            mstore(add(expmodsAndPoints, 0x60),
                   mulmod(mload(add(expmodsAndPoints, 0x40)), // traceGenerator^7
                          mload(expmodsAndPoints), // traceGenerator^2
                          PRIME))

            // expmodsAndPoints.expmods[4] = traceGenerator^11.
            mstore(add(expmodsAndPoints, 0x80),
                   mulmod(mload(add(expmodsAndPoints, 0x60)), // traceGenerator^9
                          mload(expmodsAndPoints), // traceGenerator^2
                          PRIME))

            // expmodsAndPoints.expmods[5] = traceGenerator^12.
            mstore(add(expmodsAndPoints, 0xa0),
                   mulmod(mload(add(expmodsAndPoints, 0x80)), // traceGenerator^11
                          traceGenerator, // traceGenerator^1
                          PRIME))

            // expmodsAndPoints.expmods[6] = traceGenerator^13.
            mstore(add(expmodsAndPoints, 0xc0),
                   mulmod(mload(add(expmodsAndPoints, 0xa0)), // traceGenerator^12
                          traceGenerator, // traceGenerator^1
                          PRIME))

            // expmodsAndPoints.expmods[7] = traceGenerator^14.
            mstore(add(expmodsAndPoints, 0xe0),
                   mulmod(mload(add(expmodsAndPoints, 0xc0)), // traceGenerator^13
                          traceGenerator, // traceGenerator^1
                          PRIME))

            // expmodsAndPoints.expmods[8] = traceGenerator^28.
            mstore(add(expmodsAndPoints, 0x100),
                   mulmod(mload(add(expmodsAndPoints, 0xe0)), // traceGenerator^14
                          mload(add(expmodsAndPoints, 0xe0)), // traceGenerator^14
                          PRIME))

            // expmodsAndPoints.expmods[9] = traceGenerator^48.
            mstore(add(expmodsAndPoints, 0x120),
                   mulmod(mload(add(expmodsAndPoints, 0x100)), // traceGenerator^28
                          mulmod(mload(add(expmodsAndPoints, 0xc0)), // traceGenerator^13
                                 mload(add(expmodsAndPoints, 0x40)), // traceGenerator^7
                                 PRIME),
                          PRIME))

            // expmodsAndPoints.expmods[10] = traceGenerator^216.
            mstore(add(expmodsAndPoints, 0x140),
                   mulmod(mload(add(expmodsAndPoints, 0x120)), // traceGenerator^48
                          mulmod(mload(add(expmodsAndPoints, 0x120)), // traceGenerator^48
                                 mulmod(mload(add(expmodsAndPoints, 0x120)), // traceGenerator^48
                                        mulmod(mload(add(expmodsAndPoints, 0x120)), // traceGenerator^48
                                               mulmod(mload(add(expmodsAndPoints, 0xc0)), // traceGenerator^13
                                                      mload(add(expmodsAndPoints, 0x80)), // traceGenerator^11
                                                      PRIME),
                                               PRIME),
                                        PRIME),
                                 PRIME),
                          PRIME))

            // expmodsAndPoints.expmods[11] = traceGenerator^245.
            mstore(add(expmodsAndPoints, 0x160),
                   mulmod(mload(add(expmodsAndPoints, 0x140)), // traceGenerator^216
                          mulmod(mload(add(expmodsAndPoints, 0x100)), // traceGenerator^28
                                 traceGenerator, // traceGenerator^1
                                 PRIME),
                          PRIME))

            // expmodsAndPoints.expmods[12] = traceGenerator^320.
            mstore(add(expmodsAndPoints, 0x180),
                   mulmod(mload(add(expmodsAndPoints, 0x160)), // traceGenerator^245
                          mulmod(mload(add(expmodsAndPoints, 0x120)), // traceGenerator^48
                                 mulmod(mload(add(expmodsAndPoints, 0xe0)), // traceGenerator^14
                                        mload(add(expmodsAndPoints, 0xc0)), // traceGenerator^13
                                        PRIME),
                                 PRIME),
                          PRIME))

            // expmodsAndPoints.expmods[13] = traceGenerator^1010.
            mstore(add(expmodsAndPoints, 0x1a0),
                   mulmod(mload(add(expmodsAndPoints, 0x180)), // traceGenerator^320
                          mulmod(mload(add(expmodsAndPoints, 0x180)), // traceGenerator^320
                                 mulmod(mload(add(expmodsAndPoints, 0x180)), // traceGenerator^320
                                        mulmod(mload(add(expmodsAndPoints, 0x120)), // traceGenerator^48
                                               mload(expmodsAndPoints), // traceGenerator^2
                                               PRIME),
                                        PRIME),
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
              mstore(add(expmodsAndPoints, 0x1c0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[1] = -(g * z).
              mstore(add(expmodsAndPoints, 0x1e0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[2] = -(g^2 * z).
              mstore(add(expmodsAndPoints, 0x200), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[3] = -(g^3 * z).
              mstore(add(expmodsAndPoints, 0x220), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[4] = -(g^4 * z).
              mstore(add(expmodsAndPoints, 0x240), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[5] = -(g^5 * z).
              mstore(add(expmodsAndPoints, 0x260), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[6] = -(g^6 * z).
              mstore(add(expmodsAndPoints, 0x280), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[7] = -(g^7 * z).
              mstore(add(expmodsAndPoints, 0x2a0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[8] = -(g^8 * z).
              mstore(add(expmodsAndPoints, 0x2c0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[9] = -(g^9 * z).
              mstore(add(expmodsAndPoints, 0x2e0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[10] = -(g^10 * z).
              mstore(add(expmodsAndPoints, 0x300), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[11] = -(g^11 * z).
              mstore(add(expmodsAndPoints, 0x320), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[12] = -(g^12 * z).
              mstore(add(expmodsAndPoints, 0x340), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[13] = -(g^13 * z).
              mstore(add(expmodsAndPoints, 0x360), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[14] = -(g^14 * z).
              mstore(add(expmodsAndPoints, 0x380), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[15] = -(g^15 * z).
              mstore(add(expmodsAndPoints, 0x3a0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[16] = -(g^16 * z).
              mstore(add(expmodsAndPoints, 0x3c0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[17] = -(g^17 * z).
              mstore(add(expmodsAndPoints, 0x3e0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[18] = -(g^18 * z).
              mstore(add(expmodsAndPoints, 0x400), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[19] = -(g^20 * z).
              mstore(add(expmodsAndPoints, 0x420), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[20] = -(g^22 * z).
              mstore(add(expmodsAndPoints, 0x440), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[21] = -(g^24 * z).
              mstore(add(expmodsAndPoints, 0x460), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[22] = -(g^25 * z).
              mstore(add(expmodsAndPoints, 0x480), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[23] = -(g^26 * z).
              mstore(add(expmodsAndPoints, 0x4a0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[24] = -(g^27 * z).
              mstore(add(expmodsAndPoints, 0x4c0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[25] = -(g^28 * z).
              mstore(add(expmodsAndPoints, 0x4e0), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[26] = -(g^30 * z).
              mstore(add(expmodsAndPoints, 0x500), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[27] = -(g^32 * z).
              mstore(add(expmodsAndPoints, 0x520), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[28] = -(g^33 * z).
              mstore(add(expmodsAndPoints, 0x540), point)

              // point *= g^9.
              point := mulmod(point, /*traceGenerator^9*/ mload(add(expmodsAndPoints, 0x60)), PRIME)
              // expmods_and_points.points[29] = -(g^42 * z).
              mstore(add(expmodsAndPoints, 0x560), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[30] = -(g^43 * z).
              mstore(add(expmodsAndPoints, 0x580), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[31] = -(g^44 * z).
              mstore(add(expmodsAndPoints, 0x5a0), point)

              // point *= g^14.
              point := mulmod(point, /*traceGenerator^14*/ mload(add(expmodsAndPoints, 0xe0)), PRIME)
              // expmods_and_points.points[32] = -(g^58 * z).
              mstore(add(expmodsAndPoints, 0x5c0), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[33] = -(g^60 * z).
              mstore(add(expmodsAndPoints, 0x5e0), point)

              // point *= g^4.
              point := mulmod(point, /*traceGenerator^4*/ mload(add(expmodsAndPoints, 0x20)), PRIME)
              // expmods_and_points.points[34] = -(g^64 * z).
              mstore(add(expmodsAndPoints, 0x600), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[35] = -(g^65 * z).
              mstore(add(expmodsAndPoints, 0x620), point)

              // point *= g^9.
              point := mulmod(point, /*traceGenerator^9*/ mload(add(expmodsAndPoints, 0x60)), PRIME)
              // expmods_and_points.points[36] = -(g^74 * z).
              mstore(add(expmodsAndPoints, 0x640), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[37] = -(g^75 * z).
              mstore(add(expmodsAndPoints, 0x660), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[38] = -(g^76 * z).
              mstore(add(expmodsAndPoints, 0x680), point)

              // point *= g^12.
              point := mulmod(point, /*traceGenerator^12*/ mload(add(expmodsAndPoints, 0xa0)), PRIME)
              // expmods_and_points.points[39] = -(g^88 * z).
              mstore(add(expmodsAndPoints, 0x6a0), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[40] = -(g^90 * z).
              mstore(add(expmodsAndPoints, 0x6c0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[41] = -(g^91 * z).
              mstore(add(expmodsAndPoints, 0x6e0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[42] = -(g^92 * z).
              mstore(add(expmodsAndPoints, 0x700), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[43] = -(g^94 * z).
              mstore(add(expmodsAndPoints, 0x720), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[44] = -(g^96 * z).
              mstore(add(expmodsAndPoints, 0x740), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[45] = -(g^97 * z).
              mstore(add(expmodsAndPoints, 0x760), point)

              // point *= g^11.
              point := mulmod(point, /*traceGenerator^11*/ mload(add(expmodsAndPoints, 0x80)), PRIME)
              // expmods_and_points.points[46] = -(g^108 * z).
              mstore(add(expmodsAndPoints, 0x780), point)

              // point *= g^12.
              point := mulmod(point, /*traceGenerator^12*/ mload(add(expmodsAndPoints, 0xa0)), PRIME)
              // expmods_and_points.points[47] = -(g^120 * z).
              mstore(add(expmodsAndPoints, 0x7a0), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[48] = -(g^122 * z).
              mstore(add(expmodsAndPoints, 0x7c0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[49] = -(g^123 * z).
              mstore(add(expmodsAndPoints, 0x7e0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[50] = -(g^124 * z).
              mstore(add(expmodsAndPoints, 0x800), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[51] = -(g^126 * z).
              mstore(add(expmodsAndPoints, 0x820), point)

              // point *= g^28.
              point := mulmod(point, /*traceGenerator^28*/ mload(add(expmodsAndPoints, 0x100)), PRIME)
              // expmods_and_points.points[52] = -(g^154 * z).
              mstore(add(expmodsAndPoints, 0x840), point)

              // point *= g^48.
              point := mulmod(point, /*traceGenerator^48*/ mload(add(expmodsAndPoints, 0x120)), PRIME)
              // expmods_and_points.points[53] = -(g^202 * z).
              mstore(add(expmodsAndPoints, 0x860), point)

              // point *= g^320.
              point := mulmod(point, /*traceGenerator^320*/ mload(add(expmodsAndPoints, 0x180)), PRIME)
              // expmods_and_points.points[54] = -(g^522 * z).
              mstore(add(expmodsAndPoints, 0x880), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[55] = -(g^523 * z).
              mstore(add(expmodsAndPoints, 0x8a0), point)

              // point *= g^245.
              point := mulmod(point, /*traceGenerator^245*/ mload(add(expmodsAndPoints, 0x160)), PRIME)
              // expmods_and_points.points[56] = -(g^768 * z).
              mstore(add(expmodsAndPoints, 0x8c0), point)

              // point *= g^4.
              point := mulmod(point, /*traceGenerator^4*/ mload(add(expmodsAndPoints, 0x20)), PRIME)
              // expmods_and_points.points[57] = -(g^772 * z).
              mstore(add(expmodsAndPoints, 0x8e0), point)

              // point *= g^12.
              point := mulmod(point, /*traceGenerator^12*/ mload(add(expmodsAndPoints, 0xa0)), PRIME)
              // expmods_and_points.points[58] = -(g^784 * z).
              mstore(add(expmodsAndPoints, 0x900), point)

              // point *= g^4.
              point := mulmod(point, /*traceGenerator^4*/ mload(add(expmodsAndPoints, 0x20)), PRIME)
              // expmods_and_points.points[59] = -(g^788 * z).
              mstore(add(expmodsAndPoints, 0x920), point)

              // point *= g^216.
              point := mulmod(point, /*traceGenerator^216*/ mload(add(expmodsAndPoints, 0x140)), PRIME)
              // expmods_and_points.points[60] = -(g^1004 * z).
              mstore(add(expmodsAndPoints, 0x940), point)

              // point *= g^4.
              point := mulmod(point, /*traceGenerator^4*/ mload(add(expmodsAndPoints, 0x20)), PRIME)
              // expmods_and_points.points[61] = -(g^1008 * z).
              mstore(add(expmodsAndPoints, 0x960), point)

              // point *= g^13.
              point := mulmod(point, /*traceGenerator^13*/ mload(add(expmodsAndPoints, 0xc0)), PRIME)
              // expmods_and_points.points[62] = -(g^1021 * z).
              mstore(add(expmodsAndPoints, 0x980), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[63] = -(g^1022 * z).
              mstore(add(expmodsAndPoints, 0x9a0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[64] = -(g^1023 * z).
              mstore(add(expmodsAndPoints, 0x9c0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[65] = -(g^1024 * z).
              mstore(add(expmodsAndPoints, 0x9e0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[66] = -(g^1025 * z).
              mstore(add(expmodsAndPoints, 0xa00), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[67] = -(g^1027 * z).
              mstore(add(expmodsAndPoints, 0xa20), point)

              // point *= g^7.
              point := mulmod(point, /*traceGenerator^7*/ mload(add(expmodsAndPoints, 0x40)), PRIME)
              // expmods_and_points.points[68] = -(g^1034 * z).
              mstore(add(expmodsAndPoints, 0xa40), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[69] = -(g^1035 * z).
              mstore(add(expmodsAndPoints, 0xa60), point)

              // point *= g^1010.
              point := mulmod(point, /*traceGenerator^1010*/ mload(add(expmodsAndPoints, 0x1a0)), PRIME)
              // expmods_and_points.points[70] = -(g^2045 * z).
              mstore(add(expmodsAndPoints, 0xa80), point)

              // point *= g^13.
              point := mulmod(point, /*traceGenerator^13*/ mload(add(expmodsAndPoints, 0xc0)), PRIME)
              // expmods_and_points.points[71] = -(g^2058 * z).
              mstore(add(expmodsAndPoints, 0xaa0), point)
            }

            let evalPointsPtr := /*oodsEvalPoints*/ add(context, 0x3d20)
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
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1c0)))
                mstore(productsPtr, partialProduct)
                mstore(valuesPtr, denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1: x - g * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1e0)))
                mstore(add(productsPtr, 0x20), partialProduct)
                mstore(add(valuesPtr, 0x20), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 2: x - g^2 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x200)))
                mstore(add(productsPtr, 0x40), partialProduct)
                mstore(add(valuesPtr, 0x40), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 3: x - g^3 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x220)))
                mstore(add(productsPtr, 0x60), partialProduct)
                mstore(add(valuesPtr, 0x60), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 4: x - g^4 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x240)))
                mstore(add(productsPtr, 0x80), partialProduct)
                mstore(add(valuesPtr, 0x80), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 5: x - g^5 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x260)))
                mstore(add(productsPtr, 0xa0), partialProduct)
                mstore(add(valuesPtr, 0xa0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 6: x - g^6 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x280)))
                mstore(add(productsPtr, 0xc0), partialProduct)
                mstore(add(valuesPtr, 0xc0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 7: x - g^7 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x2a0)))
                mstore(add(productsPtr, 0xe0), partialProduct)
                mstore(add(valuesPtr, 0xe0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 8: x - g^8 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x2c0)))
                mstore(add(productsPtr, 0x100), partialProduct)
                mstore(add(valuesPtr, 0x100), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 9: x - g^9 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x2e0)))
                mstore(add(productsPtr, 0x120), partialProduct)
                mstore(add(valuesPtr, 0x120), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 10: x - g^10 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x300)))
                mstore(add(productsPtr, 0x140), partialProduct)
                mstore(add(valuesPtr, 0x140), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 11: x - g^11 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x320)))
                mstore(add(productsPtr, 0x160), partialProduct)
                mstore(add(valuesPtr, 0x160), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 12: x - g^12 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x340)))
                mstore(add(productsPtr, 0x180), partialProduct)
                mstore(add(valuesPtr, 0x180), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 13: x - g^13 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x360)))
                mstore(add(productsPtr, 0x1a0), partialProduct)
                mstore(add(valuesPtr, 0x1a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 14: x - g^14 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x380)))
                mstore(add(productsPtr, 0x1c0), partialProduct)
                mstore(add(valuesPtr, 0x1c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 15: x - g^15 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x3a0)))
                mstore(add(productsPtr, 0x1e0), partialProduct)
                mstore(add(valuesPtr, 0x1e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16: x - g^16 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x3c0)))
                mstore(add(productsPtr, 0x200), partialProduct)
                mstore(add(valuesPtr, 0x200), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 17: x - g^17 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x3e0)))
                mstore(add(productsPtr, 0x220), partialProduct)
                mstore(add(valuesPtr, 0x220), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 18: x - g^18 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x400)))
                mstore(add(productsPtr, 0x240), partialProduct)
                mstore(add(valuesPtr, 0x240), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 20: x - g^20 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x420)))
                mstore(add(productsPtr, 0x260), partialProduct)
                mstore(add(valuesPtr, 0x260), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 22: x - g^22 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x440)))
                mstore(add(productsPtr, 0x280), partialProduct)
                mstore(add(valuesPtr, 0x280), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 24: x - g^24 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x460)))
                mstore(add(productsPtr, 0x2a0), partialProduct)
                mstore(add(valuesPtr, 0x2a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 25: x - g^25 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x480)))
                mstore(add(productsPtr, 0x2c0), partialProduct)
                mstore(add(valuesPtr, 0x2c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 26: x - g^26 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x4a0)))
                mstore(add(productsPtr, 0x2e0), partialProduct)
                mstore(add(valuesPtr, 0x2e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 27: x - g^27 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x4c0)))
                mstore(add(productsPtr, 0x300), partialProduct)
                mstore(add(valuesPtr, 0x300), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 28: x - g^28 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x4e0)))
                mstore(add(productsPtr, 0x320), partialProduct)
                mstore(add(valuesPtr, 0x320), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 30: x - g^30 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x500)))
                mstore(add(productsPtr, 0x340), partialProduct)
                mstore(add(valuesPtr, 0x340), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 32: x - g^32 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x520)))
                mstore(add(productsPtr, 0x360), partialProduct)
                mstore(add(valuesPtr, 0x360), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 33: x - g^33 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x540)))
                mstore(add(productsPtr, 0x380), partialProduct)
                mstore(add(valuesPtr, 0x380), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 42: x - g^42 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x560)))
                mstore(add(productsPtr, 0x3a0), partialProduct)
                mstore(add(valuesPtr, 0x3a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 43: x - g^43 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x580)))
                mstore(add(productsPtr, 0x3c0), partialProduct)
                mstore(add(valuesPtr, 0x3c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 44: x - g^44 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x5a0)))
                mstore(add(productsPtr, 0x3e0), partialProduct)
                mstore(add(valuesPtr, 0x3e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 58: x - g^58 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x5c0)))
                mstore(add(productsPtr, 0x400), partialProduct)
                mstore(add(valuesPtr, 0x400), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 60: x - g^60 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x5e0)))
                mstore(add(productsPtr, 0x420), partialProduct)
                mstore(add(valuesPtr, 0x420), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 64: x - g^64 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x600)))
                mstore(add(productsPtr, 0x440), partialProduct)
                mstore(add(valuesPtr, 0x440), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 65: x - g^65 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x620)))
                mstore(add(productsPtr, 0x460), partialProduct)
                mstore(add(valuesPtr, 0x460), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 74: x - g^74 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x640)))
                mstore(add(productsPtr, 0x480), partialProduct)
                mstore(add(valuesPtr, 0x480), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 75: x - g^75 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x660)))
                mstore(add(productsPtr, 0x4a0), partialProduct)
                mstore(add(valuesPtr, 0x4a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 76: x - g^76 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x680)))
                mstore(add(productsPtr, 0x4c0), partialProduct)
                mstore(add(valuesPtr, 0x4c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 88: x - g^88 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x6a0)))
                mstore(add(productsPtr, 0x4e0), partialProduct)
                mstore(add(valuesPtr, 0x4e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 90: x - g^90 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x6c0)))
                mstore(add(productsPtr, 0x500), partialProduct)
                mstore(add(valuesPtr, 0x500), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 91: x - g^91 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x6e0)))
                mstore(add(productsPtr, 0x520), partialProduct)
                mstore(add(valuesPtr, 0x520), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 92: x - g^92 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x700)))
                mstore(add(productsPtr, 0x540), partialProduct)
                mstore(add(valuesPtr, 0x540), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 94: x - g^94 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x720)))
                mstore(add(productsPtr, 0x560), partialProduct)
                mstore(add(valuesPtr, 0x560), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 96: x - g^96 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x740)))
                mstore(add(productsPtr, 0x580), partialProduct)
                mstore(add(valuesPtr, 0x580), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 97: x - g^97 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x760)))
                mstore(add(productsPtr, 0x5a0), partialProduct)
                mstore(add(valuesPtr, 0x5a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 108: x - g^108 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x780)))
                mstore(add(productsPtr, 0x5c0), partialProduct)
                mstore(add(valuesPtr, 0x5c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 120: x - g^120 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x7a0)))
                mstore(add(productsPtr, 0x5e0), partialProduct)
                mstore(add(valuesPtr, 0x5e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 122: x - g^122 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x7c0)))
                mstore(add(productsPtr, 0x600), partialProduct)
                mstore(add(valuesPtr, 0x600), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 123: x - g^123 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x7e0)))
                mstore(add(productsPtr, 0x620), partialProduct)
                mstore(add(valuesPtr, 0x620), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 124: x - g^124 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x800)))
                mstore(add(productsPtr, 0x640), partialProduct)
                mstore(add(valuesPtr, 0x640), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 126: x - g^126 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x820)))
                mstore(add(productsPtr, 0x660), partialProduct)
                mstore(add(valuesPtr, 0x660), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 154: x - g^154 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x840)))
                mstore(add(productsPtr, 0x680), partialProduct)
                mstore(add(valuesPtr, 0x680), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 202: x - g^202 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x860)))
                mstore(add(productsPtr, 0x6a0), partialProduct)
                mstore(add(valuesPtr, 0x6a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 522: x - g^522 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x880)))
                mstore(add(productsPtr, 0x6c0), partialProduct)
                mstore(add(valuesPtr, 0x6c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 523: x - g^523 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x8a0)))
                mstore(add(productsPtr, 0x6e0), partialProduct)
                mstore(add(valuesPtr, 0x6e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 768: x - g^768 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x8c0)))
                mstore(add(productsPtr, 0x700), partialProduct)
                mstore(add(valuesPtr, 0x700), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 772: x - g^772 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x8e0)))
                mstore(add(productsPtr, 0x720), partialProduct)
                mstore(add(valuesPtr, 0x720), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 784: x - g^784 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x900)))
                mstore(add(productsPtr, 0x740), partialProduct)
                mstore(add(valuesPtr, 0x740), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 788: x - g^788 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x920)))
                mstore(add(productsPtr, 0x760), partialProduct)
                mstore(add(valuesPtr, 0x760), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1004: x - g^1004 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x940)))
                mstore(add(productsPtr, 0x780), partialProduct)
                mstore(add(valuesPtr, 0x780), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1008: x - g^1008 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x960)))
                mstore(add(productsPtr, 0x7a0), partialProduct)
                mstore(add(valuesPtr, 0x7a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1021: x - g^1021 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x980)))
                mstore(add(productsPtr, 0x7c0), partialProduct)
                mstore(add(valuesPtr, 0x7c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1022: x - g^1022 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x9a0)))
                mstore(add(productsPtr, 0x7e0), partialProduct)
                mstore(add(valuesPtr, 0x7e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1023: x - g^1023 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x9c0)))
                mstore(add(productsPtr, 0x800), partialProduct)
                mstore(add(valuesPtr, 0x800), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1024: x - g^1024 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x9e0)))
                mstore(add(productsPtr, 0x820), partialProduct)
                mstore(add(valuesPtr, 0x820), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1025: x - g^1025 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xa00)))
                mstore(add(productsPtr, 0x840), partialProduct)
                mstore(add(valuesPtr, 0x840), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1027: x - g^1027 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xa20)))
                mstore(add(productsPtr, 0x860), partialProduct)
                mstore(add(valuesPtr, 0x860), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1034: x - g^1034 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xa40)))
                mstore(add(productsPtr, 0x880), partialProduct)
                mstore(add(valuesPtr, 0x880), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1035: x - g^1035 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xa60)))
                mstore(add(productsPtr, 0x8a0), partialProduct)
                mstore(add(valuesPtr, 0x8a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 2045: x - g^2045 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xa80)))
                mstore(add(productsPtr, 0x8c0), partialProduct)
                mstore(add(valuesPtr, 0x8c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 2058: x - g^2058 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xaa0)))
                mstore(add(productsPtr, 0x8e0), partialProduct)
                mstore(add(valuesPtr, 0x8e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate the denominator for the composition polynomial columns: x - z^2.
                let denominator := add(shiftedEvalPoint, minusPointPow)
                mstore(add(productsPtr, 0x900), partialProduct)
                mstore(add(valuesPtr, 0x900), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                // Add evalPoint to batch inverse inputs.
                // inverse(evalPoint) is going to be used by FRI.
                mstore(add(productsPtr, 0x920), partialProduct)
                mstore(add(valuesPtr, 0x920), evalPoint)
                partialProduct := mulmod(partialProduct, evalPoint, PRIME)

                // Advance pointers.
                productsPtr := add(productsPtr, 0x940)
                valuesPtr := add(valuesPtr, 0x940)
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
