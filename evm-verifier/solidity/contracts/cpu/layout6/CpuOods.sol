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
        // This function assumes that the calldata contains the context as defined in MemoryMap.sol.
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
            let traceQueryResponses := /*traceQueryQesponses*/ add(context, 0x7da0)

            let compositionQueryResponses := /*composition_query_responses*/ add(context, 0xb9a0)

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
                                  /*oods_coefficients[0]*/ mload(add(context, 0x62e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[0]*/ mload(add(context, 0x4220)))),
                           PRIME))

                // res += c_1*(f_0(x) - f_0(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  /*oods_coefficients[1]*/ mload(add(context, 0x6300)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[1]*/ mload(add(context, 0x4240)))),
                           PRIME))

                // res += c_2*(f_0(x) - f_0(g^2 * z)) / (x - g^2 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2 * z)^(-1)*/ mload(add(denominatorsPtr, 0x40)),
                                  /*oods_coefficients[2]*/ mload(add(context, 0x6320)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[2]*/ mload(add(context, 0x4260)))),
                           PRIME))

                // res += c_3*(f_0(x) - f_0(g^3 * z)) / (x - g^3 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3 * z)^(-1)*/ mload(add(denominatorsPtr, 0x60)),
                                  /*oods_coefficients[3]*/ mload(add(context, 0x6340)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[3]*/ mload(add(context, 0x4280)))),
                           PRIME))

                // res += c_4*(f_0(x) - f_0(g^4 * z)) / (x - g^4 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4 * z)^(-1)*/ mload(add(denominatorsPtr, 0x80)),
                                  /*oods_coefficients[4]*/ mload(add(context, 0x6360)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[4]*/ mload(add(context, 0x42a0)))),
                           PRIME))

                // res += c_5*(f_0(x) - f_0(g^5 * z)) / (x - g^5 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^5 * z)^(-1)*/ mload(add(denominatorsPtr, 0xa0)),
                                  /*oods_coefficients[5]*/ mload(add(context, 0x6380)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[5]*/ mload(add(context, 0x42c0)))),
                           PRIME))

                // res += c_6*(f_0(x) - f_0(g^6 * z)) / (x - g^6 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^6 * z)^(-1)*/ mload(add(denominatorsPtr, 0xc0)),
                                  /*oods_coefficients[6]*/ mload(add(context, 0x63a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[6]*/ mload(add(context, 0x42e0)))),
                           PRIME))

                // res += c_7*(f_0(x) - f_0(g^7 * z)) / (x - g^7 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^7 * z)^(-1)*/ mload(add(denominatorsPtr, 0xe0)),
                                  /*oods_coefficients[7]*/ mload(add(context, 0x63c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[7]*/ mload(add(context, 0x4300)))),
                           PRIME))

                // res += c_8*(f_0(x) - f_0(g^8 * z)) / (x - g^8 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8 * z)^(-1)*/ mload(add(denominatorsPtr, 0x100)),
                                  /*oods_coefficients[8]*/ mload(add(context, 0x63e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[8]*/ mload(add(context, 0x4320)))),
                           PRIME))

                // res += c_9*(f_0(x) - f_0(g^9 * z)) / (x - g^9 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^9 * z)^(-1)*/ mload(add(denominatorsPtr, 0x120)),
                                  /*oods_coefficients[9]*/ mload(add(context, 0x6400)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[9]*/ mload(add(context, 0x4340)))),
                           PRIME))

                // res += c_10*(f_0(x) - f_0(g^10 * z)) / (x - g^10 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^10 * z)^(-1)*/ mload(add(denominatorsPtr, 0x140)),
                                  /*oods_coefficients[10]*/ mload(add(context, 0x6420)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[10]*/ mload(add(context, 0x4360)))),
                           PRIME))

                // res += c_11*(f_0(x) - f_0(g^11 * z)) / (x - g^11 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^11 * z)^(-1)*/ mload(add(denominatorsPtr, 0x160)),
                                  /*oods_coefficients[11]*/ mload(add(context, 0x6440)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[11]*/ mload(add(context, 0x4380)))),
                           PRIME))

                // res += c_12*(f_0(x) - f_0(g^12 * z)) / (x - g^12 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^12 * z)^(-1)*/ mload(add(denominatorsPtr, 0x180)),
                                  /*oods_coefficients[12]*/ mload(add(context, 0x6460)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[12]*/ mload(add(context, 0x43a0)))),
                           PRIME))

                // res += c_13*(f_0(x) - f_0(g^13 * z)) / (x - g^13 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^13 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1a0)),
                                  /*oods_coefficients[13]*/ mload(add(context, 0x6480)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[13]*/ mload(add(context, 0x43c0)))),
                           PRIME))

                // res += c_14*(f_0(x) - f_0(g^14 * z)) / (x - g^14 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^14 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1c0)),
                                  /*oods_coefficients[14]*/ mload(add(context, 0x64a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[14]*/ mload(add(context, 0x43e0)))),
                           PRIME))

                // res += c_15*(f_0(x) - f_0(g^15 * z)) / (x - g^15 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^15 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1e0)),
                                  /*oods_coefficients[15]*/ mload(add(context, 0x64c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[15]*/ mload(add(context, 0x4400)))),
                           PRIME))
                }

                // Mask items for column #1.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x20)), kMontgomeryRInv, PRIME)

                // res += c_16*(f_1(x) - f_1(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[16]*/ mload(add(context, 0x64e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[16]*/ mload(add(context, 0x4420)))),
                           PRIME))

                // res += c_17*(f_1(x) - f_1(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  /*oods_coefficients[17]*/ mload(add(context, 0x6500)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[17]*/ mload(add(context, 0x4440)))),
                           PRIME))

                // res += c_18*(f_1(x) - f_1(g^255 * z)) / (x - g^255 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^255 * z)^(-1)*/ mload(add(denominatorsPtr, 0x980)),
                                  /*oods_coefficients[18]*/ mload(add(context, 0x6520)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[18]*/ mload(add(context, 0x4460)))),
                           PRIME))

                // res += c_19*(f_1(x) - f_1(g^256 * z)) / (x - g^256 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^256 * z)^(-1)*/ mload(add(denominatorsPtr, 0x9a0)),
                                  /*oods_coefficients[19]*/ mload(add(context, 0x6540)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[19]*/ mload(add(context, 0x4480)))),
                           PRIME))

                // res += c_20*(f_1(x) - f_1(g^511 * z)) / (x - g^511 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^511 * z)^(-1)*/ mload(add(denominatorsPtr, 0xac0)),
                                  /*oods_coefficients[20]*/ mload(add(context, 0x6560)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[20]*/ mload(add(context, 0x44a0)))),
                           PRIME))
                }

                // Mask items for column #2.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x40)), kMontgomeryRInv, PRIME)

                // res += c_21*(f_2(x) - f_2(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[21]*/ mload(add(context, 0x6580)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[21]*/ mload(add(context, 0x44c0)))),
                           PRIME))

                // res += c_22*(f_2(x) - f_2(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  /*oods_coefficients[22]*/ mload(add(context, 0x65a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[22]*/ mload(add(context, 0x44e0)))),
                           PRIME))

                // res += c_23*(f_2(x) - f_2(g^255 * z)) / (x - g^255 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^255 * z)^(-1)*/ mload(add(denominatorsPtr, 0x980)),
                                  /*oods_coefficients[23]*/ mload(add(context, 0x65c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[23]*/ mload(add(context, 0x4500)))),
                           PRIME))

                // res += c_24*(f_2(x) - f_2(g^256 * z)) / (x - g^256 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^256 * z)^(-1)*/ mload(add(denominatorsPtr, 0x9a0)),
                                  /*oods_coefficients[24]*/ mload(add(context, 0x65e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[24]*/ mload(add(context, 0x4520)))),
                           PRIME))
                }

                // Mask items for column #3.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x60)), kMontgomeryRInv, PRIME)

                // res += c_25*(f_3(x) - f_3(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[25]*/ mload(add(context, 0x6600)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[25]*/ mload(add(context, 0x4540)))),
                           PRIME))

                // res += c_26*(f_3(x) - f_3(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  /*oods_coefficients[26]*/ mload(add(context, 0x6620)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[26]*/ mload(add(context, 0x4560)))),
                           PRIME))

                // res += c_27*(f_3(x) - f_3(g^192 * z)) / (x - g^192 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^192 * z)^(-1)*/ mload(add(denominatorsPtr, 0x7e0)),
                                  /*oods_coefficients[27]*/ mload(add(context, 0x6640)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[27]*/ mload(add(context, 0x4580)))),
                           PRIME))

                // res += c_28*(f_3(x) - f_3(g^193 * z)) / (x - g^193 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^193 * z)^(-1)*/ mload(add(denominatorsPtr, 0x800)),
                                  /*oods_coefficients[28]*/ mload(add(context, 0x6660)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[28]*/ mload(add(context, 0x45a0)))),
                           PRIME))

                // res += c_29*(f_3(x) - f_3(g^196 * z)) / (x - g^196 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^196 * z)^(-1)*/ mload(add(denominatorsPtr, 0x820)),
                                  /*oods_coefficients[29]*/ mload(add(context, 0x6680)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[29]*/ mload(add(context, 0x45c0)))),
                           PRIME))

                // res += c_30*(f_3(x) - f_3(g^197 * z)) / (x - g^197 * z).
                res := addmod(
                    res,
                    mulmod(mulmod(/*(x - g^197 * z)^(-1)*/ mload(add(denominatorsPtr, 0x840)),
                                  /*oods_coefficients[30]*/ mload(add(context, 0x66a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[30]*/ mload(add(context, 0x45e0)))),
                           PRIME),
                    PRIME)

                // res += c_31*(f_3(x) - f_3(g^251 * z)) / (x - g^251 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^251 * z)^(-1)*/ mload(add(denominatorsPtr, 0x940)),
                                  /*oods_coefficients[31]*/ mload(add(context, 0x66c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[31]*/ mload(add(context, 0x4600)))),
                           PRIME))

                // res += c_32*(f_3(x) - f_3(g^252 * z)) / (x - g^252 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^252 * z)^(-1)*/ mload(add(denominatorsPtr, 0x960)),
                                  /*oods_coefficients[32]*/ mload(add(context, 0x66e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[32]*/ mload(add(context, 0x4620)))),
                           PRIME))

                // res += c_33*(f_3(x) - f_3(g^256 * z)) / (x - g^256 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^256 * z)^(-1)*/ mload(add(denominatorsPtr, 0x9a0)),
                                  /*oods_coefficients[33]*/ mload(add(context, 0x6700)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[33]*/ mload(add(context, 0x4640)))),
                           PRIME))
                }

                // Mask items for column #4.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x80)), kMontgomeryRInv, PRIME)

                // res += c_34*(f_4(x) - f_4(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[34]*/ mload(add(context, 0x6720)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[34]*/ mload(add(context, 0x4660)))),
                           PRIME))

                // res += c_35*(f_4(x) - f_4(g^255 * z)) / (x - g^255 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^255 * z)^(-1)*/ mload(add(denominatorsPtr, 0x980)),
                                  /*oods_coefficients[35]*/ mload(add(context, 0x6740)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[35]*/ mload(add(context, 0x4680)))),
                           PRIME))
                }

                // Mask items for column #5.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0xa0)), kMontgomeryRInv, PRIME)

                // res += c_36*(f_5(x) - f_5(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[36]*/ mload(add(context, 0x6760)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[36]*/ mload(add(context, 0x46a0)))),
                           PRIME))

                // res += c_37*(f_5(x) - f_5(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  /*oods_coefficients[37]*/ mload(add(context, 0x6780)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[37]*/ mload(add(context, 0x46c0)))),
                           PRIME))

                // res += c_38*(f_5(x) - f_5(g^2 * z)) / (x - g^2 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2 * z)^(-1)*/ mload(add(denominatorsPtr, 0x40)),
                                  /*oods_coefficients[38]*/ mload(add(context, 0x67a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[38]*/ mload(add(context, 0x46e0)))),
                           PRIME))

                // res += c_39*(f_5(x) - f_5(g^3 * z)) / (x - g^3 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3 * z)^(-1)*/ mload(add(denominatorsPtr, 0x60)),
                                  /*oods_coefficients[39]*/ mload(add(context, 0x67c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[39]*/ mload(add(context, 0x4700)))),
                           PRIME))

                // res += c_40*(f_5(x) - f_5(g^4 * z)) / (x - g^4 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4 * z)^(-1)*/ mload(add(denominatorsPtr, 0x80)),
                                  /*oods_coefficients[40]*/ mload(add(context, 0x67e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[40]*/ mload(add(context, 0x4720)))),
                           PRIME))

                // res += c_41*(f_5(x) - f_5(g^5 * z)) / (x - g^5 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^5 * z)^(-1)*/ mload(add(denominatorsPtr, 0xa0)),
                                  /*oods_coefficients[41]*/ mload(add(context, 0x6800)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[41]*/ mload(add(context, 0x4740)))),
                           PRIME))

                // res += c_42*(f_5(x) - f_5(g^6 * z)) / (x - g^6 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^6 * z)^(-1)*/ mload(add(denominatorsPtr, 0xc0)),
                                  /*oods_coefficients[42]*/ mload(add(context, 0x6820)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[42]*/ mload(add(context, 0x4760)))),
                           PRIME))

                // res += c_43*(f_5(x) - f_5(g^7 * z)) / (x - g^7 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^7 * z)^(-1)*/ mload(add(denominatorsPtr, 0xe0)),
                                  /*oods_coefficients[43]*/ mload(add(context, 0x6840)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[43]*/ mload(add(context, 0x4780)))),
                           PRIME))

                // res += c_44*(f_5(x) - f_5(g^8 * z)) / (x - g^8 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8 * z)^(-1)*/ mload(add(denominatorsPtr, 0x100)),
                                  /*oods_coefficients[44]*/ mload(add(context, 0x6860)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[44]*/ mload(add(context, 0x47a0)))),
                           PRIME))

                // res += c_45*(f_5(x) - f_5(g^9 * z)) / (x - g^9 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^9 * z)^(-1)*/ mload(add(denominatorsPtr, 0x120)),
                                  /*oods_coefficients[45]*/ mload(add(context, 0x6880)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[45]*/ mload(add(context, 0x47c0)))),
                           PRIME))

                // res += c_46*(f_5(x) - f_5(g^12 * z)) / (x - g^12 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^12 * z)^(-1)*/ mload(add(denominatorsPtr, 0x180)),
                                  /*oods_coefficients[46]*/ mload(add(context, 0x68a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[46]*/ mload(add(context, 0x47e0)))),
                           PRIME))

                // res += c_47*(f_5(x) - f_5(g^13 * z)) / (x - g^13 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^13 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1a0)),
                                  /*oods_coefficients[47]*/ mload(add(context, 0x68c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[47]*/ mload(add(context, 0x4800)))),
                           PRIME))

                // res += c_48*(f_5(x) - f_5(g^16 * z)) / (x - g^16 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16 * z)^(-1)*/ mload(add(denominatorsPtr, 0x200)),
                                  /*oods_coefficients[48]*/ mload(add(context, 0x68e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[48]*/ mload(add(context, 0x4820)))),
                           PRIME))

                // res += c_49*(f_5(x) - f_5(g^70 * z)) / (x - g^70 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^70 * z)^(-1)*/ mload(add(denominatorsPtr, 0x4e0)),
                                  /*oods_coefficients[49]*/ mload(add(context, 0x6900)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[49]*/ mload(add(context, 0x4840)))),
                           PRIME))

                // res += c_50*(f_5(x) - f_5(g^71 * z)) / (x - g^71 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^71 * z)^(-1)*/ mload(add(denominatorsPtr, 0x500)),
                                  /*oods_coefficients[50]*/ mload(add(context, 0x6920)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[50]*/ mload(add(context, 0x4860)))),
                           PRIME))

                // res += c_51*(f_5(x) - f_5(g^134 * z)) / (x - g^134 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^134 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6e0)),
                                  /*oods_coefficients[51]*/ mload(add(context, 0x6940)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[51]*/ mload(add(context, 0x4880)))),
                           PRIME))

                // res += c_52*(f_5(x) - f_5(g^135 * z)) / (x - g^135 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^135 * z)^(-1)*/ mload(add(denominatorsPtr, 0x700)),
                                  /*oods_coefficients[52]*/ mload(add(context, 0x6960)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[52]*/ mload(add(context, 0x48a0)))),
                           PRIME))

                // res += c_53*(f_5(x) - f_5(g^198 * z)) / (x - g^198 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^198 * z)^(-1)*/ mload(add(denominatorsPtr, 0x860)),
                                  /*oods_coefficients[53]*/ mload(add(context, 0x6980)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[53]*/ mload(add(context, 0x48c0)))),
                           PRIME))

                // res += c_54*(f_5(x) - f_5(g^199 * z)) / (x - g^199 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^199 * z)^(-1)*/ mload(add(denominatorsPtr, 0x880)),
                                  /*oods_coefficients[54]*/ mload(add(context, 0x69a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[54]*/ mload(add(context, 0x48e0)))),
                           PRIME))

                // res += c_55*(f_5(x) - f_5(g^262 * z)) / (x - g^262 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^262 * z)^(-1)*/ mload(add(denominatorsPtr, 0x9e0)),
                                  /*oods_coefficients[55]*/ mload(add(context, 0x69c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[55]*/ mload(add(context, 0x4900)))),
                           PRIME))

                // res += c_56*(f_5(x) - f_5(g^263 * z)) / (x - g^263 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^263 * z)^(-1)*/ mload(add(denominatorsPtr, 0xa00)),
                                  /*oods_coefficients[56]*/ mload(add(context, 0x69e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[56]*/ mload(add(context, 0x4920)))),
                           PRIME))

                // res += c_57*(f_5(x) - f_5(g^326 * z)) / (x - g^326 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^326 * z)^(-1)*/ mload(add(denominatorsPtr, 0xa40)),
                                  /*oods_coefficients[57]*/ mload(add(context, 0x6a00)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[57]*/ mload(add(context, 0x4940)))),
                           PRIME))

                // res += c_58*(f_5(x) - f_5(g^390 * z)) / (x - g^390 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^390 * z)^(-1)*/ mload(add(denominatorsPtr, 0xa60)),
                                  /*oods_coefficients[58]*/ mload(add(context, 0x6a20)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[58]*/ mload(add(context, 0x4960)))),
                           PRIME))

                // res += c_59*(f_5(x) - f_5(g^391 * z)) / (x - g^391 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^391 * z)^(-1)*/ mload(add(denominatorsPtr, 0xa80)),
                                  /*oods_coefficients[59]*/ mload(add(context, 0x6a40)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[59]*/ mload(add(context, 0x4980)))),
                           PRIME))

                // res += c_60*(f_5(x) - f_5(g^454 * z)) / (x - g^454 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^454 * z)^(-1)*/ mload(add(denominatorsPtr, 0xaa0)),
                                  /*oods_coefficients[60]*/ mload(add(context, 0x6a60)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[60]*/ mload(add(context, 0x49a0)))),
                           PRIME))

                // res += c_61*(f_5(x) - f_5(g^518 * z)) / (x - g^518 * z).
                res := addmod(
                    res,
                    mulmod(mulmod(/*(x - g^518 * z)^(-1)*/ mload(add(denominatorsPtr, 0xb00)),
                                  /*oods_coefficients[61]*/ mload(add(context, 0x6a80)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[61]*/ mload(add(context, 0x49c0)))),
                           PRIME),
                    PRIME)

                // res += c_62*(f_5(x) - f_5(g^711 * z)) / (x - g^711 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^711 * z)^(-1)*/ mload(add(denominatorsPtr, 0xb60)),
                                  /*oods_coefficients[62]*/ mload(add(context, 0x6aa0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[62]*/ mload(add(context, 0x49e0)))),
                           PRIME))

                // res += c_63*(f_5(x) - f_5(g^902 * z)) / (x - g^902 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^902 * z)^(-1)*/ mload(add(denominatorsPtr, 0xc20)),
                                  /*oods_coefficients[63]*/ mload(add(context, 0x6ac0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[63]*/ mload(add(context, 0x4a00)))),
                           PRIME))

                // res += c_64*(f_5(x) - f_5(g^903 * z)) / (x - g^903 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^903 * z)^(-1)*/ mload(add(denominatorsPtr, 0xc40)),
                                  /*oods_coefficients[64]*/ mload(add(context, 0x6ae0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[64]*/ mload(add(context, 0x4a20)))),
                           PRIME))

                // res += c_65*(f_5(x) - f_5(g^966 * z)) / (x - g^966 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^966 * z)^(-1)*/ mload(add(denominatorsPtr, 0xc80)),
                                  /*oods_coefficients[65]*/ mload(add(context, 0x6b00)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[65]*/ mload(add(context, 0x4a40)))),
                           PRIME))

                // res += c_66*(f_5(x) - f_5(g^967 * z)) / (x - g^967 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^967 * z)^(-1)*/ mload(add(denominatorsPtr, 0xca0)),
                                  /*oods_coefficients[66]*/ mload(add(context, 0x6b20)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[66]*/ mload(add(context, 0x4a60)))),
                           PRIME))

                // res += c_67*(f_5(x) - f_5(g^1222 * z)) / (x - g^1222 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^1222 * z)^(-1)*/ mload(add(denominatorsPtr, 0xd20)),
                                  /*oods_coefficients[67]*/ mload(add(context, 0x6b40)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[67]*/ mload(add(context, 0x4a80)))),
                           PRIME))

                // res += c_68*(f_5(x) - f_5(g^2438 * z)) / (x - g^2438 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2438 * z)^(-1)*/ mload(add(denominatorsPtr, 0xd40)),
                                  /*oods_coefficients[68]*/ mload(add(context, 0x6b60)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[68]*/ mload(add(context, 0x4aa0)))),
                           PRIME))

                // res += c_69*(f_5(x) - f_5(g^2439 * z)) / (x - g^2439 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2439 * z)^(-1)*/ mload(add(denominatorsPtr, 0xd60)),
                                  /*oods_coefficients[69]*/ mload(add(context, 0x6b80)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[69]*/ mload(add(context, 0x4ac0)))),
                           PRIME))

                // res += c_70*(f_5(x) - f_5(g^4486 * z)) / (x - g^4486 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4486 * z)^(-1)*/ mload(add(denominatorsPtr, 0xd80)),
                                  /*oods_coefficients[70]*/ mload(add(context, 0x6ba0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[70]*/ mload(add(context, 0x4ae0)))),
                           PRIME))

                // res += c_71*(f_5(x) - f_5(g^4487 * z)) / (x - g^4487 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4487 * z)^(-1)*/ mload(add(denominatorsPtr, 0xda0)),
                                  /*oods_coefficients[71]*/ mload(add(context, 0x6bc0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[71]*/ mload(add(context, 0x4b00)))),
                           PRIME))

                // res += c_72*(f_5(x) - f_5(g^6534 * z)) / (x - g^6534 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^6534 * z)^(-1)*/ mload(add(denominatorsPtr, 0xdc0)),
                                  /*oods_coefficients[72]*/ mload(add(context, 0x6be0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[72]*/ mload(add(context, 0x4b20)))),
                           PRIME))

                // res += c_73*(f_5(x) - f_5(g^6535 * z)) / (x - g^6535 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^6535 * z)^(-1)*/ mload(add(denominatorsPtr, 0xde0)),
                                  /*oods_coefficients[73]*/ mload(add(context, 0x6c00)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[73]*/ mload(add(context, 0x4b40)))),
                           PRIME))

                // res += c_74*(f_5(x) - f_5(g^8582 * z)) / (x - g^8582 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8582 * z)^(-1)*/ mload(add(denominatorsPtr, 0xe00)),
                                  /*oods_coefficients[74]*/ mload(add(context, 0x6c20)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[74]*/ mload(add(context, 0x4b60)))),
                           PRIME))

                // res += c_75*(f_5(x) - f_5(g^8583 * z)) / (x - g^8583 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8583 * z)^(-1)*/ mload(add(denominatorsPtr, 0xe20)),
                                  /*oods_coefficients[75]*/ mload(add(context, 0x6c40)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[75]*/ mload(add(context, 0x4b80)))),
                           PRIME))

                // res += c_76*(f_5(x) - f_5(g^10630 * z)) / (x - g^10630 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^10630 * z)^(-1)*/ mload(add(denominatorsPtr, 0xe40)),
                                  /*oods_coefficients[76]*/ mload(add(context, 0x6c60)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[76]*/ mload(add(context, 0x4ba0)))),
                           PRIME))

                // res += c_77*(f_5(x) - f_5(g^10631 * z)) / (x - g^10631 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^10631 * z)^(-1)*/ mload(add(denominatorsPtr, 0xe60)),
                                  /*oods_coefficients[77]*/ mload(add(context, 0x6c80)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[77]*/ mload(add(context, 0x4bc0)))),
                           PRIME))

                // res += c_78*(f_5(x) - f_5(g^12678 * z)) / (x - g^12678 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^12678 * z)^(-1)*/ mload(add(denominatorsPtr, 0xf00)),
                                  /*oods_coefficients[78]*/ mload(add(context, 0x6ca0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[78]*/ mload(add(context, 0x4be0)))),
                           PRIME))

                // res += c_79*(f_5(x) - f_5(g^12679 * z)) / (x - g^12679 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^12679 * z)^(-1)*/ mload(add(denominatorsPtr, 0xf20)),
                                  /*oods_coefficients[79]*/ mload(add(context, 0x6cc0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[79]*/ mload(add(context, 0x4c00)))),
                           PRIME))

                // res += c_80*(f_5(x) - f_5(g^14726 * z)) / (x - g^14726 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^14726 * z)^(-1)*/ mload(add(denominatorsPtr, 0xf40)),
                                  /*oods_coefficients[80]*/ mload(add(context, 0x6ce0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[80]*/ mload(add(context, 0x4c20)))),
                           PRIME))

                // res += c_81*(f_5(x) - f_5(g^14727 * z)) / (x - g^14727 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^14727 * z)^(-1)*/ mload(add(denominatorsPtr, 0xf60)),
                                  /*oods_coefficients[81]*/ mload(add(context, 0x6d00)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[81]*/ mload(add(context, 0x4c40)))),
                           PRIME))

                // res += c_82*(f_5(x) - f_5(g^16774 * z)) / (x - g^16774 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16774 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1120)),
                                  /*oods_coefficients[82]*/ mload(add(context, 0x6d20)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[82]*/ mload(add(context, 0x4c60)))),
                           PRIME))

                // res += c_83*(f_5(x) - f_5(g^16775 * z)) / (x - g^16775 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16775 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1140)),
                                  /*oods_coefficients[83]*/ mload(add(context, 0x6d40)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[83]*/ mload(add(context, 0x4c80)))),
                           PRIME))

                // res += c_84*(f_5(x) - f_5(g^24966 * z)) / (x - g^24966 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^24966 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1160)),
                                  /*oods_coefficients[84]*/ mload(add(context, 0x6d60)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[84]*/ mload(add(context, 0x4ca0)))),
                           PRIME))

                // res += c_85*(f_5(x) - f_5(g^33158 * z)) / (x - g^33158 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^33158 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1280)),
                                  /*oods_coefficients[85]*/ mload(add(context, 0x6d80)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[85]*/ mload(add(context, 0x4cc0)))),
                           PRIME))
                }

                // Mask items for column #6.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0xc0)), kMontgomeryRInv, PRIME)

                // res += c_86*(f_6(x) - f_6(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[86]*/ mload(add(context, 0x6da0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[86]*/ mload(add(context, 0x4ce0)))),
                           PRIME))

                // res += c_87*(f_6(x) - f_6(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  /*oods_coefficients[87]*/ mload(add(context, 0x6dc0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[87]*/ mload(add(context, 0x4d00)))),
                           PRIME))

                // res += c_88*(f_6(x) - f_6(g^2 * z)) / (x - g^2 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2 * z)^(-1)*/ mload(add(denominatorsPtr, 0x40)),
                                  /*oods_coefficients[88]*/ mload(add(context, 0x6de0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[88]*/ mload(add(context, 0x4d20)))),
                           PRIME))

                // res += c_89*(f_6(x) - f_6(g^3 * z)) / (x - g^3 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3 * z)^(-1)*/ mload(add(denominatorsPtr, 0x60)),
                                  /*oods_coefficients[89]*/ mload(add(context, 0x6e00)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[89]*/ mload(add(context, 0x4d40)))),
                           PRIME))
                }

                // Mask items for column #7.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0xe0)), kMontgomeryRInv, PRIME)

                // res += c_90*(f_7(x) - f_7(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[90]*/ mload(add(context, 0x6e20)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[90]*/ mload(add(context, 0x4d60)))),
                           PRIME))

                // res += c_91*(f_7(x) - f_7(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  /*oods_coefficients[91]*/ mload(add(context, 0x6e40)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[91]*/ mload(add(context, 0x4d80)))),
                           PRIME))

                // res += c_92*(f_7(x) - f_7(g^2 * z)) / (x - g^2 * z).
                res := addmod(
                    res,
                    mulmod(mulmod(/*(x - g^2 * z)^(-1)*/ mload(add(denominatorsPtr, 0x40)),
                                  /*oods_coefficients[92]*/ mload(add(context, 0x6e60)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[92]*/ mload(add(context, 0x4da0)))),
                           PRIME),
                    PRIME)

                // res += c_93*(f_7(x) - f_7(g^3 * z)) / (x - g^3 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3 * z)^(-1)*/ mload(add(denominatorsPtr, 0x60)),
                                  /*oods_coefficients[93]*/ mload(add(context, 0x6e80)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[93]*/ mload(add(context, 0x4dc0)))),
                           PRIME))

                // res += c_94*(f_7(x) - f_7(g^4 * z)) / (x - g^4 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4 * z)^(-1)*/ mload(add(denominatorsPtr, 0x80)),
                                  /*oods_coefficients[94]*/ mload(add(context, 0x6ea0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[94]*/ mload(add(context, 0x4de0)))),
                           PRIME))

                // res += c_95*(f_7(x) - f_7(g^5 * z)) / (x - g^5 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^5 * z)^(-1)*/ mload(add(denominatorsPtr, 0xa0)),
                                  /*oods_coefficients[95]*/ mload(add(context, 0x6ec0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[95]*/ mload(add(context, 0x4e00)))),
                           PRIME))

                // res += c_96*(f_7(x) - f_7(g^6 * z)) / (x - g^6 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^6 * z)^(-1)*/ mload(add(denominatorsPtr, 0xc0)),
                                  /*oods_coefficients[96]*/ mload(add(context, 0x6ee0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[96]*/ mload(add(context, 0x4e20)))),
                           PRIME))

                // res += c_97*(f_7(x) - f_7(g^7 * z)) / (x - g^7 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^7 * z)^(-1)*/ mload(add(denominatorsPtr, 0xe0)),
                                  /*oods_coefficients[97]*/ mload(add(context, 0x6f00)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[97]*/ mload(add(context, 0x4e40)))),
                           PRIME))

                // res += c_98*(f_7(x) - f_7(g^8 * z)) / (x - g^8 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8 * z)^(-1)*/ mload(add(denominatorsPtr, 0x100)),
                                  /*oods_coefficients[98]*/ mload(add(context, 0x6f20)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[98]*/ mload(add(context, 0x4e60)))),
                           PRIME))

                // res += c_99*(f_7(x) - f_7(g^9 * z)) / (x - g^9 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^9 * z)^(-1)*/ mload(add(denominatorsPtr, 0x120)),
                                  /*oods_coefficients[99]*/ mload(add(context, 0x6f40)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[99]*/ mload(add(context, 0x4e80)))),
                           PRIME))

                // res += c_100*(f_7(x) - f_7(g^11 * z)) / (x - g^11 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^11 * z)^(-1)*/ mload(add(denominatorsPtr, 0x160)),
                                  /*oods_coefficients[100]*/ mload(add(context, 0x6f60)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[100]*/ mload(add(context, 0x4ea0)))),
                           PRIME))

                // res += c_101*(f_7(x) - f_7(g^12 * z)) / (x - g^12 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^12 * z)^(-1)*/ mload(add(denominatorsPtr, 0x180)),
                                  /*oods_coefficients[101]*/ mload(add(context, 0x6f80)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[101]*/ mload(add(context, 0x4ec0)))),
                           PRIME))

                // res += c_102*(f_7(x) - f_7(g^13 * z)) / (x - g^13 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^13 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1a0)),
                                  /*oods_coefficients[102]*/ mload(add(context, 0x6fa0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[102]*/ mload(add(context, 0x4ee0)))),
                           PRIME))

                // res += c_103*(f_7(x) - f_7(g^15 * z)) / (x - g^15 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^15 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1e0)),
                                  /*oods_coefficients[103]*/ mload(add(context, 0x6fc0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[103]*/ mload(add(context, 0x4f00)))),
                           PRIME))

                // res += c_104*(f_7(x) - f_7(g^17 * z)) / (x - g^17 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^17 * z)^(-1)*/ mload(add(denominatorsPtr, 0x220)),
                                  /*oods_coefficients[104]*/ mload(add(context, 0x6fe0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[104]*/ mload(add(context, 0x4f20)))),
                           PRIME))

                // res += c_105*(f_7(x) - f_7(g^19 * z)) / (x - g^19 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^19 * z)^(-1)*/ mload(add(denominatorsPtr, 0x260)),
                                  /*oods_coefficients[105]*/ mload(add(context, 0x7000)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[105]*/ mload(add(context, 0x4f40)))),
                           PRIME))

                // res += c_106*(f_7(x) - f_7(g^27 * z)) / (x - g^27 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^27 * z)^(-1)*/ mload(add(denominatorsPtr, 0x2e0)),
                                  /*oods_coefficients[106]*/ mload(add(context, 0x7020)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[106]*/ mload(add(context, 0x4f60)))),
                           PRIME))

                // res += c_107*(f_7(x) - f_7(g^33 * z)) / (x - g^33 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^33 * z)^(-1)*/ mload(add(denominatorsPtr, 0x320)),
                                  /*oods_coefficients[107]*/ mload(add(context, 0x7040)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[107]*/ mload(add(context, 0x4f80)))),
                           PRIME))

                // res += c_108*(f_7(x) - f_7(g^44 * z)) / (x - g^44 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^44 * z)^(-1)*/ mload(add(denominatorsPtr, 0x3c0)),
                                  /*oods_coefficients[108]*/ mload(add(context, 0x7060)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[108]*/ mload(add(context, 0x4fa0)))),
                           PRIME))

                // res += c_109*(f_7(x) - f_7(g^49 * z)) / (x - g^49 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^49 * z)^(-1)*/ mload(add(denominatorsPtr, 0x3e0)),
                                  /*oods_coefficients[109]*/ mload(add(context, 0x7080)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[109]*/ mload(add(context, 0x4fc0)))),
                           PRIME))

                // res += c_110*(f_7(x) - f_7(g^65 * z)) / (x - g^65 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^65 * z)^(-1)*/ mload(add(denominatorsPtr, 0x480)),
                                  /*oods_coefficients[110]*/ mload(add(context, 0x70a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[110]*/ mload(add(context, 0x4fe0)))),
                           PRIME))

                // res += c_111*(f_7(x) - f_7(g^76 * z)) / (x - g^76 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^76 * z)^(-1)*/ mload(add(denominatorsPtr, 0x520)),
                                  /*oods_coefficients[111]*/ mload(add(context, 0x70c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[111]*/ mload(add(context, 0x5000)))),
                           PRIME))

                // res += c_112*(f_7(x) - f_7(g^81 * z)) / (x - g^81 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^81 * z)^(-1)*/ mload(add(denominatorsPtr, 0x540)),
                                  /*oods_coefficients[112]*/ mload(add(context, 0x70e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[112]*/ mload(add(context, 0x5020)))),
                           PRIME))

                // res += c_113*(f_7(x) - f_7(g^97 * z)) / (x - g^97 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^97 * z)^(-1)*/ mload(add(denominatorsPtr, 0x5e0)),
                                  /*oods_coefficients[113]*/ mload(add(context, 0x7100)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[113]*/ mload(add(context, 0x5040)))),
                           PRIME))

                // res += c_114*(f_7(x) - f_7(g^108 * z)) / (x - g^108 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^108 * z)^(-1)*/ mload(add(denominatorsPtr, 0x660)),
                                  /*oods_coefficients[114]*/ mload(add(context, 0x7120)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[114]*/ mload(add(context, 0x5060)))),
                           PRIME))

                // res += c_115*(f_7(x) - f_7(g^113 * z)) / (x - g^113 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^113 * z)^(-1)*/ mload(add(denominatorsPtr, 0x680)),
                                  /*oods_coefficients[115]*/ mload(add(context, 0x7140)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[115]*/ mload(add(context, 0x5080)))),
                           PRIME))

                // res += c_116*(f_7(x) - f_7(g^129 * z)) / (x - g^129 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^129 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6c0)),
                                  /*oods_coefficients[116]*/ mload(add(context, 0x7160)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[116]*/ mload(add(context, 0x50a0)))),
                           PRIME))

                // res += c_117*(f_7(x) - f_7(g^140 * z)) / (x - g^140 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^140 * z)^(-1)*/ mload(add(denominatorsPtr, 0x720)),
                                  /*oods_coefficients[117]*/ mload(add(context, 0x7180)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[117]*/ mload(add(context, 0x50c0)))),
                           PRIME))

                // res += c_118*(f_7(x) - f_7(g^145 * z)) / (x - g^145 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^145 * z)^(-1)*/ mload(add(denominatorsPtr, 0x740)),
                                  /*oods_coefficients[118]*/ mload(add(context, 0x71a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[118]*/ mload(add(context, 0x50e0)))),
                           PRIME))

                // res += c_119*(f_7(x) - f_7(g^161 * z)) / (x - g^161 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^161 * z)^(-1)*/ mload(add(denominatorsPtr, 0x760)),
                                  /*oods_coefficients[119]*/ mload(add(context, 0x71c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[119]*/ mload(add(context, 0x5100)))),
                           PRIME))

                // res += c_120*(f_7(x) - f_7(g^172 * z)) / (x - g^172 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^172 * z)^(-1)*/ mload(add(denominatorsPtr, 0x7a0)),
                                  /*oods_coefficients[120]*/ mload(add(context, 0x71e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[120]*/ mload(add(context, 0x5120)))),
                           PRIME))

                // res += c_121*(f_7(x) - f_7(g^177 * z)) / (x - g^177 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^177 * z)^(-1)*/ mload(add(denominatorsPtr, 0x7c0)),
                                  /*oods_coefficients[121]*/ mload(add(context, 0x7200)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[121]*/ mload(add(context, 0x5140)))),
                           PRIME))

                // res += c_122*(f_7(x) - f_7(g^193 * z)) / (x - g^193 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^193 * z)^(-1)*/ mload(add(denominatorsPtr, 0x800)),
                                  /*oods_coefficients[122]*/ mload(add(context, 0x7220)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[122]*/ mload(add(context, 0x5160)))),
                           PRIME))

                // res += c_123*(f_7(x) - f_7(g^204 * z)) / (x - g^204 * z).
                res := addmod(
                    res,
                    mulmod(mulmod(/*(x - g^204 * z)^(-1)*/ mload(add(denominatorsPtr, 0x8a0)),
                                  /*oods_coefficients[123]*/ mload(add(context, 0x7240)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[123]*/ mload(add(context, 0x5180)))),
                           PRIME),
                    PRIME)

                // res += c_124*(f_7(x) - f_7(g^209 * z)) / (x - g^209 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^209 * z)^(-1)*/ mload(add(denominatorsPtr, 0x8c0)),
                                  /*oods_coefficients[124]*/ mload(add(context, 0x7260)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[124]*/ mload(add(context, 0x51a0)))),
                           PRIME))

                // res += c_125*(f_7(x) - f_7(g^225 * z)) / (x - g^225 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^225 * z)^(-1)*/ mload(add(denominatorsPtr, 0x8e0)),
                                  /*oods_coefficients[125]*/ mload(add(context, 0x7280)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[125]*/ mload(add(context, 0x51c0)))),
                           PRIME))

                // res += c_126*(f_7(x) - f_7(g^236 * z)) / (x - g^236 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^236 * z)^(-1)*/ mload(add(denominatorsPtr, 0x900)),
                                  /*oods_coefficients[126]*/ mload(add(context, 0x72a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[126]*/ mload(add(context, 0x51e0)))),
                           PRIME))

                // res += c_127*(f_7(x) - f_7(g^241 * z)) / (x - g^241 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^241 * z)^(-1)*/ mload(add(denominatorsPtr, 0x920)),
                                  /*oods_coefficients[127]*/ mload(add(context, 0x72c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[127]*/ mload(add(context, 0x5200)))),
                           PRIME))

                // res += c_128*(f_7(x) - f_7(g^257 * z)) / (x - g^257 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^257 * z)^(-1)*/ mload(add(denominatorsPtr, 0x9c0)),
                                  /*oods_coefficients[128]*/ mload(add(context, 0x72e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[128]*/ mload(add(context, 0x5220)))),
                           PRIME))

                // res += c_129*(f_7(x) - f_7(g^265 * z)) / (x - g^265 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^265 * z)^(-1)*/ mload(add(denominatorsPtr, 0xa20)),
                                  /*oods_coefficients[129]*/ mload(add(context, 0x7300)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[129]*/ mload(add(context, 0x5240)))),
                           PRIME))

                // res += c_130*(f_7(x) - f_7(g^513 * z)) / (x - g^513 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^513 * z)^(-1)*/ mload(add(denominatorsPtr, 0xae0)),
                                  /*oods_coefficients[130]*/ mload(add(context, 0x7320)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[130]*/ mload(add(context, 0x5260)))),
                           PRIME))

                // res += c_131*(f_7(x) - f_7(g^521 * z)) / (x - g^521 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^521 * z)^(-1)*/ mload(add(denominatorsPtr, 0xb20)),
                                  /*oods_coefficients[131]*/ mload(add(context, 0x7340)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[131]*/ mload(add(context, 0x5280)))),
                           PRIME))

                // res += c_132*(f_7(x) - f_7(g^705 * z)) / (x - g^705 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^705 * z)^(-1)*/ mload(add(denominatorsPtr, 0xb40)),
                                  /*oods_coefficients[132]*/ mload(add(context, 0x7360)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[132]*/ mload(add(context, 0x52a0)))),
                           PRIME))

                // res += c_133*(f_7(x) - f_7(g^721 * z)) / (x - g^721 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^721 * z)^(-1)*/ mload(add(denominatorsPtr, 0xb80)),
                                  /*oods_coefficients[133]*/ mload(add(context, 0x7380)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[133]*/ mload(add(context, 0x52c0)))),
                           PRIME))

                // res += c_134*(f_7(x) - f_7(g^737 * z)) / (x - g^737 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^737 * z)^(-1)*/ mload(add(denominatorsPtr, 0xba0)),
                                  /*oods_coefficients[134]*/ mload(add(context, 0x73a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[134]*/ mload(add(context, 0x52e0)))),
                           PRIME))

                // res += c_135*(f_7(x) - f_7(g^753 * z)) / (x - g^753 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^753 * z)^(-1)*/ mload(add(denominatorsPtr, 0xbc0)),
                                  /*oods_coefficients[135]*/ mload(add(context, 0x73c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[135]*/ mload(add(context, 0x5300)))),
                           PRIME))

                // res += c_136*(f_7(x) - f_7(g^769 * z)) / (x - g^769 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^769 * z)^(-1)*/ mload(add(denominatorsPtr, 0xbe0)),
                                  /*oods_coefficients[136]*/ mload(add(context, 0x73e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[136]*/ mload(add(context, 0x5320)))),
                           PRIME))

                // res += c_137*(f_7(x) - f_7(g^777 * z)) / (x - g^777 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^777 * z)^(-1)*/ mload(add(denominatorsPtr, 0xc00)),
                                  /*oods_coefficients[137]*/ mload(add(context, 0x7400)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[137]*/ mload(add(context, 0x5340)))),
                           PRIME))

                // res += c_138*(f_7(x) - f_7(g^961 * z)) / (x - g^961 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^961 * z)^(-1)*/ mload(add(denominatorsPtr, 0xc60)),
                                  /*oods_coefficients[138]*/ mload(add(context, 0x7420)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[138]*/ mload(add(context, 0x5360)))),
                           PRIME))

                // res += c_139*(f_7(x) - f_7(g^977 * z)) / (x - g^977 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^977 * z)^(-1)*/ mload(add(denominatorsPtr, 0xcc0)),
                                  /*oods_coefficients[139]*/ mload(add(context, 0x7440)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[139]*/ mload(add(context, 0x5380)))),
                           PRIME))

                // res += c_140*(f_7(x) - f_7(g^993 * z)) / (x - g^993 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^993 * z)^(-1)*/ mload(add(denominatorsPtr, 0xce0)),
                                  /*oods_coefficients[140]*/ mload(add(context, 0x7460)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[140]*/ mload(add(context, 0x53a0)))),
                           PRIME))

                // res += c_141*(f_7(x) - f_7(g^1009 * z)) / (x - g^1009 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^1009 * z)^(-1)*/ mload(add(denominatorsPtr, 0xd00)),
                                  /*oods_coefficients[141]*/ mload(add(context, 0x7480)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[141]*/ mload(add(context, 0x53c0)))),
                           PRIME))
                }

                // Mask items for column #8.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x100)), kMontgomeryRInv, PRIME)

                // res += c_142*(f_8(x) - f_8(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[142]*/ mload(add(context, 0x74a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[142]*/ mload(add(context, 0x53e0)))),
                           PRIME))

                // res += c_143*(f_8(x) - f_8(g^2 * z)) / (x - g^2 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2 * z)^(-1)*/ mload(add(denominatorsPtr, 0x40)),
                                  /*oods_coefficients[143]*/ mload(add(context, 0x74c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[143]*/ mload(add(context, 0x5400)))),
                           PRIME))

                // res += c_144*(f_8(x) - f_8(g^4 * z)) / (x - g^4 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4 * z)^(-1)*/ mload(add(denominatorsPtr, 0x80)),
                                  /*oods_coefficients[144]*/ mload(add(context, 0x74e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[144]*/ mload(add(context, 0x5420)))),
                           PRIME))

                // res += c_145*(f_8(x) - f_8(g^6 * z)) / (x - g^6 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^6 * z)^(-1)*/ mload(add(denominatorsPtr, 0xc0)),
                                  /*oods_coefficients[145]*/ mload(add(context, 0x7500)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[145]*/ mload(add(context, 0x5440)))),
                           PRIME))

                // res += c_146*(f_8(x) - f_8(g^8 * z)) / (x - g^8 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8 * z)^(-1)*/ mload(add(denominatorsPtr, 0x100)),
                                  /*oods_coefficients[146]*/ mload(add(context, 0x7520)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[146]*/ mload(add(context, 0x5460)))),
                           PRIME))

                // res += c_147*(f_8(x) - f_8(g^10 * z)) / (x - g^10 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^10 * z)^(-1)*/ mload(add(denominatorsPtr, 0x140)),
                                  /*oods_coefficients[147]*/ mload(add(context, 0x7540)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[147]*/ mload(add(context, 0x5480)))),
                           PRIME))

                // res += c_148*(f_8(x) - f_8(g^12 * z)) / (x - g^12 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^12 * z)^(-1)*/ mload(add(denominatorsPtr, 0x180)),
                                  /*oods_coefficients[148]*/ mload(add(context, 0x7560)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[148]*/ mload(add(context, 0x54a0)))),
                           PRIME))

                // res += c_149*(f_8(x) - f_8(g^18 * z)) / (x - g^18 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^18 * z)^(-1)*/ mload(add(denominatorsPtr, 0x240)),
                                  /*oods_coefficients[149]*/ mload(add(context, 0x7580)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[149]*/ mload(add(context, 0x54c0)))),
                           PRIME))

                // res += c_150*(f_8(x) - f_8(g^20 * z)) / (x - g^20 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^20 * z)^(-1)*/ mload(add(denominatorsPtr, 0x280)),
                                  /*oods_coefficients[150]*/ mload(add(context, 0x75a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[150]*/ mload(add(context, 0x54e0)))),
                           PRIME))

                // res += c_151*(f_8(x) - f_8(g^22 * z)) / (x - g^22 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^22 * z)^(-1)*/ mload(add(denominatorsPtr, 0x2a0)),
                                  /*oods_coefficients[151]*/ mload(add(context, 0x75c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[151]*/ mload(add(context, 0x5500)))),
                           PRIME))

                // res += c_152*(f_8(x) - f_8(g^26 * z)) / (x - g^26 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^26 * z)^(-1)*/ mload(add(denominatorsPtr, 0x2c0)),
                                  /*oods_coefficients[152]*/ mload(add(context, 0x75e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[152]*/ mload(add(context, 0x5520)))),
                           PRIME))

                // res += c_153*(f_8(x) - f_8(g^28 * z)) / (x - g^28 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^28 * z)^(-1)*/ mload(add(denominatorsPtr, 0x300)),
                                  /*oods_coefficients[153]*/ mload(add(context, 0x7600)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[153]*/ mload(add(context, 0x5540)))),
                           PRIME))

                // res += c_154*(f_8(x) - f_8(g^34 * z)) / (x - g^34 * z).
                res := addmod(
                    res,
                    mulmod(mulmod(/*(x - g^34 * z)^(-1)*/ mload(add(denominatorsPtr, 0x340)),
                                  /*oods_coefficients[154]*/ mload(add(context, 0x7620)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[154]*/ mload(add(context, 0x5560)))),
                           PRIME),
                    PRIME)

                // res += c_155*(f_8(x) - f_8(g^36 * z)) / (x - g^36 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^36 * z)^(-1)*/ mload(add(denominatorsPtr, 0x360)),
                                  /*oods_coefficients[155]*/ mload(add(context, 0x7640)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[155]*/ mload(add(context, 0x5580)))),
                           PRIME))

                // res += c_156*(f_8(x) - f_8(g^38 * z)) / (x - g^38 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^38 * z)^(-1)*/ mload(add(denominatorsPtr, 0x380)),
                                  /*oods_coefficients[156]*/ mload(add(context, 0x7660)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[156]*/ mload(add(context, 0x55a0)))),
                           PRIME))

                // res += c_157*(f_8(x) - f_8(g^42 * z)) / (x - g^42 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^42 * z)^(-1)*/ mload(add(denominatorsPtr, 0x3a0)),
                                  /*oods_coefficients[157]*/ mload(add(context, 0x7680)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[157]*/ mload(add(context, 0x55c0)))),
                           PRIME))

                // res += c_158*(f_8(x) - f_8(g^44 * z)) / (x - g^44 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^44 * z)^(-1)*/ mload(add(denominatorsPtr, 0x3c0)),
                                  /*oods_coefficients[158]*/ mload(add(context, 0x76a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[158]*/ mload(add(context, 0x55e0)))),
                           PRIME))

                // res += c_159*(f_8(x) - f_8(g^50 * z)) / (x - g^50 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^50 * z)^(-1)*/ mload(add(denominatorsPtr, 0x400)),
                                  /*oods_coefficients[159]*/ mload(add(context, 0x76c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[159]*/ mload(add(context, 0x5600)))),
                           PRIME))

                // res += c_160*(f_8(x) - f_8(g^52 * z)) / (x - g^52 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^52 * z)^(-1)*/ mload(add(denominatorsPtr, 0x420)),
                                  /*oods_coefficients[160]*/ mload(add(context, 0x76e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[160]*/ mload(add(context, 0x5620)))),
                           PRIME))

                // res += c_161*(f_8(x) - f_8(g^58 * z)) / (x - g^58 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^58 * z)^(-1)*/ mload(add(denominatorsPtr, 0x440)),
                                  /*oods_coefficients[161]*/ mload(add(context, 0x7700)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[161]*/ mload(add(context, 0x5640)))),
                           PRIME))

                // res += c_162*(f_8(x) - f_8(g^60 * z)) / (x - g^60 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^60 * z)^(-1)*/ mload(add(denominatorsPtr, 0x460)),
                                  /*oods_coefficients[162]*/ mload(add(context, 0x7720)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[162]*/ mload(add(context, 0x5660)))),
                           PRIME))

                // res += c_163*(f_8(x) - f_8(g^66 * z)) / (x - g^66 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^66 * z)^(-1)*/ mload(add(denominatorsPtr, 0x4a0)),
                                  /*oods_coefficients[163]*/ mload(add(context, 0x7740)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[163]*/ mload(add(context, 0x5680)))),
                           PRIME))

                // res += c_164*(f_8(x) - f_8(g^68 * z)) / (x - g^68 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^68 * z)^(-1)*/ mload(add(denominatorsPtr, 0x4c0)),
                                  /*oods_coefficients[164]*/ mload(add(context, 0x7760)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[164]*/ mload(add(context, 0x56a0)))),
                           PRIME))

                // res += c_165*(f_8(x) - f_8(g^70 * z)) / (x - g^70 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^70 * z)^(-1)*/ mload(add(denominatorsPtr, 0x4e0)),
                                  /*oods_coefficients[165]*/ mload(add(context, 0x7780)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[165]*/ mload(add(context, 0x56c0)))),
                           PRIME))

                // res += c_166*(f_8(x) - f_8(g^76 * z)) / (x - g^76 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^76 * z)^(-1)*/ mload(add(denominatorsPtr, 0x520)),
                                  /*oods_coefficients[166]*/ mload(add(context, 0x77a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[166]*/ mload(add(context, 0x56e0)))),
                           PRIME))

                // res += c_167*(f_8(x) - f_8(g^82 * z)) / (x - g^82 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^82 * z)^(-1)*/ mload(add(denominatorsPtr, 0x560)),
                                  /*oods_coefficients[167]*/ mload(add(context, 0x77c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[167]*/ mload(add(context, 0x5700)))),
                           PRIME))

                // res += c_168*(f_8(x) - f_8(g^84 * z)) / (x - g^84 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^84 * z)^(-1)*/ mload(add(denominatorsPtr, 0x580)),
                                  /*oods_coefficients[168]*/ mload(add(context, 0x77e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[168]*/ mload(add(context, 0x5720)))),
                           PRIME))

                // res += c_169*(f_8(x) - f_8(g^86 * z)) / (x - g^86 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^86 * z)^(-1)*/ mload(add(denominatorsPtr, 0x5a0)),
                                  /*oods_coefficients[169]*/ mload(add(context, 0x7800)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[169]*/ mload(add(context, 0x5740)))),
                           PRIME))

                // res += c_170*(f_8(x) - f_8(g^92 * z)) / (x - g^92 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^92 * z)^(-1)*/ mload(add(denominatorsPtr, 0x5c0)),
                                  /*oods_coefficients[170]*/ mload(add(context, 0x7820)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[170]*/ mload(add(context, 0x5760)))),
                           PRIME))

                // res += c_171*(f_8(x) - f_8(g^98 * z)) / (x - g^98 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^98 * z)^(-1)*/ mload(add(denominatorsPtr, 0x600)),
                                  /*oods_coefficients[171]*/ mload(add(context, 0x7840)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[171]*/ mload(add(context, 0x5780)))),
                           PRIME))

                // res += c_172*(f_8(x) - f_8(g^100 * z)) / (x - g^100 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^100 * z)^(-1)*/ mload(add(denominatorsPtr, 0x620)),
                                  /*oods_coefficients[172]*/ mload(add(context, 0x7860)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[172]*/ mload(add(context, 0x57a0)))),
                           PRIME))

                // res += c_173*(f_8(x) - f_8(g^102 * z)) / (x - g^102 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^102 * z)^(-1)*/ mload(add(denominatorsPtr, 0x640)),
                                  /*oods_coefficients[173]*/ mload(add(context, 0x7880)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[173]*/ mload(add(context, 0x57c0)))),
                           PRIME))

                // res += c_174*(f_8(x) - f_8(g^108 * z)) / (x - g^108 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^108 * z)^(-1)*/ mload(add(denominatorsPtr, 0x660)),
                                  /*oods_coefficients[174]*/ mload(add(context, 0x78a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[174]*/ mload(add(context, 0x57e0)))),
                           PRIME))

                // res += c_175*(f_8(x) - f_8(g^116 * z)) / (x - g^116 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^116 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6a0)),
                                  /*oods_coefficients[175]*/ mload(add(context, 0x78c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[175]*/ mload(add(context, 0x5800)))),
                           PRIME))

                // res += c_176*(f_8(x) - f_8(g^134 * z)) / (x - g^134 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^134 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6e0)),
                                  /*oods_coefficients[176]*/ mload(add(context, 0x78e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[176]*/ mload(add(context, 0x5820)))),
                           PRIME))

                // res += c_177*(f_8(x) - f_8(g^166 * z)) / (x - g^166 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^166 * z)^(-1)*/ mload(add(denominatorsPtr, 0x780)),
                                  /*oods_coefficients[177]*/ mload(add(context, 0x7900)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[177]*/ mload(add(context, 0x5840)))),
                           PRIME))

                // res += c_178*(f_8(x) - f_8(g^198 * z)) / (x - g^198 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^198 * z)^(-1)*/ mload(add(denominatorsPtr, 0x860)),
                                  /*oods_coefficients[178]*/ mload(add(context, 0x7920)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[178]*/ mload(add(context, 0x5860)))),
                           PRIME))

                // res += c_179*(f_8(x) - f_8(g^12306 * z)) / (x - g^12306 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^12306 * z)^(-1)*/ mload(add(denominatorsPtr, 0xe80)),
                                  /*oods_coefficients[179]*/ mload(add(context, 0x7940)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[179]*/ mload(add(context, 0x5880)))),
                           PRIME))

                // res += c_180*(f_8(x) - f_8(g^12370 * z)) / (x - g^12370 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^12370 * z)^(-1)*/ mload(add(denominatorsPtr, 0xea0)),
                                  /*oods_coefficients[180]*/ mload(add(context, 0x7960)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[180]*/ mload(add(context, 0x58a0)))),
                           PRIME))

                // res += c_181*(f_8(x) - f_8(g^12562 * z)) / (x - g^12562 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^12562 * z)^(-1)*/ mload(add(denominatorsPtr, 0xec0)),
                                  /*oods_coefficients[181]*/ mload(add(context, 0x7980)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[181]*/ mload(add(context, 0x58c0)))),
                           PRIME))

                // res += c_182*(f_8(x) - f_8(g^12626 * z)) / (x - g^12626 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^12626 * z)^(-1)*/ mload(add(denominatorsPtr, 0xee0)),
                                  /*oods_coefficients[182]*/ mload(add(context, 0x79a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[182]*/ mload(add(context, 0x58e0)))),
                           PRIME))

                // res += c_183*(f_8(x) - f_8(g^16082 * z)) / (x - g^16082 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16082 * z)^(-1)*/ mload(add(denominatorsPtr, 0xf80)),
                                  /*oods_coefficients[183]*/ mload(add(context, 0x79c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[183]*/ mload(add(context, 0x5900)))),
                           PRIME))

                // res += c_184*(f_8(x) - f_8(g^16146 * z)) / (x - g^16146 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16146 * z)^(-1)*/ mload(add(denominatorsPtr, 0xfa0)),
                                  /*oods_coefficients[184]*/ mload(add(context, 0x79e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[184]*/ mload(add(context, 0x5920)))),
                           PRIME))

                // res += c_185*(f_8(x) - f_8(g^16322 * z)) / (x - g^16322 * z).
                res := addmod(
                    res,
                    mulmod(mulmod(/*(x - g^16322 * z)^(-1)*/ mload(add(denominatorsPtr, 0xfc0)),
                                  /*oods_coefficients[185]*/ mload(add(context, 0x7a00)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[185]*/ mload(add(context, 0x5940)))),
                           PRIME),
                    PRIME)

                // res += c_186*(f_8(x) - f_8(g^16330 * z)) / (x - g^16330 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16330 * z)^(-1)*/ mload(add(denominatorsPtr, 0xfe0)),
                                  /*oods_coefficients[186]*/ mload(add(context, 0x7a20)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[186]*/ mload(add(context, 0x5960)))),
                           PRIME))

                // res += c_187*(f_8(x) - f_8(g^16340 * z)) / (x - g^16340 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16340 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1000)),
                                  /*oods_coefficients[187]*/ mload(add(context, 0x7a40)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[187]*/ mload(add(context, 0x5980)))),
                           PRIME))

                // res += c_188*(f_8(x) - f_8(g^16346 * z)) / (x - g^16346 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16346 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1020)),
                                  /*oods_coefficients[188]*/ mload(add(context, 0x7a60)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[188]*/ mload(add(context, 0x59a0)))),
                           PRIME))

                // res += c_189*(f_8(x) - f_8(g^16354 * z)) / (x - g^16354 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16354 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1040)),
                                  /*oods_coefficients[189]*/ mload(add(context, 0x7a80)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[189]*/ mload(add(context, 0x59c0)))),
                           PRIME))

                // res += c_190*(f_8(x) - f_8(g^16362 * z)) / (x - g^16362 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16362 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1060)),
                                  /*oods_coefficients[190]*/ mload(add(context, 0x7aa0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[190]*/ mload(add(context, 0x59e0)))),
                           PRIME))

                // res += c_191*(f_8(x) - f_8(g^16370 * z)) / (x - g^16370 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16370 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1080)),
                                  /*oods_coefficients[191]*/ mload(add(context, 0x7ac0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[191]*/ mload(add(context, 0x5a00)))),
                           PRIME))

                // res += c_192*(f_8(x) - f_8(g^16372 * z)) / (x - g^16372 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16372 * z)^(-1)*/ mload(add(denominatorsPtr, 0x10a0)),
                                  /*oods_coefficients[192]*/ mload(add(context, 0x7ae0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[192]*/ mload(add(context, 0x5a20)))),
                           PRIME))

                // res += c_193*(f_8(x) - f_8(g^16378 * z)) / (x - g^16378 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16378 * z)^(-1)*/ mload(add(denominatorsPtr, 0x10c0)),
                                  /*oods_coefficients[193]*/ mload(add(context, 0x7b00)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[193]*/ mload(add(context, 0x5a40)))),
                           PRIME))

                // res += c_194*(f_8(x) - f_8(g^16388 * z)) / (x - g^16388 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16388 * z)^(-1)*/ mload(add(denominatorsPtr, 0x10e0)),
                                  /*oods_coefficients[194]*/ mload(add(context, 0x7b20)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[194]*/ mload(add(context, 0x5a60)))),
                           PRIME))

                // res += c_195*(f_8(x) - f_8(g^16420 * z)) / (x - g^16420 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16420 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1100)),
                                  /*oods_coefficients[195]*/ mload(add(context, 0x7b40)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[195]*/ mload(add(context, 0x5a80)))),
                           PRIME))

                // res += c_196*(f_8(x) - f_8(g^32646 * z)) / (x - g^32646 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^32646 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1180)),
                                  /*oods_coefficients[196]*/ mload(add(context, 0x7b60)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[196]*/ mload(add(context, 0x5aa0)))),
                           PRIME))

                // res += c_197*(f_8(x) - f_8(g^32662 * z)) / (x - g^32662 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^32662 * z)^(-1)*/ mload(add(denominatorsPtr, 0x11a0)),
                                  /*oods_coefficients[197]*/ mload(add(context, 0x7b80)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[197]*/ mload(add(context, 0x5ac0)))),
                           PRIME))

                // res += c_198*(f_8(x) - f_8(g^32710 * z)) / (x - g^32710 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^32710 * z)^(-1)*/ mload(add(denominatorsPtr, 0x11c0)),
                                  /*oods_coefficients[198]*/ mload(add(context, 0x7ba0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[198]*/ mload(add(context, 0x5ae0)))),
                           PRIME))

                // res += c_199*(f_8(x) - f_8(g^32724 * z)) / (x - g^32724 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^32724 * z)^(-1)*/ mload(add(denominatorsPtr, 0x11e0)),
                                  /*oods_coefficients[199]*/ mload(add(context, 0x7bc0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[199]*/ mload(add(context, 0x5b00)))),
                           PRIME))

                // res += c_200*(f_8(x) - f_8(g^32730 * z)) / (x - g^32730 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^32730 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1200)),
                                  /*oods_coefficients[200]*/ mload(add(context, 0x7be0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[200]*/ mload(add(context, 0x5b20)))),
                           PRIME))

                // res += c_201*(f_8(x) - f_8(g^32742 * z)) / (x - g^32742 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^32742 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1220)),
                                  /*oods_coefficients[201]*/ mload(add(context, 0x7c00)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[201]*/ mload(add(context, 0x5b40)))),
                           PRIME))

                // res += c_202*(f_8(x) - f_8(g^32756 * z)) / (x - g^32756 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^32756 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1240)),
                                  /*oods_coefficients[202]*/ mload(add(context, 0x7c20)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[202]*/ mload(add(context, 0x5b60)))),
                           PRIME))

                // res += c_203*(f_8(x) - f_8(g^32762 * z)) / (x - g^32762 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^32762 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1260)),
                                  /*oods_coefficients[203]*/ mload(add(context, 0x7c40)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[203]*/ mload(add(context, 0x5b80)))),
                           PRIME))
                }

                // Mask items for column #9.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x120)), kMontgomeryRInv, PRIME)

                // res += c_204*(f_9(x) - f_9(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[204]*/ mload(add(context, 0x7c60)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[204]*/ mload(add(context, 0x5ba0)))),
                           PRIME))

                // res += c_205*(f_9(x) - f_9(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  /*oods_coefficients[205]*/ mload(add(context, 0x7c80)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[205]*/ mload(add(context, 0x5bc0)))),
                           PRIME))

                // res += c_206*(f_9(x) - f_9(g^2 * z)) / (x - g^2 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2 * z)^(-1)*/ mload(add(denominatorsPtr, 0x40)),
                                  /*oods_coefficients[206]*/ mload(add(context, 0x7ca0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[206]*/ mload(add(context, 0x5be0)))),
                           PRIME))

                // res += c_207*(f_9(x) - f_9(g^3 * z)) / (x - g^3 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3 * z)^(-1)*/ mload(add(denominatorsPtr, 0x60)),
                                  /*oods_coefficients[207]*/ mload(add(context, 0x7cc0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[207]*/ mload(add(context, 0x5c00)))),
                           PRIME))

                // res += c_208*(f_9(x) - f_9(g^5 * z)) / (x - g^5 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^5 * z)^(-1)*/ mload(add(denominatorsPtr, 0xa0)),
                                  /*oods_coefficients[208]*/ mload(add(context, 0x7ce0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[208]*/ mload(add(context, 0x5c20)))),
                           PRIME))

                // res += c_209*(f_9(x) - f_9(g^7 * z)) / (x - g^7 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^7 * z)^(-1)*/ mload(add(denominatorsPtr, 0xe0)),
                                  /*oods_coefficients[209]*/ mload(add(context, 0x7d00)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[209]*/ mload(add(context, 0x5c40)))),
                           PRIME))

                // res += c_210*(f_9(x) - f_9(g^11 * z)) / (x - g^11 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^11 * z)^(-1)*/ mload(add(denominatorsPtr, 0x160)),
                                  /*oods_coefficients[210]*/ mload(add(context, 0x7d20)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[210]*/ mload(add(context, 0x5c60)))),
                           PRIME))

                // res += c_211*(f_9(x) - f_9(g^15 * z)) / (x - g^15 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^15 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1e0)),
                                  /*oods_coefficients[211]*/ mload(add(context, 0x7d40)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[211]*/ mload(add(context, 0x5c80)))),
                           PRIME))
                }

                // Advance traceQueryResponses by amount read (0x20 * nTraceColumns).
                traceQueryResponses := add(traceQueryResponses, 0x140)

                // Composition constraints.

                {
                // Read the next element.
                let columnValue := mulmod(mload(compositionQueryResponses), kMontgomeryRInv, PRIME)
                // res += c_212*(h_0(x) - C_0(z^2)) / (x - z^2).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z^2)^(-1)*/ mload(add(denominatorsPtr, 0x12a0)),
                                  /*oods_coefficients[212]*/ mload(add(context, 0x7d60)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*composition_oods_values[0]*/ mload(add(context, 0x5ca0)))),
                           PRIME))
                }

                {
                // Read the next element.
                let columnValue := mulmod(mload(add(compositionQueryResponses, 0x20)), kMontgomeryRInv, PRIME)
                // res += c_213*(h_1(x) - C_1(z^2)) / (x - z^2).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z^2)^(-1)*/ mload(add(denominatorsPtr, 0x12a0)),
                                  /*oods_coefficients[213]*/ mload(add(context, 0x7d80)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*composition_oods_values[1]*/ mload(add(context, 0x5cc0)))),
                           PRIME))
                }

                // Advance compositionQueryResponses by amount read (0x20 * constraintDegree).
                compositionQueryResponses := add(compositionQueryResponses, 0x40)

                // Append the friValue, which is the sum of the out-of-domain-sampling boundary
                // constraints for the trace and composition polynomials, to the friQueue array.
                mstore(add(friQueue, 0x20), mod(res, PRIME))

                // Append the friInvPoint of the current query to the friQueue array.
                mstore(add(friQueue, 0x40), /*friInvPoint*/ mload(add(denominatorsPtr,0x12c0)))

                // Advance denominatorsPtr by chunk size (0x20 * (2+N_ROWS_IN_MASK)).
                denominatorsPtr := add(denominatorsPtr, 0x12e0)
            }
            return(/*friQueue*/ add(context, 0xdc0), 0x1200)
        }
    }

    /*
      Computes and performs batch inverse on all the denominators required for the out of domain
      sampling boundary constraints.

      Since the friEvalPoints are calculated during the computation of the denominators
      this function also adds those to the batch inverse in preparation for the fri that follows.

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
        //    expmodsAndPoints[0:34] (.expmods) expmods used during calculations of the points below.
        //    expmodsAndPoints[34:183] (.points) points used during the denominators calculation.
        uint256[183] memory expmodsAndPoints;
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

            let traceGenerator := /*trace_generator*/ mload(add(context, 0x2c40))
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

            // expmodsAndPoints.expmods[5] = traceGenerator^8.
            mstore(add(expmodsAndPoints, 0xa0),
                   mulmod(mload(add(expmodsAndPoints, 0x80)), // traceGenerator^6
                          mload(expmodsAndPoints), // traceGenerator^2
                          PRIME))

            // expmodsAndPoints.expmods[6] = traceGenerator^10.
            mstore(add(expmodsAndPoints, 0xc0),
                   mulmod(mload(add(expmodsAndPoints, 0xa0)), // traceGenerator^8
                          mload(expmodsAndPoints), // traceGenerator^2
                          PRIME))

            // expmodsAndPoints.expmods[7] = traceGenerator^11.
            mstore(add(expmodsAndPoints, 0xe0),
                   mulmod(mload(add(expmodsAndPoints, 0xc0)), // traceGenerator^10
                          traceGenerator, // traceGenerator^1
                          PRIME))

            // expmodsAndPoints.expmods[8] = traceGenerator^12.
            mstore(add(expmodsAndPoints, 0x100),
                   mulmod(mload(add(expmodsAndPoints, 0xe0)), // traceGenerator^11
                          traceGenerator, // traceGenerator^1
                          PRIME))

            // expmodsAndPoints.expmods[9] = traceGenerator^13.
            mstore(add(expmodsAndPoints, 0x120),
                   mulmod(mload(add(expmodsAndPoints, 0x100)), // traceGenerator^12
                          traceGenerator, // traceGenerator^1
                          PRIME))

            // expmodsAndPoints.expmods[10] = traceGenerator^14.
            mstore(add(expmodsAndPoints, 0x140),
                   mulmod(mload(add(expmodsAndPoints, 0x120)), // traceGenerator^13
                          traceGenerator, // traceGenerator^1
                          PRIME))

            // expmodsAndPoints.expmods[11] = traceGenerator^15.
            mstore(add(expmodsAndPoints, 0x160),
                   mulmod(mload(add(expmodsAndPoints, 0x140)), // traceGenerator^14
                          traceGenerator, // traceGenerator^1
                          PRIME))

            // expmodsAndPoints.expmods[12] = traceGenerator^16.
            mstore(add(expmodsAndPoints, 0x180),
                   mulmod(mload(add(expmodsAndPoints, 0x160)), // traceGenerator^15
                          traceGenerator, // traceGenerator^1
                          PRIME))

            // expmodsAndPoints.expmods[13] = traceGenerator^32.
            mstore(add(expmodsAndPoints, 0x1a0),
                   mulmod(mload(add(expmodsAndPoints, 0x180)), // traceGenerator^16
                          mload(add(expmodsAndPoints, 0x180)), // traceGenerator^16
                          PRIME))

            // expmodsAndPoints.expmods[14] = traceGenerator^48.
            mstore(add(expmodsAndPoints, 0x1c0),
                   mulmod(mload(add(expmodsAndPoints, 0x1a0)), // traceGenerator^32
                          mload(add(expmodsAndPoints, 0x180)), // traceGenerator^16
                          PRIME))

            // expmodsAndPoints.expmods[15] = traceGenerator^52.
            mstore(add(expmodsAndPoints, 0x1e0),
                   mulmod(mload(add(expmodsAndPoints, 0x1c0)), // traceGenerator^48
                          mload(add(expmodsAndPoints, 0x40)), // traceGenerator^4
                          PRIME))

            // expmodsAndPoints.expmods[16] = traceGenerator^57.
            mstore(add(expmodsAndPoints, 0x200),
                   mulmod(mload(add(expmodsAndPoints, 0x1e0)), // traceGenerator^52
                          mload(add(expmodsAndPoints, 0x60)), // traceGenerator^5
                          PRIME))

            // expmodsAndPoints.expmods[17] = traceGenerator^58.
            mstore(add(expmodsAndPoints, 0x220),
                   mulmod(mload(add(expmodsAndPoints, 0x200)), // traceGenerator^57
                          traceGenerator, // traceGenerator^1
                          PRIME))

            // expmodsAndPoints.expmods[18] = traceGenerator^61.
            mstore(add(expmodsAndPoints, 0x240),
                   mulmod(mload(add(expmodsAndPoints, 0x220)), // traceGenerator^58
                          mload(add(expmodsAndPoints, 0x20)), // traceGenerator^3
                          PRIME))

            // expmodsAndPoints.expmods[19] = traceGenerator^63.
            mstore(add(expmodsAndPoints, 0x260),
                   mulmod(mload(add(expmodsAndPoints, 0x240)), // traceGenerator^61
                          mload(expmodsAndPoints), // traceGenerator^2
                          PRIME))

            // expmodsAndPoints.expmods[20] = traceGenerator^64.
            mstore(add(expmodsAndPoints, 0x280),
                   mulmod(mload(add(expmodsAndPoints, 0x260)), // traceGenerator^63
                          traceGenerator, // traceGenerator^1
                          PRIME))

            // expmodsAndPoints.expmods[21] = traceGenerator^125.
            mstore(add(expmodsAndPoints, 0x2a0),
                   mulmod(mload(add(expmodsAndPoints, 0x280)), // traceGenerator^64
                          mload(add(expmodsAndPoints, 0x240)), // traceGenerator^61
                          PRIME))

            // expmodsAndPoints.expmods[22] = traceGenerator^176.
            mstore(add(expmodsAndPoints, 0x2c0),
                   mulmod(mload(add(expmodsAndPoints, 0x2a0)), // traceGenerator^125
                          mulmod(mload(add(expmodsAndPoints, 0x1c0)), // traceGenerator^48
                                 mload(add(expmodsAndPoints, 0x20)), // traceGenerator^3
                                 PRIME),
                          PRIME))

            // expmodsAndPoints.expmods[23] = traceGenerator^184.
            mstore(add(expmodsAndPoints, 0x2e0),
                   mulmod(mload(add(expmodsAndPoints, 0x2c0)), // traceGenerator^176
                          mload(add(expmodsAndPoints, 0xa0)), // traceGenerator^8
                          PRIME))

            // expmodsAndPoints.expmods[24] = traceGenerator^192.
            mstore(add(expmodsAndPoints, 0x300),
                   mulmod(mload(add(expmodsAndPoints, 0x2e0)), // traceGenerator^184
                          mload(add(expmodsAndPoints, 0xa0)), // traceGenerator^8
                          PRIME))

            // expmodsAndPoints.expmods[25] = traceGenerator^213.
            mstore(add(expmodsAndPoints, 0x320),
                   mulmod(mload(add(expmodsAndPoints, 0x300)), // traceGenerator^192
                          mulmod(mload(add(expmodsAndPoints, 0x180)), // traceGenerator^16
                                 mload(add(expmodsAndPoints, 0x60)), // traceGenerator^5
                                 PRIME),
                          PRIME))

            // expmodsAndPoints.expmods[26] = traceGenerator^354.
            mstore(add(expmodsAndPoints, 0x340),
                   mulmod(mload(add(expmodsAndPoints, 0x2c0)), // traceGenerator^176
                          mulmod(mload(add(expmodsAndPoints, 0x2c0)), // traceGenerator^176
                                 mload(expmodsAndPoints), // traceGenerator^2
                                 PRIME),
                          PRIME))

            // expmodsAndPoints.expmods[27] = traceGenerator^396.
            mstore(add(expmodsAndPoints, 0x360),
                   mulmod(mload(add(expmodsAndPoints, 0x340)), // traceGenerator^354
                          mulmod(mload(add(expmodsAndPoints, 0x1a0)), // traceGenerator^32
                                 mload(add(expmodsAndPoints, 0xc0)), // traceGenerator^10
                                 PRIME),
                          PRIME))

            // expmodsAndPoints.expmods[28] = traceGenerator^1216.
            mstore(add(expmodsAndPoints, 0x380),
                   mulmod(mload(add(expmodsAndPoints, 0x360)), // traceGenerator^396
                          mulmod(mload(add(expmodsAndPoints, 0x360)), // traceGenerator^396
                                 mulmod(mload(add(expmodsAndPoints, 0x340)), // traceGenerator^354
                                        mulmod(mload(add(expmodsAndPoints, 0x280)), // traceGenerator^64
                                               mload(add(expmodsAndPoints, 0x80)), // traceGenerator^6
                                               PRIME),
                                        PRIME),
                                 PRIME),
                          PRIME))

            // expmodsAndPoints.expmods[29] = traceGenerator^1355.
            mstore(add(expmodsAndPoints, 0x3a0),
                   mulmod(mload(add(expmodsAndPoints, 0x380)), // traceGenerator^1216
                          mulmod(mload(add(expmodsAndPoints, 0x2a0)), // traceGenerator^125
                                 mload(add(expmodsAndPoints, 0x140)), // traceGenerator^14
                                 PRIME),
                          PRIME))

            // expmodsAndPoints.expmods[30] = traceGenerator^1675.
            mstore(add(expmodsAndPoints, 0x3c0),
                   mulmod(mload(add(expmodsAndPoints, 0x380)), // traceGenerator^1216
                          mulmod(mload(add(expmodsAndPoints, 0x360)), // traceGenerator^396
                                 mload(add(expmodsAndPoints, 0x260)), // traceGenerator^63
                                 PRIME),
                          PRIME))

            // expmodsAndPoints.expmods[31] = traceGenerator^2047.
            mstore(add(expmodsAndPoints, 0x3e0),
                   mulmod(mload(add(expmodsAndPoints, 0x3c0)), // traceGenerator^1675
                          mulmod(mload(add(expmodsAndPoints, 0x340)), // traceGenerator^354
                                 mulmod(mload(add(expmodsAndPoints, 0x180)), // traceGenerator^16
                                        mload(expmodsAndPoints), // traceGenerator^2
                                        PRIME),
                                 PRIME),
                          PRIME))

            // expmodsAndPoints.expmods[32] = traceGenerator^7680.
            mstore(add(expmodsAndPoints, 0x400),
                   mulmod(mload(add(expmodsAndPoints, 0x3e0)), // traceGenerator^2047
                          mulmod(mload(add(expmodsAndPoints, 0x3e0)), // traceGenerator^2047
                                 mulmod(mload(add(expmodsAndPoints, 0x3e0)), // traceGenerator^2047
                                        mulmod(mload(add(expmodsAndPoints, 0x3a0)), // traceGenerator^1355
                                               mload(add(expmodsAndPoints, 0x2e0)), // traceGenerator^184
                                               PRIME),
                                        PRIME),
                                 PRIME),
                          PRIME))

            // expmodsAndPoints.expmods[33] = traceGenerator^8191.
            mstore(add(expmodsAndPoints, 0x420),
                   mulmod(mload(add(expmodsAndPoints, 0x400)), // traceGenerator^7680
                          mulmod(mload(add(expmodsAndPoints, 0x340)), // traceGenerator^354
                                 mulmod(mload(add(expmodsAndPoints, 0x2a0)), // traceGenerator^125
                                        mload(add(expmodsAndPoints, 0x1a0)), // traceGenerator^32
                                        PRIME),
                                 PRIME),
                          PRIME))

            let oodsPoint := /*oods_point*/ mload(add(context, 0x2c60))
            {
              // point = -z.
              let point := sub(PRIME, oodsPoint)
              // Compute denominators for rows with nonconst mask expression.
              // We compute those first because for the const rows we modify the point variable.

              // Compute denominators for rows with const mask expression.

              // expmods_and_points.points[0] = -z.
              mstore(add(expmodsAndPoints, 0x440), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[1] = -(g * z).
              mstore(add(expmodsAndPoints, 0x460), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[2] = -(g^2 * z).
              mstore(add(expmodsAndPoints, 0x480), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[3] = -(g^3 * z).
              mstore(add(expmodsAndPoints, 0x4a0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[4] = -(g^4 * z).
              mstore(add(expmodsAndPoints, 0x4c0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[5] = -(g^5 * z).
              mstore(add(expmodsAndPoints, 0x4e0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[6] = -(g^6 * z).
              mstore(add(expmodsAndPoints, 0x500), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[7] = -(g^7 * z).
              mstore(add(expmodsAndPoints, 0x520), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[8] = -(g^8 * z).
              mstore(add(expmodsAndPoints, 0x540), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[9] = -(g^9 * z).
              mstore(add(expmodsAndPoints, 0x560), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[10] = -(g^10 * z).
              mstore(add(expmodsAndPoints, 0x580), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[11] = -(g^11 * z).
              mstore(add(expmodsAndPoints, 0x5a0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[12] = -(g^12 * z).
              mstore(add(expmodsAndPoints, 0x5c0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[13] = -(g^13 * z).
              mstore(add(expmodsAndPoints, 0x5e0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[14] = -(g^14 * z).
              mstore(add(expmodsAndPoints, 0x600), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[15] = -(g^15 * z).
              mstore(add(expmodsAndPoints, 0x620), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[16] = -(g^16 * z).
              mstore(add(expmodsAndPoints, 0x640), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[17] = -(g^17 * z).
              mstore(add(expmodsAndPoints, 0x660), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[18] = -(g^18 * z).
              mstore(add(expmodsAndPoints, 0x680), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[19] = -(g^19 * z).
              mstore(add(expmodsAndPoints, 0x6a0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[20] = -(g^20 * z).
              mstore(add(expmodsAndPoints, 0x6c0), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[21] = -(g^22 * z).
              mstore(add(expmodsAndPoints, 0x6e0), point)

              // point *= g^4.
              point := mulmod(point, /*traceGenerator^4*/ mload(add(expmodsAndPoints, 0x40)), PRIME)
              // expmods_and_points.points[22] = -(g^26 * z).
              mstore(add(expmodsAndPoints, 0x700), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[23] = -(g^27 * z).
              mstore(add(expmodsAndPoints, 0x720), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[24] = -(g^28 * z).
              mstore(add(expmodsAndPoints, 0x740), point)

              // point *= g^5.
              point := mulmod(point, /*traceGenerator^5*/ mload(add(expmodsAndPoints, 0x60)), PRIME)
              // expmods_and_points.points[25] = -(g^33 * z).
              mstore(add(expmodsAndPoints, 0x760), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[26] = -(g^34 * z).
              mstore(add(expmodsAndPoints, 0x780), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[27] = -(g^36 * z).
              mstore(add(expmodsAndPoints, 0x7a0), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[28] = -(g^38 * z).
              mstore(add(expmodsAndPoints, 0x7c0), point)

              // point *= g^4.
              point := mulmod(point, /*traceGenerator^4*/ mload(add(expmodsAndPoints, 0x40)), PRIME)
              // expmods_and_points.points[29] = -(g^42 * z).
              mstore(add(expmodsAndPoints, 0x7e0), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[30] = -(g^44 * z).
              mstore(add(expmodsAndPoints, 0x800), point)

              // point *= g^5.
              point := mulmod(point, /*traceGenerator^5*/ mload(add(expmodsAndPoints, 0x60)), PRIME)
              // expmods_and_points.points[31] = -(g^49 * z).
              mstore(add(expmodsAndPoints, 0x820), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[32] = -(g^50 * z).
              mstore(add(expmodsAndPoints, 0x840), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[33] = -(g^52 * z).
              mstore(add(expmodsAndPoints, 0x860), point)

              // point *= g^6.
              point := mulmod(point, /*traceGenerator^6*/ mload(add(expmodsAndPoints, 0x80)), PRIME)
              // expmods_and_points.points[34] = -(g^58 * z).
              mstore(add(expmodsAndPoints, 0x880), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[35] = -(g^60 * z).
              mstore(add(expmodsAndPoints, 0x8a0), point)

              // point *= g^5.
              point := mulmod(point, /*traceGenerator^5*/ mload(add(expmodsAndPoints, 0x60)), PRIME)
              // expmods_and_points.points[36] = -(g^65 * z).
              mstore(add(expmodsAndPoints, 0x8c0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[37] = -(g^66 * z).
              mstore(add(expmodsAndPoints, 0x8e0), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[38] = -(g^68 * z).
              mstore(add(expmodsAndPoints, 0x900), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[39] = -(g^70 * z).
              mstore(add(expmodsAndPoints, 0x920), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[40] = -(g^71 * z).
              mstore(add(expmodsAndPoints, 0x940), point)

              // point *= g^5.
              point := mulmod(point, /*traceGenerator^5*/ mload(add(expmodsAndPoints, 0x60)), PRIME)
              // expmods_and_points.points[41] = -(g^76 * z).
              mstore(add(expmodsAndPoints, 0x960), point)

              // point *= g^5.
              point := mulmod(point, /*traceGenerator^5*/ mload(add(expmodsAndPoints, 0x60)), PRIME)
              // expmods_and_points.points[42] = -(g^81 * z).
              mstore(add(expmodsAndPoints, 0x980), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[43] = -(g^82 * z).
              mstore(add(expmodsAndPoints, 0x9a0), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[44] = -(g^84 * z).
              mstore(add(expmodsAndPoints, 0x9c0), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[45] = -(g^86 * z).
              mstore(add(expmodsAndPoints, 0x9e0), point)

              // point *= g^6.
              point := mulmod(point, /*traceGenerator^6*/ mload(add(expmodsAndPoints, 0x80)), PRIME)
              // expmods_and_points.points[46] = -(g^92 * z).
              mstore(add(expmodsAndPoints, 0xa00), point)

              // point *= g^5.
              point := mulmod(point, /*traceGenerator^5*/ mload(add(expmodsAndPoints, 0x60)), PRIME)
              // expmods_and_points.points[47] = -(g^97 * z).
              mstore(add(expmodsAndPoints, 0xa20), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[48] = -(g^98 * z).
              mstore(add(expmodsAndPoints, 0xa40), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[49] = -(g^100 * z).
              mstore(add(expmodsAndPoints, 0xa60), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[50] = -(g^102 * z).
              mstore(add(expmodsAndPoints, 0xa80), point)

              // point *= g^6.
              point := mulmod(point, /*traceGenerator^6*/ mload(add(expmodsAndPoints, 0x80)), PRIME)
              // expmods_and_points.points[51] = -(g^108 * z).
              mstore(add(expmodsAndPoints, 0xaa0), point)

              // point *= g^5.
              point := mulmod(point, /*traceGenerator^5*/ mload(add(expmodsAndPoints, 0x60)), PRIME)
              // expmods_and_points.points[52] = -(g^113 * z).
              mstore(add(expmodsAndPoints, 0xac0), point)

              // point *= g^3.
              point := mulmod(point, /*traceGenerator^3*/ mload(add(expmodsAndPoints, 0x20)), PRIME)
              // expmods_and_points.points[53] = -(g^116 * z).
              mstore(add(expmodsAndPoints, 0xae0), point)

              // point *= g^13.
              point := mulmod(point, /*traceGenerator^13*/ mload(add(expmodsAndPoints, 0x120)), PRIME)
              // expmods_and_points.points[54] = -(g^129 * z).
              mstore(add(expmodsAndPoints, 0xb00), point)

              // point *= g^5.
              point := mulmod(point, /*traceGenerator^5*/ mload(add(expmodsAndPoints, 0x60)), PRIME)
              // expmods_and_points.points[55] = -(g^134 * z).
              mstore(add(expmodsAndPoints, 0xb20), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[56] = -(g^135 * z).
              mstore(add(expmodsAndPoints, 0xb40), point)

              // point *= g^5.
              point := mulmod(point, /*traceGenerator^5*/ mload(add(expmodsAndPoints, 0x60)), PRIME)
              // expmods_and_points.points[57] = -(g^140 * z).
              mstore(add(expmodsAndPoints, 0xb60), point)

              // point *= g^5.
              point := mulmod(point, /*traceGenerator^5*/ mload(add(expmodsAndPoints, 0x60)), PRIME)
              // expmods_and_points.points[58] = -(g^145 * z).
              mstore(add(expmodsAndPoints, 0xb80), point)

              // point *= g^16.
              point := mulmod(point, /*traceGenerator^16*/ mload(add(expmodsAndPoints, 0x180)), PRIME)
              // expmods_and_points.points[59] = -(g^161 * z).
              mstore(add(expmodsAndPoints, 0xba0), point)

              // point *= g^5.
              point := mulmod(point, /*traceGenerator^5*/ mload(add(expmodsAndPoints, 0x60)), PRIME)
              // expmods_and_points.points[60] = -(g^166 * z).
              mstore(add(expmodsAndPoints, 0xbc0), point)

              // point *= g^6.
              point := mulmod(point, /*traceGenerator^6*/ mload(add(expmodsAndPoints, 0x80)), PRIME)
              // expmods_and_points.points[61] = -(g^172 * z).
              mstore(add(expmodsAndPoints, 0xbe0), point)

              // point *= g^5.
              point := mulmod(point, /*traceGenerator^5*/ mload(add(expmodsAndPoints, 0x60)), PRIME)
              // expmods_and_points.points[62] = -(g^177 * z).
              mstore(add(expmodsAndPoints, 0xc00), point)

              // point *= g^15.
              point := mulmod(point, /*traceGenerator^15*/ mload(add(expmodsAndPoints, 0x160)), PRIME)
              // expmods_and_points.points[63] = -(g^192 * z).
              mstore(add(expmodsAndPoints, 0xc20), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[64] = -(g^193 * z).
              mstore(add(expmodsAndPoints, 0xc40), point)

              // point *= g^3.
              point := mulmod(point, /*traceGenerator^3*/ mload(add(expmodsAndPoints, 0x20)), PRIME)
              // expmods_and_points.points[65] = -(g^196 * z).
              mstore(add(expmodsAndPoints, 0xc60), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[66] = -(g^197 * z).
              mstore(add(expmodsAndPoints, 0xc80), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[67] = -(g^198 * z).
              mstore(add(expmodsAndPoints, 0xca0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[68] = -(g^199 * z).
              mstore(add(expmodsAndPoints, 0xcc0), point)

              // point *= g^5.
              point := mulmod(point, /*traceGenerator^5*/ mload(add(expmodsAndPoints, 0x60)), PRIME)
              // expmods_and_points.points[69] = -(g^204 * z).
              mstore(add(expmodsAndPoints, 0xce0), point)

              // point *= g^5.
              point := mulmod(point, /*traceGenerator^5*/ mload(add(expmodsAndPoints, 0x60)), PRIME)
              // expmods_and_points.points[70] = -(g^209 * z).
              mstore(add(expmodsAndPoints, 0xd00), point)

              // point *= g^16.
              point := mulmod(point, /*traceGenerator^16*/ mload(add(expmodsAndPoints, 0x180)), PRIME)
              // expmods_and_points.points[71] = -(g^225 * z).
              mstore(add(expmodsAndPoints, 0xd20), point)

              // point *= g^11.
              point := mulmod(point, /*traceGenerator^11*/ mload(add(expmodsAndPoints, 0xe0)), PRIME)
              // expmods_and_points.points[72] = -(g^236 * z).
              mstore(add(expmodsAndPoints, 0xd40), point)

              // point *= g^5.
              point := mulmod(point, /*traceGenerator^5*/ mload(add(expmodsAndPoints, 0x60)), PRIME)
              // expmods_and_points.points[73] = -(g^241 * z).
              mstore(add(expmodsAndPoints, 0xd60), point)

              // point *= g^10.
              point := mulmod(point, /*traceGenerator^10*/ mload(add(expmodsAndPoints, 0xc0)), PRIME)
              // expmods_and_points.points[74] = -(g^251 * z).
              mstore(add(expmodsAndPoints, 0xd80), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[75] = -(g^252 * z).
              mstore(add(expmodsAndPoints, 0xda0), point)

              // point *= g^3.
              point := mulmod(point, /*traceGenerator^3*/ mload(add(expmodsAndPoints, 0x20)), PRIME)
              // expmods_and_points.points[76] = -(g^255 * z).
              mstore(add(expmodsAndPoints, 0xdc0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[77] = -(g^256 * z).
              mstore(add(expmodsAndPoints, 0xde0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[78] = -(g^257 * z).
              mstore(add(expmodsAndPoints, 0xe00), point)

              // point *= g^5.
              point := mulmod(point, /*traceGenerator^5*/ mload(add(expmodsAndPoints, 0x60)), PRIME)
              // expmods_and_points.points[79] = -(g^262 * z).
              mstore(add(expmodsAndPoints, 0xe20), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[80] = -(g^263 * z).
              mstore(add(expmodsAndPoints, 0xe40), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[81] = -(g^265 * z).
              mstore(add(expmodsAndPoints, 0xe60), point)

              // point *= g^61.
              point := mulmod(point, /*traceGenerator^61*/ mload(add(expmodsAndPoints, 0x240)), PRIME)
              // expmods_and_points.points[82] = -(g^326 * z).
              mstore(add(expmodsAndPoints, 0xe80), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x280)), PRIME)
              // expmods_and_points.points[83] = -(g^390 * z).
              mstore(add(expmodsAndPoints, 0xea0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[84] = -(g^391 * z).
              mstore(add(expmodsAndPoints, 0xec0), point)

              // point *= g^63.
              point := mulmod(point, /*traceGenerator^63*/ mload(add(expmodsAndPoints, 0x260)), PRIME)
              // expmods_and_points.points[85] = -(g^454 * z).
              mstore(add(expmodsAndPoints, 0xee0), point)

              // point *= g^57.
              point := mulmod(point, /*traceGenerator^57*/ mload(add(expmodsAndPoints, 0x200)), PRIME)
              // expmods_and_points.points[86] = -(g^511 * z).
              mstore(add(expmodsAndPoints, 0xf00), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[87] = -(g^513 * z).
              mstore(add(expmodsAndPoints, 0xf20), point)

              // point *= g^5.
              point := mulmod(point, /*traceGenerator^5*/ mload(add(expmodsAndPoints, 0x60)), PRIME)
              // expmods_and_points.points[88] = -(g^518 * z).
              mstore(add(expmodsAndPoints, 0xf40), point)

              // point *= g^3.
              point := mulmod(point, /*traceGenerator^3*/ mload(add(expmodsAndPoints, 0x20)), PRIME)
              // expmods_and_points.points[89] = -(g^521 * z).
              mstore(add(expmodsAndPoints, 0xf60), point)

              // point *= g^184.
              point := mulmod(point, /*traceGenerator^184*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[90] = -(g^705 * z).
              mstore(add(expmodsAndPoints, 0xf80), point)

              // point *= g^6.
              point := mulmod(point, /*traceGenerator^6*/ mload(add(expmodsAndPoints, 0x80)), PRIME)
              // expmods_and_points.points[91] = -(g^711 * z).
              mstore(add(expmodsAndPoints, 0xfa0), point)

              // point *= g^10.
              point := mulmod(point, /*traceGenerator^10*/ mload(add(expmodsAndPoints, 0xc0)), PRIME)
              // expmods_and_points.points[92] = -(g^721 * z).
              mstore(add(expmodsAndPoints, 0xfc0), point)

              // point *= g^16.
              point := mulmod(point, /*traceGenerator^16*/ mload(add(expmodsAndPoints, 0x180)), PRIME)
              // expmods_and_points.points[93] = -(g^737 * z).
              mstore(add(expmodsAndPoints, 0xfe0), point)

              // point *= g^16.
              point := mulmod(point, /*traceGenerator^16*/ mload(add(expmodsAndPoints, 0x180)), PRIME)
              // expmods_and_points.points[94] = -(g^753 * z).
              mstore(add(expmodsAndPoints, 0x1000), point)

              // point *= g^16.
              point := mulmod(point, /*traceGenerator^16*/ mload(add(expmodsAndPoints, 0x180)), PRIME)
              // expmods_and_points.points[95] = -(g^769 * z).
              mstore(add(expmodsAndPoints, 0x1020), point)

              // point *= g^8.
              point := mulmod(point, /*traceGenerator^8*/ mload(add(expmodsAndPoints, 0xa0)), PRIME)
              // expmods_and_points.points[96] = -(g^777 * z).
              mstore(add(expmodsAndPoints, 0x1040), point)

              // point *= g^125.
              point := mulmod(point, /*traceGenerator^125*/ mload(add(expmodsAndPoints, 0x2a0)), PRIME)
              // expmods_and_points.points[97] = -(g^902 * z).
              mstore(add(expmodsAndPoints, 0x1060), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[98] = -(g^903 * z).
              mstore(add(expmodsAndPoints, 0x1080), point)

              // point *= g^58.
              point := mulmod(point, /*traceGenerator^58*/ mload(add(expmodsAndPoints, 0x220)), PRIME)
              // expmods_and_points.points[99] = -(g^961 * z).
              mstore(add(expmodsAndPoints, 0x10a0), point)

              // point *= g^5.
              point := mulmod(point, /*traceGenerator^5*/ mload(add(expmodsAndPoints, 0x60)), PRIME)
              // expmods_and_points.points[100] = -(g^966 * z).
              mstore(add(expmodsAndPoints, 0x10c0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[101] = -(g^967 * z).
              mstore(add(expmodsAndPoints, 0x10e0), point)

              // point *= g^10.
              point := mulmod(point, /*traceGenerator^10*/ mload(add(expmodsAndPoints, 0xc0)), PRIME)
              // expmods_and_points.points[102] = -(g^977 * z).
              mstore(add(expmodsAndPoints, 0x1100), point)

              // point *= g^16.
              point := mulmod(point, /*traceGenerator^16*/ mload(add(expmodsAndPoints, 0x180)), PRIME)
              // expmods_and_points.points[103] = -(g^993 * z).
              mstore(add(expmodsAndPoints, 0x1120), point)

              // point *= g^16.
              point := mulmod(point, /*traceGenerator^16*/ mload(add(expmodsAndPoints, 0x180)), PRIME)
              // expmods_and_points.points[104] = -(g^1009 * z).
              mstore(add(expmodsAndPoints, 0x1140), point)

              // point *= g^213.
              point := mulmod(point, /*traceGenerator^213*/ mload(add(expmodsAndPoints, 0x320)), PRIME)
              // expmods_and_points.points[105] = -(g^1222 * z).
              mstore(add(expmodsAndPoints, 0x1160), point)

              // point *= g^1216.
              point := mulmod(point, /*traceGenerator^1216*/ mload(add(expmodsAndPoints, 0x380)), PRIME)
              // expmods_and_points.points[106] = -(g^2438 * z).
              mstore(add(expmodsAndPoints, 0x1180), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[107] = -(g^2439 * z).
              mstore(add(expmodsAndPoints, 0x11a0), point)

              // point *= g^2047.
              point := mulmod(point, /*traceGenerator^2047*/ mload(add(expmodsAndPoints, 0x3e0)), PRIME)
              // expmods_and_points.points[108] = -(g^4486 * z).
              mstore(add(expmodsAndPoints, 0x11c0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[109] = -(g^4487 * z).
              mstore(add(expmodsAndPoints, 0x11e0), point)

              // point *= g^2047.
              point := mulmod(point, /*traceGenerator^2047*/ mload(add(expmodsAndPoints, 0x3e0)), PRIME)
              // expmods_and_points.points[110] = -(g^6534 * z).
              mstore(add(expmodsAndPoints, 0x1200), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[111] = -(g^6535 * z).
              mstore(add(expmodsAndPoints, 0x1220), point)

              // point *= g^2047.
              point := mulmod(point, /*traceGenerator^2047*/ mload(add(expmodsAndPoints, 0x3e0)), PRIME)
              // expmods_and_points.points[112] = -(g^8582 * z).
              mstore(add(expmodsAndPoints, 0x1240), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[113] = -(g^8583 * z).
              mstore(add(expmodsAndPoints, 0x1260), point)

              // point *= g^2047.
              point := mulmod(point, /*traceGenerator^2047*/ mload(add(expmodsAndPoints, 0x3e0)), PRIME)
              // expmods_and_points.points[114] = -(g^10630 * z).
              mstore(add(expmodsAndPoints, 0x1280), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[115] = -(g^10631 * z).
              mstore(add(expmodsAndPoints, 0x12a0), point)

              // point *= g^1675.
              point := mulmod(point, /*traceGenerator^1675*/ mload(add(expmodsAndPoints, 0x3c0)), PRIME)
              // expmods_and_points.points[116] = -(g^12306 * z).
              mstore(add(expmodsAndPoints, 0x12c0), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x280)), PRIME)
              // expmods_and_points.points[117] = -(g^12370 * z).
              mstore(add(expmodsAndPoints, 0x12e0), point)

              // point *= g^192.
              point := mulmod(point, /*traceGenerator^192*/ mload(add(expmodsAndPoints, 0x300)), PRIME)
              // expmods_and_points.points[118] = -(g^12562 * z).
              mstore(add(expmodsAndPoints, 0x1300), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x280)), PRIME)
              // expmods_and_points.points[119] = -(g^12626 * z).
              mstore(add(expmodsAndPoints, 0x1320), point)

              // point *= g^52.
              point := mulmod(point, /*traceGenerator^52*/ mload(add(expmodsAndPoints, 0x1e0)), PRIME)
              // expmods_and_points.points[120] = -(g^12678 * z).
              mstore(add(expmodsAndPoints, 0x1340), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[121] = -(g^12679 * z).
              mstore(add(expmodsAndPoints, 0x1360), point)

              // point *= g^2047.
              point := mulmod(point, /*traceGenerator^2047*/ mload(add(expmodsAndPoints, 0x3e0)), PRIME)
              // expmods_and_points.points[122] = -(g^14726 * z).
              mstore(add(expmodsAndPoints, 0x1380), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[123] = -(g^14727 * z).
              mstore(add(expmodsAndPoints, 0x13a0), point)

              // point *= g^1355.
              point := mulmod(point, /*traceGenerator^1355*/ mload(add(expmodsAndPoints, 0x3a0)), PRIME)
              // expmods_and_points.points[124] = -(g^16082 * z).
              mstore(add(expmodsAndPoints, 0x13c0), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x280)), PRIME)
              // expmods_and_points.points[125] = -(g^16146 * z).
              mstore(add(expmodsAndPoints, 0x13e0), point)

              // point *= g^176.
              point := mulmod(point, /*traceGenerator^176*/ mload(add(expmodsAndPoints, 0x2c0)), PRIME)
              // expmods_and_points.points[126] = -(g^16322 * z).
              mstore(add(expmodsAndPoints, 0x1400), point)

              // point *= g^8.
              point := mulmod(point, /*traceGenerator^8*/ mload(add(expmodsAndPoints, 0xa0)), PRIME)
              // expmods_and_points.points[127] = -(g^16330 * z).
              mstore(add(expmodsAndPoints, 0x1420), point)

              // point *= g^10.
              point := mulmod(point, /*traceGenerator^10*/ mload(add(expmodsAndPoints, 0xc0)), PRIME)
              // expmods_and_points.points[128] = -(g^16340 * z).
              mstore(add(expmodsAndPoints, 0x1440), point)

              // point *= g^6.
              point := mulmod(point, /*traceGenerator^6*/ mload(add(expmodsAndPoints, 0x80)), PRIME)
              // expmods_and_points.points[129] = -(g^16346 * z).
              mstore(add(expmodsAndPoints, 0x1460), point)

              // point *= g^8.
              point := mulmod(point, /*traceGenerator^8*/ mload(add(expmodsAndPoints, 0xa0)), PRIME)
              // expmods_and_points.points[130] = -(g^16354 * z).
              mstore(add(expmodsAndPoints, 0x1480), point)

              // point *= g^8.
              point := mulmod(point, /*traceGenerator^8*/ mload(add(expmodsAndPoints, 0xa0)), PRIME)
              // expmods_and_points.points[131] = -(g^16362 * z).
              mstore(add(expmodsAndPoints, 0x14a0), point)

              // point *= g^8.
              point := mulmod(point, /*traceGenerator^8*/ mload(add(expmodsAndPoints, 0xa0)), PRIME)
              // expmods_and_points.points[132] = -(g^16370 * z).
              mstore(add(expmodsAndPoints, 0x14c0), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[133] = -(g^16372 * z).
              mstore(add(expmodsAndPoints, 0x14e0), point)

              // point *= g^6.
              point := mulmod(point, /*traceGenerator^6*/ mload(add(expmodsAndPoints, 0x80)), PRIME)
              // expmods_and_points.points[134] = -(g^16378 * z).
              mstore(add(expmodsAndPoints, 0x1500), point)

              // point *= g^10.
              point := mulmod(point, /*traceGenerator^10*/ mload(add(expmodsAndPoints, 0xc0)), PRIME)
              // expmods_and_points.points[135] = -(g^16388 * z).
              mstore(add(expmodsAndPoints, 0x1520), point)

              // point *= g^32.
              point := mulmod(point, /*traceGenerator^32*/ mload(add(expmodsAndPoints, 0x1a0)), PRIME)
              // expmods_and_points.points[136] = -(g^16420 * z).
              mstore(add(expmodsAndPoints, 0x1540), point)

              // point *= g^354.
              point := mulmod(point, /*traceGenerator^354*/ mload(add(expmodsAndPoints, 0x340)), PRIME)
              // expmods_and_points.points[137] = -(g^16774 * z).
              mstore(add(expmodsAndPoints, 0x1560), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[138] = -(g^16775 * z).
              mstore(add(expmodsAndPoints, 0x1580), point)

              // point *= g^8191.
              point := mulmod(point, /*traceGenerator^8191*/ mload(add(expmodsAndPoints, 0x420)), PRIME)
              // expmods_and_points.points[139] = -(g^24966 * z).
              mstore(add(expmodsAndPoints, 0x15a0), point)

              // point *= g^7680.
              point := mulmod(point, /*traceGenerator^7680*/ mload(add(expmodsAndPoints, 0x400)), PRIME)
              // expmods_and_points.points[140] = -(g^32646 * z).
              mstore(add(expmodsAndPoints, 0x15c0), point)

              // point *= g^16.
              point := mulmod(point, /*traceGenerator^16*/ mload(add(expmodsAndPoints, 0x180)), PRIME)
              // expmods_and_points.points[141] = -(g^32662 * z).
              mstore(add(expmodsAndPoints, 0x15e0), point)

              // point *= g^48.
              point := mulmod(point, /*traceGenerator^48*/ mload(add(expmodsAndPoints, 0x1c0)), PRIME)
              // expmods_and_points.points[142] = -(g^32710 * z).
              mstore(add(expmodsAndPoints, 0x1600), point)

              // point *= g^14.
              point := mulmod(point, /*traceGenerator^14*/ mload(add(expmodsAndPoints, 0x140)), PRIME)
              // expmods_and_points.points[143] = -(g^32724 * z).
              mstore(add(expmodsAndPoints, 0x1620), point)

              // point *= g^6.
              point := mulmod(point, /*traceGenerator^6*/ mload(add(expmodsAndPoints, 0x80)), PRIME)
              // expmods_and_points.points[144] = -(g^32730 * z).
              mstore(add(expmodsAndPoints, 0x1640), point)

              // point *= g^12.
              point := mulmod(point, /*traceGenerator^12*/ mload(add(expmodsAndPoints, 0x100)), PRIME)
              // expmods_and_points.points[145] = -(g^32742 * z).
              mstore(add(expmodsAndPoints, 0x1660), point)

              // point *= g^14.
              point := mulmod(point, /*traceGenerator^14*/ mload(add(expmodsAndPoints, 0x140)), PRIME)
              // expmods_and_points.points[146] = -(g^32756 * z).
              mstore(add(expmodsAndPoints, 0x1680), point)

              // point *= g^6.
              point := mulmod(point, /*traceGenerator^6*/ mload(add(expmodsAndPoints, 0x80)), PRIME)
              // expmods_and_points.points[147] = -(g^32762 * z).
              mstore(add(expmodsAndPoints, 0x16a0), point)

              // point *= g^396.
              point := mulmod(point, /*traceGenerator^396*/ mload(add(expmodsAndPoints, 0x360)), PRIME)
              // expmods_and_points.points[148] = -(g^33158 * z).
              mstore(add(expmodsAndPoints, 0x16c0), point)
            }

            let evalPointsPtr := /*oodsEvalPoints*/ add(context, 0x5ce0)
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
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x440)))
                mstore(productsPtr, partialProduct)
                mstore(valuesPtr, denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1: x - g * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x460)))
                mstore(add(productsPtr, 0x20), partialProduct)
                mstore(add(valuesPtr, 0x20), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 2: x - g^2 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x480)))
                mstore(add(productsPtr, 0x40), partialProduct)
                mstore(add(valuesPtr, 0x40), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 3: x - g^3 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x4a0)))
                mstore(add(productsPtr, 0x60), partialProduct)
                mstore(add(valuesPtr, 0x60), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 4: x - g^4 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x4c0)))
                mstore(add(productsPtr, 0x80), partialProduct)
                mstore(add(valuesPtr, 0x80), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 5: x - g^5 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x4e0)))
                mstore(add(productsPtr, 0xa0), partialProduct)
                mstore(add(valuesPtr, 0xa0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 6: x - g^6 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x500)))
                mstore(add(productsPtr, 0xc0), partialProduct)
                mstore(add(valuesPtr, 0xc0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 7: x - g^7 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x520)))
                mstore(add(productsPtr, 0xe0), partialProduct)
                mstore(add(valuesPtr, 0xe0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 8: x - g^8 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x540)))
                mstore(add(productsPtr, 0x100), partialProduct)
                mstore(add(valuesPtr, 0x100), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 9: x - g^9 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x560)))
                mstore(add(productsPtr, 0x120), partialProduct)
                mstore(add(valuesPtr, 0x120), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 10: x - g^10 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x580)))
                mstore(add(productsPtr, 0x140), partialProduct)
                mstore(add(valuesPtr, 0x140), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 11: x - g^11 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x5a0)))
                mstore(add(productsPtr, 0x160), partialProduct)
                mstore(add(valuesPtr, 0x160), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 12: x - g^12 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x5c0)))
                mstore(add(productsPtr, 0x180), partialProduct)
                mstore(add(valuesPtr, 0x180), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 13: x - g^13 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x5e0)))
                mstore(add(productsPtr, 0x1a0), partialProduct)
                mstore(add(valuesPtr, 0x1a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 14: x - g^14 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x600)))
                mstore(add(productsPtr, 0x1c0), partialProduct)
                mstore(add(valuesPtr, 0x1c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 15: x - g^15 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x620)))
                mstore(add(productsPtr, 0x1e0), partialProduct)
                mstore(add(valuesPtr, 0x1e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16: x - g^16 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x640)))
                mstore(add(productsPtr, 0x200), partialProduct)
                mstore(add(valuesPtr, 0x200), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 17: x - g^17 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x660)))
                mstore(add(productsPtr, 0x220), partialProduct)
                mstore(add(valuesPtr, 0x220), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 18: x - g^18 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x680)))
                mstore(add(productsPtr, 0x240), partialProduct)
                mstore(add(valuesPtr, 0x240), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 19: x - g^19 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x6a0)))
                mstore(add(productsPtr, 0x260), partialProduct)
                mstore(add(valuesPtr, 0x260), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 20: x - g^20 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x6c0)))
                mstore(add(productsPtr, 0x280), partialProduct)
                mstore(add(valuesPtr, 0x280), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 22: x - g^22 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x6e0)))
                mstore(add(productsPtr, 0x2a0), partialProduct)
                mstore(add(valuesPtr, 0x2a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 26: x - g^26 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x700)))
                mstore(add(productsPtr, 0x2c0), partialProduct)
                mstore(add(valuesPtr, 0x2c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 27: x - g^27 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x720)))
                mstore(add(productsPtr, 0x2e0), partialProduct)
                mstore(add(valuesPtr, 0x2e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 28: x - g^28 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x740)))
                mstore(add(productsPtr, 0x300), partialProduct)
                mstore(add(valuesPtr, 0x300), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 33: x - g^33 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x760)))
                mstore(add(productsPtr, 0x320), partialProduct)
                mstore(add(valuesPtr, 0x320), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 34: x - g^34 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x780)))
                mstore(add(productsPtr, 0x340), partialProduct)
                mstore(add(valuesPtr, 0x340), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 36: x - g^36 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x7a0)))
                mstore(add(productsPtr, 0x360), partialProduct)
                mstore(add(valuesPtr, 0x360), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 38: x - g^38 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x7c0)))
                mstore(add(productsPtr, 0x380), partialProduct)
                mstore(add(valuesPtr, 0x380), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 42: x - g^42 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x7e0)))
                mstore(add(productsPtr, 0x3a0), partialProduct)
                mstore(add(valuesPtr, 0x3a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 44: x - g^44 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x800)))
                mstore(add(productsPtr, 0x3c0), partialProduct)
                mstore(add(valuesPtr, 0x3c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 49: x - g^49 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x820)))
                mstore(add(productsPtr, 0x3e0), partialProduct)
                mstore(add(valuesPtr, 0x3e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 50: x - g^50 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x840)))
                mstore(add(productsPtr, 0x400), partialProduct)
                mstore(add(valuesPtr, 0x400), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 52: x - g^52 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x860)))
                mstore(add(productsPtr, 0x420), partialProduct)
                mstore(add(valuesPtr, 0x420), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 58: x - g^58 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x880)))
                mstore(add(productsPtr, 0x440), partialProduct)
                mstore(add(valuesPtr, 0x440), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 60: x - g^60 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x8a0)))
                mstore(add(productsPtr, 0x460), partialProduct)
                mstore(add(valuesPtr, 0x460), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 65: x - g^65 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x8c0)))
                mstore(add(productsPtr, 0x480), partialProduct)
                mstore(add(valuesPtr, 0x480), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 66: x - g^66 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x8e0)))
                mstore(add(productsPtr, 0x4a0), partialProduct)
                mstore(add(valuesPtr, 0x4a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 68: x - g^68 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x900)))
                mstore(add(productsPtr, 0x4c0), partialProduct)
                mstore(add(valuesPtr, 0x4c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 70: x - g^70 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x920)))
                mstore(add(productsPtr, 0x4e0), partialProduct)
                mstore(add(valuesPtr, 0x4e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 71: x - g^71 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x940)))
                mstore(add(productsPtr, 0x500), partialProduct)
                mstore(add(valuesPtr, 0x500), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 76: x - g^76 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x960)))
                mstore(add(productsPtr, 0x520), partialProduct)
                mstore(add(valuesPtr, 0x520), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 81: x - g^81 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x980)))
                mstore(add(productsPtr, 0x540), partialProduct)
                mstore(add(valuesPtr, 0x540), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 82: x - g^82 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x9a0)))
                mstore(add(productsPtr, 0x560), partialProduct)
                mstore(add(valuesPtr, 0x560), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 84: x - g^84 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x9c0)))
                mstore(add(productsPtr, 0x580), partialProduct)
                mstore(add(valuesPtr, 0x580), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 86: x - g^86 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x9e0)))
                mstore(add(productsPtr, 0x5a0), partialProduct)
                mstore(add(valuesPtr, 0x5a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 92: x - g^92 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xa00)))
                mstore(add(productsPtr, 0x5c0), partialProduct)
                mstore(add(valuesPtr, 0x5c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 97: x - g^97 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xa20)))
                mstore(add(productsPtr, 0x5e0), partialProduct)
                mstore(add(valuesPtr, 0x5e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 98: x - g^98 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xa40)))
                mstore(add(productsPtr, 0x600), partialProduct)
                mstore(add(valuesPtr, 0x600), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 100: x - g^100 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xa60)))
                mstore(add(productsPtr, 0x620), partialProduct)
                mstore(add(valuesPtr, 0x620), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 102: x - g^102 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xa80)))
                mstore(add(productsPtr, 0x640), partialProduct)
                mstore(add(valuesPtr, 0x640), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 108: x - g^108 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xaa0)))
                mstore(add(productsPtr, 0x660), partialProduct)
                mstore(add(valuesPtr, 0x660), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 113: x - g^113 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xac0)))
                mstore(add(productsPtr, 0x680), partialProduct)
                mstore(add(valuesPtr, 0x680), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 116: x - g^116 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xae0)))
                mstore(add(productsPtr, 0x6a0), partialProduct)
                mstore(add(valuesPtr, 0x6a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 129: x - g^129 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xb00)))
                mstore(add(productsPtr, 0x6c0), partialProduct)
                mstore(add(valuesPtr, 0x6c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 134: x - g^134 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xb20)))
                mstore(add(productsPtr, 0x6e0), partialProduct)
                mstore(add(valuesPtr, 0x6e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 135: x - g^135 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xb40)))
                mstore(add(productsPtr, 0x700), partialProduct)
                mstore(add(valuesPtr, 0x700), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 140: x - g^140 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xb60)))
                mstore(add(productsPtr, 0x720), partialProduct)
                mstore(add(valuesPtr, 0x720), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 145: x - g^145 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xb80)))
                mstore(add(productsPtr, 0x740), partialProduct)
                mstore(add(valuesPtr, 0x740), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 161: x - g^161 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xba0)))
                mstore(add(productsPtr, 0x760), partialProduct)
                mstore(add(valuesPtr, 0x760), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 166: x - g^166 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xbc0)))
                mstore(add(productsPtr, 0x780), partialProduct)
                mstore(add(valuesPtr, 0x780), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 172: x - g^172 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xbe0)))
                mstore(add(productsPtr, 0x7a0), partialProduct)
                mstore(add(valuesPtr, 0x7a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 177: x - g^177 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xc00)))
                mstore(add(productsPtr, 0x7c0), partialProduct)
                mstore(add(valuesPtr, 0x7c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 192: x - g^192 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xc20)))
                mstore(add(productsPtr, 0x7e0), partialProduct)
                mstore(add(valuesPtr, 0x7e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 193: x - g^193 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xc40)))
                mstore(add(productsPtr, 0x800), partialProduct)
                mstore(add(valuesPtr, 0x800), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 196: x - g^196 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xc60)))
                mstore(add(productsPtr, 0x820), partialProduct)
                mstore(add(valuesPtr, 0x820), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 197: x - g^197 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xc80)))
                mstore(add(productsPtr, 0x840), partialProduct)
                mstore(add(valuesPtr, 0x840), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 198: x - g^198 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xca0)))
                mstore(add(productsPtr, 0x860), partialProduct)
                mstore(add(valuesPtr, 0x860), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 199: x - g^199 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xcc0)))
                mstore(add(productsPtr, 0x880), partialProduct)
                mstore(add(valuesPtr, 0x880), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 204: x - g^204 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xce0)))
                mstore(add(productsPtr, 0x8a0), partialProduct)
                mstore(add(valuesPtr, 0x8a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 209: x - g^209 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xd00)))
                mstore(add(productsPtr, 0x8c0), partialProduct)
                mstore(add(valuesPtr, 0x8c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 225: x - g^225 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xd20)))
                mstore(add(productsPtr, 0x8e0), partialProduct)
                mstore(add(valuesPtr, 0x8e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 236: x - g^236 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xd40)))
                mstore(add(productsPtr, 0x900), partialProduct)
                mstore(add(valuesPtr, 0x900), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 241: x - g^241 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xd60)))
                mstore(add(productsPtr, 0x920), partialProduct)
                mstore(add(valuesPtr, 0x920), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 251: x - g^251 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xd80)))
                mstore(add(productsPtr, 0x940), partialProduct)
                mstore(add(valuesPtr, 0x940), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 252: x - g^252 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xda0)))
                mstore(add(productsPtr, 0x960), partialProduct)
                mstore(add(valuesPtr, 0x960), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 255: x - g^255 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xdc0)))
                mstore(add(productsPtr, 0x980), partialProduct)
                mstore(add(valuesPtr, 0x980), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 256: x - g^256 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xde0)))
                mstore(add(productsPtr, 0x9a0), partialProduct)
                mstore(add(valuesPtr, 0x9a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 257: x - g^257 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xe00)))
                mstore(add(productsPtr, 0x9c0), partialProduct)
                mstore(add(valuesPtr, 0x9c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 262: x - g^262 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xe20)))
                mstore(add(productsPtr, 0x9e0), partialProduct)
                mstore(add(valuesPtr, 0x9e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 263: x - g^263 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xe40)))
                mstore(add(productsPtr, 0xa00), partialProduct)
                mstore(add(valuesPtr, 0xa00), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 265: x - g^265 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xe60)))
                mstore(add(productsPtr, 0xa20), partialProduct)
                mstore(add(valuesPtr, 0xa20), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 326: x - g^326 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xe80)))
                mstore(add(productsPtr, 0xa40), partialProduct)
                mstore(add(valuesPtr, 0xa40), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 390: x - g^390 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xea0)))
                mstore(add(productsPtr, 0xa60), partialProduct)
                mstore(add(valuesPtr, 0xa60), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 391: x - g^391 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xec0)))
                mstore(add(productsPtr, 0xa80), partialProduct)
                mstore(add(valuesPtr, 0xa80), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 454: x - g^454 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xee0)))
                mstore(add(productsPtr, 0xaa0), partialProduct)
                mstore(add(valuesPtr, 0xaa0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 511: x - g^511 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xf00)))
                mstore(add(productsPtr, 0xac0), partialProduct)
                mstore(add(valuesPtr, 0xac0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 513: x - g^513 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xf20)))
                mstore(add(productsPtr, 0xae0), partialProduct)
                mstore(add(valuesPtr, 0xae0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 518: x - g^518 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xf40)))
                mstore(add(productsPtr, 0xb00), partialProduct)
                mstore(add(valuesPtr, 0xb00), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 521: x - g^521 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xf60)))
                mstore(add(productsPtr, 0xb20), partialProduct)
                mstore(add(valuesPtr, 0xb20), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 705: x - g^705 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xf80)))
                mstore(add(productsPtr, 0xb40), partialProduct)
                mstore(add(valuesPtr, 0xb40), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 711: x - g^711 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xfa0)))
                mstore(add(productsPtr, 0xb60), partialProduct)
                mstore(add(valuesPtr, 0xb60), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 721: x - g^721 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xfc0)))
                mstore(add(productsPtr, 0xb80), partialProduct)
                mstore(add(valuesPtr, 0xb80), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 737: x - g^737 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xfe0)))
                mstore(add(productsPtr, 0xba0), partialProduct)
                mstore(add(valuesPtr, 0xba0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 753: x - g^753 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1000)))
                mstore(add(productsPtr, 0xbc0), partialProduct)
                mstore(add(valuesPtr, 0xbc0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 769: x - g^769 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1020)))
                mstore(add(productsPtr, 0xbe0), partialProduct)
                mstore(add(valuesPtr, 0xbe0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 777: x - g^777 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1040)))
                mstore(add(productsPtr, 0xc00), partialProduct)
                mstore(add(valuesPtr, 0xc00), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 902: x - g^902 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1060)))
                mstore(add(productsPtr, 0xc20), partialProduct)
                mstore(add(valuesPtr, 0xc20), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 903: x - g^903 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1080)))
                mstore(add(productsPtr, 0xc40), partialProduct)
                mstore(add(valuesPtr, 0xc40), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 961: x - g^961 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x10a0)))
                mstore(add(productsPtr, 0xc60), partialProduct)
                mstore(add(valuesPtr, 0xc60), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 966: x - g^966 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x10c0)))
                mstore(add(productsPtr, 0xc80), partialProduct)
                mstore(add(valuesPtr, 0xc80), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 967: x - g^967 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x10e0)))
                mstore(add(productsPtr, 0xca0), partialProduct)
                mstore(add(valuesPtr, 0xca0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 977: x - g^977 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1100)))
                mstore(add(productsPtr, 0xcc0), partialProduct)
                mstore(add(valuesPtr, 0xcc0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 993: x - g^993 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1120)))
                mstore(add(productsPtr, 0xce0), partialProduct)
                mstore(add(valuesPtr, 0xce0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1009: x - g^1009 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1140)))
                mstore(add(productsPtr, 0xd00), partialProduct)
                mstore(add(valuesPtr, 0xd00), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1222: x - g^1222 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1160)))
                mstore(add(productsPtr, 0xd20), partialProduct)
                mstore(add(valuesPtr, 0xd20), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 2438: x - g^2438 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1180)))
                mstore(add(productsPtr, 0xd40), partialProduct)
                mstore(add(valuesPtr, 0xd40), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 2439: x - g^2439 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x11a0)))
                mstore(add(productsPtr, 0xd60), partialProduct)
                mstore(add(valuesPtr, 0xd60), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 4486: x - g^4486 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x11c0)))
                mstore(add(productsPtr, 0xd80), partialProduct)
                mstore(add(valuesPtr, 0xd80), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 4487: x - g^4487 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x11e0)))
                mstore(add(productsPtr, 0xda0), partialProduct)
                mstore(add(valuesPtr, 0xda0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 6534: x - g^6534 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1200)))
                mstore(add(productsPtr, 0xdc0), partialProduct)
                mstore(add(valuesPtr, 0xdc0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 6535: x - g^6535 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1220)))
                mstore(add(productsPtr, 0xde0), partialProduct)
                mstore(add(valuesPtr, 0xde0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 8582: x - g^8582 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1240)))
                mstore(add(productsPtr, 0xe00), partialProduct)
                mstore(add(valuesPtr, 0xe00), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 8583: x - g^8583 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1260)))
                mstore(add(productsPtr, 0xe20), partialProduct)
                mstore(add(valuesPtr, 0xe20), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 10630: x - g^10630 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1280)))
                mstore(add(productsPtr, 0xe40), partialProduct)
                mstore(add(valuesPtr, 0xe40), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 10631: x - g^10631 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x12a0)))
                mstore(add(productsPtr, 0xe60), partialProduct)
                mstore(add(valuesPtr, 0xe60), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 12306: x - g^12306 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x12c0)))
                mstore(add(productsPtr, 0xe80), partialProduct)
                mstore(add(valuesPtr, 0xe80), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 12370: x - g^12370 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x12e0)))
                mstore(add(productsPtr, 0xea0), partialProduct)
                mstore(add(valuesPtr, 0xea0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 12562: x - g^12562 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1300)))
                mstore(add(productsPtr, 0xec0), partialProduct)
                mstore(add(valuesPtr, 0xec0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 12626: x - g^12626 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1320)))
                mstore(add(productsPtr, 0xee0), partialProduct)
                mstore(add(valuesPtr, 0xee0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 12678: x - g^12678 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1340)))
                mstore(add(productsPtr, 0xf00), partialProduct)
                mstore(add(valuesPtr, 0xf00), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 12679: x - g^12679 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1360)))
                mstore(add(productsPtr, 0xf20), partialProduct)
                mstore(add(valuesPtr, 0xf20), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 14726: x - g^14726 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1380)))
                mstore(add(productsPtr, 0xf40), partialProduct)
                mstore(add(valuesPtr, 0xf40), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 14727: x - g^14727 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x13a0)))
                mstore(add(productsPtr, 0xf60), partialProduct)
                mstore(add(valuesPtr, 0xf60), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16082: x - g^16082 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x13c0)))
                mstore(add(productsPtr, 0xf80), partialProduct)
                mstore(add(valuesPtr, 0xf80), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16146: x - g^16146 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x13e0)))
                mstore(add(productsPtr, 0xfa0), partialProduct)
                mstore(add(valuesPtr, 0xfa0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16322: x - g^16322 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1400)))
                mstore(add(productsPtr, 0xfc0), partialProduct)
                mstore(add(valuesPtr, 0xfc0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16330: x - g^16330 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1420)))
                mstore(add(productsPtr, 0xfe0), partialProduct)
                mstore(add(valuesPtr, 0xfe0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16340: x - g^16340 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1440)))
                mstore(add(productsPtr, 0x1000), partialProduct)
                mstore(add(valuesPtr, 0x1000), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16346: x - g^16346 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1460)))
                mstore(add(productsPtr, 0x1020), partialProduct)
                mstore(add(valuesPtr, 0x1020), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16354: x - g^16354 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1480)))
                mstore(add(productsPtr, 0x1040), partialProduct)
                mstore(add(valuesPtr, 0x1040), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16362: x - g^16362 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x14a0)))
                mstore(add(productsPtr, 0x1060), partialProduct)
                mstore(add(valuesPtr, 0x1060), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16370: x - g^16370 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x14c0)))
                mstore(add(productsPtr, 0x1080), partialProduct)
                mstore(add(valuesPtr, 0x1080), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16372: x - g^16372 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x14e0)))
                mstore(add(productsPtr, 0x10a0), partialProduct)
                mstore(add(valuesPtr, 0x10a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16378: x - g^16378 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1500)))
                mstore(add(productsPtr, 0x10c0), partialProduct)
                mstore(add(valuesPtr, 0x10c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16388: x - g^16388 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1520)))
                mstore(add(productsPtr, 0x10e0), partialProduct)
                mstore(add(valuesPtr, 0x10e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16420: x - g^16420 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1540)))
                mstore(add(productsPtr, 0x1100), partialProduct)
                mstore(add(valuesPtr, 0x1100), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16774: x - g^16774 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1560)))
                mstore(add(productsPtr, 0x1120), partialProduct)
                mstore(add(valuesPtr, 0x1120), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16775: x - g^16775 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1580)))
                mstore(add(productsPtr, 0x1140), partialProduct)
                mstore(add(valuesPtr, 0x1140), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 24966: x - g^24966 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x15a0)))
                mstore(add(productsPtr, 0x1160), partialProduct)
                mstore(add(valuesPtr, 0x1160), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 32646: x - g^32646 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x15c0)))
                mstore(add(productsPtr, 0x1180), partialProduct)
                mstore(add(valuesPtr, 0x1180), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 32662: x - g^32662 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x15e0)))
                mstore(add(productsPtr, 0x11a0), partialProduct)
                mstore(add(valuesPtr, 0x11a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 32710: x - g^32710 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1600)))
                mstore(add(productsPtr, 0x11c0), partialProduct)
                mstore(add(valuesPtr, 0x11c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 32724: x - g^32724 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1620)))
                mstore(add(productsPtr, 0x11e0), partialProduct)
                mstore(add(valuesPtr, 0x11e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 32730: x - g^32730 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1640)))
                mstore(add(productsPtr, 0x1200), partialProduct)
                mstore(add(valuesPtr, 0x1200), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 32742: x - g^32742 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1660)))
                mstore(add(productsPtr, 0x1220), partialProduct)
                mstore(add(valuesPtr, 0x1220), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 32756: x - g^32756 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1680)))
                mstore(add(productsPtr, 0x1240), partialProduct)
                mstore(add(valuesPtr, 0x1240), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 32762: x - g^32762 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x16a0)))
                mstore(add(productsPtr, 0x1260), partialProduct)
                mstore(add(valuesPtr, 0x1260), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 33158: x - g^33158 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x16c0)))
                mstore(add(productsPtr, 0x1280), partialProduct)
                mstore(add(valuesPtr, 0x1280), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate the denominator for the composition polynomial columns: x - z^2.
                let denominator := add(shiftedEvalPoint, minusPointPow)
                mstore(add(productsPtr, 0x12a0), partialProduct)
                mstore(add(valuesPtr, 0x12a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                // Add evalPoint to batch inverse inputs.
                // inverse(evalPoint) is going to be used by FRI.
                mstore(add(productsPtr, 0x12c0), partialProduct)
                mstore(add(valuesPtr, 0x12c0), evalPoint)
                partialProduct := mulmod(partialProduct, evalPoint, PRIME)

                // Advance pointers.
                productsPtr := add(productsPtr, 0x12e0)
                valuesPtr := add(valuesPtr, 0x12e0)
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
