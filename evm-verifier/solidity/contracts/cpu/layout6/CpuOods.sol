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
            let traceQueryResponses := /*traceQueryQesponses*/ add(context, 0x5620)

            let compositionQueryResponses := /*composition_query_responses*/ add(context, 0x9220)

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
                let oods_alpha := /*oods_alpha*/ mload(add(context, 0x5600))

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
                           add(columnValue, sub(PRIME, /*oods_values[0]*/ mload(add(context, 0x2e20)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_1*(f_0(x) - f_0(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[1]*/ mload(add(context, 0x2e40)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_2*(f_0(x) - f_0(g^2 * z)) / (x - g^2 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2 * z)^(-1)*/ mload(add(denominatorsPtr, 0x40)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[2]*/ mload(add(context, 0x2e60)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_3*(f_0(x) - f_0(g^3 * z)) / (x - g^3 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3 * z)^(-1)*/ mload(add(denominatorsPtr, 0x60)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[3]*/ mload(add(context, 0x2e80)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_4*(f_0(x) - f_0(g^4 * z)) / (x - g^4 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4 * z)^(-1)*/ mload(add(denominatorsPtr, 0x80)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[4]*/ mload(add(context, 0x2ea0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_5*(f_0(x) - f_0(g^5 * z)) / (x - g^5 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^5 * z)^(-1)*/ mload(add(denominatorsPtr, 0xa0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[5]*/ mload(add(context, 0x2ec0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_6*(f_0(x) - f_0(g^6 * z)) / (x - g^6 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^6 * z)^(-1)*/ mload(add(denominatorsPtr, 0xc0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[6]*/ mload(add(context, 0x2ee0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_7*(f_0(x) - f_0(g^7 * z)) / (x - g^7 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^7 * z)^(-1)*/ mload(add(denominatorsPtr, 0xe0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[7]*/ mload(add(context, 0x2f00)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_8*(f_0(x) - f_0(g^8 * z)) / (x - g^8 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8 * z)^(-1)*/ mload(add(denominatorsPtr, 0x100)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[8]*/ mload(add(context, 0x2f20)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_9*(f_0(x) - f_0(g^9 * z)) / (x - g^9 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^9 * z)^(-1)*/ mload(add(denominatorsPtr, 0x120)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[9]*/ mload(add(context, 0x2f40)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_10*(f_0(x) - f_0(g^10 * z)) / (x - g^10 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^10 * z)^(-1)*/ mload(add(denominatorsPtr, 0x140)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[10]*/ mload(add(context, 0x2f60)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_11*(f_0(x) - f_0(g^11 * z)) / (x - g^11 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^11 * z)^(-1)*/ mload(add(denominatorsPtr, 0x160)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[11]*/ mload(add(context, 0x2f80)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_12*(f_0(x) - f_0(g^12 * z)) / (x - g^12 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^12 * z)^(-1)*/ mload(add(denominatorsPtr, 0x180)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[12]*/ mload(add(context, 0x2fa0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_13*(f_0(x) - f_0(g^13 * z)) / (x - g^13 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^13 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[13]*/ mload(add(context, 0x2fc0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_14*(f_0(x) - f_0(g^14 * z)) / (x - g^14 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^14 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[14]*/ mload(add(context, 0x2fe0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_15*(f_0(x) - f_0(g^15 * z)) / (x - g^15 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^15 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[15]*/ mload(add(context, 0x3000)))),
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
                           add(columnValue, sub(PRIME, /*oods_values[16]*/ mload(add(context, 0x3020)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_17*(f_1(x) - f_1(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[17]*/ mload(add(context, 0x3040)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_18*(f_1(x) - f_1(g^255 * z)) / (x - g^255 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^255 * z)^(-1)*/ mload(add(denominatorsPtr, 0xc20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[18]*/ mload(add(context, 0x3060)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_19*(f_1(x) - f_1(g^256 * z)) / (x - g^256 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^256 * z)^(-1)*/ mload(add(denominatorsPtr, 0xc40)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[19]*/ mload(add(context, 0x3080)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_20*(f_1(x) - f_1(g^511 * z)) / (x - g^511 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^511 * z)^(-1)*/ mload(add(denominatorsPtr, 0xfe0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[20]*/ mload(add(context, 0x30a0)))),
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
                           add(columnValue, sub(PRIME, /*oods_values[21]*/ mload(add(context, 0x30c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_22*(f_2(x) - f_2(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[22]*/ mload(add(context, 0x30e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_23*(f_2(x) - f_2(g^255 * z)) / (x - g^255 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^255 * z)^(-1)*/ mload(add(denominatorsPtr, 0xc20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[23]*/ mload(add(context, 0x3100)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_24*(f_2(x) - f_2(g^256 * z)) / (x - g^256 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^256 * z)^(-1)*/ mload(add(denominatorsPtr, 0xc40)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[24]*/ mload(add(context, 0x3120)))),
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
                           add(columnValue, sub(PRIME, /*oods_values[25]*/ mload(add(context, 0x3140)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_26*(f_3(x) - f_3(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[26]*/ mload(add(context, 0x3160)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_27*(f_3(x) - f_3(g^192 * z)) / (x - g^192 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^192 * z)^(-1)*/ mload(add(denominatorsPtr, 0x980)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[27]*/ mload(add(context, 0x3180)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_28*(f_3(x) - f_3(g^193 * z)) / (x - g^193 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^193 * z)^(-1)*/ mload(add(denominatorsPtr, 0x9a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[28]*/ mload(add(context, 0x31a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_29*(f_3(x) - f_3(g^196 * z)) / (x - g^196 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^196 * z)^(-1)*/ mload(add(denominatorsPtr, 0x9e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[29]*/ mload(add(context, 0x31c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_30*(f_3(x) - f_3(g^197 * z)) / (x - g^197 * z).
                res := addmod(
                    res,
                    mulmod(mulmod(/*(x - g^197 * z)^(-1)*/ mload(add(denominatorsPtr, 0xa00)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[30]*/ mload(add(context, 0x31e0)))),
                           PRIME),
                    PRIME)
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_31*(f_3(x) - f_3(g^251 * z)) / (x - g^251 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^251 * z)^(-1)*/ mload(add(denominatorsPtr, 0xbc0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[31]*/ mload(add(context, 0x3200)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_32*(f_3(x) - f_3(g^252 * z)) / (x - g^252 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^252 * z)^(-1)*/ mload(add(denominatorsPtr, 0xbe0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[32]*/ mload(add(context, 0x3220)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_33*(f_3(x) - f_3(g^256 * z)) / (x - g^256 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^256 * z)^(-1)*/ mload(add(denominatorsPtr, 0xc40)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[33]*/ mload(add(context, 0x3240)))),
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
                           add(columnValue, sub(PRIME, /*oods_values[34]*/ mload(add(context, 0x3260)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_35*(f_4(x) - f_4(g^255 * z)) / (x - g^255 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^255 * z)^(-1)*/ mload(add(denominatorsPtr, 0xc20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[35]*/ mload(add(context, 0x3280)))),
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
                           add(columnValue, sub(PRIME, /*oods_values[36]*/ mload(add(context, 0x32a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_37*(f_5(x) - f_5(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[37]*/ mload(add(context, 0x32c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_38*(f_5(x) - f_5(g^2 * z)) / (x - g^2 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2 * z)^(-1)*/ mload(add(denominatorsPtr, 0x40)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[38]*/ mload(add(context, 0x32e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_39*(f_5(x) - f_5(g^3 * z)) / (x - g^3 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3 * z)^(-1)*/ mload(add(denominatorsPtr, 0x60)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[39]*/ mload(add(context, 0x3300)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_40*(f_5(x) - f_5(g^4 * z)) / (x - g^4 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4 * z)^(-1)*/ mload(add(denominatorsPtr, 0x80)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[40]*/ mload(add(context, 0x3320)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_41*(f_5(x) - f_5(g^5 * z)) / (x - g^5 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^5 * z)^(-1)*/ mload(add(denominatorsPtr, 0xa0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[41]*/ mload(add(context, 0x3340)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_42*(f_5(x) - f_5(g^6 * z)) / (x - g^6 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^6 * z)^(-1)*/ mload(add(denominatorsPtr, 0xc0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[42]*/ mload(add(context, 0x3360)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_43*(f_5(x) - f_5(g^7 * z)) / (x - g^7 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^7 * z)^(-1)*/ mload(add(denominatorsPtr, 0xe0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[43]*/ mload(add(context, 0x3380)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_44*(f_5(x) - f_5(g^8 * z)) / (x - g^8 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8 * z)^(-1)*/ mload(add(denominatorsPtr, 0x100)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[44]*/ mload(add(context, 0x33a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_45*(f_5(x) - f_5(g^9 * z)) / (x - g^9 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^9 * z)^(-1)*/ mload(add(denominatorsPtr, 0x120)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[45]*/ mload(add(context, 0x33c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_46*(f_5(x) - f_5(g^12 * z)) / (x - g^12 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^12 * z)^(-1)*/ mload(add(denominatorsPtr, 0x180)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[46]*/ mload(add(context, 0x33e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_47*(f_5(x) - f_5(g^13 * z)) / (x - g^13 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^13 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[47]*/ mload(add(context, 0x3400)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_48*(f_5(x) - f_5(g^16 * z)) / (x - g^16 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16 * z)^(-1)*/ mload(add(denominatorsPtr, 0x200)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[48]*/ mload(add(context, 0x3420)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_49*(f_5(x) - f_5(g^38 * z)) / (x - g^38 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^38 * z)^(-1)*/ mload(add(denominatorsPtr, 0x3c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[49]*/ mload(add(context, 0x3440)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_50*(f_5(x) - f_5(g^39 * z)) / (x - g^39 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^39 * z)^(-1)*/ mload(add(denominatorsPtr, 0x3e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[50]*/ mload(add(context, 0x3460)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_51*(f_5(x) - f_5(g^70 * z)) / (x - g^70 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^70 * z)^(-1)*/ mload(add(denominatorsPtr, 0x5c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[51]*/ mload(add(context, 0x3480)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_52*(f_5(x) - f_5(g^71 * z)) / (x - g^71 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^71 * z)^(-1)*/ mload(add(denominatorsPtr, 0x5e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[52]*/ mload(add(context, 0x34a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_53*(f_5(x) - f_5(g^102 * z)) / (x - g^102 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^102 * z)^(-1)*/ mload(add(denominatorsPtr, 0x720)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[53]*/ mload(add(context, 0x34c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_54*(f_5(x) - f_5(g^103 * z)) / (x - g^103 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^103 * z)^(-1)*/ mload(add(denominatorsPtr, 0x740)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[54]*/ mload(add(context, 0x34e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_55*(f_5(x) - f_5(g^134 * z)) / (x - g^134 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^134 * z)^(-1)*/ mload(add(denominatorsPtr, 0x840)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[55]*/ mload(add(context, 0x3500)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_56*(f_5(x) - f_5(g^135 * z)) / (x - g^135 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^135 * z)^(-1)*/ mload(add(denominatorsPtr, 0x860)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[56]*/ mload(add(context, 0x3520)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_57*(f_5(x) - f_5(g^167 * z)) / (x - g^167 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^167 * z)^(-1)*/ mload(add(denominatorsPtr, 0x900)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[57]*/ mload(add(context, 0x3540)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_58*(f_5(x) - f_5(g^198 * z)) / (x - g^198 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^198 * z)^(-1)*/ mload(add(denominatorsPtr, 0xa20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[58]*/ mload(add(context, 0x3560)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_59*(f_5(x) - f_5(g^199 * z)) / (x - g^199 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^199 * z)^(-1)*/ mload(add(denominatorsPtr, 0xa40)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[59]*/ mload(add(context, 0x3580)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_60*(f_5(x) - f_5(g^231 * z)) / (x - g^231 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^231 * z)^(-1)*/ mload(add(denominatorsPtr, 0xb20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[60]*/ mload(add(context, 0x35a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_61*(f_5(x) - f_5(g^262 * z)) / (x - g^262 * z).
                res := addmod(
                    res,
                    mulmod(mulmod(/*(x - g^262 * z)^(-1)*/ mload(add(denominatorsPtr, 0xc80)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[61]*/ mload(add(context, 0x35c0)))),
                           PRIME),
                    PRIME)
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_62*(f_5(x) - f_5(g^263 * z)) / (x - g^263 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^263 * z)^(-1)*/ mload(add(denominatorsPtr, 0xca0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[62]*/ mload(add(context, 0x35e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_63*(f_5(x) - f_5(g^295 * z)) / (x - g^295 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^295 * z)^(-1)*/ mload(add(denominatorsPtr, 0xd00)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[63]*/ mload(add(context, 0x3600)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_64*(f_5(x) - f_5(g^326 * z)) / (x - g^326 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^326 * z)^(-1)*/ mload(add(denominatorsPtr, 0xda0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[64]*/ mload(add(context, 0x3620)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_65*(f_5(x) - f_5(g^358 * z)) / (x - g^358 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^358 * z)^(-1)*/ mload(add(denominatorsPtr, 0xe20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[65]*/ mload(add(context, 0x3640)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_66*(f_5(x) - f_5(g^359 * z)) / (x - g^359 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^359 * z)^(-1)*/ mload(add(denominatorsPtr, 0xe40)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[66]*/ mload(add(context, 0x3660)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_67*(f_5(x) - f_5(g^390 * z)) / (x - g^390 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^390 * z)^(-1)*/ mload(add(denominatorsPtr, 0xe60)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[67]*/ mload(add(context, 0x3680)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_68*(f_5(x) - f_5(g^391 * z)) / (x - g^391 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^391 * z)^(-1)*/ mload(add(denominatorsPtr, 0xe80)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[68]*/ mload(add(context, 0x36a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_69*(f_5(x) - f_5(g^454 * z)) / (x - g^454 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^454 * z)^(-1)*/ mload(add(denominatorsPtr, 0xec0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[69]*/ mload(add(context, 0x36c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_70*(f_5(x) - f_5(g^518 * z)) / (x - g^518 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^518 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1020)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[70]*/ mload(add(context, 0x36e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_71*(f_5(x) - f_5(g^550 * z)) / (x - g^550 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^550 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1060)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[71]*/ mload(add(context, 0x3700)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_72*(f_5(x) - f_5(g^711 * z)) / (x - g^711 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^711 * z)^(-1)*/ mload(add(denominatorsPtr, 0x10a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[72]*/ mload(add(context, 0x3720)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_73*(f_5(x) - f_5(g^902 * z)) / (x - g^902 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^902 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1160)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[73]*/ mload(add(context, 0x3740)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_74*(f_5(x) - f_5(g^903 * z)) / (x - g^903 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^903 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1180)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[74]*/ mload(add(context, 0x3760)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_75*(f_5(x) - f_5(g^966 * z)) / (x - g^966 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^966 * z)^(-1)*/ mload(add(denominatorsPtr, 0x11c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[75]*/ mload(add(context, 0x3780)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_76*(f_5(x) - f_5(g^967 * z)) / (x - g^967 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^967 * z)^(-1)*/ mload(add(denominatorsPtr, 0x11e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[76]*/ mload(add(context, 0x37a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_77*(f_5(x) - f_5(g^1222 * z)) / (x - g^1222 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^1222 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1260)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[77]*/ mload(add(context, 0x37c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_78*(f_5(x) - f_5(g^2438 * z)) / (x - g^2438 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2438 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1280)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[78]*/ mload(add(context, 0x37e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_79*(f_5(x) - f_5(g^2439 * z)) / (x - g^2439 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2439 * z)^(-1)*/ mload(add(denominatorsPtr, 0x12a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[79]*/ mload(add(context, 0x3800)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_80*(f_5(x) - f_5(g^4486 * z)) / (x - g^4486 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4486 * z)^(-1)*/ mload(add(denominatorsPtr, 0x12c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[80]*/ mload(add(context, 0x3820)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_81*(f_5(x) - f_5(g^4487 * z)) / (x - g^4487 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4487 * z)^(-1)*/ mload(add(denominatorsPtr, 0x12e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[81]*/ mload(add(context, 0x3840)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_82*(f_5(x) - f_5(g^6534 * z)) / (x - g^6534 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^6534 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1300)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[82]*/ mload(add(context, 0x3860)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_83*(f_5(x) - f_5(g^6535 * z)) / (x - g^6535 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^6535 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1320)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[83]*/ mload(add(context, 0x3880)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_84*(f_5(x) - f_5(g^8582 * z)) / (x - g^8582 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8582 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1340)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[84]*/ mload(add(context, 0x38a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_85*(f_5(x) - f_5(g^8583 * z)) / (x - g^8583 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8583 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1360)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[85]*/ mload(add(context, 0x38c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_86*(f_5(x) - f_5(g^10630 * z)) / (x - g^10630 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^10630 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1380)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[86]*/ mload(add(context, 0x38e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_87*(f_5(x) - f_5(g^10631 * z)) / (x - g^10631 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^10631 * z)^(-1)*/ mload(add(denominatorsPtr, 0x13a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[87]*/ mload(add(context, 0x3900)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_88*(f_5(x) - f_5(g^12678 * z)) / (x - g^12678 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^12678 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1440)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[88]*/ mload(add(context, 0x3920)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_89*(f_5(x) - f_5(g^12679 * z)) / (x - g^12679 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^12679 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1460)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[89]*/ mload(add(context, 0x3940)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_90*(f_5(x) - f_5(g^14726 * z)) / (x - g^14726 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^14726 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1480)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[90]*/ mload(add(context, 0x3960)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_91*(f_5(x) - f_5(g^14727 * z)) / (x - g^14727 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^14727 * z)^(-1)*/ mload(add(denominatorsPtr, 0x14a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[91]*/ mload(add(context, 0x3980)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_92*(f_5(x) - f_5(g^16774 * z)) / (x - g^16774 * z).
                res := addmod(
                    res,
                    mulmod(mulmod(/*(x - g^16774 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1660)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[92]*/ mload(add(context, 0x39a0)))),
                           PRIME),
                    PRIME)
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_93*(f_5(x) - f_5(g^16775 * z)) / (x - g^16775 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16775 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1680)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[93]*/ mload(add(context, 0x39c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_94*(f_5(x) - f_5(g^24966 * z)) / (x - g^24966 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^24966 * z)^(-1)*/ mload(add(denominatorsPtr, 0x16a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[94]*/ mload(add(context, 0x39e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_95*(f_5(x) - f_5(g^33158 * z)) / (x - g^33158 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^33158 * z)^(-1)*/ mload(add(denominatorsPtr, 0x17c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[95]*/ mload(add(context, 0x3a00)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Mask items for column #6.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0xc0)), kMontgomeryRInv, PRIME)

                // res += c_96*(f_6(x) - f_6(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[96]*/ mload(add(context, 0x3a20)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_97*(f_6(x) - f_6(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[97]*/ mload(add(context, 0x3a40)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_98*(f_6(x) - f_6(g^2 * z)) / (x - g^2 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2 * z)^(-1)*/ mload(add(denominatorsPtr, 0x40)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[98]*/ mload(add(context, 0x3a60)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_99*(f_6(x) - f_6(g^3 * z)) / (x - g^3 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3 * z)^(-1)*/ mload(add(denominatorsPtr, 0x60)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[99]*/ mload(add(context, 0x3a80)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Mask items for column #7.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0xe0)), kMontgomeryRInv, PRIME)

                // res += c_100*(f_7(x) - f_7(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[100]*/ mload(add(context, 0x3aa0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_101*(f_7(x) - f_7(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[101]*/ mload(add(context, 0x3ac0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_102*(f_7(x) - f_7(g^2 * z)) / (x - g^2 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2 * z)^(-1)*/ mload(add(denominatorsPtr, 0x40)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[102]*/ mload(add(context, 0x3ae0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_103*(f_7(x) - f_7(g^3 * z)) / (x - g^3 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3 * z)^(-1)*/ mload(add(denominatorsPtr, 0x60)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[103]*/ mload(add(context, 0x3b00)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_104*(f_7(x) - f_7(g^4 * z)) / (x - g^4 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4 * z)^(-1)*/ mload(add(denominatorsPtr, 0x80)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[104]*/ mload(add(context, 0x3b20)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_105*(f_7(x) - f_7(g^5 * z)) / (x - g^5 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^5 * z)^(-1)*/ mload(add(denominatorsPtr, 0xa0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[105]*/ mload(add(context, 0x3b40)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_106*(f_7(x) - f_7(g^6 * z)) / (x - g^6 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^6 * z)^(-1)*/ mload(add(denominatorsPtr, 0xc0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[106]*/ mload(add(context, 0x3b60)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_107*(f_7(x) - f_7(g^7 * z)) / (x - g^7 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^7 * z)^(-1)*/ mload(add(denominatorsPtr, 0xe0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[107]*/ mload(add(context, 0x3b80)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_108*(f_7(x) - f_7(g^8 * z)) / (x - g^8 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8 * z)^(-1)*/ mload(add(denominatorsPtr, 0x100)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[108]*/ mload(add(context, 0x3ba0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_109*(f_7(x) - f_7(g^9 * z)) / (x - g^9 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^9 * z)^(-1)*/ mload(add(denominatorsPtr, 0x120)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[109]*/ mload(add(context, 0x3bc0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_110*(f_7(x) - f_7(g^11 * z)) / (x - g^11 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^11 * z)^(-1)*/ mload(add(denominatorsPtr, 0x160)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[110]*/ mload(add(context, 0x3be0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_111*(f_7(x) - f_7(g^12 * z)) / (x - g^12 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^12 * z)^(-1)*/ mload(add(denominatorsPtr, 0x180)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[111]*/ mload(add(context, 0x3c00)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_112*(f_7(x) - f_7(g^13 * z)) / (x - g^13 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^13 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[112]*/ mload(add(context, 0x3c20)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_113*(f_7(x) - f_7(g^15 * z)) / (x - g^15 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^15 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[113]*/ mload(add(context, 0x3c40)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_114*(f_7(x) - f_7(g^17 * z)) / (x - g^17 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^17 * z)^(-1)*/ mload(add(denominatorsPtr, 0x220)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[114]*/ mload(add(context, 0x3c60)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_115*(f_7(x) - f_7(g^19 * z)) / (x - g^19 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^19 * z)^(-1)*/ mload(add(denominatorsPtr, 0x240)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[115]*/ mload(add(context, 0x3c80)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_116*(f_7(x) - f_7(g^23 * z)) / (x - g^23 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^23 * z)^(-1)*/ mload(add(denominatorsPtr, 0x2a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[116]*/ mload(add(context, 0x3ca0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_117*(f_7(x) - f_7(g^27 * z)) / (x - g^27 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^27 * z)^(-1)*/ mload(add(denominatorsPtr, 0x300)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[117]*/ mload(add(context, 0x3cc0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_118*(f_7(x) - f_7(g^33 * z)) / (x - g^33 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^33 * z)^(-1)*/ mload(add(denominatorsPtr, 0x360)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[118]*/ mload(add(context, 0x3ce0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_119*(f_7(x) - f_7(g^44 * z)) / (x - g^44 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^44 * z)^(-1)*/ mload(add(denominatorsPtr, 0x440)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[119]*/ mload(add(context, 0x3d00)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_120*(f_7(x) - f_7(g^49 * z)) / (x - g^49 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^49 * z)^(-1)*/ mload(add(denominatorsPtr, 0x4a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[120]*/ mload(add(context, 0x3d20)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_121*(f_7(x) - f_7(g^65 * z)) / (x - g^65 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^65 * z)^(-1)*/ mload(add(denominatorsPtr, 0x580)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[121]*/ mload(add(context, 0x3d40)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_122*(f_7(x) - f_7(g^76 * z)) / (x - g^76 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^76 * z)^(-1)*/ mload(add(denominatorsPtr, 0x620)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[122]*/ mload(add(context, 0x3d60)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_123*(f_7(x) - f_7(g^81 * z)) / (x - g^81 * z).
                res := addmod(
                    res,
                    mulmod(mulmod(/*(x - g^81 * z)^(-1)*/ mload(add(denominatorsPtr, 0x660)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[123]*/ mload(add(context, 0x3d80)))),
                           PRIME),
                    PRIME)
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_124*(f_7(x) - f_7(g^97 * z)) / (x - g^97 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^97 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[124]*/ mload(add(context, 0x3da0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_125*(f_7(x) - f_7(g^108 * z)) / (x - g^108 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^108 * z)^(-1)*/ mload(add(denominatorsPtr, 0x780)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[125]*/ mload(add(context, 0x3dc0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_126*(f_7(x) - f_7(g^113 * z)) / (x - g^113 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^113 * z)^(-1)*/ mload(add(denominatorsPtr, 0x7c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[126]*/ mload(add(context, 0x3de0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_127*(f_7(x) - f_7(g^129 * z)) / (x - g^129 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^129 * z)^(-1)*/ mload(add(denominatorsPtr, 0x820)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[127]*/ mload(add(context, 0x3e00)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_128*(f_7(x) - f_7(g^140 * z)) / (x - g^140 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^140 * z)^(-1)*/ mload(add(denominatorsPtr, 0x880)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[128]*/ mload(add(context, 0x3e20)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_129*(f_7(x) - f_7(g^145 * z)) / (x - g^145 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^145 * z)^(-1)*/ mload(add(denominatorsPtr, 0x8a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[129]*/ mload(add(context, 0x3e40)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_130*(f_7(x) - f_7(g^161 * z)) / (x - g^161 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^161 * z)^(-1)*/ mload(add(denominatorsPtr, 0x8e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[130]*/ mload(add(context, 0x3e60)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_131*(f_7(x) - f_7(g^172 * z)) / (x - g^172 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^172 * z)^(-1)*/ mload(add(denominatorsPtr, 0x920)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[131]*/ mload(add(context, 0x3e80)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_132*(f_7(x) - f_7(g^177 * z)) / (x - g^177 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^177 * z)^(-1)*/ mload(add(denominatorsPtr, 0x940)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[132]*/ mload(add(context, 0x3ea0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_133*(f_7(x) - f_7(g^193 * z)) / (x - g^193 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^193 * z)^(-1)*/ mload(add(denominatorsPtr, 0x9a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[133]*/ mload(add(context, 0x3ec0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_134*(f_7(x) - f_7(g^204 * z)) / (x - g^204 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^204 * z)^(-1)*/ mload(add(denominatorsPtr, 0xa60)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[134]*/ mload(add(context, 0x3ee0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_135*(f_7(x) - f_7(g^209 * z)) / (x - g^209 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^209 * z)^(-1)*/ mload(add(denominatorsPtr, 0xaa0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[135]*/ mload(add(context, 0x3f00)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_136*(f_7(x) - f_7(g^225 * z)) / (x - g^225 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^225 * z)^(-1)*/ mload(add(denominatorsPtr, 0xb00)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[136]*/ mload(add(context, 0x3f20)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_137*(f_7(x) - f_7(g^236 * z)) / (x - g^236 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^236 * z)^(-1)*/ mload(add(denominatorsPtr, 0xb40)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[137]*/ mload(add(context, 0x3f40)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_138*(f_7(x) - f_7(g^241 * z)) / (x - g^241 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^241 * z)^(-1)*/ mload(add(denominatorsPtr, 0xb80)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[138]*/ mload(add(context, 0x3f60)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_139*(f_7(x) - f_7(g^257 * z)) / (x - g^257 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^257 * z)^(-1)*/ mload(add(denominatorsPtr, 0xc60)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[139]*/ mload(add(context, 0x3f80)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_140*(f_7(x) - f_7(g^265 * z)) / (x - g^265 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^265 * z)^(-1)*/ mload(add(denominatorsPtr, 0xcc0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[140]*/ mload(add(context, 0x3fa0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_141*(f_7(x) - f_7(g^491 * z)) / (x - g^491 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^491 * z)^(-1)*/ mload(add(denominatorsPtr, 0xf20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[141]*/ mload(add(context, 0x3fc0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_142*(f_7(x) - f_7(g^499 * z)) / (x - g^499 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^499 * z)^(-1)*/ mload(add(denominatorsPtr, 0xf60)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[142]*/ mload(add(context, 0x3fe0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_143*(f_7(x) - f_7(g^507 * z)) / (x - g^507 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^507 * z)^(-1)*/ mload(add(denominatorsPtr, 0xfa0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[143]*/ mload(add(context, 0x4000)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_144*(f_7(x) - f_7(g^513 * z)) / (x - g^513 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^513 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1000)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[144]*/ mload(add(context, 0x4020)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_145*(f_7(x) - f_7(g^521 * z)) / (x - g^521 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^521 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1040)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[145]*/ mload(add(context, 0x4040)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_146*(f_7(x) - f_7(g^705 * z)) / (x - g^705 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^705 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1080)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[146]*/ mload(add(context, 0x4060)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_147*(f_7(x) - f_7(g^721 * z)) / (x - g^721 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^721 * z)^(-1)*/ mload(add(denominatorsPtr, 0x10c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[147]*/ mload(add(context, 0x4080)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_148*(f_7(x) - f_7(g^737 * z)) / (x - g^737 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^737 * z)^(-1)*/ mload(add(denominatorsPtr, 0x10e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[148]*/ mload(add(context, 0x40a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_149*(f_7(x) - f_7(g^753 * z)) / (x - g^753 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^753 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1100)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[149]*/ mload(add(context, 0x40c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_150*(f_7(x) - f_7(g^769 * z)) / (x - g^769 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^769 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1120)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[150]*/ mload(add(context, 0x40e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_151*(f_7(x) - f_7(g^777 * z)) / (x - g^777 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^777 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1140)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[151]*/ mload(add(context, 0x4100)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_152*(f_7(x) - f_7(g^961 * z)) / (x - g^961 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^961 * z)^(-1)*/ mload(add(denominatorsPtr, 0x11a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[152]*/ mload(add(context, 0x4120)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_153*(f_7(x) - f_7(g^977 * z)) / (x - g^977 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^977 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1200)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[153]*/ mload(add(context, 0x4140)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_154*(f_7(x) - f_7(g^993 * z)) / (x - g^993 * z).
                res := addmod(
                    res,
                    mulmod(mulmod(/*(x - g^993 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1220)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[154]*/ mload(add(context, 0x4160)))),
                           PRIME),
                    PRIME)
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_155*(f_7(x) - f_7(g^1009 * z)) / (x - g^1009 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^1009 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1240)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[155]*/ mload(add(context, 0x4180)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Mask items for column #8.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x100)), kMontgomeryRInv, PRIME)

                // res += c_156*(f_8(x) - f_8(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[156]*/ mload(add(context, 0x41a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_157*(f_8(x) - f_8(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[157]*/ mload(add(context, 0x41c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_158*(f_8(x) - f_8(g^2 * z)) / (x - g^2 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2 * z)^(-1)*/ mload(add(denominatorsPtr, 0x40)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[158]*/ mload(add(context, 0x41e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_159*(f_8(x) - f_8(g^3 * z)) / (x - g^3 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3 * z)^(-1)*/ mload(add(denominatorsPtr, 0x60)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[159]*/ mload(add(context, 0x4200)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_160*(f_8(x) - f_8(g^4 * z)) / (x - g^4 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4 * z)^(-1)*/ mload(add(denominatorsPtr, 0x80)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[160]*/ mload(add(context, 0x4220)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_161*(f_8(x) - f_8(g^5 * z)) / (x - g^5 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^5 * z)^(-1)*/ mload(add(denominatorsPtr, 0xa0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[161]*/ mload(add(context, 0x4240)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_162*(f_8(x) - f_8(g^6 * z)) / (x - g^6 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^6 * z)^(-1)*/ mload(add(denominatorsPtr, 0xc0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[162]*/ mload(add(context, 0x4260)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_163*(f_8(x) - f_8(g^7 * z)) / (x - g^7 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^7 * z)^(-1)*/ mload(add(denominatorsPtr, 0xe0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[163]*/ mload(add(context, 0x4280)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_164*(f_8(x) - f_8(g^8 * z)) / (x - g^8 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8 * z)^(-1)*/ mload(add(denominatorsPtr, 0x100)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[164]*/ mload(add(context, 0x42a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_165*(f_8(x) - f_8(g^9 * z)) / (x - g^9 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^9 * z)^(-1)*/ mload(add(denominatorsPtr, 0x120)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[165]*/ mload(add(context, 0x42c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_166*(f_8(x) - f_8(g^10 * z)) / (x - g^10 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^10 * z)^(-1)*/ mload(add(denominatorsPtr, 0x140)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[166]*/ mload(add(context, 0x42e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_167*(f_8(x) - f_8(g^11 * z)) / (x - g^11 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^11 * z)^(-1)*/ mload(add(denominatorsPtr, 0x160)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[167]*/ mload(add(context, 0x4300)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_168*(f_8(x) - f_8(g^12 * z)) / (x - g^12 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^12 * z)^(-1)*/ mload(add(denominatorsPtr, 0x180)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[168]*/ mload(add(context, 0x4320)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_169*(f_8(x) - f_8(g^13 * z)) / (x - g^13 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^13 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[169]*/ mload(add(context, 0x4340)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_170*(f_8(x) - f_8(g^14 * z)) / (x - g^14 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^14 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[170]*/ mload(add(context, 0x4360)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_171*(f_8(x) - f_8(g^16 * z)) / (x - g^16 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16 * z)^(-1)*/ mload(add(denominatorsPtr, 0x200)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[171]*/ mload(add(context, 0x4380)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_172*(f_8(x) - f_8(g^17 * z)) / (x - g^17 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^17 * z)^(-1)*/ mload(add(denominatorsPtr, 0x220)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[172]*/ mload(add(context, 0x43a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_173*(f_8(x) - f_8(g^19 * z)) / (x - g^19 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^19 * z)^(-1)*/ mload(add(denominatorsPtr, 0x240)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[173]*/ mload(add(context, 0x43c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_174*(f_8(x) - f_8(g^21 * z)) / (x - g^21 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^21 * z)^(-1)*/ mload(add(denominatorsPtr, 0x260)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[174]*/ mload(add(context, 0x43e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_175*(f_8(x) - f_8(g^22 * z)) / (x - g^22 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^22 * z)^(-1)*/ mload(add(denominatorsPtr, 0x280)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[175]*/ mload(add(context, 0x4400)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_176*(f_8(x) - f_8(g^24 * z)) / (x - g^24 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^24 * z)^(-1)*/ mload(add(denominatorsPtr, 0x2c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[176]*/ mload(add(context, 0x4420)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_177*(f_8(x) - f_8(g^25 * z)) / (x - g^25 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^25 * z)^(-1)*/ mload(add(denominatorsPtr, 0x2e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[177]*/ mload(add(context, 0x4440)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_178*(f_8(x) - f_8(g^27 * z)) / (x - g^27 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^27 * z)^(-1)*/ mload(add(denominatorsPtr, 0x300)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[178]*/ mload(add(context, 0x4460)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_179*(f_8(x) - f_8(g^29 * z)) / (x - g^29 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^29 * z)^(-1)*/ mload(add(denominatorsPtr, 0x320)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[179]*/ mload(add(context, 0x4480)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_180*(f_8(x) - f_8(g^30 * z)) / (x - g^30 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^30 * z)^(-1)*/ mload(add(denominatorsPtr, 0x340)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[180]*/ mload(add(context, 0x44a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_181*(f_8(x) - f_8(g^33 * z)) / (x - g^33 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^33 * z)^(-1)*/ mload(add(denominatorsPtr, 0x360)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[181]*/ mload(add(context, 0x44c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_182*(f_8(x) - f_8(g^35 * z)) / (x - g^35 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^35 * z)^(-1)*/ mload(add(denominatorsPtr, 0x380)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[182]*/ mload(add(context, 0x44e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_183*(f_8(x) - f_8(g^37 * z)) / (x - g^37 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^37 * z)^(-1)*/ mload(add(denominatorsPtr, 0x3a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[183]*/ mload(add(context, 0x4500)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_184*(f_8(x) - f_8(g^38 * z)) / (x - g^38 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^38 * z)^(-1)*/ mload(add(denominatorsPtr, 0x3c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[184]*/ mload(add(context, 0x4520)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_185*(f_8(x) - f_8(g^41 * z)) / (x - g^41 * z).
                res := addmod(
                    res,
                    mulmod(mulmod(/*(x - g^41 * z)^(-1)*/ mload(add(denominatorsPtr, 0x400)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[185]*/ mload(add(context, 0x4540)))),
                           PRIME),
                    PRIME)
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_186*(f_8(x) - f_8(g^43 * z)) / (x - g^43 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^43 * z)^(-1)*/ mload(add(denominatorsPtr, 0x420)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[186]*/ mload(add(context, 0x4560)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_187*(f_8(x) - f_8(g^45 * z)) / (x - g^45 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^45 * z)^(-1)*/ mload(add(denominatorsPtr, 0x460)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[187]*/ mload(add(context, 0x4580)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_188*(f_8(x) - f_8(g^46 * z)) / (x - g^46 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^46 * z)^(-1)*/ mload(add(denominatorsPtr, 0x480)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[188]*/ mload(add(context, 0x45a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_189*(f_8(x) - f_8(g^49 * z)) / (x - g^49 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^49 * z)^(-1)*/ mload(add(denominatorsPtr, 0x4a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[189]*/ mload(add(context, 0x45c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_190*(f_8(x) - f_8(g^51 * z)) / (x - g^51 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^51 * z)^(-1)*/ mload(add(denominatorsPtr, 0x4c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[190]*/ mload(add(context, 0x45e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_191*(f_8(x) - f_8(g^53 * z)) / (x - g^53 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^53 * z)^(-1)*/ mload(add(denominatorsPtr, 0x4e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[191]*/ mload(add(context, 0x4600)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_192*(f_8(x) - f_8(g^54 * z)) / (x - g^54 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^54 * z)^(-1)*/ mload(add(denominatorsPtr, 0x500)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[192]*/ mload(add(context, 0x4620)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_193*(f_8(x) - f_8(g^57 * z)) / (x - g^57 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^57 * z)^(-1)*/ mload(add(denominatorsPtr, 0x520)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[193]*/ mload(add(context, 0x4640)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_194*(f_8(x) - f_8(g^59 * z)) / (x - g^59 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^59 * z)^(-1)*/ mload(add(denominatorsPtr, 0x540)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[194]*/ mload(add(context, 0x4660)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_195*(f_8(x) - f_8(g^61 * z)) / (x - g^61 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^61 * z)^(-1)*/ mload(add(denominatorsPtr, 0x560)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[195]*/ mload(add(context, 0x4680)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_196*(f_8(x) - f_8(g^65 * z)) / (x - g^65 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^65 * z)^(-1)*/ mload(add(denominatorsPtr, 0x580)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[196]*/ mload(add(context, 0x46a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_197*(f_8(x) - f_8(g^69 * z)) / (x - g^69 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^69 * z)^(-1)*/ mload(add(denominatorsPtr, 0x5a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[197]*/ mload(add(context, 0x46c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_198*(f_8(x) - f_8(g^71 * z)) / (x - g^71 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^71 * z)^(-1)*/ mload(add(denominatorsPtr, 0x5e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[198]*/ mload(add(context, 0x46e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_199*(f_8(x) - f_8(g^73 * z)) / (x - g^73 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^73 * z)^(-1)*/ mload(add(denominatorsPtr, 0x600)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[199]*/ mload(add(context, 0x4700)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_200*(f_8(x) - f_8(g^77 * z)) / (x - g^77 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^77 * z)^(-1)*/ mload(add(denominatorsPtr, 0x640)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[200]*/ mload(add(context, 0x4720)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_201*(f_8(x) - f_8(g^81 * z)) / (x - g^81 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^81 * z)^(-1)*/ mload(add(denominatorsPtr, 0x660)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[201]*/ mload(add(context, 0x4740)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_202*(f_8(x) - f_8(g^85 * z)) / (x - g^85 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^85 * z)^(-1)*/ mload(add(denominatorsPtr, 0x680)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[202]*/ mload(add(context, 0x4760)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_203*(f_8(x) - f_8(g^89 * z)) / (x - g^89 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^89 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[203]*/ mload(add(context, 0x4780)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_204*(f_8(x) - f_8(g^91 * z)) / (x - g^91 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^91 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[204]*/ mload(add(context, 0x47a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_205*(f_8(x) - f_8(g^97 * z)) / (x - g^97 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^97 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[205]*/ mload(add(context, 0x47c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_206*(f_8(x) - f_8(g^101 * z)) / (x - g^101 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^101 * z)^(-1)*/ mload(add(denominatorsPtr, 0x700)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[206]*/ mload(add(context, 0x47e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_207*(f_8(x) - f_8(g^105 * z)) / (x - g^105 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^105 * z)^(-1)*/ mload(add(denominatorsPtr, 0x760)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[207]*/ mload(add(context, 0x4800)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_208*(f_8(x) - f_8(g^109 * z)) / (x - g^109 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^109 * z)^(-1)*/ mload(add(denominatorsPtr, 0x7a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[208]*/ mload(add(context, 0x4820)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_209*(f_8(x) - f_8(g^113 * z)) / (x - g^113 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^113 * z)^(-1)*/ mload(add(denominatorsPtr, 0x7c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[209]*/ mload(add(context, 0x4840)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_210*(f_8(x) - f_8(g^117 * z)) / (x - g^117 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^117 * z)^(-1)*/ mload(add(denominatorsPtr, 0x7e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[210]*/ mload(add(context, 0x4860)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_211*(f_8(x) - f_8(g^123 * z)) / (x - g^123 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^123 * z)^(-1)*/ mload(add(denominatorsPtr, 0x800)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[211]*/ mload(add(context, 0x4880)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_212*(f_8(x) - f_8(g^155 * z)) / (x - g^155 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^155 * z)^(-1)*/ mload(add(denominatorsPtr, 0x8c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[212]*/ mload(add(context, 0x48a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_213*(f_8(x) - f_8(g^187 * z)) / (x - g^187 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^187 * z)^(-1)*/ mload(add(denominatorsPtr, 0x960)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[213]*/ mload(add(context, 0x48c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_214*(f_8(x) - f_8(g^195 * z)) / (x - g^195 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^195 * z)^(-1)*/ mload(add(denominatorsPtr, 0x9c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[214]*/ mload(add(context, 0x48e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_215*(f_8(x) - f_8(g^205 * z)) / (x - g^205 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^205 * z)^(-1)*/ mload(add(denominatorsPtr, 0xa80)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[215]*/ mload(add(context, 0x4900)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_216*(f_8(x) - f_8(g^219 * z)) / (x - g^219 * z).
                res := addmod(
                    res,
                    mulmod(mulmod(/*(x - g^219 * z)^(-1)*/ mload(add(denominatorsPtr, 0xac0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[216]*/ mload(add(context, 0x4920)))),
                           PRIME),
                    PRIME)
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_217*(f_8(x) - f_8(g^221 * z)) / (x - g^221 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^221 * z)^(-1)*/ mload(add(denominatorsPtr, 0xae0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[217]*/ mload(add(context, 0x4940)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_218*(f_8(x) - f_8(g^237 * z)) / (x - g^237 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^237 * z)^(-1)*/ mload(add(denominatorsPtr, 0xb60)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[218]*/ mload(add(context, 0x4960)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_219*(f_8(x) - f_8(g^245 * z)) / (x - g^245 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^245 * z)^(-1)*/ mload(add(denominatorsPtr, 0xba0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[219]*/ mload(add(context, 0x4980)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_220*(f_8(x) - f_8(g^253 * z)) / (x - g^253 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^253 * z)^(-1)*/ mload(add(denominatorsPtr, 0xc00)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[220]*/ mload(add(context, 0x49a0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_221*(f_8(x) - f_8(g^269 * z)) / (x - g^269 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^269 * z)^(-1)*/ mload(add(denominatorsPtr, 0xce0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[221]*/ mload(add(context, 0x49c0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_222*(f_8(x) - f_8(g^301 * z)) / (x - g^301 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^301 * z)^(-1)*/ mload(add(denominatorsPtr, 0xd20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[222]*/ mload(add(context, 0x49e0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_223*(f_8(x) - f_8(g^309 * z)) / (x - g^309 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^309 * z)^(-1)*/ mload(add(denominatorsPtr, 0xd40)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[223]*/ mload(add(context, 0x4a00)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_224*(f_8(x) - f_8(g^310 * z)) / (x - g^310 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^310 * z)^(-1)*/ mload(add(denominatorsPtr, 0xd60)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[224]*/ mload(add(context, 0x4a20)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_225*(f_8(x) - f_8(g^318 * z)) / (x - g^318 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^318 * z)^(-1)*/ mload(add(denominatorsPtr, 0xd80)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[225]*/ mload(add(context, 0x4a40)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_226*(f_8(x) - f_8(g^326 * z)) / (x - g^326 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^326 * z)^(-1)*/ mload(add(denominatorsPtr, 0xda0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[226]*/ mload(add(context, 0x4a60)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_227*(f_8(x) - f_8(g^334 * z)) / (x - g^334 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^334 * z)^(-1)*/ mload(add(denominatorsPtr, 0xdc0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[227]*/ mload(add(context, 0x4a80)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_228*(f_8(x) - f_8(g^342 * z)) / (x - g^342 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^342 * z)^(-1)*/ mload(add(denominatorsPtr, 0xde0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[228]*/ mload(add(context, 0x4aa0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_229*(f_8(x) - f_8(g^350 * z)) / (x - g^350 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^350 * z)^(-1)*/ mload(add(denominatorsPtr, 0xe00)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[229]*/ mload(add(context, 0x4ac0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_230*(f_8(x) - f_8(g^451 * z)) / (x - g^451 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^451 * z)^(-1)*/ mload(add(denominatorsPtr, 0xea0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[230]*/ mload(add(context, 0x4ae0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_231*(f_8(x) - f_8(g^461 * z)) / (x - g^461 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^461 * z)^(-1)*/ mload(add(denominatorsPtr, 0xee0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[231]*/ mload(add(context, 0x4b00)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_232*(f_8(x) - f_8(g^477 * z)) / (x - g^477 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^477 * z)^(-1)*/ mload(add(denominatorsPtr, 0xf00)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[232]*/ mload(add(context, 0x4b20)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_233*(f_8(x) - f_8(g^493 * z)) / (x - g^493 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^493 * z)^(-1)*/ mload(add(denominatorsPtr, 0xf40)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[233]*/ mload(add(context, 0x4b40)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_234*(f_8(x) - f_8(g^501 * z)) / (x - g^501 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^501 * z)^(-1)*/ mload(add(denominatorsPtr, 0xf80)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[234]*/ mload(add(context, 0x4b60)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_235*(f_8(x) - f_8(g^509 * z)) / (x - g^509 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^509 * z)^(-1)*/ mload(add(denominatorsPtr, 0xfc0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[235]*/ mload(add(context, 0x4b80)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_236*(f_8(x) - f_8(g^12309 * z)) / (x - g^12309 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^12309 * z)^(-1)*/ mload(add(denominatorsPtr, 0x13c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[236]*/ mload(add(context, 0x4ba0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_237*(f_8(x) - f_8(g^12373 * z)) / (x - g^12373 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^12373 * z)^(-1)*/ mload(add(denominatorsPtr, 0x13e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[237]*/ mload(add(context, 0x4bc0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_238*(f_8(x) - f_8(g^12565 * z)) / (x - g^12565 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^12565 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1400)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[238]*/ mload(add(context, 0x4be0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_239*(f_8(x) - f_8(g^12629 * z)) / (x - g^12629 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^12629 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1420)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[239]*/ mload(add(context, 0x4c00)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_240*(f_8(x) - f_8(g^16085 * z)) / (x - g^16085 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16085 * z)^(-1)*/ mload(add(denominatorsPtr, 0x14c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[240]*/ mload(add(context, 0x4c20)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_241*(f_8(x) - f_8(g^16149 * z)) / (x - g^16149 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16149 * z)^(-1)*/ mload(add(denominatorsPtr, 0x14e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[241]*/ mload(add(context, 0x4c40)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_242*(f_8(x) - f_8(g^16325 * z)) / (x - g^16325 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16325 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1500)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[242]*/ mload(add(context, 0x4c60)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_243*(f_8(x) - f_8(g^16331 * z)) / (x - g^16331 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16331 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1520)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[243]*/ mload(add(context, 0x4c80)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_244*(f_8(x) - f_8(g^16337 * z)) / (x - g^16337 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16337 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1540)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[244]*/ mload(add(context, 0x4ca0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_245*(f_8(x) - f_8(g^16339 * z)) / (x - g^16339 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16339 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1560)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[245]*/ mload(add(context, 0x4cc0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_246*(f_8(x) - f_8(g^16355 * z)) / (x - g^16355 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16355 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1580)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[246]*/ mload(add(context, 0x4ce0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_247*(f_8(x) - f_8(g^16357 * z)) / (x - g^16357 * z).
                res := addmod(
                    res,
                    mulmod(mulmod(/*(x - g^16357 * z)^(-1)*/ mload(add(denominatorsPtr, 0x15a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[247]*/ mload(add(context, 0x4d00)))),
                           PRIME),
                    PRIME)
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_248*(f_8(x) - f_8(g^16363 * z)) / (x - g^16363 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16363 * z)^(-1)*/ mload(add(denominatorsPtr, 0x15c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[248]*/ mload(add(context, 0x4d20)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_249*(f_8(x) - f_8(g^16369 * z)) / (x - g^16369 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16369 * z)^(-1)*/ mload(add(denominatorsPtr, 0x15e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[249]*/ mload(add(context, 0x4d40)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_250*(f_8(x) - f_8(g^16371 * z)) / (x - g^16371 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16371 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1600)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[250]*/ mload(add(context, 0x4d60)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_251*(f_8(x) - f_8(g^16385 * z)) / (x - g^16385 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16385 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1620)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[251]*/ mload(add(context, 0x4d80)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_252*(f_8(x) - f_8(g^16417 * z)) / (x - g^16417 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16417 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1640)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[252]*/ mload(add(context, 0x4da0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_253*(f_8(x) - f_8(g^32647 * z)) / (x - g^32647 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^32647 * z)^(-1)*/ mload(add(denominatorsPtr, 0x16c0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[253]*/ mload(add(context, 0x4dc0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_254*(f_8(x) - f_8(g^32667 * z)) / (x - g^32667 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^32667 * z)^(-1)*/ mload(add(denominatorsPtr, 0x16e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[254]*/ mload(add(context, 0x4de0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_255*(f_8(x) - f_8(g^32715 * z)) / (x - g^32715 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^32715 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1700)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[255]*/ mload(add(context, 0x4e00)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_256*(f_8(x) - f_8(g^32721 * z)) / (x - g^32721 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^32721 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1720)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[256]*/ mload(add(context, 0x4e20)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_257*(f_8(x) - f_8(g^32731 * z)) / (x - g^32731 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^32731 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1740)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[257]*/ mload(add(context, 0x4e40)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_258*(f_8(x) - f_8(g^32747 * z)) / (x - g^32747 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^32747 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1760)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[258]*/ mload(add(context, 0x4e60)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_259*(f_8(x) - f_8(g^32753 * z)) / (x - g^32753 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^32753 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1780)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[259]*/ mload(add(context, 0x4e80)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_260*(f_8(x) - f_8(g^32763 * z)) / (x - g^32763 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^32763 * z)^(-1)*/ mload(add(denominatorsPtr, 0x17a0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[260]*/ mload(add(context, 0x4ea0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Mask items for column #9.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x120)), kMontgomeryRInv, PRIME)

                // res += c_261*(f_9(x) - f_9(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[261]*/ mload(add(context, 0x4ec0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_262*(f_9(x) - f_9(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[262]*/ mload(add(context, 0x4ee0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_263*(f_9(x) - f_9(g^2 * z)) / (x - g^2 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2 * z)^(-1)*/ mload(add(denominatorsPtr, 0x40)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[263]*/ mload(add(context, 0x4f00)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_264*(f_9(x) - f_9(g^3 * z)) / (x - g^3 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3 * z)^(-1)*/ mload(add(denominatorsPtr, 0x60)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[264]*/ mload(add(context, 0x4f20)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_265*(f_9(x) - f_9(g^5 * z)) / (x - g^5 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^5 * z)^(-1)*/ mload(add(denominatorsPtr, 0xa0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[265]*/ mload(add(context, 0x4f40)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_266*(f_9(x) - f_9(g^7 * z)) / (x - g^7 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^7 * z)^(-1)*/ mload(add(denominatorsPtr, 0xe0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[266]*/ mload(add(context, 0x4f60)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_267*(f_9(x) - f_9(g^11 * z)) / (x - g^11 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^11 * z)^(-1)*/ mload(add(denominatorsPtr, 0x160)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[267]*/ mload(add(context, 0x4f80)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)

                // res += c_268*(f_9(x) - f_9(g^15 * z)) / (x - g^15 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^15 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[268]*/ mload(add(context, 0x4fa0)))),
                           PRIME))
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)
                }

                // Advance traceQueryResponses by amount read (0x20 * nTraceColumns).
                traceQueryResponses := add(traceQueryResponses, 0x140)

                // Composition constraints.

                {
                // Read the next element.
                let columnValue := mulmod(mload(compositionQueryResponses), kMontgomeryRInv, PRIME)
                // res += c_269*(h_0(x) - C_0(z^2)) / (x - z^2).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z^2)^(-1)*/ mload(add(denominatorsPtr, 0x17e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*composition_oods_values[0]*/ mload(add(context, 0x4fc0)))),
                           PRIME)
                )
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)}

                {
                // Read the next element.
                let columnValue := mulmod(mload(add(compositionQueryResponses, 0x20)), kMontgomeryRInv, PRIME)
                // res += c_270*(h_1(x) - C_1(z^2)) / (x - z^2).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z^2)^(-1)*/ mload(add(denominatorsPtr, 0x17e0)),
                                  oods_alpha_pow,
                                  PRIME),
                           add(columnValue, sub(PRIME, /*composition_oods_values[1]*/ mload(add(context, 0x4fe0)))),
                           PRIME)
                )
                oods_alpha_pow := mulmod(oods_alpha_pow, oods_alpha, PRIME)}

                // Advance compositionQueryResponses by amount read (0x20 * constraintDegree).
                compositionQueryResponses := add(compositionQueryResponses, 0x40)

                // Append the friValue, which is the sum of the out-of-domain-sampling boundary
                // constraints for the trace and composition polynomials, to the friQueue array.
                mstore(add(friQueue, 0x20), mod(res, PRIME))

                // Append the friInvPoint of the current query to the friQueue array.
                mstore(add(friQueue, 0x40), /*friInvPoint*/ mload(add(denominatorsPtr,0x1800)))

                // Advance denominatorsPtr by chunk size (0x20 * (2+N_ROWS_IN_MASK)).
                denominatorsPtr := add(denominatorsPtr, 0x1820)
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
        //    expmodsAndPoints[0:33] (.expmods) expmods used during calculations of the points below.
        //    expmodsAndPoints[33:224] (.points) points used during the denominators calculation.
        uint256[224] memory expmodsAndPoints;
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

            let traceGenerator := /*trace_generator*/ mload(add(context, 0x2d00))
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

            // expmodsAndPoints.expmods[7] = traceGenerator^10.
            mstore(add(expmodsAndPoints, 0xe0),
                   mulmod(mload(add(expmodsAndPoints, 0xc0)), // traceGenerator^8
                          mload(expmodsAndPoints), // traceGenerator^2
                          PRIME))

            // expmodsAndPoints.expmods[8] = traceGenerator^14.
            mstore(add(expmodsAndPoints, 0x100),
                   mulmod(mload(add(expmodsAndPoints, 0xe0)), // traceGenerator^10
                          mload(add(expmodsAndPoints, 0x40)), // traceGenerator^4
                          PRIME))

            // expmodsAndPoints.expmods[9] = traceGenerator^16.
            mstore(add(expmodsAndPoints, 0x120),
                   mulmod(mload(add(expmodsAndPoints, 0x100)), // traceGenerator^14
                          mload(expmodsAndPoints), // traceGenerator^2
                          PRIME))

            // expmodsAndPoints.expmods[10] = traceGenerator^20.
            mstore(add(expmodsAndPoints, 0x140),
                   mulmod(mload(add(expmodsAndPoints, 0x120)), // traceGenerator^16
                          mload(add(expmodsAndPoints, 0x40)), // traceGenerator^4
                          PRIME))

            // expmodsAndPoints.expmods[11] = traceGenerator^26.
            mstore(add(expmodsAndPoints, 0x160),
                   mulmod(mload(add(expmodsAndPoints, 0x140)), // traceGenerator^20
                          mload(add(expmodsAndPoints, 0x80)), // traceGenerator^6
                          PRIME))

            // expmodsAndPoints.expmods[12] = traceGenerator^29.
            mstore(add(expmodsAndPoints, 0x180),
                   mulmod(mload(add(expmodsAndPoints, 0x160)), // traceGenerator^26
                          mload(add(expmodsAndPoints, 0x20)), // traceGenerator^3
                          PRIME))

            // expmodsAndPoints.expmods[13] = traceGenerator^31.
            mstore(add(expmodsAndPoints, 0x1a0),
                   mulmod(mload(add(expmodsAndPoints, 0x180)), // traceGenerator^29
                          mload(expmodsAndPoints), // traceGenerator^2
                          PRIME))

            // expmodsAndPoints.expmods[14] = traceGenerator^32.
            mstore(add(expmodsAndPoints, 0x1c0),
                   mulmod(mload(add(expmodsAndPoints, 0x1a0)), // traceGenerator^31
                          traceGenerator, // traceGenerator^1
                          PRIME))

            // expmodsAndPoints.expmods[15] = traceGenerator^48.
            mstore(add(expmodsAndPoints, 0x1e0),
                   mulmod(mload(add(expmodsAndPoints, 0x1c0)), // traceGenerator^32
                          mload(add(expmodsAndPoints, 0x120)), // traceGenerator^16
                          PRIME))

            // expmodsAndPoints.expmods[16] = traceGenerator^49.
            mstore(add(expmodsAndPoints, 0x200),
                   mulmod(mload(add(expmodsAndPoints, 0x1e0)), // traceGenerator^48
                          traceGenerator, // traceGenerator^1
                          PRIME))

            // expmodsAndPoints.expmods[17] = traceGenerator^58.
            mstore(add(expmodsAndPoints, 0x220),
                   mulmod(mload(add(expmodsAndPoints, 0x1e0)), // traceGenerator^48
                          mload(add(expmodsAndPoints, 0xe0)), // traceGenerator^10
                          PRIME))

            // expmodsAndPoints.expmods[18] = traceGenerator^60.
            mstore(add(expmodsAndPoints, 0x240),
                   mulmod(mload(add(expmodsAndPoints, 0x220)), // traceGenerator^58
                          mload(expmodsAndPoints), // traceGenerator^2
                          PRIME))

            // expmodsAndPoints.expmods[19] = traceGenerator^64.
            mstore(add(expmodsAndPoints, 0x260),
                   mulmod(mload(add(expmodsAndPoints, 0x240)), // traceGenerator^60
                          mload(add(expmodsAndPoints, 0x40)), // traceGenerator^4
                          PRIME))

            // expmodsAndPoints.expmods[20] = traceGenerator^125.
            mstore(add(expmodsAndPoints, 0x280),
                   mulmod(mload(add(expmodsAndPoints, 0x260)), // traceGenerator^64
                          mulmod(mload(add(expmodsAndPoints, 0x240)), // traceGenerator^60
                                 traceGenerator, // traceGenerator^1
                                 PRIME),
                          PRIME))

            // expmodsAndPoints.expmods[21] = traceGenerator^155.
            mstore(add(expmodsAndPoints, 0x2a0),
                   mulmod(mload(add(expmodsAndPoints, 0x280)), // traceGenerator^125
                          mulmod(mload(add(expmodsAndPoints, 0x180)), // traceGenerator^29
                                 traceGenerator, // traceGenerator^1
                                 PRIME),
                          PRIME))

            // expmodsAndPoints.expmods[22] = traceGenerator^176.
            mstore(add(expmodsAndPoints, 0x2c0),
                   mulmod(mload(add(expmodsAndPoints, 0x2a0)), // traceGenerator^155
                          mulmod(mload(add(expmodsAndPoints, 0x140)), // traceGenerator^20
                                 traceGenerator, // traceGenerator^1
                                 PRIME),
                          PRIME))

            // expmodsAndPoints.expmods[23] = traceGenerator^192.
            mstore(add(expmodsAndPoints, 0x2e0),
                   mulmod(mload(add(expmodsAndPoints, 0x2c0)), // traceGenerator^176
                          mload(add(expmodsAndPoints, 0x120)), // traceGenerator^16
                          PRIME))

            // expmodsAndPoints.expmods[24] = traceGenerator^213.
            mstore(add(expmodsAndPoints, 0x300),
                   mulmod(mload(add(expmodsAndPoints, 0x2a0)), // traceGenerator^155
                          mload(add(expmodsAndPoints, 0x220)), // traceGenerator^58
                          PRIME))

            // expmodsAndPoints.expmods[25] = traceGenerator^357.
            mstore(add(expmodsAndPoints, 0x320),
                   mulmod(mload(add(expmodsAndPoints, 0x2c0)), // traceGenerator^176
                          mulmod(mload(add(expmodsAndPoints, 0x2c0)), // traceGenerator^176
                                 mload(add(expmodsAndPoints, 0x60)), // traceGenerator^5
                                 PRIME),
                          PRIME))

            // expmodsAndPoints.expmods[26] = traceGenerator^395.
            mstore(add(expmodsAndPoints, 0x340),
                   mulmod(mload(add(expmodsAndPoints, 0x320)), // traceGenerator^357
                          mulmod(mload(add(expmodsAndPoints, 0x1c0)), // traceGenerator^32
                                 mload(add(expmodsAndPoints, 0x80)), // traceGenerator^6
                                 PRIME),
                          PRIME))

            // expmodsAndPoints.expmods[27] = traceGenerator^1216.
            mstore(add(expmodsAndPoints, 0x360),
                   mulmod(mload(add(expmodsAndPoints, 0x340)), // traceGenerator^395
                          mulmod(mload(add(expmodsAndPoints, 0x340)), // traceGenerator^395
                                 mulmod(mload(add(expmodsAndPoints, 0x340)), // traceGenerator^395
                                        mload(add(expmodsAndPoints, 0x1a0)), // traceGenerator^31
                                        PRIME),
                                 PRIME),
                          PRIME))

            // expmodsAndPoints.expmods[28] = traceGenerator^1358.
            mstore(add(expmodsAndPoints, 0x380),
                   mulmod(mload(add(expmodsAndPoints, 0x360)), // traceGenerator^1216
                          mulmod(mload(add(expmodsAndPoints, 0x280)), // traceGenerator^125
                                 mulmod(mload(add(expmodsAndPoints, 0x120)), // traceGenerator^16
                                        traceGenerator, // traceGenerator^1
                                        PRIME),
                                 PRIME),
                          PRIME))

            // expmodsAndPoints.expmods[29] = traceGenerator^1678.
            mstore(add(expmodsAndPoints, 0x3a0),
                   mulmod(mload(add(expmodsAndPoints, 0x360)), // traceGenerator^1216
                          mulmod(mload(add(expmodsAndPoints, 0x340)), // traceGenerator^395
                                 mulmod(mload(add(expmodsAndPoints, 0x260)), // traceGenerator^64
                                        mload(add(expmodsAndPoints, 0x20)), // traceGenerator^3
                                        PRIME),
                                 PRIME),
                          PRIME))

            // expmodsAndPoints.expmods[30] = traceGenerator^2047.
            mstore(add(expmodsAndPoints, 0x3c0),
                   mulmod(mload(add(expmodsAndPoints, 0x3a0)), // traceGenerator^1678
                          mulmod(mload(add(expmodsAndPoints, 0x300)), // traceGenerator^213
                                 mulmod(mload(add(expmodsAndPoints, 0x2a0)), // traceGenerator^155
                                        traceGenerator, // traceGenerator^1
                                        PRIME),
                                 PRIME),
                          PRIME))

            // expmodsAndPoints.expmods[31] = traceGenerator^7681.
            mstore(add(expmodsAndPoints, 0x3e0),
                   mulmod(mload(add(expmodsAndPoints, 0x3c0)), // traceGenerator^2047
                          mulmod(mload(add(expmodsAndPoints, 0x3c0)), // traceGenerator^2047
                                 mulmod(mload(add(expmodsAndPoints, 0x3c0)), // traceGenerator^2047
                                        mulmod(mload(add(expmodsAndPoints, 0x380)), // traceGenerator^1358
                                               mulmod(mload(add(expmodsAndPoints, 0x2c0)), // traceGenerator^176
                                                      mload(add(expmodsAndPoints, 0x80)), // traceGenerator^6
                                                      PRIME),
                                               PRIME),
                                        PRIME),
                                 PRIME),
                          PRIME))

            // expmodsAndPoints.expmods[32] = traceGenerator^8191.
            mstore(add(expmodsAndPoints, 0x400),
                   mulmod(mload(add(expmodsAndPoints, 0x3e0)), // traceGenerator^7681
                          mulmod(mload(add(expmodsAndPoints, 0x2e0)), // traceGenerator^192
                                 mulmod(mload(add(expmodsAndPoints, 0x2e0)), // traceGenerator^192
                                        mulmod(mload(add(expmodsAndPoints, 0x280)), // traceGenerator^125
                                               traceGenerator, // traceGenerator^1
                                               PRIME),
                                        PRIME),
                                 PRIME),
                          PRIME))

            let oodsPoint := /*oods_point*/ mload(add(context, 0x2d20))
            {
              // point = -z.
              let point := sub(PRIME, oodsPoint)
              // Compute denominators for rows with nonconst mask expression.
              // We compute those first because for the const rows we modify the point variable.

              // Compute denominators for rows with const mask expression.

              // expmods_and_points.points[0] = -z.
              mstore(add(expmodsAndPoints, 0x420), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[1] = -(g * z).
              mstore(add(expmodsAndPoints, 0x440), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[2] = -(g^2 * z).
              mstore(add(expmodsAndPoints, 0x460), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[3] = -(g^3 * z).
              mstore(add(expmodsAndPoints, 0x480), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[4] = -(g^4 * z).
              mstore(add(expmodsAndPoints, 0x4a0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[5] = -(g^5 * z).
              mstore(add(expmodsAndPoints, 0x4c0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[6] = -(g^6 * z).
              mstore(add(expmodsAndPoints, 0x4e0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[7] = -(g^7 * z).
              mstore(add(expmodsAndPoints, 0x500), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[8] = -(g^8 * z).
              mstore(add(expmodsAndPoints, 0x520), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[9] = -(g^9 * z).
              mstore(add(expmodsAndPoints, 0x540), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[10] = -(g^10 * z).
              mstore(add(expmodsAndPoints, 0x560), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[11] = -(g^11 * z).
              mstore(add(expmodsAndPoints, 0x580), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[12] = -(g^12 * z).
              mstore(add(expmodsAndPoints, 0x5a0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[13] = -(g^13 * z).
              mstore(add(expmodsAndPoints, 0x5c0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[14] = -(g^14 * z).
              mstore(add(expmodsAndPoints, 0x5e0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[15] = -(g^15 * z).
              mstore(add(expmodsAndPoints, 0x600), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[16] = -(g^16 * z).
              mstore(add(expmodsAndPoints, 0x620), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[17] = -(g^17 * z).
              mstore(add(expmodsAndPoints, 0x640), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[18] = -(g^19 * z).
              mstore(add(expmodsAndPoints, 0x660), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[19] = -(g^21 * z).
              mstore(add(expmodsAndPoints, 0x680), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[20] = -(g^22 * z).
              mstore(add(expmodsAndPoints, 0x6a0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[21] = -(g^23 * z).
              mstore(add(expmodsAndPoints, 0x6c0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[22] = -(g^24 * z).
              mstore(add(expmodsAndPoints, 0x6e0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[23] = -(g^25 * z).
              mstore(add(expmodsAndPoints, 0x700), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[24] = -(g^27 * z).
              mstore(add(expmodsAndPoints, 0x720), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[25] = -(g^29 * z).
              mstore(add(expmodsAndPoints, 0x740), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[26] = -(g^30 * z).
              mstore(add(expmodsAndPoints, 0x760), point)

              // point *= g^3.
              point := mulmod(point, /*traceGenerator^3*/ mload(add(expmodsAndPoints, 0x20)), PRIME)
              // expmods_and_points.points[27] = -(g^33 * z).
              mstore(add(expmodsAndPoints, 0x780), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[28] = -(g^35 * z).
              mstore(add(expmodsAndPoints, 0x7a0), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[29] = -(g^37 * z).
              mstore(add(expmodsAndPoints, 0x7c0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[30] = -(g^38 * z).
              mstore(add(expmodsAndPoints, 0x7e0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[31] = -(g^39 * z).
              mstore(add(expmodsAndPoints, 0x800), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[32] = -(g^41 * z).
              mstore(add(expmodsAndPoints, 0x820), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[33] = -(g^43 * z).
              mstore(add(expmodsAndPoints, 0x840), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[34] = -(g^44 * z).
              mstore(add(expmodsAndPoints, 0x860), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[35] = -(g^45 * z).
              mstore(add(expmodsAndPoints, 0x880), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[36] = -(g^46 * z).
              mstore(add(expmodsAndPoints, 0x8a0), point)

              // point *= g^3.
              point := mulmod(point, /*traceGenerator^3*/ mload(add(expmodsAndPoints, 0x20)), PRIME)
              // expmods_and_points.points[37] = -(g^49 * z).
              mstore(add(expmodsAndPoints, 0x8c0), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[38] = -(g^51 * z).
              mstore(add(expmodsAndPoints, 0x8e0), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[39] = -(g^53 * z).
              mstore(add(expmodsAndPoints, 0x900), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[40] = -(g^54 * z).
              mstore(add(expmodsAndPoints, 0x920), point)

              // point *= g^3.
              point := mulmod(point, /*traceGenerator^3*/ mload(add(expmodsAndPoints, 0x20)), PRIME)
              // expmods_and_points.points[41] = -(g^57 * z).
              mstore(add(expmodsAndPoints, 0x940), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[42] = -(g^59 * z).
              mstore(add(expmodsAndPoints, 0x960), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[43] = -(g^61 * z).
              mstore(add(expmodsAndPoints, 0x980), point)

              // point *= g^4.
              point := mulmod(point, /*traceGenerator^4*/ mload(add(expmodsAndPoints, 0x40)), PRIME)
              // expmods_and_points.points[44] = -(g^65 * z).
              mstore(add(expmodsAndPoints, 0x9a0), point)

              // point *= g^4.
              point := mulmod(point, /*traceGenerator^4*/ mload(add(expmodsAndPoints, 0x40)), PRIME)
              // expmods_and_points.points[45] = -(g^69 * z).
              mstore(add(expmodsAndPoints, 0x9c0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[46] = -(g^70 * z).
              mstore(add(expmodsAndPoints, 0x9e0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[47] = -(g^71 * z).
              mstore(add(expmodsAndPoints, 0xa00), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[48] = -(g^73 * z).
              mstore(add(expmodsAndPoints, 0xa20), point)

              // point *= g^3.
              point := mulmod(point, /*traceGenerator^3*/ mload(add(expmodsAndPoints, 0x20)), PRIME)
              // expmods_and_points.points[49] = -(g^76 * z).
              mstore(add(expmodsAndPoints, 0xa40), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[50] = -(g^77 * z).
              mstore(add(expmodsAndPoints, 0xa60), point)

              // point *= g^4.
              point := mulmod(point, /*traceGenerator^4*/ mload(add(expmodsAndPoints, 0x40)), PRIME)
              // expmods_and_points.points[51] = -(g^81 * z).
              mstore(add(expmodsAndPoints, 0xa80), point)

              // point *= g^4.
              point := mulmod(point, /*traceGenerator^4*/ mload(add(expmodsAndPoints, 0x40)), PRIME)
              // expmods_and_points.points[52] = -(g^85 * z).
              mstore(add(expmodsAndPoints, 0xaa0), point)

              // point *= g^4.
              point := mulmod(point, /*traceGenerator^4*/ mload(add(expmodsAndPoints, 0x40)), PRIME)
              // expmods_and_points.points[53] = -(g^89 * z).
              mstore(add(expmodsAndPoints, 0xac0), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[54] = -(g^91 * z).
              mstore(add(expmodsAndPoints, 0xae0), point)

              // point *= g^6.
              point := mulmod(point, /*traceGenerator^6*/ mload(add(expmodsAndPoints, 0x80)), PRIME)
              // expmods_and_points.points[55] = -(g^97 * z).
              mstore(add(expmodsAndPoints, 0xb00), point)

              // point *= g^4.
              point := mulmod(point, /*traceGenerator^4*/ mload(add(expmodsAndPoints, 0x40)), PRIME)
              // expmods_and_points.points[56] = -(g^101 * z).
              mstore(add(expmodsAndPoints, 0xb20), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[57] = -(g^102 * z).
              mstore(add(expmodsAndPoints, 0xb40), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[58] = -(g^103 * z).
              mstore(add(expmodsAndPoints, 0xb60), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[59] = -(g^105 * z).
              mstore(add(expmodsAndPoints, 0xb80), point)

              // point *= g^3.
              point := mulmod(point, /*traceGenerator^3*/ mload(add(expmodsAndPoints, 0x20)), PRIME)
              // expmods_and_points.points[60] = -(g^108 * z).
              mstore(add(expmodsAndPoints, 0xba0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[61] = -(g^109 * z).
              mstore(add(expmodsAndPoints, 0xbc0), point)

              // point *= g^4.
              point := mulmod(point, /*traceGenerator^4*/ mload(add(expmodsAndPoints, 0x40)), PRIME)
              // expmods_and_points.points[62] = -(g^113 * z).
              mstore(add(expmodsAndPoints, 0xbe0), point)

              // point *= g^4.
              point := mulmod(point, /*traceGenerator^4*/ mload(add(expmodsAndPoints, 0x40)), PRIME)
              // expmods_and_points.points[63] = -(g^117 * z).
              mstore(add(expmodsAndPoints, 0xc00), point)

              // point *= g^6.
              point := mulmod(point, /*traceGenerator^6*/ mload(add(expmodsAndPoints, 0x80)), PRIME)
              // expmods_and_points.points[64] = -(g^123 * z).
              mstore(add(expmodsAndPoints, 0xc20), point)

              // point *= g^6.
              point := mulmod(point, /*traceGenerator^6*/ mload(add(expmodsAndPoints, 0x80)), PRIME)
              // expmods_and_points.points[65] = -(g^129 * z).
              mstore(add(expmodsAndPoints, 0xc40), point)

              // point *= g^5.
              point := mulmod(point, /*traceGenerator^5*/ mload(add(expmodsAndPoints, 0x60)), PRIME)
              // expmods_and_points.points[66] = -(g^134 * z).
              mstore(add(expmodsAndPoints, 0xc60), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[67] = -(g^135 * z).
              mstore(add(expmodsAndPoints, 0xc80), point)

              // point *= g^5.
              point := mulmod(point, /*traceGenerator^5*/ mload(add(expmodsAndPoints, 0x60)), PRIME)
              // expmods_and_points.points[68] = -(g^140 * z).
              mstore(add(expmodsAndPoints, 0xca0), point)

              // point *= g^5.
              point := mulmod(point, /*traceGenerator^5*/ mload(add(expmodsAndPoints, 0x60)), PRIME)
              // expmods_and_points.points[69] = -(g^145 * z).
              mstore(add(expmodsAndPoints, 0xcc0), point)

              // point *= g^10.
              point := mulmod(point, /*traceGenerator^10*/ mload(add(expmodsAndPoints, 0xe0)), PRIME)
              // expmods_and_points.points[70] = -(g^155 * z).
              mstore(add(expmodsAndPoints, 0xce0), point)

              // point *= g^6.
              point := mulmod(point, /*traceGenerator^6*/ mload(add(expmodsAndPoints, 0x80)), PRIME)
              // expmods_and_points.points[71] = -(g^161 * z).
              mstore(add(expmodsAndPoints, 0xd00), point)

              // point *= g^6.
              point := mulmod(point, /*traceGenerator^6*/ mload(add(expmodsAndPoints, 0x80)), PRIME)
              // expmods_and_points.points[72] = -(g^167 * z).
              mstore(add(expmodsAndPoints, 0xd20), point)

              // point *= g^5.
              point := mulmod(point, /*traceGenerator^5*/ mload(add(expmodsAndPoints, 0x60)), PRIME)
              // expmods_and_points.points[73] = -(g^172 * z).
              mstore(add(expmodsAndPoints, 0xd40), point)

              // point *= g^5.
              point := mulmod(point, /*traceGenerator^5*/ mload(add(expmodsAndPoints, 0x60)), PRIME)
              // expmods_and_points.points[74] = -(g^177 * z).
              mstore(add(expmodsAndPoints, 0xd60), point)

              // point *= g^10.
              point := mulmod(point, /*traceGenerator^10*/ mload(add(expmodsAndPoints, 0xe0)), PRIME)
              // expmods_and_points.points[75] = -(g^187 * z).
              mstore(add(expmodsAndPoints, 0xd80), point)

              // point *= g^5.
              point := mulmod(point, /*traceGenerator^5*/ mload(add(expmodsAndPoints, 0x60)), PRIME)
              // expmods_and_points.points[76] = -(g^192 * z).
              mstore(add(expmodsAndPoints, 0xda0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[77] = -(g^193 * z).
              mstore(add(expmodsAndPoints, 0xdc0), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[78] = -(g^195 * z).
              mstore(add(expmodsAndPoints, 0xde0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[79] = -(g^196 * z).
              mstore(add(expmodsAndPoints, 0xe00), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[80] = -(g^197 * z).
              mstore(add(expmodsAndPoints, 0xe20), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[81] = -(g^198 * z).
              mstore(add(expmodsAndPoints, 0xe40), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[82] = -(g^199 * z).
              mstore(add(expmodsAndPoints, 0xe60), point)

              // point *= g^5.
              point := mulmod(point, /*traceGenerator^5*/ mload(add(expmodsAndPoints, 0x60)), PRIME)
              // expmods_and_points.points[83] = -(g^204 * z).
              mstore(add(expmodsAndPoints, 0xe80), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[84] = -(g^205 * z).
              mstore(add(expmodsAndPoints, 0xea0), point)

              // point *= g^4.
              point := mulmod(point, /*traceGenerator^4*/ mload(add(expmodsAndPoints, 0x40)), PRIME)
              // expmods_and_points.points[85] = -(g^209 * z).
              mstore(add(expmodsAndPoints, 0xec0), point)

              // point *= g^10.
              point := mulmod(point, /*traceGenerator^10*/ mload(add(expmodsAndPoints, 0xe0)), PRIME)
              // expmods_and_points.points[86] = -(g^219 * z).
              mstore(add(expmodsAndPoints, 0xee0), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[87] = -(g^221 * z).
              mstore(add(expmodsAndPoints, 0xf00), point)

              // point *= g^4.
              point := mulmod(point, /*traceGenerator^4*/ mload(add(expmodsAndPoints, 0x40)), PRIME)
              // expmods_and_points.points[88] = -(g^225 * z).
              mstore(add(expmodsAndPoints, 0xf20), point)

              // point *= g^6.
              point := mulmod(point, /*traceGenerator^6*/ mload(add(expmodsAndPoints, 0x80)), PRIME)
              // expmods_and_points.points[89] = -(g^231 * z).
              mstore(add(expmodsAndPoints, 0xf40), point)

              // point *= g^5.
              point := mulmod(point, /*traceGenerator^5*/ mload(add(expmodsAndPoints, 0x60)), PRIME)
              // expmods_and_points.points[90] = -(g^236 * z).
              mstore(add(expmodsAndPoints, 0xf60), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[91] = -(g^237 * z).
              mstore(add(expmodsAndPoints, 0xf80), point)

              // point *= g^4.
              point := mulmod(point, /*traceGenerator^4*/ mload(add(expmodsAndPoints, 0x40)), PRIME)
              // expmods_and_points.points[92] = -(g^241 * z).
              mstore(add(expmodsAndPoints, 0xfa0), point)

              // point *= g^4.
              point := mulmod(point, /*traceGenerator^4*/ mload(add(expmodsAndPoints, 0x40)), PRIME)
              // expmods_and_points.points[93] = -(g^245 * z).
              mstore(add(expmodsAndPoints, 0xfc0), point)

              // point *= g^6.
              point := mulmod(point, /*traceGenerator^6*/ mload(add(expmodsAndPoints, 0x80)), PRIME)
              // expmods_and_points.points[94] = -(g^251 * z).
              mstore(add(expmodsAndPoints, 0xfe0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[95] = -(g^252 * z).
              mstore(add(expmodsAndPoints, 0x1000), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[96] = -(g^253 * z).
              mstore(add(expmodsAndPoints, 0x1020), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[97] = -(g^255 * z).
              mstore(add(expmodsAndPoints, 0x1040), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[98] = -(g^256 * z).
              mstore(add(expmodsAndPoints, 0x1060), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[99] = -(g^257 * z).
              mstore(add(expmodsAndPoints, 0x1080), point)

              // point *= g^5.
              point := mulmod(point, /*traceGenerator^5*/ mload(add(expmodsAndPoints, 0x60)), PRIME)
              // expmods_and_points.points[100] = -(g^262 * z).
              mstore(add(expmodsAndPoints, 0x10a0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[101] = -(g^263 * z).
              mstore(add(expmodsAndPoints, 0x10c0), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[102] = -(g^265 * z).
              mstore(add(expmodsAndPoints, 0x10e0), point)

              // point *= g^4.
              point := mulmod(point, /*traceGenerator^4*/ mload(add(expmodsAndPoints, 0x40)), PRIME)
              // expmods_and_points.points[103] = -(g^269 * z).
              mstore(add(expmodsAndPoints, 0x1100), point)

              // point *= g^26.
              point := mulmod(point, /*traceGenerator^26*/ mload(add(expmodsAndPoints, 0x160)), PRIME)
              // expmods_and_points.points[104] = -(g^295 * z).
              mstore(add(expmodsAndPoints, 0x1120), point)

              // point *= g^6.
              point := mulmod(point, /*traceGenerator^6*/ mload(add(expmodsAndPoints, 0x80)), PRIME)
              // expmods_and_points.points[105] = -(g^301 * z).
              mstore(add(expmodsAndPoints, 0x1140), point)

              // point *= g^8.
              point := mulmod(point, /*traceGenerator^8*/ mload(add(expmodsAndPoints, 0xc0)), PRIME)
              // expmods_and_points.points[106] = -(g^309 * z).
              mstore(add(expmodsAndPoints, 0x1160), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[107] = -(g^310 * z).
              mstore(add(expmodsAndPoints, 0x1180), point)

              // point *= g^8.
              point := mulmod(point, /*traceGenerator^8*/ mload(add(expmodsAndPoints, 0xc0)), PRIME)
              // expmods_and_points.points[108] = -(g^318 * z).
              mstore(add(expmodsAndPoints, 0x11a0), point)

              // point *= g^8.
              point := mulmod(point, /*traceGenerator^8*/ mload(add(expmodsAndPoints, 0xc0)), PRIME)
              // expmods_and_points.points[109] = -(g^326 * z).
              mstore(add(expmodsAndPoints, 0x11c0), point)

              // point *= g^8.
              point := mulmod(point, /*traceGenerator^8*/ mload(add(expmodsAndPoints, 0xc0)), PRIME)
              // expmods_and_points.points[110] = -(g^334 * z).
              mstore(add(expmodsAndPoints, 0x11e0), point)

              // point *= g^8.
              point := mulmod(point, /*traceGenerator^8*/ mload(add(expmodsAndPoints, 0xc0)), PRIME)
              // expmods_and_points.points[111] = -(g^342 * z).
              mstore(add(expmodsAndPoints, 0x1200), point)

              // point *= g^8.
              point := mulmod(point, /*traceGenerator^8*/ mload(add(expmodsAndPoints, 0xc0)), PRIME)
              // expmods_and_points.points[112] = -(g^350 * z).
              mstore(add(expmodsAndPoints, 0x1220), point)

              // point *= g^8.
              point := mulmod(point, /*traceGenerator^8*/ mload(add(expmodsAndPoints, 0xc0)), PRIME)
              // expmods_and_points.points[113] = -(g^358 * z).
              mstore(add(expmodsAndPoints, 0x1240), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[114] = -(g^359 * z).
              mstore(add(expmodsAndPoints, 0x1260), point)

              // point *= g^31.
              point := mulmod(point, /*traceGenerator^31*/ mload(add(expmodsAndPoints, 0x1a0)), PRIME)
              // expmods_and_points.points[115] = -(g^390 * z).
              mstore(add(expmodsAndPoints, 0x1280), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[116] = -(g^391 * z).
              mstore(add(expmodsAndPoints, 0x12a0), point)

              // point *= g^60.
              point := mulmod(point, /*traceGenerator^60*/ mload(add(expmodsAndPoints, 0x240)), PRIME)
              // expmods_and_points.points[117] = -(g^451 * z).
              mstore(add(expmodsAndPoints, 0x12c0), point)

              // point *= g^3.
              point := mulmod(point, /*traceGenerator^3*/ mload(add(expmodsAndPoints, 0x20)), PRIME)
              // expmods_and_points.points[118] = -(g^454 * z).
              mstore(add(expmodsAndPoints, 0x12e0), point)

              // point *= g^7.
              point := mulmod(point, /*traceGenerator^7*/ mload(add(expmodsAndPoints, 0xa0)), PRIME)
              // expmods_and_points.points[119] = -(g^461 * z).
              mstore(add(expmodsAndPoints, 0x1300), point)

              // point *= g^16.
              point := mulmod(point, /*traceGenerator^16*/ mload(add(expmodsAndPoints, 0x120)), PRIME)
              // expmods_and_points.points[120] = -(g^477 * z).
              mstore(add(expmodsAndPoints, 0x1320), point)

              // point *= g^14.
              point := mulmod(point, /*traceGenerator^14*/ mload(add(expmodsAndPoints, 0x100)), PRIME)
              // expmods_and_points.points[121] = -(g^491 * z).
              mstore(add(expmodsAndPoints, 0x1340), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[122] = -(g^493 * z).
              mstore(add(expmodsAndPoints, 0x1360), point)

              // point *= g^6.
              point := mulmod(point, /*traceGenerator^6*/ mload(add(expmodsAndPoints, 0x80)), PRIME)
              // expmods_and_points.points[123] = -(g^499 * z).
              mstore(add(expmodsAndPoints, 0x1380), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[124] = -(g^501 * z).
              mstore(add(expmodsAndPoints, 0x13a0), point)

              // point *= g^6.
              point := mulmod(point, /*traceGenerator^6*/ mload(add(expmodsAndPoints, 0x80)), PRIME)
              // expmods_and_points.points[125] = -(g^507 * z).
              mstore(add(expmodsAndPoints, 0x13c0), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[126] = -(g^509 * z).
              mstore(add(expmodsAndPoints, 0x13e0), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[127] = -(g^511 * z).
              mstore(add(expmodsAndPoints, 0x1400), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[128] = -(g^513 * z).
              mstore(add(expmodsAndPoints, 0x1420), point)

              // point *= g^5.
              point := mulmod(point, /*traceGenerator^5*/ mload(add(expmodsAndPoints, 0x60)), PRIME)
              // expmods_and_points.points[129] = -(g^518 * z).
              mstore(add(expmodsAndPoints, 0x1440), point)

              // point *= g^3.
              point := mulmod(point, /*traceGenerator^3*/ mload(add(expmodsAndPoints, 0x20)), PRIME)
              // expmods_and_points.points[130] = -(g^521 * z).
              mstore(add(expmodsAndPoints, 0x1460), point)

              // point *= g^29.
              point := mulmod(point, /*traceGenerator^29*/ mload(add(expmodsAndPoints, 0x180)), PRIME)
              // expmods_and_points.points[131] = -(g^550 * z).
              mstore(add(expmodsAndPoints, 0x1480), point)

              // point *= g^155.
              point := mulmod(point, /*traceGenerator^155*/ mload(add(expmodsAndPoints, 0x2a0)), PRIME)
              // expmods_and_points.points[132] = -(g^705 * z).
              mstore(add(expmodsAndPoints, 0x14a0), point)

              // point *= g^6.
              point := mulmod(point, /*traceGenerator^6*/ mload(add(expmodsAndPoints, 0x80)), PRIME)
              // expmods_and_points.points[133] = -(g^711 * z).
              mstore(add(expmodsAndPoints, 0x14c0), point)

              // point *= g^10.
              point := mulmod(point, /*traceGenerator^10*/ mload(add(expmodsAndPoints, 0xe0)), PRIME)
              // expmods_and_points.points[134] = -(g^721 * z).
              mstore(add(expmodsAndPoints, 0x14e0), point)

              // point *= g^16.
              point := mulmod(point, /*traceGenerator^16*/ mload(add(expmodsAndPoints, 0x120)), PRIME)
              // expmods_and_points.points[135] = -(g^737 * z).
              mstore(add(expmodsAndPoints, 0x1500), point)

              // point *= g^16.
              point := mulmod(point, /*traceGenerator^16*/ mload(add(expmodsAndPoints, 0x120)), PRIME)
              // expmods_and_points.points[136] = -(g^753 * z).
              mstore(add(expmodsAndPoints, 0x1520), point)

              // point *= g^16.
              point := mulmod(point, /*traceGenerator^16*/ mload(add(expmodsAndPoints, 0x120)), PRIME)
              // expmods_and_points.points[137] = -(g^769 * z).
              mstore(add(expmodsAndPoints, 0x1540), point)

              // point *= g^8.
              point := mulmod(point, /*traceGenerator^8*/ mload(add(expmodsAndPoints, 0xc0)), PRIME)
              // expmods_and_points.points[138] = -(g^777 * z).
              mstore(add(expmodsAndPoints, 0x1560), point)

              // point *= g^125.
              point := mulmod(point, /*traceGenerator^125*/ mload(add(expmodsAndPoints, 0x280)), PRIME)
              // expmods_and_points.points[139] = -(g^902 * z).
              mstore(add(expmodsAndPoints, 0x1580), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[140] = -(g^903 * z).
              mstore(add(expmodsAndPoints, 0x15a0), point)

              // point *= g^58.
              point := mulmod(point, /*traceGenerator^58*/ mload(add(expmodsAndPoints, 0x220)), PRIME)
              // expmods_and_points.points[141] = -(g^961 * z).
              mstore(add(expmodsAndPoints, 0x15c0), point)

              // point *= g^5.
              point := mulmod(point, /*traceGenerator^5*/ mload(add(expmodsAndPoints, 0x60)), PRIME)
              // expmods_and_points.points[142] = -(g^966 * z).
              mstore(add(expmodsAndPoints, 0x15e0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[143] = -(g^967 * z).
              mstore(add(expmodsAndPoints, 0x1600), point)

              // point *= g^10.
              point := mulmod(point, /*traceGenerator^10*/ mload(add(expmodsAndPoints, 0xe0)), PRIME)
              // expmods_and_points.points[144] = -(g^977 * z).
              mstore(add(expmodsAndPoints, 0x1620), point)

              // point *= g^16.
              point := mulmod(point, /*traceGenerator^16*/ mload(add(expmodsAndPoints, 0x120)), PRIME)
              // expmods_and_points.points[145] = -(g^993 * z).
              mstore(add(expmodsAndPoints, 0x1640), point)

              // point *= g^16.
              point := mulmod(point, /*traceGenerator^16*/ mload(add(expmodsAndPoints, 0x120)), PRIME)
              // expmods_and_points.points[146] = -(g^1009 * z).
              mstore(add(expmodsAndPoints, 0x1660), point)

              // point *= g^213.
              point := mulmod(point, /*traceGenerator^213*/ mload(add(expmodsAndPoints, 0x300)), PRIME)
              // expmods_and_points.points[147] = -(g^1222 * z).
              mstore(add(expmodsAndPoints, 0x1680), point)

              // point *= g^1216.
              point := mulmod(point, /*traceGenerator^1216*/ mload(add(expmodsAndPoints, 0x360)), PRIME)
              // expmods_and_points.points[148] = -(g^2438 * z).
              mstore(add(expmodsAndPoints, 0x16a0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[149] = -(g^2439 * z).
              mstore(add(expmodsAndPoints, 0x16c0), point)

              // point *= g^2047.
              point := mulmod(point, /*traceGenerator^2047*/ mload(add(expmodsAndPoints, 0x3c0)), PRIME)
              // expmods_and_points.points[150] = -(g^4486 * z).
              mstore(add(expmodsAndPoints, 0x16e0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[151] = -(g^4487 * z).
              mstore(add(expmodsAndPoints, 0x1700), point)

              // point *= g^2047.
              point := mulmod(point, /*traceGenerator^2047*/ mload(add(expmodsAndPoints, 0x3c0)), PRIME)
              // expmods_and_points.points[152] = -(g^6534 * z).
              mstore(add(expmodsAndPoints, 0x1720), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[153] = -(g^6535 * z).
              mstore(add(expmodsAndPoints, 0x1740), point)

              // point *= g^2047.
              point := mulmod(point, /*traceGenerator^2047*/ mload(add(expmodsAndPoints, 0x3c0)), PRIME)
              // expmods_and_points.points[154] = -(g^8582 * z).
              mstore(add(expmodsAndPoints, 0x1760), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[155] = -(g^8583 * z).
              mstore(add(expmodsAndPoints, 0x1780), point)

              // point *= g^2047.
              point := mulmod(point, /*traceGenerator^2047*/ mload(add(expmodsAndPoints, 0x3c0)), PRIME)
              // expmods_and_points.points[156] = -(g^10630 * z).
              mstore(add(expmodsAndPoints, 0x17a0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[157] = -(g^10631 * z).
              mstore(add(expmodsAndPoints, 0x17c0), point)

              // point *= g^1678.
              point := mulmod(point, /*traceGenerator^1678*/ mload(add(expmodsAndPoints, 0x3a0)), PRIME)
              // expmods_and_points.points[158] = -(g^12309 * z).
              mstore(add(expmodsAndPoints, 0x17e0), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x260)), PRIME)
              // expmods_and_points.points[159] = -(g^12373 * z).
              mstore(add(expmodsAndPoints, 0x1800), point)

              // point *= g^192.
              point := mulmod(point, /*traceGenerator^192*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[160] = -(g^12565 * z).
              mstore(add(expmodsAndPoints, 0x1820), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x260)), PRIME)
              // expmods_and_points.points[161] = -(g^12629 * z).
              mstore(add(expmodsAndPoints, 0x1840), point)

              // point *= g^49.
              point := mulmod(point, /*traceGenerator^49*/ mload(add(expmodsAndPoints, 0x200)), PRIME)
              // expmods_and_points.points[162] = -(g^12678 * z).
              mstore(add(expmodsAndPoints, 0x1860), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[163] = -(g^12679 * z).
              mstore(add(expmodsAndPoints, 0x1880), point)

              // point *= g^2047.
              point := mulmod(point, /*traceGenerator^2047*/ mload(add(expmodsAndPoints, 0x3c0)), PRIME)
              // expmods_and_points.points[164] = -(g^14726 * z).
              mstore(add(expmodsAndPoints, 0x18a0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[165] = -(g^14727 * z).
              mstore(add(expmodsAndPoints, 0x18c0), point)

              // point *= g^1358.
              point := mulmod(point, /*traceGenerator^1358*/ mload(add(expmodsAndPoints, 0x380)), PRIME)
              // expmods_and_points.points[166] = -(g^16085 * z).
              mstore(add(expmodsAndPoints, 0x18e0), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x260)), PRIME)
              // expmods_and_points.points[167] = -(g^16149 * z).
              mstore(add(expmodsAndPoints, 0x1900), point)

              // point *= g^176.
              point := mulmod(point, /*traceGenerator^176*/ mload(add(expmodsAndPoints, 0x2c0)), PRIME)
              // expmods_and_points.points[168] = -(g^16325 * z).
              mstore(add(expmodsAndPoints, 0x1920), point)

              // point *= g^6.
              point := mulmod(point, /*traceGenerator^6*/ mload(add(expmodsAndPoints, 0x80)), PRIME)
              // expmods_and_points.points[169] = -(g^16331 * z).
              mstore(add(expmodsAndPoints, 0x1940), point)

              // point *= g^6.
              point := mulmod(point, /*traceGenerator^6*/ mload(add(expmodsAndPoints, 0x80)), PRIME)
              // expmods_and_points.points[170] = -(g^16337 * z).
              mstore(add(expmodsAndPoints, 0x1960), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[171] = -(g^16339 * z).
              mstore(add(expmodsAndPoints, 0x1980), point)

              // point *= g^16.
              point := mulmod(point, /*traceGenerator^16*/ mload(add(expmodsAndPoints, 0x120)), PRIME)
              // expmods_and_points.points[172] = -(g^16355 * z).
              mstore(add(expmodsAndPoints, 0x19a0), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[173] = -(g^16357 * z).
              mstore(add(expmodsAndPoints, 0x19c0), point)

              // point *= g^6.
              point := mulmod(point, /*traceGenerator^6*/ mload(add(expmodsAndPoints, 0x80)), PRIME)
              // expmods_and_points.points[174] = -(g^16363 * z).
              mstore(add(expmodsAndPoints, 0x19e0), point)

              // point *= g^6.
              point := mulmod(point, /*traceGenerator^6*/ mload(add(expmodsAndPoints, 0x80)), PRIME)
              // expmods_and_points.points[175] = -(g^16369 * z).
              mstore(add(expmodsAndPoints, 0x1a00), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[176] = -(g^16371 * z).
              mstore(add(expmodsAndPoints, 0x1a20), point)

              // point *= g^14.
              point := mulmod(point, /*traceGenerator^14*/ mload(add(expmodsAndPoints, 0x100)), PRIME)
              // expmods_and_points.points[177] = -(g^16385 * z).
              mstore(add(expmodsAndPoints, 0x1a40), point)

              // point *= g^32.
              point := mulmod(point, /*traceGenerator^32*/ mload(add(expmodsAndPoints, 0x1c0)), PRIME)
              // expmods_and_points.points[178] = -(g^16417 * z).
              mstore(add(expmodsAndPoints, 0x1a60), point)

              // point *= g^357.
              point := mulmod(point, /*traceGenerator^357*/ mload(add(expmodsAndPoints, 0x320)), PRIME)
              // expmods_and_points.points[179] = -(g^16774 * z).
              mstore(add(expmodsAndPoints, 0x1a80), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[180] = -(g^16775 * z).
              mstore(add(expmodsAndPoints, 0x1aa0), point)

              // point *= g^8191.
              point := mulmod(point, /*traceGenerator^8191*/ mload(add(expmodsAndPoints, 0x400)), PRIME)
              // expmods_and_points.points[181] = -(g^24966 * z).
              mstore(add(expmodsAndPoints, 0x1ac0), point)

              // point *= g^7681.
              point := mulmod(point, /*traceGenerator^7681*/ mload(add(expmodsAndPoints, 0x3e0)), PRIME)
              // expmods_and_points.points[182] = -(g^32647 * z).
              mstore(add(expmodsAndPoints, 0x1ae0), point)

              // point *= g^20.
              point := mulmod(point, /*traceGenerator^20*/ mload(add(expmodsAndPoints, 0x140)), PRIME)
              // expmods_and_points.points[183] = -(g^32667 * z).
              mstore(add(expmodsAndPoints, 0x1b00), point)

              // point *= g^48.
              point := mulmod(point, /*traceGenerator^48*/ mload(add(expmodsAndPoints, 0x1e0)), PRIME)
              // expmods_and_points.points[184] = -(g^32715 * z).
              mstore(add(expmodsAndPoints, 0x1b20), point)

              // point *= g^6.
              point := mulmod(point, /*traceGenerator^6*/ mload(add(expmodsAndPoints, 0x80)), PRIME)
              // expmods_and_points.points[185] = -(g^32721 * z).
              mstore(add(expmodsAndPoints, 0x1b40), point)

              // point *= g^10.
              point := mulmod(point, /*traceGenerator^10*/ mload(add(expmodsAndPoints, 0xe0)), PRIME)
              // expmods_and_points.points[186] = -(g^32731 * z).
              mstore(add(expmodsAndPoints, 0x1b60), point)

              // point *= g^16.
              point := mulmod(point, /*traceGenerator^16*/ mload(add(expmodsAndPoints, 0x120)), PRIME)
              // expmods_and_points.points[187] = -(g^32747 * z).
              mstore(add(expmodsAndPoints, 0x1b80), point)

              // point *= g^6.
              point := mulmod(point, /*traceGenerator^6*/ mload(add(expmodsAndPoints, 0x80)), PRIME)
              // expmods_and_points.points[188] = -(g^32753 * z).
              mstore(add(expmodsAndPoints, 0x1ba0), point)

              // point *= g^10.
              point := mulmod(point, /*traceGenerator^10*/ mload(add(expmodsAndPoints, 0xe0)), PRIME)
              // expmods_and_points.points[189] = -(g^32763 * z).
              mstore(add(expmodsAndPoints, 0x1bc0), point)

              // point *= g^395.
              point := mulmod(point, /*traceGenerator^395*/ mload(add(expmodsAndPoints, 0x340)), PRIME)
              // expmods_and_points.points[190] = -(g^33158 * z).
              mstore(add(expmodsAndPoints, 0x1be0), point)
            }

            let evalPointsPtr := /*oodsEvalPoints*/ add(context, 0x5000)
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
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x420)))
                mstore(productsPtr, partialProduct)
                mstore(valuesPtr, denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1: x - g * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x440)))
                mstore(add(productsPtr, 0x20), partialProduct)
                mstore(add(valuesPtr, 0x20), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 2: x - g^2 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x460)))
                mstore(add(productsPtr, 0x40), partialProduct)
                mstore(add(valuesPtr, 0x40), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 3: x - g^3 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x480)))
                mstore(add(productsPtr, 0x60), partialProduct)
                mstore(add(valuesPtr, 0x60), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 4: x - g^4 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x4a0)))
                mstore(add(productsPtr, 0x80), partialProduct)
                mstore(add(valuesPtr, 0x80), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 5: x - g^5 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x4c0)))
                mstore(add(productsPtr, 0xa0), partialProduct)
                mstore(add(valuesPtr, 0xa0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 6: x - g^6 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x4e0)))
                mstore(add(productsPtr, 0xc0), partialProduct)
                mstore(add(valuesPtr, 0xc0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 7: x - g^7 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x500)))
                mstore(add(productsPtr, 0xe0), partialProduct)
                mstore(add(valuesPtr, 0xe0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 8: x - g^8 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x520)))
                mstore(add(productsPtr, 0x100), partialProduct)
                mstore(add(valuesPtr, 0x100), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 9: x - g^9 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x540)))
                mstore(add(productsPtr, 0x120), partialProduct)
                mstore(add(valuesPtr, 0x120), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 10: x - g^10 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x560)))
                mstore(add(productsPtr, 0x140), partialProduct)
                mstore(add(valuesPtr, 0x140), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 11: x - g^11 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x580)))
                mstore(add(productsPtr, 0x160), partialProduct)
                mstore(add(valuesPtr, 0x160), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 12: x - g^12 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x5a0)))
                mstore(add(productsPtr, 0x180), partialProduct)
                mstore(add(valuesPtr, 0x180), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 13: x - g^13 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x5c0)))
                mstore(add(productsPtr, 0x1a0), partialProduct)
                mstore(add(valuesPtr, 0x1a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 14: x - g^14 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x5e0)))
                mstore(add(productsPtr, 0x1c0), partialProduct)
                mstore(add(valuesPtr, 0x1c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 15: x - g^15 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x600)))
                mstore(add(productsPtr, 0x1e0), partialProduct)
                mstore(add(valuesPtr, 0x1e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16: x - g^16 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x620)))
                mstore(add(productsPtr, 0x200), partialProduct)
                mstore(add(valuesPtr, 0x200), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 17: x - g^17 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x640)))
                mstore(add(productsPtr, 0x220), partialProduct)
                mstore(add(valuesPtr, 0x220), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 19: x - g^19 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x660)))
                mstore(add(productsPtr, 0x240), partialProduct)
                mstore(add(valuesPtr, 0x240), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 21: x - g^21 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x680)))
                mstore(add(productsPtr, 0x260), partialProduct)
                mstore(add(valuesPtr, 0x260), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 22: x - g^22 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x6a0)))
                mstore(add(productsPtr, 0x280), partialProduct)
                mstore(add(valuesPtr, 0x280), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 23: x - g^23 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x6c0)))
                mstore(add(productsPtr, 0x2a0), partialProduct)
                mstore(add(valuesPtr, 0x2a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 24: x - g^24 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x6e0)))
                mstore(add(productsPtr, 0x2c0), partialProduct)
                mstore(add(valuesPtr, 0x2c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 25: x - g^25 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x700)))
                mstore(add(productsPtr, 0x2e0), partialProduct)
                mstore(add(valuesPtr, 0x2e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 27: x - g^27 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x720)))
                mstore(add(productsPtr, 0x300), partialProduct)
                mstore(add(valuesPtr, 0x300), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 29: x - g^29 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x740)))
                mstore(add(productsPtr, 0x320), partialProduct)
                mstore(add(valuesPtr, 0x320), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 30: x - g^30 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x760)))
                mstore(add(productsPtr, 0x340), partialProduct)
                mstore(add(valuesPtr, 0x340), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 33: x - g^33 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x780)))
                mstore(add(productsPtr, 0x360), partialProduct)
                mstore(add(valuesPtr, 0x360), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 35: x - g^35 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x7a0)))
                mstore(add(productsPtr, 0x380), partialProduct)
                mstore(add(valuesPtr, 0x380), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 37: x - g^37 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x7c0)))
                mstore(add(productsPtr, 0x3a0), partialProduct)
                mstore(add(valuesPtr, 0x3a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 38: x - g^38 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x7e0)))
                mstore(add(productsPtr, 0x3c0), partialProduct)
                mstore(add(valuesPtr, 0x3c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 39: x - g^39 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x800)))
                mstore(add(productsPtr, 0x3e0), partialProduct)
                mstore(add(valuesPtr, 0x3e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 41: x - g^41 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x820)))
                mstore(add(productsPtr, 0x400), partialProduct)
                mstore(add(valuesPtr, 0x400), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 43: x - g^43 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x840)))
                mstore(add(productsPtr, 0x420), partialProduct)
                mstore(add(valuesPtr, 0x420), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 44: x - g^44 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x860)))
                mstore(add(productsPtr, 0x440), partialProduct)
                mstore(add(valuesPtr, 0x440), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 45: x - g^45 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x880)))
                mstore(add(productsPtr, 0x460), partialProduct)
                mstore(add(valuesPtr, 0x460), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 46: x - g^46 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x8a0)))
                mstore(add(productsPtr, 0x480), partialProduct)
                mstore(add(valuesPtr, 0x480), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 49: x - g^49 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x8c0)))
                mstore(add(productsPtr, 0x4a0), partialProduct)
                mstore(add(valuesPtr, 0x4a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 51: x - g^51 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x8e0)))
                mstore(add(productsPtr, 0x4c0), partialProduct)
                mstore(add(valuesPtr, 0x4c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 53: x - g^53 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x900)))
                mstore(add(productsPtr, 0x4e0), partialProduct)
                mstore(add(valuesPtr, 0x4e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 54: x - g^54 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x920)))
                mstore(add(productsPtr, 0x500), partialProduct)
                mstore(add(valuesPtr, 0x500), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 57: x - g^57 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x940)))
                mstore(add(productsPtr, 0x520), partialProduct)
                mstore(add(valuesPtr, 0x520), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 59: x - g^59 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x960)))
                mstore(add(productsPtr, 0x540), partialProduct)
                mstore(add(valuesPtr, 0x540), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 61: x - g^61 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x980)))
                mstore(add(productsPtr, 0x560), partialProduct)
                mstore(add(valuesPtr, 0x560), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 65: x - g^65 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x9a0)))
                mstore(add(productsPtr, 0x580), partialProduct)
                mstore(add(valuesPtr, 0x580), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 69: x - g^69 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x9c0)))
                mstore(add(productsPtr, 0x5a0), partialProduct)
                mstore(add(valuesPtr, 0x5a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 70: x - g^70 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x9e0)))
                mstore(add(productsPtr, 0x5c0), partialProduct)
                mstore(add(valuesPtr, 0x5c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 71: x - g^71 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xa00)))
                mstore(add(productsPtr, 0x5e0), partialProduct)
                mstore(add(valuesPtr, 0x5e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 73: x - g^73 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xa20)))
                mstore(add(productsPtr, 0x600), partialProduct)
                mstore(add(valuesPtr, 0x600), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 76: x - g^76 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xa40)))
                mstore(add(productsPtr, 0x620), partialProduct)
                mstore(add(valuesPtr, 0x620), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 77: x - g^77 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xa60)))
                mstore(add(productsPtr, 0x640), partialProduct)
                mstore(add(valuesPtr, 0x640), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 81: x - g^81 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xa80)))
                mstore(add(productsPtr, 0x660), partialProduct)
                mstore(add(valuesPtr, 0x660), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 85: x - g^85 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xaa0)))
                mstore(add(productsPtr, 0x680), partialProduct)
                mstore(add(valuesPtr, 0x680), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 89: x - g^89 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xac0)))
                mstore(add(productsPtr, 0x6a0), partialProduct)
                mstore(add(valuesPtr, 0x6a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 91: x - g^91 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xae0)))
                mstore(add(productsPtr, 0x6c0), partialProduct)
                mstore(add(valuesPtr, 0x6c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 97: x - g^97 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xb00)))
                mstore(add(productsPtr, 0x6e0), partialProduct)
                mstore(add(valuesPtr, 0x6e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 101: x - g^101 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xb20)))
                mstore(add(productsPtr, 0x700), partialProduct)
                mstore(add(valuesPtr, 0x700), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 102: x - g^102 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xb40)))
                mstore(add(productsPtr, 0x720), partialProduct)
                mstore(add(valuesPtr, 0x720), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 103: x - g^103 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xb60)))
                mstore(add(productsPtr, 0x740), partialProduct)
                mstore(add(valuesPtr, 0x740), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 105: x - g^105 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xb80)))
                mstore(add(productsPtr, 0x760), partialProduct)
                mstore(add(valuesPtr, 0x760), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 108: x - g^108 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xba0)))
                mstore(add(productsPtr, 0x780), partialProduct)
                mstore(add(valuesPtr, 0x780), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 109: x - g^109 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xbc0)))
                mstore(add(productsPtr, 0x7a0), partialProduct)
                mstore(add(valuesPtr, 0x7a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 113: x - g^113 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xbe0)))
                mstore(add(productsPtr, 0x7c0), partialProduct)
                mstore(add(valuesPtr, 0x7c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 117: x - g^117 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xc00)))
                mstore(add(productsPtr, 0x7e0), partialProduct)
                mstore(add(valuesPtr, 0x7e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 123: x - g^123 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xc20)))
                mstore(add(productsPtr, 0x800), partialProduct)
                mstore(add(valuesPtr, 0x800), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 129: x - g^129 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xc40)))
                mstore(add(productsPtr, 0x820), partialProduct)
                mstore(add(valuesPtr, 0x820), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 134: x - g^134 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xc60)))
                mstore(add(productsPtr, 0x840), partialProduct)
                mstore(add(valuesPtr, 0x840), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 135: x - g^135 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xc80)))
                mstore(add(productsPtr, 0x860), partialProduct)
                mstore(add(valuesPtr, 0x860), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 140: x - g^140 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xca0)))
                mstore(add(productsPtr, 0x880), partialProduct)
                mstore(add(valuesPtr, 0x880), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 145: x - g^145 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xcc0)))
                mstore(add(productsPtr, 0x8a0), partialProduct)
                mstore(add(valuesPtr, 0x8a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 155: x - g^155 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xce0)))
                mstore(add(productsPtr, 0x8c0), partialProduct)
                mstore(add(valuesPtr, 0x8c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 161: x - g^161 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xd00)))
                mstore(add(productsPtr, 0x8e0), partialProduct)
                mstore(add(valuesPtr, 0x8e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 167: x - g^167 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xd20)))
                mstore(add(productsPtr, 0x900), partialProduct)
                mstore(add(valuesPtr, 0x900), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 172: x - g^172 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xd40)))
                mstore(add(productsPtr, 0x920), partialProduct)
                mstore(add(valuesPtr, 0x920), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 177: x - g^177 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xd60)))
                mstore(add(productsPtr, 0x940), partialProduct)
                mstore(add(valuesPtr, 0x940), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 187: x - g^187 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xd80)))
                mstore(add(productsPtr, 0x960), partialProduct)
                mstore(add(valuesPtr, 0x960), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 192: x - g^192 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xda0)))
                mstore(add(productsPtr, 0x980), partialProduct)
                mstore(add(valuesPtr, 0x980), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 193: x - g^193 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xdc0)))
                mstore(add(productsPtr, 0x9a0), partialProduct)
                mstore(add(valuesPtr, 0x9a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 195: x - g^195 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xde0)))
                mstore(add(productsPtr, 0x9c0), partialProduct)
                mstore(add(valuesPtr, 0x9c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 196: x - g^196 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xe00)))
                mstore(add(productsPtr, 0x9e0), partialProduct)
                mstore(add(valuesPtr, 0x9e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 197: x - g^197 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xe20)))
                mstore(add(productsPtr, 0xa00), partialProduct)
                mstore(add(valuesPtr, 0xa00), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 198: x - g^198 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xe40)))
                mstore(add(productsPtr, 0xa20), partialProduct)
                mstore(add(valuesPtr, 0xa20), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 199: x - g^199 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xe60)))
                mstore(add(productsPtr, 0xa40), partialProduct)
                mstore(add(valuesPtr, 0xa40), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 204: x - g^204 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xe80)))
                mstore(add(productsPtr, 0xa60), partialProduct)
                mstore(add(valuesPtr, 0xa60), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 205: x - g^205 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xea0)))
                mstore(add(productsPtr, 0xa80), partialProduct)
                mstore(add(valuesPtr, 0xa80), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 209: x - g^209 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xec0)))
                mstore(add(productsPtr, 0xaa0), partialProduct)
                mstore(add(valuesPtr, 0xaa0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 219: x - g^219 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xee0)))
                mstore(add(productsPtr, 0xac0), partialProduct)
                mstore(add(valuesPtr, 0xac0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 221: x - g^221 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xf00)))
                mstore(add(productsPtr, 0xae0), partialProduct)
                mstore(add(valuesPtr, 0xae0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 225: x - g^225 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xf20)))
                mstore(add(productsPtr, 0xb00), partialProduct)
                mstore(add(valuesPtr, 0xb00), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 231: x - g^231 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xf40)))
                mstore(add(productsPtr, 0xb20), partialProduct)
                mstore(add(valuesPtr, 0xb20), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 236: x - g^236 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xf60)))
                mstore(add(productsPtr, 0xb40), partialProduct)
                mstore(add(valuesPtr, 0xb40), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 237: x - g^237 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xf80)))
                mstore(add(productsPtr, 0xb60), partialProduct)
                mstore(add(valuesPtr, 0xb60), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 241: x - g^241 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xfa0)))
                mstore(add(productsPtr, 0xb80), partialProduct)
                mstore(add(valuesPtr, 0xb80), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 245: x - g^245 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xfc0)))
                mstore(add(productsPtr, 0xba0), partialProduct)
                mstore(add(valuesPtr, 0xba0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 251: x - g^251 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xfe0)))
                mstore(add(productsPtr, 0xbc0), partialProduct)
                mstore(add(valuesPtr, 0xbc0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 252: x - g^252 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1000)))
                mstore(add(productsPtr, 0xbe0), partialProduct)
                mstore(add(valuesPtr, 0xbe0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 253: x - g^253 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1020)))
                mstore(add(productsPtr, 0xc00), partialProduct)
                mstore(add(valuesPtr, 0xc00), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 255: x - g^255 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1040)))
                mstore(add(productsPtr, 0xc20), partialProduct)
                mstore(add(valuesPtr, 0xc20), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 256: x - g^256 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1060)))
                mstore(add(productsPtr, 0xc40), partialProduct)
                mstore(add(valuesPtr, 0xc40), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 257: x - g^257 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1080)))
                mstore(add(productsPtr, 0xc60), partialProduct)
                mstore(add(valuesPtr, 0xc60), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 262: x - g^262 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x10a0)))
                mstore(add(productsPtr, 0xc80), partialProduct)
                mstore(add(valuesPtr, 0xc80), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 263: x - g^263 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x10c0)))
                mstore(add(productsPtr, 0xca0), partialProduct)
                mstore(add(valuesPtr, 0xca0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 265: x - g^265 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x10e0)))
                mstore(add(productsPtr, 0xcc0), partialProduct)
                mstore(add(valuesPtr, 0xcc0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 269: x - g^269 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1100)))
                mstore(add(productsPtr, 0xce0), partialProduct)
                mstore(add(valuesPtr, 0xce0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 295: x - g^295 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1120)))
                mstore(add(productsPtr, 0xd00), partialProduct)
                mstore(add(valuesPtr, 0xd00), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 301: x - g^301 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1140)))
                mstore(add(productsPtr, 0xd20), partialProduct)
                mstore(add(valuesPtr, 0xd20), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 309: x - g^309 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1160)))
                mstore(add(productsPtr, 0xd40), partialProduct)
                mstore(add(valuesPtr, 0xd40), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 310: x - g^310 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1180)))
                mstore(add(productsPtr, 0xd60), partialProduct)
                mstore(add(valuesPtr, 0xd60), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 318: x - g^318 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x11a0)))
                mstore(add(productsPtr, 0xd80), partialProduct)
                mstore(add(valuesPtr, 0xd80), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 326: x - g^326 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x11c0)))
                mstore(add(productsPtr, 0xda0), partialProduct)
                mstore(add(valuesPtr, 0xda0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 334: x - g^334 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x11e0)))
                mstore(add(productsPtr, 0xdc0), partialProduct)
                mstore(add(valuesPtr, 0xdc0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 342: x - g^342 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1200)))
                mstore(add(productsPtr, 0xde0), partialProduct)
                mstore(add(valuesPtr, 0xde0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 350: x - g^350 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1220)))
                mstore(add(productsPtr, 0xe00), partialProduct)
                mstore(add(valuesPtr, 0xe00), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 358: x - g^358 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1240)))
                mstore(add(productsPtr, 0xe20), partialProduct)
                mstore(add(valuesPtr, 0xe20), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 359: x - g^359 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1260)))
                mstore(add(productsPtr, 0xe40), partialProduct)
                mstore(add(valuesPtr, 0xe40), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 390: x - g^390 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1280)))
                mstore(add(productsPtr, 0xe60), partialProduct)
                mstore(add(valuesPtr, 0xe60), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 391: x - g^391 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x12a0)))
                mstore(add(productsPtr, 0xe80), partialProduct)
                mstore(add(valuesPtr, 0xe80), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 451: x - g^451 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x12c0)))
                mstore(add(productsPtr, 0xea0), partialProduct)
                mstore(add(valuesPtr, 0xea0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 454: x - g^454 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x12e0)))
                mstore(add(productsPtr, 0xec0), partialProduct)
                mstore(add(valuesPtr, 0xec0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 461: x - g^461 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1300)))
                mstore(add(productsPtr, 0xee0), partialProduct)
                mstore(add(valuesPtr, 0xee0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 477: x - g^477 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1320)))
                mstore(add(productsPtr, 0xf00), partialProduct)
                mstore(add(valuesPtr, 0xf00), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 491: x - g^491 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1340)))
                mstore(add(productsPtr, 0xf20), partialProduct)
                mstore(add(valuesPtr, 0xf20), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 493: x - g^493 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1360)))
                mstore(add(productsPtr, 0xf40), partialProduct)
                mstore(add(valuesPtr, 0xf40), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 499: x - g^499 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1380)))
                mstore(add(productsPtr, 0xf60), partialProduct)
                mstore(add(valuesPtr, 0xf60), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 501: x - g^501 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x13a0)))
                mstore(add(productsPtr, 0xf80), partialProduct)
                mstore(add(valuesPtr, 0xf80), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 507: x - g^507 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x13c0)))
                mstore(add(productsPtr, 0xfa0), partialProduct)
                mstore(add(valuesPtr, 0xfa0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 509: x - g^509 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x13e0)))
                mstore(add(productsPtr, 0xfc0), partialProduct)
                mstore(add(valuesPtr, 0xfc0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 511: x - g^511 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1400)))
                mstore(add(productsPtr, 0xfe0), partialProduct)
                mstore(add(valuesPtr, 0xfe0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 513: x - g^513 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1420)))
                mstore(add(productsPtr, 0x1000), partialProduct)
                mstore(add(valuesPtr, 0x1000), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 518: x - g^518 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1440)))
                mstore(add(productsPtr, 0x1020), partialProduct)
                mstore(add(valuesPtr, 0x1020), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 521: x - g^521 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1460)))
                mstore(add(productsPtr, 0x1040), partialProduct)
                mstore(add(valuesPtr, 0x1040), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 550: x - g^550 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1480)))
                mstore(add(productsPtr, 0x1060), partialProduct)
                mstore(add(valuesPtr, 0x1060), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 705: x - g^705 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x14a0)))
                mstore(add(productsPtr, 0x1080), partialProduct)
                mstore(add(valuesPtr, 0x1080), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 711: x - g^711 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x14c0)))
                mstore(add(productsPtr, 0x10a0), partialProduct)
                mstore(add(valuesPtr, 0x10a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 721: x - g^721 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x14e0)))
                mstore(add(productsPtr, 0x10c0), partialProduct)
                mstore(add(valuesPtr, 0x10c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 737: x - g^737 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1500)))
                mstore(add(productsPtr, 0x10e0), partialProduct)
                mstore(add(valuesPtr, 0x10e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 753: x - g^753 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1520)))
                mstore(add(productsPtr, 0x1100), partialProduct)
                mstore(add(valuesPtr, 0x1100), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 769: x - g^769 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1540)))
                mstore(add(productsPtr, 0x1120), partialProduct)
                mstore(add(valuesPtr, 0x1120), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 777: x - g^777 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1560)))
                mstore(add(productsPtr, 0x1140), partialProduct)
                mstore(add(valuesPtr, 0x1140), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 902: x - g^902 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1580)))
                mstore(add(productsPtr, 0x1160), partialProduct)
                mstore(add(valuesPtr, 0x1160), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 903: x - g^903 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x15a0)))
                mstore(add(productsPtr, 0x1180), partialProduct)
                mstore(add(valuesPtr, 0x1180), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 961: x - g^961 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x15c0)))
                mstore(add(productsPtr, 0x11a0), partialProduct)
                mstore(add(valuesPtr, 0x11a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 966: x - g^966 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x15e0)))
                mstore(add(productsPtr, 0x11c0), partialProduct)
                mstore(add(valuesPtr, 0x11c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 967: x - g^967 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1600)))
                mstore(add(productsPtr, 0x11e0), partialProduct)
                mstore(add(valuesPtr, 0x11e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 977: x - g^977 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1620)))
                mstore(add(productsPtr, 0x1200), partialProduct)
                mstore(add(valuesPtr, 0x1200), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 993: x - g^993 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1640)))
                mstore(add(productsPtr, 0x1220), partialProduct)
                mstore(add(valuesPtr, 0x1220), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1009: x - g^1009 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1660)))
                mstore(add(productsPtr, 0x1240), partialProduct)
                mstore(add(valuesPtr, 0x1240), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1222: x - g^1222 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1680)))
                mstore(add(productsPtr, 0x1260), partialProduct)
                mstore(add(valuesPtr, 0x1260), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 2438: x - g^2438 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x16a0)))
                mstore(add(productsPtr, 0x1280), partialProduct)
                mstore(add(valuesPtr, 0x1280), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 2439: x - g^2439 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x16c0)))
                mstore(add(productsPtr, 0x12a0), partialProduct)
                mstore(add(valuesPtr, 0x12a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 4486: x - g^4486 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x16e0)))
                mstore(add(productsPtr, 0x12c0), partialProduct)
                mstore(add(valuesPtr, 0x12c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 4487: x - g^4487 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1700)))
                mstore(add(productsPtr, 0x12e0), partialProduct)
                mstore(add(valuesPtr, 0x12e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 6534: x - g^6534 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1720)))
                mstore(add(productsPtr, 0x1300), partialProduct)
                mstore(add(valuesPtr, 0x1300), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 6535: x - g^6535 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1740)))
                mstore(add(productsPtr, 0x1320), partialProduct)
                mstore(add(valuesPtr, 0x1320), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 8582: x - g^8582 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1760)))
                mstore(add(productsPtr, 0x1340), partialProduct)
                mstore(add(valuesPtr, 0x1340), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 8583: x - g^8583 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1780)))
                mstore(add(productsPtr, 0x1360), partialProduct)
                mstore(add(valuesPtr, 0x1360), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 10630: x - g^10630 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x17a0)))
                mstore(add(productsPtr, 0x1380), partialProduct)
                mstore(add(valuesPtr, 0x1380), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 10631: x - g^10631 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x17c0)))
                mstore(add(productsPtr, 0x13a0), partialProduct)
                mstore(add(valuesPtr, 0x13a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 12309: x - g^12309 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x17e0)))
                mstore(add(productsPtr, 0x13c0), partialProduct)
                mstore(add(valuesPtr, 0x13c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 12373: x - g^12373 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1800)))
                mstore(add(productsPtr, 0x13e0), partialProduct)
                mstore(add(valuesPtr, 0x13e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 12565: x - g^12565 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1820)))
                mstore(add(productsPtr, 0x1400), partialProduct)
                mstore(add(valuesPtr, 0x1400), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 12629: x - g^12629 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1840)))
                mstore(add(productsPtr, 0x1420), partialProduct)
                mstore(add(valuesPtr, 0x1420), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 12678: x - g^12678 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1860)))
                mstore(add(productsPtr, 0x1440), partialProduct)
                mstore(add(valuesPtr, 0x1440), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 12679: x - g^12679 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1880)))
                mstore(add(productsPtr, 0x1460), partialProduct)
                mstore(add(valuesPtr, 0x1460), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 14726: x - g^14726 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x18a0)))
                mstore(add(productsPtr, 0x1480), partialProduct)
                mstore(add(valuesPtr, 0x1480), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 14727: x - g^14727 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x18c0)))
                mstore(add(productsPtr, 0x14a0), partialProduct)
                mstore(add(valuesPtr, 0x14a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16085: x - g^16085 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x18e0)))
                mstore(add(productsPtr, 0x14c0), partialProduct)
                mstore(add(valuesPtr, 0x14c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16149: x - g^16149 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1900)))
                mstore(add(productsPtr, 0x14e0), partialProduct)
                mstore(add(valuesPtr, 0x14e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16325: x - g^16325 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1920)))
                mstore(add(productsPtr, 0x1500), partialProduct)
                mstore(add(valuesPtr, 0x1500), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16331: x - g^16331 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1940)))
                mstore(add(productsPtr, 0x1520), partialProduct)
                mstore(add(valuesPtr, 0x1520), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16337: x - g^16337 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1960)))
                mstore(add(productsPtr, 0x1540), partialProduct)
                mstore(add(valuesPtr, 0x1540), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16339: x - g^16339 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1980)))
                mstore(add(productsPtr, 0x1560), partialProduct)
                mstore(add(valuesPtr, 0x1560), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16355: x - g^16355 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x19a0)))
                mstore(add(productsPtr, 0x1580), partialProduct)
                mstore(add(valuesPtr, 0x1580), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16357: x - g^16357 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x19c0)))
                mstore(add(productsPtr, 0x15a0), partialProduct)
                mstore(add(valuesPtr, 0x15a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16363: x - g^16363 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x19e0)))
                mstore(add(productsPtr, 0x15c0), partialProduct)
                mstore(add(valuesPtr, 0x15c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16369: x - g^16369 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1a00)))
                mstore(add(productsPtr, 0x15e0), partialProduct)
                mstore(add(valuesPtr, 0x15e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16371: x - g^16371 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1a20)))
                mstore(add(productsPtr, 0x1600), partialProduct)
                mstore(add(valuesPtr, 0x1600), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16385: x - g^16385 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1a40)))
                mstore(add(productsPtr, 0x1620), partialProduct)
                mstore(add(valuesPtr, 0x1620), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16417: x - g^16417 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1a60)))
                mstore(add(productsPtr, 0x1640), partialProduct)
                mstore(add(valuesPtr, 0x1640), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16774: x - g^16774 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1a80)))
                mstore(add(productsPtr, 0x1660), partialProduct)
                mstore(add(valuesPtr, 0x1660), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16775: x - g^16775 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1aa0)))
                mstore(add(productsPtr, 0x1680), partialProduct)
                mstore(add(valuesPtr, 0x1680), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 24966: x - g^24966 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1ac0)))
                mstore(add(productsPtr, 0x16a0), partialProduct)
                mstore(add(valuesPtr, 0x16a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 32647: x - g^32647 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1ae0)))
                mstore(add(productsPtr, 0x16c0), partialProduct)
                mstore(add(valuesPtr, 0x16c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 32667: x - g^32667 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1b00)))
                mstore(add(productsPtr, 0x16e0), partialProduct)
                mstore(add(valuesPtr, 0x16e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 32715: x - g^32715 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1b20)))
                mstore(add(productsPtr, 0x1700), partialProduct)
                mstore(add(valuesPtr, 0x1700), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 32721: x - g^32721 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1b40)))
                mstore(add(productsPtr, 0x1720), partialProduct)
                mstore(add(valuesPtr, 0x1720), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 32731: x - g^32731 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1b60)))
                mstore(add(productsPtr, 0x1740), partialProduct)
                mstore(add(valuesPtr, 0x1740), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 32747: x - g^32747 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1b80)))
                mstore(add(productsPtr, 0x1760), partialProduct)
                mstore(add(valuesPtr, 0x1760), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 32753: x - g^32753 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1ba0)))
                mstore(add(productsPtr, 0x1780), partialProduct)
                mstore(add(valuesPtr, 0x1780), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 32763: x - g^32763 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1bc0)))
                mstore(add(productsPtr, 0x17a0), partialProduct)
                mstore(add(valuesPtr, 0x17a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 33158: x - g^33158 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1be0)))
                mstore(add(productsPtr, 0x17c0), partialProduct)
                mstore(add(valuesPtr, 0x17c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate the denominator for the composition polynomial columns: x - z^2.
                let denominator := add(shiftedEvalPoint, minusPointPow)
                mstore(add(productsPtr, 0x17e0), partialProduct)
                mstore(add(valuesPtr, 0x17e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                // Add evalPoint to batch inverse inputs.
                // inverse(evalPoint) is going to be used by FRI.
                mstore(add(productsPtr, 0x1800), partialProduct)
                mstore(add(valuesPtr, 0x1800), evalPoint)
                partialProduct := mulmod(partialProduct, evalPoint, PRIME)

                // Advance pointers.
                productsPtr := add(productsPtr, 0x1820)
                valuesPtr := add(valuesPtr, 0x1820)
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
