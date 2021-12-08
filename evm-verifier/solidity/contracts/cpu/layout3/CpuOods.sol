// ---------- The following code was auto-generated. PLEASE DO NOT EDIT. ----------
// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.11;

import "./MemoryMap.sol";
import "./StarkParameters.sol";

contract CpuOods is MemoryMap, StarkParameters {
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
        uint256[] memory batchInverseArray = new uint256[](2 * BATCH_INVERSE_SIZE);

        oodsPrepareInverses(ctx, batchInverseArray);

        uint256 kMontgomeryRInv_ = PrimeFieldElement0.K_MONTGOMERY_R_INV;

        assembly {
            let PRIME := 0x800000000000011000000000000000000000000000000000000000000000001
            let kMontgomeryRInv := kMontgomeryRInv_
            let context := ctx
            let friQueue := /*friQueue*/ add(context, 0xdc0)
            let friQueueEnd := add(friQueue,  mul(/*n_unique_queries*/ mload(add(context, 0x140)), 0x60))
            let traceQueryResponses := /*traceQueryQesponses*/ add(context, 0x97e0)

            let compositionQueryResponses := /*composition_query_responses*/ add(context, 0x139e0)

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
                                  /*oods_coefficients[0]*/ mload(add(context, 0x7340)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[0]*/ mload(add(context, 0x48a0)))),
                           PRIME))

                // res += c_1*(f_0(x) - f_0(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  /*oods_coefficients[1]*/ mload(add(context, 0x7360)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[1]*/ mload(add(context, 0x48c0)))),
                           PRIME))

                // res += c_2*(f_0(x) - f_0(g^2 * z)) / (x - g^2 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2 * z)^(-1)*/ mload(add(denominatorsPtr, 0x40)),
                                  /*oods_coefficients[2]*/ mload(add(context, 0x7380)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[2]*/ mload(add(context, 0x48e0)))),
                           PRIME))

                // res += c_3*(f_0(x) - f_0(g^3 * z)) / (x - g^3 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3 * z)^(-1)*/ mload(add(denominatorsPtr, 0x60)),
                                  /*oods_coefficients[3]*/ mload(add(context, 0x73a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[3]*/ mload(add(context, 0x4900)))),
                           PRIME))

                // res += c_4*(f_0(x) - f_0(g^4 * z)) / (x - g^4 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4 * z)^(-1)*/ mload(add(denominatorsPtr, 0x80)),
                                  /*oods_coefficients[4]*/ mload(add(context, 0x73c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[4]*/ mload(add(context, 0x4920)))),
                           PRIME))

                // res += c_5*(f_0(x) - f_0(g^5 * z)) / (x - g^5 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^5 * z)^(-1)*/ mload(add(denominatorsPtr, 0xa0)),
                                  /*oods_coefficients[5]*/ mload(add(context, 0x73e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[5]*/ mload(add(context, 0x4940)))),
                           PRIME))

                // res += c_6*(f_0(x) - f_0(g^6 * z)) / (x - g^6 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^6 * z)^(-1)*/ mload(add(denominatorsPtr, 0xc0)),
                                  /*oods_coefficients[6]*/ mload(add(context, 0x7400)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[6]*/ mload(add(context, 0x4960)))),
                           PRIME))

                // res += c_7*(f_0(x) - f_0(g^7 * z)) / (x - g^7 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^7 * z)^(-1)*/ mload(add(denominatorsPtr, 0xe0)),
                                  /*oods_coefficients[7]*/ mload(add(context, 0x7420)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[7]*/ mload(add(context, 0x4980)))),
                           PRIME))

                // res += c_8*(f_0(x) - f_0(g^8 * z)) / (x - g^8 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8 * z)^(-1)*/ mload(add(denominatorsPtr, 0x100)),
                                  /*oods_coefficients[8]*/ mload(add(context, 0x7440)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[8]*/ mload(add(context, 0x49a0)))),
                           PRIME))

                // res += c_9*(f_0(x) - f_0(g^9 * z)) / (x - g^9 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^9 * z)^(-1)*/ mload(add(denominatorsPtr, 0x120)),
                                  /*oods_coefficients[9]*/ mload(add(context, 0x7460)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[9]*/ mload(add(context, 0x49c0)))),
                           PRIME))

                // res += c_10*(f_0(x) - f_0(g^10 * z)) / (x - g^10 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^10 * z)^(-1)*/ mload(add(denominatorsPtr, 0x140)),
                                  /*oods_coefficients[10]*/ mload(add(context, 0x7480)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[10]*/ mload(add(context, 0x49e0)))),
                           PRIME))

                // res += c_11*(f_0(x) - f_0(g^11 * z)) / (x - g^11 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^11 * z)^(-1)*/ mload(add(denominatorsPtr, 0x160)),
                                  /*oods_coefficients[11]*/ mload(add(context, 0x74a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[11]*/ mload(add(context, 0x4a00)))),
                           PRIME))

                // res += c_12*(f_0(x) - f_0(g^12 * z)) / (x - g^12 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^12 * z)^(-1)*/ mload(add(denominatorsPtr, 0x180)),
                                  /*oods_coefficients[12]*/ mload(add(context, 0x74c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[12]*/ mload(add(context, 0x4a20)))),
                           PRIME))

                // res += c_13*(f_0(x) - f_0(g^13 * z)) / (x - g^13 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^13 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1a0)),
                                  /*oods_coefficients[13]*/ mload(add(context, 0x74e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[13]*/ mload(add(context, 0x4a40)))),
                           PRIME))

                // res += c_14*(f_0(x) - f_0(g^14 * z)) / (x - g^14 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^14 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1c0)),
                                  /*oods_coefficients[14]*/ mload(add(context, 0x7500)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[14]*/ mload(add(context, 0x4a60)))),
                           PRIME))

                // res += c_15*(f_0(x) - f_0(g^15 * z)) / (x - g^15 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^15 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1e0)),
                                  /*oods_coefficients[15]*/ mload(add(context, 0x7520)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[15]*/ mload(add(context, 0x4a80)))),
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
                                  /*oods_coefficients[16]*/ mload(add(context, 0x7540)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[16]*/ mload(add(context, 0x4aa0)))),
                           PRIME))

                // res += c_17*(f_1(x) - f_1(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  /*oods_coefficients[17]*/ mload(add(context, 0x7560)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[17]*/ mload(add(context, 0x4ac0)))),
                           PRIME))

                // res += c_18*(f_1(x) - f_1(g^32 * z)) / (x - g^32 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^32 * z)^(-1)*/ mload(add(denominatorsPtr, 0x380)),
                                  /*oods_coefficients[18]*/ mload(add(context, 0x7580)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[18]*/ mload(add(context, 0x4ae0)))),
                           PRIME))

                // res += c_19*(f_1(x) - f_1(g^64 * z)) / (x - g^64 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^64 * z)^(-1)*/ mload(add(denominatorsPtr, 0x480)),
                                  /*oods_coefficients[19]*/ mload(add(context, 0x75a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[19]*/ mload(add(context, 0x4b00)))),
                           PRIME))

                // res += c_20*(f_1(x) - f_1(g^128 * z)) / (x - g^128 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^128 * z)^(-1)*/ mload(add(denominatorsPtr, 0x5c0)),
                                  /*oods_coefficients[20]*/ mload(add(context, 0x75c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[20]*/ mload(add(context, 0x4b20)))),
                           PRIME))

                // res += c_21*(f_1(x) - f_1(g^192 * z)) / (x - g^192 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^192 * z)^(-1)*/ mload(add(denominatorsPtr, 0x660)),
                                  /*oods_coefficients[21]*/ mload(add(context, 0x75e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[21]*/ mload(add(context, 0x4b40)))),
                           PRIME))

                // res += c_22*(f_1(x) - f_1(g^256 * z)) / (x - g^256 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^256 * z)^(-1)*/ mload(add(denominatorsPtr, 0x7a0)),
                                  /*oods_coefficients[22]*/ mload(add(context, 0x7600)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[22]*/ mload(add(context, 0x4b60)))),
                           PRIME))

                // res += c_23*(f_1(x) - f_1(g^320 * z)) / (x - g^320 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^320 * z)^(-1)*/ mload(add(denominatorsPtr, 0x800)),
                                  /*oods_coefficients[23]*/ mload(add(context, 0x7620)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[23]*/ mload(add(context, 0x4b80)))),
                           PRIME))

                // res += c_24*(f_1(x) - f_1(g^384 * z)) / (x - g^384 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^384 * z)^(-1)*/ mload(add(denominatorsPtr, 0x840)),
                                  /*oods_coefficients[24]*/ mload(add(context, 0x7640)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[24]*/ mload(add(context, 0x4ba0)))),
                           PRIME))

                // res += c_25*(f_1(x) - f_1(g^448 * z)) / (x - g^448 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^448 * z)^(-1)*/ mload(add(denominatorsPtr, 0x8a0)),
                                  /*oods_coefficients[25]*/ mload(add(context, 0x7660)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[25]*/ mload(add(context, 0x4bc0)))),
                           PRIME))

                // res += c_26*(f_1(x) - f_1(g^512 * z)) / (x - g^512 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^512 * z)^(-1)*/ mload(add(denominatorsPtr, 0x900)),
                                  /*oods_coefficients[26]*/ mload(add(context, 0x7680)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[26]*/ mload(add(context, 0x4be0)))),
                           PRIME))

                // res += c_27*(f_1(x) - f_1(g^576 * z)) / (x - g^576 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^576 * z)^(-1)*/ mload(add(denominatorsPtr, 0x960)),
                                  /*oods_coefficients[27]*/ mload(add(context, 0x76a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[27]*/ mload(add(context, 0x4c00)))),
                           PRIME))

                // res += c_28*(f_1(x) - f_1(g^640 * z)) / (x - g^640 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^640 * z)^(-1)*/ mload(add(denominatorsPtr, 0x980)),
                                  /*oods_coefficients[28]*/ mload(add(context, 0x76c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[28]*/ mload(add(context, 0x4c20)))),
                           PRIME))

                // res += c_29*(f_1(x) - f_1(g^704 * z)) / (x - g^704 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^704 * z)^(-1)*/ mload(add(denominatorsPtr, 0x9a0)),
                                  /*oods_coefficients[29]*/ mload(add(context, 0x76e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[29]*/ mload(add(context, 0x4c40)))),
                           PRIME))

                // res += c_30*(f_1(x) - f_1(g^768 * z)) / (x - g^768 * z).
                res := addmod(
                    res,
                    mulmod(mulmod(/*(x - g^768 * z)^(-1)*/ mload(add(denominatorsPtr, 0x9c0)),
                                  /*oods_coefficients[30]*/ mload(add(context, 0x7700)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[30]*/ mload(add(context, 0x4c60)))),
                           PRIME),
                    PRIME)

                // res += c_31*(f_1(x) - f_1(g^832 * z)) / (x - g^832 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^832 * z)^(-1)*/ mload(add(denominatorsPtr, 0x9e0)),
                                  /*oods_coefficients[31]*/ mload(add(context, 0x7720)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[31]*/ mload(add(context, 0x4c80)))),
                           PRIME))

                // res += c_32*(f_1(x) - f_1(g^896 * z)) / (x - g^896 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^896 * z)^(-1)*/ mload(add(denominatorsPtr, 0xa00)),
                                  /*oods_coefficients[32]*/ mload(add(context, 0x7740)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[32]*/ mload(add(context, 0x4ca0)))),
                           PRIME))

                // res += c_33*(f_1(x) - f_1(g^960 * z)) / (x - g^960 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^960 * z)^(-1)*/ mload(add(denominatorsPtr, 0xa20)),
                                  /*oods_coefficients[33]*/ mload(add(context, 0x7760)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[33]*/ mload(add(context, 0x4cc0)))),
                           PRIME))

                // res += c_34*(f_1(x) - f_1(g^1024 * z)) / (x - g^1024 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^1024 * z)^(-1)*/ mload(add(denominatorsPtr, 0xa40)),
                                  /*oods_coefficients[34]*/ mload(add(context, 0x7780)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[34]*/ mload(add(context, 0x4ce0)))),
                           PRIME))

                // res += c_35*(f_1(x) - f_1(g^1056 * z)) / (x - g^1056 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^1056 * z)^(-1)*/ mload(add(denominatorsPtr, 0xaa0)),
                                  /*oods_coefficients[35]*/ mload(add(context, 0x77a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[35]*/ mload(add(context, 0x4d00)))),
                           PRIME))

                // res += c_36*(f_1(x) - f_1(g^1088 * z)) / (x - g^1088 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^1088 * z)^(-1)*/ mload(add(denominatorsPtr, 0xac0)),
                                  /*oods_coefficients[36]*/ mload(add(context, 0x77c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[36]*/ mload(add(context, 0x4d20)))),
                           PRIME))

                // res += c_37*(f_1(x) - f_1(g^1152 * z)) / (x - g^1152 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^1152 * z)^(-1)*/ mload(add(denominatorsPtr, 0xae0)),
                                  /*oods_coefficients[37]*/ mload(add(context, 0x77e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[37]*/ mload(add(context, 0x4d40)))),
                           PRIME))

                // res += c_38*(f_1(x) - f_1(g^1216 * z)) / (x - g^1216 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^1216 * z)^(-1)*/ mload(add(denominatorsPtr, 0xb00)),
                                  /*oods_coefficients[38]*/ mload(add(context, 0x7800)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[38]*/ mload(add(context, 0x4d60)))),
                           PRIME))

                // res += c_39*(f_1(x) - f_1(g^1280 * z)) / (x - g^1280 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^1280 * z)^(-1)*/ mload(add(denominatorsPtr, 0xb20)),
                                  /*oods_coefficients[39]*/ mload(add(context, 0x7820)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[39]*/ mload(add(context, 0x4d80)))),
                           PRIME))

                // res += c_40*(f_1(x) - f_1(g^1344 * z)) / (x - g^1344 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^1344 * z)^(-1)*/ mload(add(denominatorsPtr, 0xb40)),
                                  /*oods_coefficients[40]*/ mload(add(context, 0x7840)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[40]*/ mload(add(context, 0x4da0)))),
                           PRIME))

                // res += c_41*(f_1(x) - f_1(g^1408 * z)) / (x - g^1408 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^1408 * z)^(-1)*/ mload(add(denominatorsPtr, 0xb60)),
                                  /*oods_coefficients[41]*/ mload(add(context, 0x7860)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[41]*/ mload(add(context, 0x4dc0)))),
                           PRIME))

                // res += c_42*(f_1(x) - f_1(g^1472 * z)) / (x - g^1472 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^1472 * z)^(-1)*/ mload(add(denominatorsPtr, 0xb80)),
                                  /*oods_coefficients[42]*/ mload(add(context, 0x7880)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[42]*/ mload(add(context, 0x4de0)))),
                           PRIME))

                // res += c_43*(f_1(x) - f_1(g^1536 * z)) / (x - g^1536 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^1536 * z)^(-1)*/ mload(add(denominatorsPtr, 0xba0)),
                                  /*oods_coefficients[43]*/ mload(add(context, 0x78a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[43]*/ mload(add(context, 0x4e00)))),
                           PRIME))

                // res += c_44*(f_1(x) - f_1(g^1600 * z)) / (x - g^1600 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^1600 * z)^(-1)*/ mload(add(denominatorsPtr, 0xbc0)),
                                  /*oods_coefficients[44]*/ mload(add(context, 0x78c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[44]*/ mload(add(context, 0x4e20)))),
                           PRIME))

                // res += c_45*(f_1(x) - f_1(g^1664 * z)) / (x - g^1664 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^1664 * z)^(-1)*/ mload(add(denominatorsPtr, 0xbe0)),
                                  /*oods_coefficients[45]*/ mload(add(context, 0x78e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[45]*/ mload(add(context, 0x4e40)))),
                           PRIME))

                // res += c_46*(f_1(x) - f_1(g^1728 * z)) / (x - g^1728 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^1728 * z)^(-1)*/ mload(add(denominatorsPtr, 0xc00)),
                                  /*oods_coefficients[46]*/ mload(add(context, 0x7900)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[46]*/ mload(add(context, 0x4e60)))),
                           PRIME))

                // res += c_47*(f_1(x) - f_1(g^1792 * z)) / (x - g^1792 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^1792 * z)^(-1)*/ mload(add(denominatorsPtr, 0xc20)),
                                  /*oods_coefficients[47]*/ mload(add(context, 0x7920)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[47]*/ mload(add(context, 0x4e80)))),
                           PRIME))

                // res += c_48*(f_1(x) - f_1(g^1856 * z)) / (x - g^1856 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^1856 * z)^(-1)*/ mload(add(denominatorsPtr, 0xc40)),
                                  /*oods_coefficients[48]*/ mload(add(context, 0x7940)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[48]*/ mload(add(context, 0x4ea0)))),
                           PRIME))

                // res += c_49*(f_1(x) - f_1(g^1920 * z)) / (x - g^1920 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^1920 * z)^(-1)*/ mload(add(denominatorsPtr, 0xc60)),
                                  /*oods_coefficients[49]*/ mload(add(context, 0x7960)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[49]*/ mload(add(context, 0x4ec0)))),
                           PRIME))

                // res += c_50*(f_1(x) - f_1(g^1984 * z)) / (x - g^1984 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^1984 * z)^(-1)*/ mload(add(denominatorsPtr, 0xc80)),
                                  /*oods_coefficients[50]*/ mload(add(context, 0x7980)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[50]*/ mload(add(context, 0x4ee0)))),
                           PRIME))

                // res += c_51*(f_1(x) - f_1(g^2048 * z)) / (x - g^2048 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2048 * z)^(-1)*/ mload(add(denominatorsPtr, 0xca0)),
                                  /*oods_coefficients[51]*/ mload(add(context, 0x79a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[51]*/ mload(add(context, 0x4f00)))),
                           PRIME))

                // res += c_52*(f_1(x) - f_1(g^2080 * z)) / (x - g^2080 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2080 * z)^(-1)*/ mload(add(denominatorsPtr, 0xd00)),
                                  /*oods_coefficients[52]*/ mload(add(context, 0x79c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[52]*/ mload(add(context, 0x4f20)))),
                           PRIME))

                // res += c_53*(f_1(x) - f_1(g^2112 * z)) / (x - g^2112 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2112 * z)^(-1)*/ mload(add(denominatorsPtr, 0xd20)),
                                  /*oods_coefficients[53]*/ mload(add(context, 0x79e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[53]*/ mload(add(context, 0x4f40)))),
                           PRIME))

                // res += c_54*(f_1(x) - f_1(g^2176 * z)) / (x - g^2176 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2176 * z)^(-1)*/ mload(add(denominatorsPtr, 0xd40)),
                                  /*oods_coefficients[54]*/ mload(add(context, 0x7a00)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[54]*/ mload(add(context, 0x4f60)))),
                           PRIME))

                // res += c_55*(f_1(x) - f_1(g^2240 * z)) / (x - g^2240 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2240 * z)^(-1)*/ mload(add(denominatorsPtr, 0xd60)),
                                  /*oods_coefficients[55]*/ mload(add(context, 0x7a20)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[55]*/ mload(add(context, 0x4f80)))),
                           PRIME))

                // res += c_56*(f_1(x) - f_1(g^2304 * z)) / (x - g^2304 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2304 * z)^(-1)*/ mload(add(denominatorsPtr, 0xd80)),
                                  /*oods_coefficients[56]*/ mload(add(context, 0x7a40)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[56]*/ mload(add(context, 0x4fa0)))),
                           PRIME))

                // res += c_57*(f_1(x) - f_1(g^2368 * z)) / (x - g^2368 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2368 * z)^(-1)*/ mload(add(denominatorsPtr, 0xda0)),
                                  /*oods_coefficients[57]*/ mload(add(context, 0x7a60)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[57]*/ mload(add(context, 0x4fc0)))),
                           PRIME))

                // res += c_58*(f_1(x) - f_1(g^2432 * z)) / (x - g^2432 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2432 * z)^(-1)*/ mload(add(denominatorsPtr, 0xdc0)),
                                  /*oods_coefficients[58]*/ mload(add(context, 0x7a80)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[58]*/ mload(add(context, 0x4fe0)))),
                           PRIME))

                // res += c_59*(f_1(x) - f_1(g^2496 * z)) / (x - g^2496 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2496 * z)^(-1)*/ mload(add(denominatorsPtr, 0xde0)),
                                  /*oods_coefficients[59]*/ mload(add(context, 0x7aa0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[59]*/ mload(add(context, 0x5000)))),
                           PRIME))

                // res += c_60*(f_1(x) - f_1(g^2560 * z)) / (x - g^2560 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2560 * z)^(-1)*/ mload(add(denominatorsPtr, 0xe00)),
                                  /*oods_coefficients[60]*/ mload(add(context, 0x7ac0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[60]*/ mload(add(context, 0x5020)))),
                           PRIME))

                // res += c_61*(f_1(x) - f_1(g^2624 * z)) / (x - g^2624 * z).
                res := addmod(
                    res,
                    mulmod(mulmod(/*(x - g^2624 * z)^(-1)*/ mload(add(denominatorsPtr, 0xe60)),
                                  /*oods_coefficients[61]*/ mload(add(context, 0x7ae0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[61]*/ mload(add(context, 0x5040)))),
                           PRIME),
                    PRIME)

                // res += c_62*(f_1(x) - f_1(g^2688 * z)) / (x - g^2688 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2688 * z)^(-1)*/ mload(add(denominatorsPtr, 0xe80)),
                                  /*oods_coefficients[62]*/ mload(add(context, 0x7b00)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[62]*/ mload(add(context, 0x5060)))),
                           PRIME))

                // res += c_63*(f_1(x) - f_1(g^2752 * z)) / (x - g^2752 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2752 * z)^(-1)*/ mload(add(denominatorsPtr, 0xea0)),
                                  /*oods_coefficients[63]*/ mload(add(context, 0x7b20)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[63]*/ mload(add(context, 0x5080)))),
                           PRIME))

                // res += c_64*(f_1(x) - f_1(g^2816 * z)) / (x - g^2816 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2816 * z)^(-1)*/ mload(add(denominatorsPtr, 0xec0)),
                                  /*oods_coefficients[64]*/ mload(add(context, 0x7b40)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[64]*/ mload(add(context, 0x50a0)))),
                           PRIME))

                // res += c_65*(f_1(x) - f_1(g^2880 * z)) / (x - g^2880 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2880 * z)^(-1)*/ mload(add(denominatorsPtr, 0xee0)),
                                  /*oods_coefficients[65]*/ mload(add(context, 0x7b60)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[65]*/ mload(add(context, 0x50c0)))),
                           PRIME))

                // res += c_66*(f_1(x) - f_1(g^2944 * z)) / (x - g^2944 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2944 * z)^(-1)*/ mload(add(denominatorsPtr, 0xf00)),
                                  /*oods_coefficients[66]*/ mload(add(context, 0x7b80)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[66]*/ mload(add(context, 0x50e0)))),
                           PRIME))

                // res += c_67*(f_1(x) - f_1(g^3008 * z)) / (x - g^3008 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3008 * z)^(-1)*/ mload(add(denominatorsPtr, 0xf20)),
                                  /*oods_coefficients[67]*/ mload(add(context, 0x7ba0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[67]*/ mload(add(context, 0x5100)))),
                           PRIME))

                // res += c_68*(f_1(x) - f_1(g^3072 * z)) / (x - g^3072 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3072 * z)^(-1)*/ mload(add(denominatorsPtr, 0xf40)),
                                  /*oods_coefficients[68]*/ mload(add(context, 0x7bc0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[68]*/ mload(add(context, 0x5120)))),
                           PRIME))

                // res += c_69*(f_1(x) - f_1(g^3104 * z)) / (x - g^3104 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3104 * z)^(-1)*/ mload(add(denominatorsPtr, 0xfa0)),
                                  /*oods_coefficients[69]*/ mload(add(context, 0x7be0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[69]*/ mload(add(context, 0x5140)))),
                           PRIME))

                // res += c_70*(f_1(x) - f_1(g^3136 * z)) / (x - g^3136 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3136 * z)^(-1)*/ mload(add(denominatorsPtr, 0xfc0)),
                                  /*oods_coefficients[70]*/ mload(add(context, 0x7c00)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[70]*/ mload(add(context, 0x5160)))),
                           PRIME))

                // res += c_71*(f_1(x) - f_1(g^3200 * z)) / (x - g^3200 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3200 * z)^(-1)*/ mload(add(denominatorsPtr, 0xfe0)),
                                  /*oods_coefficients[71]*/ mload(add(context, 0x7c20)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[71]*/ mload(add(context, 0x5180)))),
                           PRIME))

                // res += c_72*(f_1(x) - f_1(g^3264 * z)) / (x - g^3264 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3264 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1000)),
                                  /*oods_coefficients[72]*/ mload(add(context, 0x7c40)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[72]*/ mload(add(context, 0x51a0)))),
                           PRIME))

                // res += c_73*(f_1(x) - f_1(g^3328 * z)) / (x - g^3328 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3328 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1020)),
                                  /*oods_coefficients[73]*/ mload(add(context, 0x7c60)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[73]*/ mload(add(context, 0x51c0)))),
                           PRIME))

                // res += c_74*(f_1(x) - f_1(g^3392 * z)) / (x - g^3392 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3392 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1040)),
                                  /*oods_coefficients[74]*/ mload(add(context, 0x7c80)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[74]*/ mload(add(context, 0x51e0)))),
                           PRIME))

                // res += c_75*(f_1(x) - f_1(g^3456 * z)) / (x - g^3456 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3456 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1060)),
                                  /*oods_coefficients[75]*/ mload(add(context, 0x7ca0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[75]*/ mload(add(context, 0x5200)))),
                           PRIME))

                // res += c_76*(f_1(x) - f_1(g^3520 * z)) / (x - g^3520 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3520 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1080)),
                                  /*oods_coefficients[76]*/ mload(add(context, 0x7cc0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[76]*/ mload(add(context, 0x5220)))),
                           PRIME))

                // res += c_77*(f_1(x) - f_1(g^3584 * z)) / (x - g^3584 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3584 * z)^(-1)*/ mload(add(denominatorsPtr, 0x10a0)),
                                  /*oods_coefficients[77]*/ mload(add(context, 0x7ce0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[77]*/ mload(add(context, 0x5240)))),
                           PRIME))

                // res += c_78*(f_1(x) - f_1(g^3648 * z)) / (x - g^3648 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3648 * z)^(-1)*/ mload(add(denominatorsPtr, 0x10c0)),
                                  /*oods_coefficients[78]*/ mload(add(context, 0x7d00)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[78]*/ mload(add(context, 0x5260)))),
                           PRIME))

                // res += c_79*(f_1(x) - f_1(g^3712 * z)) / (x - g^3712 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3712 * z)^(-1)*/ mload(add(denominatorsPtr, 0x10e0)),
                                  /*oods_coefficients[79]*/ mload(add(context, 0x7d20)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[79]*/ mload(add(context, 0x5280)))),
                           PRIME))

                // res += c_80*(f_1(x) - f_1(g^3776 * z)) / (x - g^3776 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3776 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1100)),
                                  /*oods_coefficients[80]*/ mload(add(context, 0x7d40)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[80]*/ mload(add(context, 0x52a0)))),
                           PRIME))

                // res += c_81*(f_1(x) - f_1(g^3840 * z)) / (x - g^3840 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3840 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1120)),
                                  /*oods_coefficients[81]*/ mload(add(context, 0x7d60)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[81]*/ mload(add(context, 0x52c0)))),
                           PRIME))

                // res += c_82*(f_1(x) - f_1(g^3904 * z)) / (x - g^3904 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3904 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1140)),
                                  /*oods_coefficients[82]*/ mload(add(context, 0x7d80)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[82]*/ mload(add(context, 0x52e0)))),
                           PRIME))

                // res += c_83*(f_1(x) - f_1(g^3968 * z)) / (x - g^3968 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3968 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1160)),
                                  /*oods_coefficients[83]*/ mload(add(context, 0x7da0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[83]*/ mload(add(context, 0x5300)))),
                           PRIME))

                // res += c_84*(f_1(x) - f_1(g^4032 * z)) / (x - g^4032 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4032 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1180)),
                                  /*oods_coefficients[84]*/ mload(add(context, 0x7dc0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[84]*/ mload(add(context, 0x5320)))),
                           PRIME))
                }

                // Mask items for column #2.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x40)), kMontgomeryRInv, PRIME)

                // res += c_85*(f_2(x) - f_2(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[85]*/ mload(add(context, 0x7de0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[85]*/ mload(add(context, 0x5340)))),
                           PRIME))

                // res += c_86*(f_2(x) - f_2(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  /*oods_coefficients[86]*/ mload(add(context, 0x7e00)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[86]*/ mload(add(context, 0x5360)))),
                           PRIME))
                }

                // Mask items for column #3.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x60)), kMontgomeryRInv, PRIME)

                // res += c_87*(f_3(x) - f_3(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[87]*/ mload(add(context, 0x7e20)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[87]*/ mload(add(context, 0x5380)))),
                           PRIME))

                // res += c_88*(f_3(x) - f_3(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  /*oods_coefficients[88]*/ mload(add(context, 0x7e40)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[88]*/ mload(add(context, 0x53a0)))),
                           PRIME))

                // res += c_89*(f_3(x) - f_3(g^255 * z)) / (x - g^255 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^255 * z)^(-1)*/ mload(add(denominatorsPtr, 0x780)),
                                  /*oods_coefficients[89]*/ mload(add(context, 0x7e60)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[89]*/ mload(add(context, 0x53c0)))),
                           PRIME))

                // res += c_90*(f_3(x) - f_3(g^256 * z)) / (x - g^256 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^256 * z)^(-1)*/ mload(add(denominatorsPtr, 0x7a0)),
                                  /*oods_coefficients[90]*/ mload(add(context, 0x7e80)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[90]*/ mload(add(context, 0x53e0)))),
                           PRIME))

                // res += c_91*(f_3(x) - f_3(g^511 * z)) / (x - g^511 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^511 * z)^(-1)*/ mload(add(denominatorsPtr, 0x8e0)),
                                  /*oods_coefficients[91]*/ mload(add(context, 0x7ea0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[91]*/ mload(add(context, 0x5400)))),
                           PRIME))
                }

                // Mask items for column #4.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x80)), kMontgomeryRInv, PRIME)

                // res += c_92*(f_4(x) - f_4(z)) / (x - z).
                res := addmod(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[92]*/ mload(add(context, 0x7ec0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[92]*/ mload(add(context, 0x5420)))),
                           PRIME),
                    PRIME)

                // res += c_93*(f_4(x) - f_4(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  /*oods_coefficients[93]*/ mload(add(context, 0x7ee0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[93]*/ mload(add(context, 0x5440)))),
                           PRIME))

                // res += c_94*(f_4(x) - f_4(g^255 * z)) / (x - g^255 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^255 * z)^(-1)*/ mload(add(denominatorsPtr, 0x780)),
                                  /*oods_coefficients[94]*/ mload(add(context, 0x7f00)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[94]*/ mload(add(context, 0x5460)))),
                           PRIME))

                // res += c_95*(f_4(x) - f_4(g^256 * z)) / (x - g^256 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^256 * z)^(-1)*/ mload(add(denominatorsPtr, 0x7a0)),
                                  /*oods_coefficients[95]*/ mload(add(context, 0x7f20)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[95]*/ mload(add(context, 0x5480)))),
                           PRIME))
                }

                // Mask items for column #5.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0xa0)), kMontgomeryRInv, PRIME)

                // res += c_96*(f_5(x) - f_5(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[96]*/ mload(add(context, 0x7f40)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[96]*/ mload(add(context, 0x54a0)))),
                           PRIME))

                // res += c_97*(f_5(x) - f_5(g^255 * z)) / (x - g^255 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^255 * z)^(-1)*/ mload(add(denominatorsPtr, 0x780)),
                                  /*oods_coefficients[97]*/ mload(add(context, 0x7f60)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[97]*/ mload(add(context, 0x54c0)))),
                           PRIME))
                }

                // Mask items for column #6.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0xc0)), kMontgomeryRInv, PRIME)

                // res += c_98*(f_6(x) - f_6(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[98]*/ mload(add(context, 0x7f80)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[98]*/ mload(add(context, 0x54e0)))),
                           PRIME))

                // res += c_99*(f_6(x) - f_6(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  /*oods_coefficients[99]*/ mload(add(context, 0x7fa0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[99]*/ mload(add(context, 0x5500)))),
                           PRIME))

                // res += c_100*(f_6(x) - f_6(g^192 * z)) / (x - g^192 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^192 * z)^(-1)*/ mload(add(denominatorsPtr, 0x660)),
                                  /*oods_coefficients[100]*/ mload(add(context, 0x7fc0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[100]*/ mload(add(context, 0x5520)))),
                           PRIME))

                // res += c_101*(f_6(x) - f_6(g^193 * z)) / (x - g^193 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^193 * z)^(-1)*/ mload(add(denominatorsPtr, 0x680)),
                                  /*oods_coefficients[101]*/ mload(add(context, 0x7fe0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[101]*/ mload(add(context, 0x5540)))),
                           PRIME))

                // res += c_102*(f_6(x) - f_6(g^196 * z)) / (x - g^196 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^196 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6a0)),
                                  /*oods_coefficients[102]*/ mload(add(context, 0x8000)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[102]*/ mload(add(context, 0x5560)))),
                           PRIME))

                // res += c_103*(f_6(x) - f_6(g^197 * z)) / (x - g^197 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^197 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6c0)),
                                  /*oods_coefficients[103]*/ mload(add(context, 0x8020)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[103]*/ mload(add(context, 0x5580)))),
                           PRIME))

                // res += c_104*(f_6(x) - f_6(g^251 * z)) / (x - g^251 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^251 * z)^(-1)*/ mload(add(denominatorsPtr, 0x740)),
                                  /*oods_coefficients[104]*/ mload(add(context, 0x8040)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[104]*/ mload(add(context, 0x55a0)))),
                           PRIME))

                // res += c_105*(f_6(x) - f_6(g^252 * z)) / (x - g^252 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^252 * z)^(-1)*/ mload(add(denominatorsPtr, 0x760)),
                                  /*oods_coefficients[105]*/ mload(add(context, 0x8060)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[105]*/ mload(add(context, 0x55c0)))),
                           PRIME))

                // res += c_106*(f_6(x) - f_6(g^256 * z)) / (x - g^256 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^256 * z)^(-1)*/ mload(add(denominatorsPtr, 0x7a0)),
                                  /*oods_coefficients[106]*/ mload(add(context, 0x8080)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[106]*/ mload(add(context, 0x55e0)))),
                           PRIME))
                }

                // Mask items for column #7.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0xe0)), kMontgomeryRInv, PRIME)

                // res += c_107*(f_7(x) - f_7(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[107]*/ mload(add(context, 0x80a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[107]*/ mload(add(context, 0x5600)))),
                           PRIME))

                // res += c_108*(f_7(x) - f_7(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  /*oods_coefficients[108]*/ mload(add(context, 0x80c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[108]*/ mload(add(context, 0x5620)))),
                           PRIME))

                // res += c_109*(f_7(x) - f_7(g^255 * z)) / (x - g^255 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^255 * z)^(-1)*/ mload(add(denominatorsPtr, 0x780)),
                                  /*oods_coefficients[109]*/ mload(add(context, 0x80e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[109]*/ mload(add(context, 0x5640)))),
                           PRIME))

                // res += c_110*(f_7(x) - f_7(g^256 * z)) / (x - g^256 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^256 * z)^(-1)*/ mload(add(denominatorsPtr, 0x7a0)),
                                  /*oods_coefficients[110]*/ mload(add(context, 0x8100)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[110]*/ mload(add(context, 0x5660)))),
                           PRIME))

                // res += c_111*(f_7(x) - f_7(g^511 * z)) / (x - g^511 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^511 * z)^(-1)*/ mload(add(denominatorsPtr, 0x8e0)),
                                  /*oods_coefficients[111]*/ mload(add(context, 0x8120)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[111]*/ mload(add(context, 0x5680)))),
                           PRIME))
                }

                // Mask items for column #8.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x100)), kMontgomeryRInv, PRIME)

                // res += c_112*(f_8(x) - f_8(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[112]*/ mload(add(context, 0x8140)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[112]*/ mload(add(context, 0x56a0)))),
                           PRIME))

                // res += c_113*(f_8(x) - f_8(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  /*oods_coefficients[113]*/ mload(add(context, 0x8160)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[113]*/ mload(add(context, 0x56c0)))),
                           PRIME))

                // res += c_114*(f_8(x) - f_8(g^255 * z)) / (x - g^255 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^255 * z)^(-1)*/ mload(add(denominatorsPtr, 0x780)),
                                  /*oods_coefficients[114]*/ mload(add(context, 0x8180)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[114]*/ mload(add(context, 0x56e0)))),
                           PRIME))

                // res += c_115*(f_8(x) - f_8(g^256 * z)) / (x - g^256 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^256 * z)^(-1)*/ mload(add(denominatorsPtr, 0x7a0)),
                                  /*oods_coefficients[115]*/ mload(add(context, 0x81a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[115]*/ mload(add(context, 0x5700)))),
                           PRIME))
                }

                // Mask items for column #9.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x120)), kMontgomeryRInv, PRIME)

                // res += c_116*(f_9(x) - f_9(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[116]*/ mload(add(context, 0x81c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[116]*/ mload(add(context, 0x5720)))),
                           PRIME))

                // res += c_117*(f_9(x) - f_9(g^255 * z)) / (x - g^255 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^255 * z)^(-1)*/ mload(add(denominatorsPtr, 0x780)),
                                  /*oods_coefficients[117]*/ mload(add(context, 0x81e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[117]*/ mload(add(context, 0x5740)))),
                           PRIME))
                }

                // Mask items for column #10.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x140)), kMontgomeryRInv, PRIME)

                // res += c_118*(f_10(x) - f_10(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[118]*/ mload(add(context, 0x8200)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[118]*/ mload(add(context, 0x5760)))),
                           PRIME))

                // res += c_119*(f_10(x) - f_10(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  /*oods_coefficients[119]*/ mload(add(context, 0x8220)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[119]*/ mload(add(context, 0x5780)))),
                           PRIME))

                // res += c_120*(f_10(x) - f_10(g^192 * z)) / (x - g^192 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^192 * z)^(-1)*/ mload(add(denominatorsPtr, 0x660)),
                                  /*oods_coefficients[120]*/ mload(add(context, 0x8240)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[120]*/ mload(add(context, 0x57a0)))),
                           PRIME))

                // res += c_121*(f_10(x) - f_10(g^193 * z)) / (x - g^193 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^193 * z)^(-1)*/ mload(add(denominatorsPtr, 0x680)),
                                  /*oods_coefficients[121]*/ mload(add(context, 0x8260)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[121]*/ mload(add(context, 0x57c0)))),
                           PRIME))

                // res += c_122*(f_10(x) - f_10(g^196 * z)) / (x - g^196 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^196 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6a0)),
                                  /*oods_coefficients[122]*/ mload(add(context, 0x8280)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[122]*/ mload(add(context, 0x57e0)))),
                           PRIME))

                // res += c_123*(f_10(x) - f_10(g^197 * z)) / (x - g^197 * z).
                res := addmod(
                    res,
                    mulmod(mulmod(/*(x - g^197 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6c0)),
                                  /*oods_coefficients[123]*/ mload(add(context, 0x82a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[123]*/ mload(add(context, 0x5800)))),
                           PRIME),
                    PRIME)

                // res += c_124*(f_10(x) - f_10(g^251 * z)) / (x - g^251 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^251 * z)^(-1)*/ mload(add(denominatorsPtr, 0x740)),
                                  /*oods_coefficients[124]*/ mload(add(context, 0x82c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[124]*/ mload(add(context, 0x5820)))),
                           PRIME))

                // res += c_125*(f_10(x) - f_10(g^252 * z)) / (x - g^252 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^252 * z)^(-1)*/ mload(add(denominatorsPtr, 0x760)),
                                  /*oods_coefficients[125]*/ mload(add(context, 0x82e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[125]*/ mload(add(context, 0x5840)))),
                           PRIME))

                // res += c_126*(f_10(x) - f_10(g^256 * z)) / (x - g^256 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^256 * z)^(-1)*/ mload(add(denominatorsPtr, 0x7a0)),
                                  /*oods_coefficients[126]*/ mload(add(context, 0x8300)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[126]*/ mload(add(context, 0x5860)))),
                           PRIME))
                }

                // Mask items for column #11.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x160)), kMontgomeryRInv, PRIME)

                // res += c_127*(f_11(x) - f_11(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[127]*/ mload(add(context, 0x8320)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[127]*/ mload(add(context, 0x5880)))),
                           PRIME))

                // res += c_128*(f_11(x) - f_11(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  /*oods_coefficients[128]*/ mload(add(context, 0x8340)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[128]*/ mload(add(context, 0x58a0)))),
                           PRIME))

                // res += c_129*(f_11(x) - f_11(g^255 * z)) / (x - g^255 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^255 * z)^(-1)*/ mload(add(denominatorsPtr, 0x780)),
                                  /*oods_coefficients[129]*/ mload(add(context, 0x8360)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[129]*/ mload(add(context, 0x58c0)))),
                           PRIME))

                // res += c_130*(f_11(x) - f_11(g^256 * z)) / (x - g^256 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^256 * z)^(-1)*/ mload(add(denominatorsPtr, 0x7a0)),
                                  /*oods_coefficients[130]*/ mload(add(context, 0x8380)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[130]*/ mload(add(context, 0x58e0)))),
                           PRIME))

                // res += c_131*(f_11(x) - f_11(g^511 * z)) / (x - g^511 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^511 * z)^(-1)*/ mload(add(denominatorsPtr, 0x8e0)),
                                  /*oods_coefficients[131]*/ mload(add(context, 0x83a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[131]*/ mload(add(context, 0x5900)))),
                           PRIME))
                }

                // Mask items for column #12.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x180)), kMontgomeryRInv, PRIME)

                // res += c_132*(f_12(x) - f_12(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[132]*/ mload(add(context, 0x83c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[132]*/ mload(add(context, 0x5920)))),
                           PRIME))

                // res += c_133*(f_12(x) - f_12(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  /*oods_coefficients[133]*/ mload(add(context, 0x83e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[133]*/ mload(add(context, 0x5940)))),
                           PRIME))

                // res += c_134*(f_12(x) - f_12(g^255 * z)) / (x - g^255 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^255 * z)^(-1)*/ mload(add(denominatorsPtr, 0x780)),
                                  /*oods_coefficients[134]*/ mload(add(context, 0x8400)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[134]*/ mload(add(context, 0x5960)))),
                           PRIME))

                // res += c_135*(f_12(x) - f_12(g^256 * z)) / (x - g^256 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^256 * z)^(-1)*/ mload(add(denominatorsPtr, 0x7a0)),
                                  /*oods_coefficients[135]*/ mload(add(context, 0x8420)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[135]*/ mload(add(context, 0x5980)))),
                           PRIME))
                }

                // Mask items for column #13.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x1a0)), kMontgomeryRInv, PRIME)

                // res += c_136*(f_13(x) - f_13(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[136]*/ mload(add(context, 0x8440)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[136]*/ mload(add(context, 0x59a0)))),
                           PRIME))

                // res += c_137*(f_13(x) - f_13(g^255 * z)) / (x - g^255 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^255 * z)^(-1)*/ mload(add(denominatorsPtr, 0x780)),
                                  /*oods_coefficients[137]*/ mload(add(context, 0x8460)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[137]*/ mload(add(context, 0x59c0)))),
                           PRIME))
                }

                // Mask items for column #14.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x1c0)), kMontgomeryRInv, PRIME)

                // res += c_138*(f_14(x) - f_14(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[138]*/ mload(add(context, 0x8480)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[138]*/ mload(add(context, 0x59e0)))),
                           PRIME))

                // res += c_139*(f_14(x) - f_14(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  /*oods_coefficients[139]*/ mload(add(context, 0x84a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[139]*/ mload(add(context, 0x5a00)))),
                           PRIME))

                // res += c_140*(f_14(x) - f_14(g^192 * z)) / (x - g^192 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^192 * z)^(-1)*/ mload(add(denominatorsPtr, 0x660)),
                                  /*oods_coefficients[140]*/ mload(add(context, 0x84c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[140]*/ mload(add(context, 0x5a20)))),
                           PRIME))

                // res += c_141*(f_14(x) - f_14(g^193 * z)) / (x - g^193 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^193 * z)^(-1)*/ mload(add(denominatorsPtr, 0x680)),
                                  /*oods_coefficients[141]*/ mload(add(context, 0x84e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[141]*/ mload(add(context, 0x5a40)))),
                           PRIME))

                // res += c_142*(f_14(x) - f_14(g^196 * z)) / (x - g^196 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^196 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6a0)),
                                  /*oods_coefficients[142]*/ mload(add(context, 0x8500)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[142]*/ mload(add(context, 0x5a60)))),
                           PRIME))

                // res += c_143*(f_14(x) - f_14(g^197 * z)) / (x - g^197 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^197 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6c0)),
                                  /*oods_coefficients[143]*/ mload(add(context, 0x8520)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[143]*/ mload(add(context, 0x5a80)))),
                           PRIME))

                // res += c_144*(f_14(x) - f_14(g^251 * z)) / (x - g^251 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^251 * z)^(-1)*/ mload(add(denominatorsPtr, 0x740)),
                                  /*oods_coefficients[144]*/ mload(add(context, 0x8540)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[144]*/ mload(add(context, 0x5aa0)))),
                           PRIME))

                // res += c_145*(f_14(x) - f_14(g^252 * z)) / (x - g^252 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^252 * z)^(-1)*/ mload(add(denominatorsPtr, 0x760)),
                                  /*oods_coefficients[145]*/ mload(add(context, 0x8560)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[145]*/ mload(add(context, 0x5ac0)))),
                           PRIME))

                // res += c_146*(f_14(x) - f_14(g^256 * z)) / (x - g^256 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^256 * z)^(-1)*/ mload(add(denominatorsPtr, 0x7a0)),
                                  /*oods_coefficients[146]*/ mload(add(context, 0x8580)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[146]*/ mload(add(context, 0x5ae0)))),
                           PRIME))
                }

                // Mask items for column #15.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x1e0)), kMontgomeryRInv, PRIME)

                // res += c_147*(f_15(x) - f_15(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[147]*/ mload(add(context, 0x85a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[147]*/ mload(add(context, 0x5b00)))),
                           PRIME))

                // res += c_148*(f_15(x) - f_15(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  /*oods_coefficients[148]*/ mload(add(context, 0x85c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[148]*/ mload(add(context, 0x5b20)))),
                           PRIME))

                // res += c_149*(f_15(x) - f_15(g^255 * z)) / (x - g^255 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^255 * z)^(-1)*/ mload(add(denominatorsPtr, 0x780)),
                                  /*oods_coefficients[149]*/ mload(add(context, 0x85e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[149]*/ mload(add(context, 0x5b40)))),
                           PRIME))

                // res += c_150*(f_15(x) - f_15(g^256 * z)) / (x - g^256 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^256 * z)^(-1)*/ mload(add(denominatorsPtr, 0x7a0)),
                                  /*oods_coefficients[150]*/ mload(add(context, 0x8600)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[150]*/ mload(add(context, 0x5b60)))),
                           PRIME))

                // res += c_151*(f_15(x) - f_15(g^511 * z)) / (x - g^511 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^511 * z)^(-1)*/ mload(add(denominatorsPtr, 0x8e0)),
                                  /*oods_coefficients[151]*/ mload(add(context, 0x8620)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[151]*/ mload(add(context, 0x5b80)))),
                           PRIME))
                }

                // Mask items for column #16.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x200)), kMontgomeryRInv, PRIME)

                // res += c_152*(f_16(x) - f_16(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[152]*/ mload(add(context, 0x8640)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[152]*/ mload(add(context, 0x5ba0)))),
                           PRIME))

                // res += c_153*(f_16(x) - f_16(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  /*oods_coefficients[153]*/ mload(add(context, 0x8660)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[153]*/ mload(add(context, 0x5bc0)))),
                           PRIME))

                // res += c_154*(f_16(x) - f_16(g^255 * z)) / (x - g^255 * z).
                res := addmod(
                    res,
                    mulmod(mulmod(/*(x - g^255 * z)^(-1)*/ mload(add(denominatorsPtr, 0x780)),
                                  /*oods_coefficients[154]*/ mload(add(context, 0x8680)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[154]*/ mload(add(context, 0x5be0)))),
                           PRIME),
                    PRIME)

                // res += c_155*(f_16(x) - f_16(g^256 * z)) / (x - g^256 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^256 * z)^(-1)*/ mload(add(denominatorsPtr, 0x7a0)),
                                  /*oods_coefficients[155]*/ mload(add(context, 0x86a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[155]*/ mload(add(context, 0x5c00)))),
                           PRIME))
                }

                // Mask items for column #17.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x220)), kMontgomeryRInv, PRIME)

                // res += c_156*(f_17(x) - f_17(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[156]*/ mload(add(context, 0x86c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[156]*/ mload(add(context, 0x5c20)))),
                           PRIME))

                // res += c_157*(f_17(x) - f_17(g^255 * z)) / (x - g^255 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^255 * z)^(-1)*/ mload(add(denominatorsPtr, 0x780)),
                                  /*oods_coefficients[157]*/ mload(add(context, 0x86e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[157]*/ mload(add(context, 0x5c40)))),
                           PRIME))
                }

                // Mask items for column #18.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x240)), kMontgomeryRInv, PRIME)

                // res += c_158*(f_18(x) - f_18(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[158]*/ mload(add(context, 0x8700)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[158]*/ mload(add(context, 0x5c60)))),
                           PRIME))

                // res += c_159*(f_18(x) - f_18(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  /*oods_coefficients[159]*/ mload(add(context, 0x8720)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[159]*/ mload(add(context, 0x5c80)))),
                           PRIME))

                // res += c_160*(f_18(x) - f_18(g^192 * z)) / (x - g^192 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^192 * z)^(-1)*/ mload(add(denominatorsPtr, 0x660)),
                                  /*oods_coefficients[160]*/ mload(add(context, 0x8740)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[160]*/ mload(add(context, 0x5ca0)))),
                           PRIME))

                // res += c_161*(f_18(x) - f_18(g^193 * z)) / (x - g^193 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^193 * z)^(-1)*/ mload(add(denominatorsPtr, 0x680)),
                                  /*oods_coefficients[161]*/ mload(add(context, 0x8760)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[161]*/ mload(add(context, 0x5cc0)))),
                           PRIME))

                // res += c_162*(f_18(x) - f_18(g^196 * z)) / (x - g^196 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^196 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6a0)),
                                  /*oods_coefficients[162]*/ mload(add(context, 0x8780)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[162]*/ mload(add(context, 0x5ce0)))),
                           PRIME))

                // res += c_163*(f_18(x) - f_18(g^197 * z)) / (x - g^197 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^197 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6c0)),
                                  /*oods_coefficients[163]*/ mload(add(context, 0x87a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[163]*/ mload(add(context, 0x5d00)))),
                           PRIME))

                // res += c_164*(f_18(x) - f_18(g^251 * z)) / (x - g^251 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^251 * z)^(-1)*/ mload(add(denominatorsPtr, 0x740)),
                                  /*oods_coefficients[164]*/ mload(add(context, 0x87c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[164]*/ mload(add(context, 0x5d20)))),
                           PRIME))

                // res += c_165*(f_18(x) - f_18(g^252 * z)) / (x - g^252 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^252 * z)^(-1)*/ mload(add(denominatorsPtr, 0x760)),
                                  /*oods_coefficients[165]*/ mload(add(context, 0x87e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[165]*/ mload(add(context, 0x5d40)))),
                           PRIME))

                // res += c_166*(f_18(x) - f_18(g^256 * z)) / (x - g^256 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^256 * z)^(-1)*/ mload(add(denominatorsPtr, 0x7a0)),
                                  /*oods_coefficients[166]*/ mload(add(context, 0x8800)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[166]*/ mload(add(context, 0x5d60)))),
                           PRIME))
                }

                // Mask items for column #19.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x260)), kMontgomeryRInv, PRIME)

                // res += c_167*(f_19(x) - f_19(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[167]*/ mload(add(context, 0x8820)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[167]*/ mload(add(context, 0x5d80)))),
                           PRIME))

                // res += c_168*(f_19(x) - f_19(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  /*oods_coefficients[168]*/ mload(add(context, 0x8840)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[168]*/ mload(add(context, 0x5da0)))),
                           PRIME))

                // res += c_169*(f_19(x) - f_19(g^2 * z)) / (x - g^2 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2 * z)^(-1)*/ mload(add(denominatorsPtr, 0x40)),
                                  /*oods_coefficients[169]*/ mload(add(context, 0x8860)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[169]*/ mload(add(context, 0x5dc0)))),
                           PRIME))

                // res += c_170*(f_19(x) - f_19(g^3 * z)) / (x - g^3 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3 * z)^(-1)*/ mload(add(denominatorsPtr, 0x60)),
                                  /*oods_coefficients[170]*/ mload(add(context, 0x8880)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[170]*/ mload(add(context, 0x5de0)))),
                           PRIME))

                // res += c_171*(f_19(x) - f_19(g^4 * z)) / (x - g^4 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4 * z)^(-1)*/ mload(add(denominatorsPtr, 0x80)),
                                  /*oods_coefficients[171]*/ mload(add(context, 0x88a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[171]*/ mload(add(context, 0x5e00)))),
                           PRIME))

                // res += c_172*(f_19(x) - f_19(g^5 * z)) / (x - g^5 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^5 * z)^(-1)*/ mload(add(denominatorsPtr, 0xa0)),
                                  /*oods_coefficients[172]*/ mload(add(context, 0x88c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[172]*/ mload(add(context, 0x5e20)))),
                           PRIME))

                // res += c_173*(f_19(x) - f_19(g^8 * z)) / (x - g^8 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8 * z)^(-1)*/ mload(add(denominatorsPtr, 0x100)),
                                  /*oods_coefficients[173]*/ mload(add(context, 0x88e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[173]*/ mload(add(context, 0x5e40)))),
                           PRIME))

                // res += c_174*(f_19(x) - f_19(g^9 * z)) / (x - g^9 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^9 * z)^(-1)*/ mload(add(denominatorsPtr, 0x120)),
                                  /*oods_coefficients[174]*/ mload(add(context, 0x8900)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[174]*/ mload(add(context, 0x5e60)))),
                           PRIME))

                // res += c_175*(f_19(x) - f_19(g^10 * z)) / (x - g^10 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^10 * z)^(-1)*/ mload(add(denominatorsPtr, 0x140)),
                                  /*oods_coefficients[175]*/ mload(add(context, 0x8920)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[175]*/ mload(add(context, 0x5e80)))),
                           PRIME))

                // res += c_176*(f_19(x) - f_19(g^11 * z)) / (x - g^11 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^11 * z)^(-1)*/ mload(add(denominatorsPtr, 0x160)),
                                  /*oods_coefficients[176]*/ mload(add(context, 0x8940)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[176]*/ mload(add(context, 0x5ea0)))),
                           PRIME))

                // res += c_177*(f_19(x) - f_19(g^12 * z)) / (x - g^12 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^12 * z)^(-1)*/ mload(add(denominatorsPtr, 0x180)),
                                  /*oods_coefficients[177]*/ mload(add(context, 0x8960)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[177]*/ mload(add(context, 0x5ec0)))),
                           PRIME))

                // res += c_178*(f_19(x) - f_19(g^13 * z)) / (x - g^13 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^13 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1a0)),
                                  /*oods_coefficients[178]*/ mload(add(context, 0x8980)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[178]*/ mload(add(context, 0x5ee0)))),
                           PRIME))

                // res += c_179*(f_19(x) - f_19(g^16 * z)) / (x - g^16 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16 * z)^(-1)*/ mload(add(denominatorsPtr, 0x200)),
                                  /*oods_coefficients[179]*/ mload(add(context, 0x89a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[179]*/ mload(add(context, 0x5f00)))),
                           PRIME))

                // res += c_180*(f_19(x) - f_19(g^26 * z)) / (x - g^26 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^26 * z)^(-1)*/ mload(add(denominatorsPtr, 0x2e0)),
                                  /*oods_coefficients[180]*/ mload(add(context, 0x89c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[180]*/ mload(add(context, 0x5f20)))),
                           PRIME))

                // res += c_181*(f_19(x) - f_19(g^27 * z)) / (x - g^27 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^27 * z)^(-1)*/ mload(add(denominatorsPtr, 0x300)),
                                  /*oods_coefficients[181]*/ mload(add(context, 0x89e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[181]*/ mload(add(context, 0x5f40)))),
                           PRIME))

                // res += c_182*(f_19(x) - f_19(g^42 * z)) / (x - g^42 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^42 * z)^(-1)*/ mload(add(denominatorsPtr, 0x3c0)),
                                  /*oods_coefficients[182]*/ mload(add(context, 0x8a00)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[182]*/ mload(add(context, 0x5f60)))),
                           PRIME))

                // res += c_183*(f_19(x) - f_19(g^43 * z)) / (x - g^43 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^43 * z)^(-1)*/ mload(add(denominatorsPtr, 0x3e0)),
                                  /*oods_coefficients[183]*/ mload(add(context, 0x8a20)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[183]*/ mload(add(context, 0x5f80)))),
                           PRIME))

                // res += c_184*(f_19(x) - f_19(g^74 * z)) / (x - g^74 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^74 * z)^(-1)*/ mload(add(denominatorsPtr, 0x4a0)),
                                  /*oods_coefficients[184]*/ mload(add(context, 0x8a40)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[184]*/ mload(add(context, 0x5fa0)))),
                           PRIME))

                // res += c_185*(f_19(x) - f_19(g^75 * z)) / (x - g^75 * z).
                res := addmod(
                    res,
                    mulmod(mulmod(/*(x - g^75 * z)^(-1)*/ mload(add(denominatorsPtr, 0x4c0)),
                                  /*oods_coefficients[185]*/ mload(add(context, 0x8a60)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[185]*/ mload(add(context, 0x5fc0)))),
                           PRIME),
                    PRIME)

                // res += c_186*(f_19(x) - f_19(g^106 * z)) / (x - g^106 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^106 * z)^(-1)*/ mload(add(denominatorsPtr, 0x540)),
                                  /*oods_coefficients[186]*/ mload(add(context, 0x8a80)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[186]*/ mload(add(context, 0x5fe0)))),
                           PRIME))

                // res += c_187*(f_19(x) - f_19(g^107 * z)) / (x - g^107 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^107 * z)^(-1)*/ mload(add(denominatorsPtr, 0x560)),
                                  /*oods_coefficients[187]*/ mload(add(context, 0x8aa0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[187]*/ mload(add(context, 0x6000)))),
                           PRIME))

                // res += c_188*(f_19(x) - f_19(g^138 * z)) / (x - g^138 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^138 * z)^(-1)*/ mload(add(denominatorsPtr, 0x5e0)),
                                  /*oods_coefficients[188]*/ mload(add(context, 0x8ac0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[188]*/ mload(add(context, 0x6020)))),
                           PRIME))

                // res += c_189*(f_19(x) - f_19(g^139 * z)) / (x - g^139 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^139 * z)^(-1)*/ mload(add(denominatorsPtr, 0x600)),
                                  /*oods_coefficients[189]*/ mload(add(context, 0x8ae0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[189]*/ mload(add(context, 0x6040)))),
                           PRIME))

                // res += c_190*(f_19(x) - f_19(g^171 * z)) / (x - g^171 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^171 * z)^(-1)*/ mload(add(denominatorsPtr, 0x640)),
                                  /*oods_coefficients[190]*/ mload(add(context, 0x8b00)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[190]*/ mload(add(context, 0x6060)))),
                           PRIME))

                // res += c_191*(f_19(x) - f_19(g^203 * z)) / (x - g^203 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^203 * z)^(-1)*/ mload(add(denominatorsPtr, 0x6e0)),
                                  /*oods_coefficients[191]*/ mload(add(context, 0x8b20)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[191]*/ mload(add(context, 0x6080)))),
                           PRIME))

                // res += c_192*(f_19(x) - f_19(g^234 * z)) / (x - g^234 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^234 * z)^(-1)*/ mload(add(denominatorsPtr, 0x720)),
                                  /*oods_coefficients[192]*/ mload(add(context, 0x8b40)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[192]*/ mload(add(context, 0x60a0)))),
                           PRIME))

                // res += c_193*(f_19(x) - f_19(g^267 * z)) / (x - g^267 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^267 * z)^(-1)*/ mload(add(denominatorsPtr, 0x7c0)),
                                  /*oods_coefficients[193]*/ mload(add(context, 0x8b60)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[193]*/ mload(add(context, 0x60c0)))),
                           PRIME))

                // res += c_194*(f_19(x) - f_19(g^299 * z)) / (x - g^299 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^299 * z)^(-1)*/ mload(add(denominatorsPtr, 0x7e0)),
                                  /*oods_coefficients[194]*/ mload(add(context, 0x8b80)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[194]*/ mload(add(context, 0x60e0)))),
                           PRIME))

                // res += c_195*(f_19(x) - f_19(g^331 * z)) / (x - g^331 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^331 * z)^(-1)*/ mload(add(denominatorsPtr, 0x820)),
                                  /*oods_coefficients[195]*/ mload(add(context, 0x8ba0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[195]*/ mload(add(context, 0x6100)))),
                           PRIME))

                // res += c_196*(f_19(x) - f_19(g^395 * z)) / (x - g^395 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^395 * z)^(-1)*/ mload(add(denominatorsPtr, 0x860)),
                                  /*oods_coefficients[196]*/ mload(add(context, 0x8bc0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[196]*/ mload(add(context, 0x6120)))),
                           PRIME))

                // res += c_197*(f_19(x) - f_19(g^427 * z)) / (x - g^427 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^427 * z)^(-1)*/ mload(add(denominatorsPtr, 0x880)),
                                  /*oods_coefficients[197]*/ mload(add(context, 0x8be0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[197]*/ mload(add(context, 0x6140)))),
                           PRIME))

                // res += c_198*(f_19(x) - f_19(g^459 * z)) / (x - g^459 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^459 * z)^(-1)*/ mload(add(denominatorsPtr, 0x8c0)),
                                  /*oods_coefficients[198]*/ mload(add(context, 0x8c00)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[198]*/ mload(add(context, 0x6160)))),
                           PRIME))

                // res += c_199*(f_19(x) - f_19(g^538 * z)) / (x - g^538 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^538 * z)^(-1)*/ mload(add(denominatorsPtr, 0x920)),
                                  /*oods_coefficients[199]*/ mload(add(context, 0x8c20)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[199]*/ mload(add(context, 0x6180)))),
                           PRIME))

                // res += c_200*(f_19(x) - f_19(g^539 * z)) / (x - g^539 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^539 * z)^(-1)*/ mload(add(denominatorsPtr, 0x940)),
                                  /*oods_coefficients[200]*/ mload(add(context, 0x8c40)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[200]*/ mload(add(context, 0x61a0)))),
                           PRIME))

                // res += c_201*(f_19(x) - f_19(g^1050 * z)) / (x - g^1050 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^1050 * z)^(-1)*/ mload(add(denominatorsPtr, 0xa60)),
                                  /*oods_coefficients[201]*/ mload(add(context, 0x8c60)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[201]*/ mload(add(context, 0x61c0)))),
                           PRIME))

                // res += c_202*(f_19(x) - f_19(g^1051 * z)) / (x - g^1051 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^1051 * z)^(-1)*/ mload(add(denominatorsPtr, 0xa80)),
                                  /*oods_coefficients[202]*/ mload(add(context, 0x8c80)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[202]*/ mload(add(context, 0x61e0)))),
                           PRIME))

                // res += c_203*(f_19(x) - f_19(g^2074 * z)) / (x - g^2074 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2074 * z)^(-1)*/ mload(add(denominatorsPtr, 0xcc0)),
                                  /*oods_coefficients[203]*/ mload(add(context, 0x8ca0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[203]*/ mload(add(context, 0x6200)))),
                           PRIME))

                // res += c_204*(f_19(x) - f_19(g^2075 * z)) / (x - g^2075 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2075 * z)^(-1)*/ mload(add(denominatorsPtr, 0xce0)),
                                  /*oods_coefficients[204]*/ mload(add(context, 0x8cc0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[204]*/ mload(add(context, 0x6220)))),
                           PRIME))

                // res += c_205*(f_19(x) - f_19(g^2586 * z)) / (x - g^2586 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2586 * z)^(-1)*/ mload(add(denominatorsPtr, 0xe20)),
                                  /*oods_coefficients[205]*/ mload(add(context, 0x8ce0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[205]*/ mload(add(context, 0x6240)))),
                           PRIME))

                // res += c_206*(f_19(x) - f_19(g^2587 * z)) / (x - g^2587 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2587 * z)^(-1)*/ mload(add(denominatorsPtr, 0xe40)),
                                  /*oods_coefficients[206]*/ mload(add(context, 0x8d00)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[206]*/ mload(add(context, 0x6260)))),
                           PRIME))

                // res += c_207*(f_19(x) - f_19(g^3098 * z)) / (x - g^3098 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3098 * z)^(-1)*/ mload(add(denominatorsPtr, 0xf60)),
                                  /*oods_coefficients[207]*/ mload(add(context, 0x8d20)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[207]*/ mload(add(context, 0x6280)))),
                           PRIME))

                // res += c_208*(f_19(x) - f_19(g^3099 * z)) / (x - g^3099 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3099 * z)^(-1)*/ mload(add(denominatorsPtr, 0xf80)),
                                  /*oods_coefficients[208]*/ mload(add(context, 0x8d40)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[208]*/ mload(add(context, 0x62a0)))),
                           PRIME))

                // res += c_209*(f_19(x) - f_19(g^4122 * z)) / (x - g^4122 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4122 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1280)),
                                  /*oods_coefficients[209]*/ mload(add(context, 0x8d60)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[209]*/ mload(add(context, 0x62c0)))),
                           PRIME))

                // res += c_210*(f_19(x) - f_19(g^4123 * z)) / (x - g^4123 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4123 * z)^(-1)*/ mload(add(denominatorsPtr, 0x12a0)),
                                  /*oods_coefficients[210]*/ mload(add(context, 0x8d80)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[210]*/ mload(add(context, 0x62e0)))),
                           PRIME))

                // res += c_211*(f_19(x) - f_19(g^4634 * z)) / (x - g^4634 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4634 * z)^(-1)*/ mload(add(denominatorsPtr, 0x12c0)),
                                  /*oods_coefficients[211]*/ mload(add(context, 0x8da0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[211]*/ mload(add(context, 0x6300)))),
                           PRIME))

                // res += c_212*(f_19(x) - f_19(g^5146 * z)) / (x - g^5146 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^5146 * z)^(-1)*/ mload(add(denominatorsPtr, 0x12e0)),
                                  /*oods_coefficients[212]*/ mload(add(context, 0x8dc0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[212]*/ mload(add(context, 0x6320)))),
                           PRIME))

                // res += c_213*(f_19(x) - f_19(g^6170 * z)) / (x - g^6170 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^6170 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1300)),
                                  /*oods_coefficients[213]*/ mload(add(context, 0x8de0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[213]*/ mload(add(context, 0x6340)))),
                           PRIME))

                // res += c_214*(f_19(x) - f_19(g^6682 * z)) / (x - g^6682 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^6682 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1320)),
                                  /*oods_coefficients[214]*/ mload(add(context, 0x8e00)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[214]*/ mload(add(context, 0x6360)))),
                           PRIME))

                // res += c_215*(f_19(x) - f_19(g^7194 * z)) / (x - g^7194 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^7194 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1340)),
                                  /*oods_coefficients[215]*/ mload(add(context, 0x8e20)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[215]*/ mload(add(context, 0x6380)))),
                           PRIME))

                // res += c_216*(f_19(x) - f_19(g^8218 * z)) / (x - g^8218 * z).
                res := addmod(
                    res,
                    mulmod(mulmod(/*(x - g^8218 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1460)),
                                  /*oods_coefficients[216]*/ mload(add(context, 0x8e40)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[216]*/ mload(add(context, 0x63a0)))),
                           PRIME),
                    PRIME)
                }

                // Mask items for column #20.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x280)), kMontgomeryRInv, PRIME)

                // res += c_217*(f_20(x) - f_20(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[217]*/ mload(add(context, 0x8e60)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[217]*/ mload(add(context, 0x63c0)))),
                           PRIME))

                // res += c_218*(f_20(x) - f_20(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  /*oods_coefficients[218]*/ mload(add(context, 0x8e80)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[218]*/ mload(add(context, 0x63e0)))),
                           PRIME))

                // res += c_219*(f_20(x) - f_20(g^2 * z)) / (x - g^2 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2 * z)^(-1)*/ mload(add(denominatorsPtr, 0x40)),
                                  /*oods_coefficients[219]*/ mload(add(context, 0x8ea0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[219]*/ mload(add(context, 0x6400)))),
                           PRIME))

                // res += c_220*(f_20(x) - f_20(g^3 * z)) / (x - g^3 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3 * z)^(-1)*/ mload(add(denominatorsPtr, 0x60)),
                                  /*oods_coefficients[220]*/ mload(add(context, 0x8ec0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[220]*/ mload(add(context, 0x6420)))),
                           PRIME))

                // res += c_221*(f_20(x) - f_20(g^4 * z)) / (x - g^4 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4 * z)^(-1)*/ mload(add(denominatorsPtr, 0x80)),
                                  /*oods_coefficients[221]*/ mload(add(context, 0x8ee0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[221]*/ mload(add(context, 0x6440)))),
                           PRIME))

                // res += c_222*(f_20(x) - f_20(g^8 * z)) / (x - g^8 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8 * z)^(-1)*/ mload(add(denominatorsPtr, 0x100)),
                                  /*oods_coefficients[222]*/ mload(add(context, 0x8f00)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[222]*/ mload(add(context, 0x6460)))),
                           PRIME))

                // res += c_223*(f_20(x) - f_20(g^12 * z)) / (x - g^12 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^12 * z)^(-1)*/ mload(add(denominatorsPtr, 0x180)),
                                  /*oods_coefficients[223]*/ mload(add(context, 0x8f20)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[223]*/ mload(add(context, 0x6480)))),
                           PRIME))

                // res += c_224*(f_20(x) - f_20(g^28 * z)) / (x - g^28 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^28 * z)^(-1)*/ mload(add(denominatorsPtr, 0x320)),
                                  /*oods_coefficients[224]*/ mload(add(context, 0x8f40)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[224]*/ mload(add(context, 0x64a0)))),
                           PRIME))

                // res += c_225*(f_20(x) - f_20(g^44 * z)) / (x - g^44 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^44 * z)^(-1)*/ mload(add(denominatorsPtr, 0x400)),
                                  /*oods_coefficients[225]*/ mload(add(context, 0x8f60)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[225]*/ mload(add(context, 0x64c0)))),
                           PRIME))

                // res += c_226*(f_20(x) - f_20(g^60 * z)) / (x - g^60 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^60 * z)^(-1)*/ mload(add(denominatorsPtr, 0x440)),
                                  /*oods_coefficients[226]*/ mload(add(context, 0x8f80)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[226]*/ mload(add(context, 0x64e0)))),
                           PRIME))

                // res += c_227*(f_20(x) - f_20(g^76 * z)) / (x - g^76 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^76 * z)^(-1)*/ mload(add(denominatorsPtr, 0x4e0)),
                                  /*oods_coefficients[227]*/ mload(add(context, 0x8fa0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[227]*/ mload(add(context, 0x6500)))),
                           PRIME))

                // res += c_228*(f_20(x) - f_20(g^92 * z)) / (x - g^92 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^92 * z)^(-1)*/ mload(add(denominatorsPtr, 0x520)),
                                  /*oods_coefficients[228]*/ mload(add(context, 0x8fc0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[228]*/ mload(add(context, 0x6520)))),
                           PRIME))

                // res += c_229*(f_20(x) - f_20(g^108 * z)) / (x - g^108 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^108 * z)^(-1)*/ mload(add(denominatorsPtr, 0x580)),
                                  /*oods_coefficients[229]*/ mload(add(context, 0x8fe0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[229]*/ mload(add(context, 0x6540)))),
                           PRIME))

                // res += c_230*(f_20(x) - f_20(g^124 * z)) / (x - g^124 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^124 * z)^(-1)*/ mload(add(denominatorsPtr, 0x5a0)),
                                  /*oods_coefficients[230]*/ mload(add(context, 0x9000)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[230]*/ mload(add(context, 0x6560)))),
                           PRIME))
                }

                // Mask items for column #21.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x2a0)), kMontgomeryRInv, PRIME)

                // res += c_231*(f_21(x) - f_21(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[231]*/ mload(add(context, 0x9020)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[231]*/ mload(add(context, 0x6580)))),
                           PRIME))

                // res += c_232*(f_21(x) - f_21(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  /*oods_coefficients[232]*/ mload(add(context, 0x9040)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[232]*/ mload(add(context, 0x65a0)))),
                           PRIME))

                // res += c_233*(f_21(x) - f_21(g^2 * z)) / (x - g^2 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2 * z)^(-1)*/ mload(add(denominatorsPtr, 0x40)),
                                  /*oods_coefficients[233]*/ mload(add(context, 0x9060)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[233]*/ mload(add(context, 0x65c0)))),
                           PRIME))

                // res += c_234*(f_21(x) - f_21(g^3 * z)) / (x - g^3 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3 * z)^(-1)*/ mload(add(denominatorsPtr, 0x60)),
                                  /*oods_coefficients[234]*/ mload(add(context, 0x9080)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[234]*/ mload(add(context, 0x65e0)))),
                           PRIME))
                }

                // Mask items for column #22.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x2c0)), kMontgomeryRInv, PRIME)

                // res += c_235*(f_22(x) - f_22(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[235]*/ mload(add(context, 0x90a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[235]*/ mload(add(context, 0x6600)))),
                           PRIME))

                // res += c_236*(f_22(x) - f_22(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  /*oods_coefficients[236]*/ mload(add(context, 0x90c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[236]*/ mload(add(context, 0x6620)))),
                           PRIME))

                // res += c_237*(f_22(x) - f_22(g^2 * z)) / (x - g^2 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2 * z)^(-1)*/ mload(add(denominatorsPtr, 0x40)),
                                  /*oods_coefficients[237]*/ mload(add(context, 0x90e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[237]*/ mload(add(context, 0x6640)))),
                           PRIME))

                // res += c_238*(f_22(x) - f_22(g^3 * z)) / (x - g^3 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3 * z)^(-1)*/ mload(add(denominatorsPtr, 0x60)),
                                  /*oods_coefficients[238]*/ mload(add(context, 0x9100)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[238]*/ mload(add(context, 0x6660)))),
                           PRIME))

                // res += c_239*(f_22(x) - f_22(g^4 * z)) / (x - g^4 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4 * z)^(-1)*/ mload(add(denominatorsPtr, 0x80)),
                                  /*oods_coefficients[239]*/ mload(add(context, 0x9120)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[239]*/ mload(add(context, 0x6680)))),
                           PRIME))

                // res += c_240*(f_22(x) - f_22(g^5 * z)) / (x - g^5 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^5 * z)^(-1)*/ mload(add(denominatorsPtr, 0xa0)),
                                  /*oods_coefficients[240]*/ mload(add(context, 0x9140)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[240]*/ mload(add(context, 0x66a0)))),
                           PRIME))

                // res += c_241*(f_22(x) - f_22(g^6 * z)) / (x - g^6 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^6 * z)^(-1)*/ mload(add(denominatorsPtr, 0xc0)),
                                  /*oods_coefficients[241]*/ mload(add(context, 0x9160)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[241]*/ mload(add(context, 0x66c0)))),
                           PRIME))

                // res += c_242*(f_22(x) - f_22(g^7 * z)) / (x - g^7 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^7 * z)^(-1)*/ mload(add(denominatorsPtr, 0xe0)),
                                  /*oods_coefficients[242]*/ mload(add(context, 0x9180)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[242]*/ mload(add(context, 0x66e0)))),
                           PRIME))

                // res += c_243*(f_22(x) - f_22(g^8 * z)) / (x - g^8 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8 * z)^(-1)*/ mload(add(denominatorsPtr, 0x100)),
                                  /*oods_coefficients[243]*/ mload(add(context, 0x91a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[243]*/ mload(add(context, 0x6700)))),
                           PRIME))

                // res += c_244*(f_22(x) - f_22(g^9 * z)) / (x - g^9 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^9 * z)^(-1)*/ mload(add(denominatorsPtr, 0x120)),
                                  /*oods_coefficients[244]*/ mload(add(context, 0x91c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[244]*/ mload(add(context, 0x6720)))),
                           PRIME))

                // res += c_245*(f_22(x) - f_22(g^10 * z)) / (x - g^10 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^10 * z)^(-1)*/ mload(add(denominatorsPtr, 0x140)),
                                  /*oods_coefficients[245]*/ mload(add(context, 0x91e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[245]*/ mload(add(context, 0x6740)))),
                           PRIME))

                // res += c_246*(f_22(x) - f_22(g^11 * z)) / (x - g^11 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^11 * z)^(-1)*/ mload(add(denominatorsPtr, 0x160)),
                                  /*oods_coefficients[246]*/ mload(add(context, 0x9200)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[246]*/ mload(add(context, 0x6760)))),
                           PRIME))

                // res += c_247*(f_22(x) - f_22(g^12 * z)) / (x - g^12 * z).
                res := addmod(
                    res,
                    mulmod(mulmod(/*(x - g^12 * z)^(-1)*/ mload(add(denominatorsPtr, 0x180)),
                                  /*oods_coefficients[247]*/ mload(add(context, 0x9220)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[247]*/ mload(add(context, 0x6780)))),
                           PRIME),
                    PRIME)

                // res += c_248*(f_22(x) - f_22(g^13 * z)) / (x - g^13 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^13 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1a0)),
                                  /*oods_coefficients[248]*/ mload(add(context, 0x9240)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[248]*/ mload(add(context, 0x67a0)))),
                           PRIME))

                // res += c_249*(f_22(x) - f_22(g^14 * z)) / (x - g^14 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^14 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1c0)),
                                  /*oods_coefficients[249]*/ mload(add(context, 0x9260)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[249]*/ mload(add(context, 0x67c0)))),
                           PRIME))

                // res += c_250*(f_22(x) - f_22(g^15 * z)) / (x - g^15 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^15 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1e0)),
                                  /*oods_coefficients[250]*/ mload(add(context, 0x9280)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[250]*/ mload(add(context, 0x67e0)))),
                           PRIME))

                // res += c_251*(f_22(x) - f_22(g^16 * z)) / (x - g^16 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^16 * z)^(-1)*/ mload(add(denominatorsPtr, 0x200)),
                                  /*oods_coefficients[251]*/ mload(add(context, 0x92a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[251]*/ mload(add(context, 0x6800)))),
                           PRIME))

                // res += c_252*(f_22(x) - f_22(g^19 * z)) / (x - g^19 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^19 * z)^(-1)*/ mload(add(denominatorsPtr, 0x220)),
                                  /*oods_coefficients[252]*/ mload(add(context, 0x92c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[252]*/ mload(add(context, 0x6820)))),
                           PRIME))

                // res += c_253*(f_22(x) - f_22(g^21 * z)) / (x - g^21 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^21 * z)^(-1)*/ mload(add(denominatorsPtr, 0x240)),
                                  /*oods_coefficients[253]*/ mload(add(context, 0x92e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[253]*/ mload(add(context, 0x6840)))),
                           PRIME))

                // res += c_254*(f_22(x) - f_22(g^22 * z)) / (x - g^22 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^22 * z)^(-1)*/ mload(add(denominatorsPtr, 0x260)),
                                  /*oods_coefficients[254]*/ mload(add(context, 0x9300)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[254]*/ mload(add(context, 0x6860)))),
                           PRIME))

                // res += c_255*(f_22(x) - f_22(g^23 * z)) / (x - g^23 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^23 * z)^(-1)*/ mload(add(denominatorsPtr, 0x280)),
                                  /*oods_coefficients[255]*/ mload(add(context, 0x9320)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[255]*/ mload(add(context, 0x6880)))),
                           PRIME))

                // res += c_256*(f_22(x) - f_22(g^24 * z)) / (x - g^24 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^24 * z)^(-1)*/ mload(add(denominatorsPtr, 0x2a0)),
                                  /*oods_coefficients[256]*/ mload(add(context, 0x9340)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[256]*/ mload(add(context, 0x68a0)))),
                           PRIME))

                // res += c_257*(f_22(x) - f_22(g^25 * z)) / (x - g^25 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^25 * z)^(-1)*/ mload(add(denominatorsPtr, 0x2c0)),
                                  /*oods_coefficients[257]*/ mload(add(context, 0x9360)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[257]*/ mload(add(context, 0x68c0)))),
                           PRIME))

                // res += c_258*(f_22(x) - f_22(g^30 * z)) / (x - g^30 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^30 * z)^(-1)*/ mload(add(denominatorsPtr, 0x340)),
                                  /*oods_coefficients[258]*/ mload(add(context, 0x9380)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[258]*/ mload(add(context, 0x68e0)))),
                           PRIME))

                // res += c_259*(f_22(x) - f_22(g^31 * z)) / (x - g^31 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^31 * z)^(-1)*/ mload(add(denominatorsPtr, 0x360)),
                                  /*oods_coefficients[259]*/ mload(add(context, 0x93a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[259]*/ mload(add(context, 0x6900)))),
                           PRIME))

                // res += c_260*(f_22(x) - f_22(g^39 * z)) / (x - g^39 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^39 * z)^(-1)*/ mload(add(denominatorsPtr, 0x3a0)),
                                  /*oods_coefficients[260]*/ mload(add(context, 0x93c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[260]*/ mload(add(context, 0x6920)))),
                           PRIME))

                // res += c_261*(f_22(x) - f_22(g^55 * z)) / (x - g^55 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^55 * z)^(-1)*/ mload(add(denominatorsPtr, 0x420)),
                                  /*oods_coefficients[261]*/ mload(add(context, 0x93e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[261]*/ mload(add(context, 0x6940)))),
                           PRIME))

                // res += c_262*(f_22(x) - f_22(g^63 * z)) / (x - g^63 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^63 * z)^(-1)*/ mload(add(denominatorsPtr, 0x460)),
                                  /*oods_coefficients[262]*/ mload(add(context, 0x9400)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[262]*/ mload(add(context, 0x6960)))),
                           PRIME))

                // res += c_263*(f_22(x) - f_22(g^4081 * z)) / (x - g^4081 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4081 * z)^(-1)*/ mload(add(denominatorsPtr, 0x11a0)),
                                  /*oods_coefficients[263]*/ mload(add(context, 0x9420)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[263]*/ mload(add(context, 0x6980)))),
                           PRIME))

                // res += c_264*(f_22(x) - f_22(g^4085 * z)) / (x - g^4085 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4085 * z)^(-1)*/ mload(add(denominatorsPtr, 0x11c0)),
                                  /*oods_coefficients[264]*/ mload(add(context, 0x9440)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[264]*/ mload(add(context, 0x69a0)))),
                           PRIME))

                // res += c_265*(f_22(x) - f_22(g^4089 * z)) / (x - g^4089 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4089 * z)^(-1)*/ mload(add(denominatorsPtr, 0x11e0)),
                                  /*oods_coefficients[265]*/ mload(add(context, 0x9460)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[265]*/ mload(add(context, 0x69c0)))),
                           PRIME))

                // res += c_266*(f_22(x) - f_22(g^4091 * z)) / (x - g^4091 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4091 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1200)),
                                  /*oods_coefficients[266]*/ mload(add(context, 0x9480)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[266]*/ mload(add(context, 0x69e0)))),
                           PRIME))

                // res += c_267*(f_22(x) - f_22(g^4093 * z)) / (x - g^4093 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4093 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1220)),
                                  /*oods_coefficients[267]*/ mload(add(context, 0x94a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[267]*/ mload(add(context, 0x6a00)))),
                           PRIME))

                // res += c_268*(f_22(x) - f_22(g^4102 * z)) / (x - g^4102 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4102 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1240)),
                                  /*oods_coefficients[268]*/ mload(add(context, 0x94c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[268]*/ mload(add(context, 0x6a20)))),
                           PRIME))

                // res += c_269*(f_22(x) - f_22(g^4110 * z)) / (x - g^4110 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^4110 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1260)),
                                  /*oods_coefficients[269]*/ mload(add(context, 0x94e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[269]*/ mload(add(context, 0x6a40)))),
                           PRIME))

                // res += c_270*(f_22(x) - f_22(g^8167 * z)) / (x - g^8167 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8167 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1380)),
                                  /*oods_coefficients[270]*/ mload(add(context, 0x9500)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[270]*/ mload(add(context, 0x6a60)))),
                           PRIME))

                // res += c_271*(f_22(x) - f_22(g^8175 * z)) / (x - g^8175 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8175 * z)^(-1)*/ mload(add(denominatorsPtr, 0x13a0)),
                                  /*oods_coefficients[271]*/ mload(add(context, 0x9520)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[271]*/ mload(add(context, 0x6a80)))),
                           PRIME))

                // res += c_272*(f_22(x) - f_22(g^8177 * z)) / (x - g^8177 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8177 * z)^(-1)*/ mload(add(denominatorsPtr, 0x13c0)),
                                  /*oods_coefficients[272]*/ mload(add(context, 0x9540)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[272]*/ mload(add(context, 0x6aa0)))),
                           PRIME))

                // res += c_273*(f_22(x) - f_22(g^8181 * z)) / (x - g^8181 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8181 * z)^(-1)*/ mload(add(denominatorsPtr, 0x13e0)),
                                  /*oods_coefficients[273]*/ mload(add(context, 0x9560)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[273]*/ mload(add(context, 0x6ac0)))),
                           PRIME))

                // res += c_274*(f_22(x) - f_22(g^8183 * z)) / (x - g^8183 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8183 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1400)),
                                  /*oods_coefficients[274]*/ mload(add(context, 0x9580)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[274]*/ mload(add(context, 0x6ae0)))),
                           PRIME))

                // res += c_275*(f_22(x) - f_22(g^8185 * z)) / (x - g^8185 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8185 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1420)),
                                  /*oods_coefficients[275]*/ mload(add(context, 0x95a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[275]*/ mload(add(context, 0x6b00)))),
                           PRIME))

                // res += c_276*(f_22(x) - f_22(g^8189 * z)) / (x - g^8189 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8189 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1440)),
                                  /*oods_coefficients[276]*/ mload(add(context, 0x95c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[276]*/ mload(add(context, 0x6b20)))),
                           PRIME))
                }

                // Mask items for column #23.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x2e0)), kMontgomeryRInv, PRIME)

                // res += c_277*(f_23(x) - f_23(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[277]*/ mload(add(context, 0x95e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[277]*/ mload(add(context, 0x6b40)))),
                           PRIME))

                // res += c_278*(f_23(x) - f_23(g^16 * z)) / (x - g^16 * z).
                res := addmod(
                    res,
                    mulmod(mulmod(/*(x - g^16 * z)^(-1)*/ mload(add(denominatorsPtr, 0x200)),
                                  /*oods_coefficients[278]*/ mload(add(context, 0x9600)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[278]*/ mload(add(context, 0x6b60)))),
                           PRIME),
                    PRIME)

                // res += c_279*(f_23(x) - f_23(g^80 * z)) / (x - g^80 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^80 * z)^(-1)*/ mload(add(denominatorsPtr, 0x500)),
                                  /*oods_coefficients[279]*/ mload(add(context, 0x9620)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[279]*/ mload(add(context, 0x6b80)))),
                           PRIME))

                // res += c_280*(f_23(x) - f_23(g^144 * z)) / (x - g^144 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^144 * z)^(-1)*/ mload(add(denominatorsPtr, 0x620)),
                                  /*oods_coefficients[280]*/ mload(add(context, 0x9640)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[280]*/ mload(add(context, 0x6ba0)))),
                           PRIME))

                // res += c_281*(f_23(x) - f_23(g^208 * z)) / (x - g^208 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^208 * z)^(-1)*/ mload(add(denominatorsPtr, 0x700)),
                                  /*oods_coefficients[281]*/ mload(add(context, 0x9660)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[281]*/ mload(add(context, 0x6bc0)))),
                           PRIME))

                // res += c_282*(f_23(x) - f_23(g^8160 * z)) / (x - g^8160 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^8160 * z)^(-1)*/ mload(add(denominatorsPtr, 0x1360)),
                                  /*oods_coefficients[282]*/ mload(add(context, 0x9680)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[282]*/ mload(add(context, 0x6be0)))),
                           PRIME))
                }

                // Mask items for column #24.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x300)), kMontgomeryRInv, PRIME)

                // res += c_283*(f_24(x) - f_24(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[283]*/ mload(add(context, 0x96a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[283]*/ mload(add(context, 0x6c00)))),
                           PRIME))

                // res += c_284*(f_24(x) - f_24(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  /*oods_coefficients[284]*/ mload(add(context, 0x96c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[284]*/ mload(add(context, 0x6c20)))),
                           PRIME))
                }

                // Mask items for column #25.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x320)), kMontgomeryRInv, PRIME)

                // res += c_285*(f_25(x) - f_25(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[285]*/ mload(add(context, 0x96e0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[285]*/ mload(add(context, 0x6c40)))),
                           PRIME))

                // res += c_286*(f_25(x) - f_25(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  /*oods_coefficients[286]*/ mload(add(context, 0x9700)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[286]*/ mload(add(context, 0x6c60)))),
                           PRIME))
                }

                // Mask items for column #26.
                {
                // Read the next element.
                let columnValue := mulmod(mload(add(traceQueryResponses, 0x340)), kMontgomeryRInv, PRIME)

                // res += c_287*(f_26(x) - f_26(z)) / (x - z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z)^(-1)*/ mload(denominatorsPtr),
                                  /*oods_coefficients[287]*/ mload(add(context, 0x9720)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[287]*/ mload(add(context, 0x6c80)))),
                           PRIME))

                // res += c_288*(f_26(x) - f_26(g * z)) / (x - g * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g * z)^(-1)*/ mload(add(denominatorsPtr, 0x20)),
                                  /*oods_coefficients[288]*/ mload(add(context, 0x9740)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[288]*/ mload(add(context, 0x6ca0)))),
                           PRIME))

                // res += c_289*(f_26(x) - f_26(g^2 * z)) / (x - g^2 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^2 * z)^(-1)*/ mload(add(denominatorsPtr, 0x40)),
                                  /*oods_coefficients[289]*/ mload(add(context, 0x9760)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[289]*/ mload(add(context, 0x6cc0)))),
                           PRIME))

                // res += c_290*(f_26(x) - f_26(g^3 * z)) / (x - g^3 * z).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - g^3 * z)^(-1)*/ mload(add(denominatorsPtr, 0x60)),
                                  /*oods_coefficients[290]*/ mload(add(context, 0x9780)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*oods_values[290]*/ mload(add(context, 0x6ce0)))),
                           PRIME))
                }

                // Advance traceQueryResponses by amount read (0x20 * nTraceColumns).
                traceQueryResponses := add(traceQueryResponses, 0x360)

                // Composition constraints.

                {
                // Read the next element.
                let columnValue := mulmod(mload(compositionQueryResponses), kMontgomeryRInv, PRIME)
                // res += c_291*(h_0(x) - C_0(z^2)) / (x - z^2).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z^2)^(-1)*/ mload(add(denominatorsPtr, 0x1480)),
                                  /*oods_coefficients[291]*/ mload(add(context, 0x97a0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*composition_oods_values[0]*/ mload(add(context, 0x6d00)))),
                           PRIME))
                }

                {
                // Read the next element.
                let columnValue := mulmod(mload(add(compositionQueryResponses, 0x20)), kMontgomeryRInv, PRIME)
                // res += c_292*(h_1(x) - C_1(z^2)) / (x - z^2).
                res := add(
                    res,
                    mulmod(mulmod(/*(x - z^2)^(-1)*/ mload(add(denominatorsPtr, 0x1480)),
                                  /*oods_coefficients[292]*/ mload(add(context, 0x97c0)),
                                  PRIME),
                           add(columnValue, sub(PRIME, /*composition_oods_values[1]*/ mload(add(context, 0x6d20)))),
                           PRIME))
                }

                // Advance compositionQueryResponses by amount read (0x20 * constraintDegree).
                compositionQueryResponses := add(compositionQueryResponses, 0x40)

                // Append the friValue, which is the sum of the out-of-domain-sampling boundary
                // constraints for the trace and composition polynomials, to the friQueue array.
                mstore(add(friQueue, 0x20), mod(res, PRIME))

                // Append the friInvPoint of the current query to the friQueue array.
                mstore(add(friQueue, 0x40), /*friInvPoint*/ mload(add(denominatorsPtr,0x14a0)))

                // Advance denominatorsPtr by chunk size (0x20 * (2+N_ROWS_IN_MASK)).
                denominatorsPtr := add(denominatorsPtr, 0x14c0)
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
        //    expmodsAndPoints[0:28] (.expmods) expmods used during calculations of the points below.
        //    expmodsAndPoints[28:192] (.points) points used during the denominators calculation.
        uint256[192] memory expmodsAndPoints;
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

            let traceGenerator := /*trace_generator*/ mload(add(context, 0x2c00))
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

            // expmodsAndPoints.expmods[9] = traceGenerator^11.
            mstore(add(expmodsAndPoints, 0x120),
                   mulmod(mload(add(expmodsAndPoints, 0x100)), // traceGenerator^10
                          traceGenerator, // traceGenerator^1
                          PRIME))

            // expmodsAndPoints.expmods[10] = traceGenerator^12.
            mstore(add(expmodsAndPoints, 0x140),
                   mulmod(mload(add(expmodsAndPoints, 0x120)), // traceGenerator^11
                          traceGenerator, // traceGenerator^1
                          PRIME))

            // expmodsAndPoints.expmods[11] = traceGenerator^14.
            mstore(add(expmodsAndPoints, 0x160),
                   mulmod(mload(add(expmodsAndPoints, 0x140)), // traceGenerator^12
                          mload(expmodsAndPoints), // traceGenerator^2
                          PRIME))

            // expmodsAndPoints.expmods[12] = traceGenerator^16.
            mstore(add(expmodsAndPoints, 0x180),
                   mulmod(mload(add(expmodsAndPoints, 0x160)), // traceGenerator^14
                          mload(expmodsAndPoints), // traceGenerator^2
                          PRIME))

            // expmodsAndPoints.expmods[13] = traceGenerator^17.
            mstore(add(expmodsAndPoints, 0x1a0),
                   mulmod(mload(add(expmodsAndPoints, 0x180)), // traceGenerator^16
                          traceGenerator, // traceGenerator^1
                          PRIME))

            // expmodsAndPoints.expmods[14] = traceGenerator^21.
            mstore(add(expmodsAndPoints, 0x1c0),
                   mulmod(mload(add(expmodsAndPoints, 0x1a0)), // traceGenerator^17
                          mload(add(expmodsAndPoints, 0x40)), // traceGenerator^4
                          PRIME))

            // expmodsAndPoints.expmods[15] = traceGenerator^26.
            mstore(add(expmodsAndPoints, 0x1e0),
                   mulmod(mload(add(expmodsAndPoints, 0x1c0)), // traceGenerator^21
                          mload(add(expmodsAndPoints, 0x60)), // traceGenerator^5
                          PRIME))

            // expmodsAndPoints.expmods[16] = traceGenerator^27.
            mstore(add(expmodsAndPoints, 0x200),
                   mulmod(mload(add(expmodsAndPoints, 0x1e0)), // traceGenerator^26
                          traceGenerator, // traceGenerator^1
                          PRIME))

            // expmodsAndPoints.expmods[17] = traceGenerator^29.
            mstore(add(expmodsAndPoints, 0x220),
                   mulmod(mload(add(expmodsAndPoints, 0x200)), // traceGenerator^27
                          mload(expmodsAndPoints), // traceGenerator^2
                          PRIME))

            // expmodsAndPoints.expmods[18] = traceGenerator^32.
            mstore(add(expmodsAndPoints, 0x240),
                   mulmod(mload(add(expmodsAndPoints, 0x220)), // traceGenerator^29
                          mload(add(expmodsAndPoints, 0x20)), // traceGenerator^3
                          PRIME))

            // expmodsAndPoints.expmods[19] = traceGenerator^37.
            mstore(add(expmodsAndPoints, 0x260),
                   mulmod(mload(add(expmodsAndPoints, 0x240)), // traceGenerator^32
                          mload(add(expmodsAndPoints, 0x60)), // traceGenerator^5
                          PRIME))

            // expmodsAndPoints.expmods[20] = traceGenerator^49.
            mstore(add(expmodsAndPoints, 0x280),
                   mulmod(mload(add(expmodsAndPoints, 0x260)), // traceGenerator^37
                          mload(add(expmodsAndPoints, 0x140)), // traceGenerator^12
                          PRIME))

            // expmodsAndPoints.expmods[21] = traceGenerator^52.
            mstore(add(expmodsAndPoints, 0x2a0),
                   mulmod(mload(add(expmodsAndPoints, 0x280)), // traceGenerator^49
                          mload(add(expmodsAndPoints, 0x20)), // traceGenerator^3
                          PRIME))

            // expmodsAndPoints.expmods[22] = traceGenerator^53.
            mstore(add(expmodsAndPoints, 0x2c0),
                   mulmod(mload(add(expmodsAndPoints, 0x2a0)), // traceGenerator^52
                          traceGenerator, // traceGenerator^1
                          PRIME))

            // expmodsAndPoints.expmods[23] = traceGenerator^64.
            mstore(add(expmodsAndPoints, 0x2e0),
                   mulmod(mload(add(expmodsAndPoints, 0x2c0)), // traceGenerator^53
                          mload(add(expmodsAndPoints, 0x120)), // traceGenerator^11
                          PRIME))

            // expmodsAndPoints.expmods[24] = traceGenerator^511.
            mstore(add(expmodsAndPoints, 0x300),
                   expmod(traceGenerator, 511, PRIME))

            // expmodsAndPoints.expmods[25] = traceGenerator^512.
            mstore(add(expmodsAndPoints, 0x320),
                   mulmod(mload(add(expmodsAndPoints, 0x300)), // traceGenerator^511
                          traceGenerator, // traceGenerator^1
                          PRIME))

            // expmodsAndPoints.expmods[26] = traceGenerator^966.
            mstore(add(expmodsAndPoints, 0x340),
                   expmod(traceGenerator, 966, PRIME))

            // expmodsAndPoints.expmods[27] = traceGenerator^1024.
            mstore(add(expmodsAndPoints, 0x360),
                   mulmod(mload(add(expmodsAndPoints, 0x320)), // traceGenerator^512
                          mload(add(expmodsAndPoints, 0x320)), // traceGenerator^512
                          PRIME))

            let oodsPoint := /*oods_point*/ mload(add(context, 0x2c20))
            {
              // point = -z.
              let point := sub(PRIME, oodsPoint)
              // Compute denominators for rows with nonconst mask expression.
              // We compute those first because for the const rows we modify the point variable.

              // Compute denominators for rows with const mask expression.

              // expmods_and_points.points[0] = -z.
              mstore(add(expmodsAndPoints, 0x380), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[1] = -(g * z).
              mstore(add(expmodsAndPoints, 0x3a0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[2] = -(g^2 * z).
              mstore(add(expmodsAndPoints, 0x3c0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[3] = -(g^3 * z).
              mstore(add(expmodsAndPoints, 0x3e0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[4] = -(g^4 * z).
              mstore(add(expmodsAndPoints, 0x400), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[5] = -(g^5 * z).
              mstore(add(expmodsAndPoints, 0x420), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[6] = -(g^6 * z).
              mstore(add(expmodsAndPoints, 0x440), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[7] = -(g^7 * z).
              mstore(add(expmodsAndPoints, 0x460), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[8] = -(g^8 * z).
              mstore(add(expmodsAndPoints, 0x480), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[9] = -(g^9 * z).
              mstore(add(expmodsAndPoints, 0x4a0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[10] = -(g^10 * z).
              mstore(add(expmodsAndPoints, 0x4c0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[11] = -(g^11 * z).
              mstore(add(expmodsAndPoints, 0x4e0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[12] = -(g^12 * z).
              mstore(add(expmodsAndPoints, 0x500), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[13] = -(g^13 * z).
              mstore(add(expmodsAndPoints, 0x520), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[14] = -(g^14 * z).
              mstore(add(expmodsAndPoints, 0x540), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[15] = -(g^15 * z).
              mstore(add(expmodsAndPoints, 0x560), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[16] = -(g^16 * z).
              mstore(add(expmodsAndPoints, 0x580), point)

              // point *= g^3.
              point := mulmod(point, /*traceGenerator^3*/ mload(add(expmodsAndPoints, 0x20)), PRIME)
              // expmods_and_points.points[17] = -(g^19 * z).
              mstore(add(expmodsAndPoints, 0x5a0), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[18] = -(g^21 * z).
              mstore(add(expmodsAndPoints, 0x5c0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[19] = -(g^22 * z).
              mstore(add(expmodsAndPoints, 0x5e0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[20] = -(g^23 * z).
              mstore(add(expmodsAndPoints, 0x600), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[21] = -(g^24 * z).
              mstore(add(expmodsAndPoints, 0x620), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[22] = -(g^25 * z).
              mstore(add(expmodsAndPoints, 0x640), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[23] = -(g^26 * z).
              mstore(add(expmodsAndPoints, 0x660), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[24] = -(g^27 * z).
              mstore(add(expmodsAndPoints, 0x680), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[25] = -(g^28 * z).
              mstore(add(expmodsAndPoints, 0x6a0), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[26] = -(g^30 * z).
              mstore(add(expmodsAndPoints, 0x6c0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[27] = -(g^31 * z).
              mstore(add(expmodsAndPoints, 0x6e0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[28] = -(g^32 * z).
              mstore(add(expmodsAndPoints, 0x700), point)

              // point *= g^7.
              point := mulmod(point, /*traceGenerator^7*/ mload(add(expmodsAndPoints, 0xa0)), PRIME)
              // expmods_and_points.points[29] = -(g^39 * z).
              mstore(add(expmodsAndPoints, 0x720), point)

              // point *= g^3.
              point := mulmod(point, /*traceGenerator^3*/ mload(add(expmodsAndPoints, 0x20)), PRIME)
              // expmods_and_points.points[30] = -(g^42 * z).
              mstore(add(expmodsAndPoints, 0x740), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[31] = -(g^43 * z).
              mstore(add(expmodsAndPoints, 0x760), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[32] = -(g^44 * z).
              mstore(add(expmodsAndPoints, 0x780), point)

              // point *= g^11.
              point := mulmod(point, /*traceGenerator^11*/ mload(add(expmodsAndPoints, 0x120)), PRIME)
              // expmods_and_points.points[33] = -(g^55 * z).
              mstore(add(expmodsAndPoints, 0x7a0), point)

              // point *= g^5.
              point := mulmod(point, /*traceGenerator^5*/ mload(add(expmodsAndPoints, 0x60)), PRIME)
              // expmods_and_points.points[34] = -(g^60 * z).
              mstore(add(expmodsAndPoints, 0x7c0), point)

              // point *= g^3.
              point := mulmod(point, /*traceGenerator^3*/ mload(add(expmodsAndPoints, 0x20)), PRIME)
              // expmods_and_points.points[35] = -(g^63 * z).
              mstore(add(expmodsAndPoints, 0x7e0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[36] = -(g^64 * z).
              mstore(add(expmodsAndPoints, 0x800), point)

              // point *= g^10.
              point := mulmod(point, /*traceGenerator^10*/ mload(add(expmodsAndPoints, 0x100)), PRIME)
              // expmods_and_points.points[37] = -(g^74 * z).
              mstore(add(expmodsAndPoints, 0x820), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[38] = -(g^75 * z).
              mstore(add(expmodsAndPoints, 0x840), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[39] = -(g^76 * z).
              mstore(add(expmodsAndPoints, 0x860), point)

              // point *= g^4.
              point := mulmod(point, /*traceGenerator^4*/ mload(add(expmodsAndPoints, 0x40)), PRIME)
              // expmods_and_points.points[40] = -(g^80 * z).
              mstore(add(expmodsAndPoints, 0x880), point)

              // point *= g^12.
              point := mulmod(point, /*traceGenerator^12*/ mload(add(expmodsAndPoints, 0x140)), PRIME)
              // expmods_and_points.points[41] = -(g^92 * z).
              mstore(add(expmodsAndPoints, 0x8a0), point)

              // point *= g^14.
              point := mulmod(point, /*traceGenerator^14*/ mload(add(expmodsAndPoints, 0x160)), PRIME)
              // expmods_and_points.points[42] = -(g^106 * z).
              mstore(add(expmodsAndPoints, 0x8c0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[43] = -(g^107 * z).
              mstore(add(expmodsAndPoints, 0x8e0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[44] = -(g^108 * z).
              mstore(add(expmodsAndPoints, 0x900), point)

              // point *= g^16.
              point := mulmod(point, /*traceGenerator^16*/ mload(add(expmodsAndPoints, 0x180)), PRIME)
              // expmods_and_points.points[45] = -(g^124 * z).
              mstore(add(expmodsAndPoints, 0x920), point)

              // point *= g^4.
              point := mulmod(point, /*traceGenerator^4*/ mload(add(expmodsAndPoints, 0x40)), PRIME)
              // expmods_and_points.points[46] = -(g^128 * z).
              mstore(add(expmodsAndPoints, 0x940), point)

              // point *= g^10.
              point := mulmod(point, /*traceGenerator^10*/ mload(add(expmodsAndPoints, 0x100)), PRIME)
              // expmods_and_points.points[47] = -(g^138 * z).
              mstore(add(expmodsAndPoints, 0x960), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[48] = -(g^139 * z).
              mstore(add(expmodsAndPoints, 0x980), point)

              // point *= g^5.
              point := mulmod(point, /*traceGenerator^5*/ mload(add(expmodsAndPoints, 0x60)), PRIME)
              // expmods_and_points.points[49] = -(g^144 * z).
              mstore(add(expmodsAndPoints, 0x9a0), point)

              // point *= g^27.
              point := mulmod(point, /*traceGenerator^27*/ mload(add(expmodsAndPoints, 0x200)), PRIME)
              // expmods_and_points.points[50] = -(g^171 * z).
              mstore(add(expmodsAndPoints, 0x9c0), point)

              // point *= g^21.
              point := mulmod(point, /*traceGenerator^21*/ mload(add(expmodsAndPoints, 0x1c0)), PRIME)
              // expmods_and_points.points[51] = -(g^192 * z).
              mstore(add(expmodsAndPoints, 0x9e0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[52] = -(g^193 * z).
              mstore(add(expmodsAndPoints, 0xa00), point)

              // point *= g^3.
              point := mulmod(point, /*traceGenerator^3*/ mload(add(expmodsAndPoints, 0x20)), PRIME)
              // expmods_and_points.points[53] = -(g^196 * z).
              mstore(add(expmodsAndPoints, 0xa20), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[54] = -(g^197 * z).
              mstore(add(expmodsAndPoints, 0xa40), point)

              // point *= g^6.
              point := mulmod(point, /*traceGenerator^6*/ mload(add(expmodsAndPoints, 0x80)), PRIME)
              // expmods_and_points.points[55] = -(g^203 * z).
              mstore(add(expmodsAndPoints, 0xa60), point)

              // point *= g^5.
              point := mulmod(point, /*traceGenerator^5*/ mload(add(expmodsAndPoints, 0x60)), PRIME)
              // expmods_and_points.points[56] = -(g^208 * z).
              mstore(add(expmodsAndPoints, 0xa80), point)

              // point *= g^26.
              point := mulmod(point, /*traceGenerator^26*/ mload(add(expmodsAndPoints, 0x1e0)), PRIME)
              // expmods_and_points.points[57] = -(g^234 * z).
              mstore(add(expmodsAndPoints, 0xaa0), point)

              // point *= g^17.
              point := mulmod(point, /*traceGenerator^17*/ mload(add(expmodsAndPoints, 0x1a0)), PRIME)
              // expmods_and_points.points[58] = -(g^251 * z).
              mstore(add(expmodsAndPoints, 0xac0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[59] = -(g^252 * z).
              mstore(add(expmodsAndPoints, 0xae0), point)

              // point *= g^3.
              point := mulmod(point, /*traceGenerator^3*/ mload(add(expmodsAndPoints, 0x20)), PRIME)
              // expmods_and_points.points[60] = -(g^255 * z).
              mstore(add(expmodsAndPoints, 0xb00), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[61] = -(g^256 * z).
              mstore(add(expmodsAndPoints, 0xb20), point)

              // point *= g^11.
              point := mulmod(point, /*traceGenerator^11*/ mload(add(expmodsAndPoints, 0x120)), PRIME)
              // expmods_and_points.points[62] = -(g^267 * z).
              mstore(add(expmodsAndPoints, 0xb40), point)

              // point *= g^32.
              point := mulmod(point, /*traceGenerator^32*/ mload(add(expmodsAndPoints, 0x240)), PRIME)
              // expmods_and_points.points[63] = -(g^299 * z).
              mstore(add(expmodsAndPoints, 0xb60), point)

              // point *= g^21.
              point := mulmod(point, /*traceGenerator^21*/ mload(add(expmodsAndPoints, 0x1c0)), PRIME)
              // expmods_and_points.points[64] = -(g^320 * z).
              mstore(add(expmodsAndPoints, 0xb80), point)

              // point *= g^11.
              point := mulmod(point, /*traceGenerator^11*/ mload(add(expmodsAndPoints, 0x120)), PRIME)
              // expmods_and_points.points[65] = -(g^331 * z).
              mstore(add(expmodsAndPoints, 0xba0), point)

              // point *= g^53.
              point := mulmod(point, /*traceGenerator^53*/ mload(add(expmodsAndPoints, 0x2c0)), PRIME)
              // expmods_and_points.points[66] = -(g^384 * z).
              mstore(add(expmodsAndPoints, 0xbc0), point)

              // point *= g^11.
              point := mulmod(point, /*traceGenerator^11*/ mload(add(expmodsAndPoints, 0x120)), PRIME)
              // expmods_and_points.points[67] = -(g^395 * z).
              mstore(add(expmodsAndPoints, 0xbe0), point)

              // point *= g^32.
              point := mulmod(point, /*traceGenerator^32*/ mload(add(expmodsAndPoints, 0x240)), PRIME)
              // expmods_and_points.points[68] = -(g^427 * z).
              mstore(add(expmodsAndPoints, 0xc00), point)

              // point *= g^21.
              point := mulmod(point, /*traceGenerator^21*/ mload(add(expmodsAndPoints, 0x1c0)), PRIME)
              // expmods_and_points.points[69] = -(g^448 * z).
              mstore(add(expmodsAndPoints, 0xc20), point)

              // point *= g^11.
              point := mulmod(point, /*traceGenerator^11*/ mload(add(expmodsAndPoints, 0x120)), PRIME)
              // expmods_and_points.points[70] = -(g^459 * z).
              mstore(add(expmodsAndPoints, 0xc40), point)

              // point *= g^52.
              point := mulmod(point, /*traceGenerator^52*/ mload(add(expmodsAndPoints, 0x2a0)), PRIME)
              // expmods_and_points.points[71] = -(g^511 * z).
              mstore(add(expmodsAndPoints, 0xc60), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[72] = -(g^512 * z).
              mstore(add(expmodsAndPoints, 0xc80), point)

              // point *= g^26.
              point := mulmod(point, /*traceGenerator^26*/ mload(add(expmodsAndPoints, 0x1e0)), PRIME)
              // expmods_and_points.points[73] = -(g^538 * z).
              mstore(add(expmodsAndPoints, 0xca0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[74] = -(g^539 * z).
              mstore(add(expmodsAndPoints, 0xcc0), point)

              // point *= g^37.
              point := mulmod(point, /*traceGenerator^37*/ mload(add(expmodsAndPoints, 0x260)), PRIME)
              // expmods_and_points.points[75] = -(g^576 * z).
              mstore(add(expmodsAndPoints, 0xce0), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[76] = -(g^640 * z).
              mstore(add(expmodsAndPoints, 0xd00), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[77] = -(g^704 * z).
              mstore(add(expmodsAndPoints, 0xd20), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[78] = -(g^768 * z).
              mstore(add(expmodsAndPoints, 0xd40), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[79] = -(g^832 * z).
              mstore(add(expmodsAndPoints, 0xd60), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[80] = -(g^896 * z).
              mstore(add(expmodsAndPoints, 0xd80), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[81] = -(g^960 * z).
              mstore(add(expmodsAndPoints, 0xda0), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[82] = -(g^1024 * z).
              mstore(add(expmodsAndPoints, 0xdc0), point)

              // point *= g^26.
              point := mulmod(point, /*traceGenerator^26*/ mload(add(expmodsAndPoints, 0x1e0)), PRIME)
              // expmods_and_points.points[83] = -(g^1050 * z).
              mstore(add(expmodsAndPoints, 0xde0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[84] = -(g^1051 * z).
              mstore(add(expmodsAndPoints, 0xe00), point)

              // point *= g^5.
              point := mulmod(point, /*traceGenerator^5*/ mload(add(expmodsAndPoints, 0x60)), PRIME)
              // expmods_and_points.points[85] = -(g^1056 * z).
              mstore(add(expmodsAndPoints, 0xe20), point)

              // point *= g^32.
              point := mulmod(point, /*traceGenerator^32*/ mload(add(expmodsAndPoints, 0x240)), PRIME)
              // expmods_and_points.points[86] = -(g^1088 * z).
              mstore(add(expmodsAndPoints, 0xe40), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[87] = -(g^1152 * z).
              mstore(add(expmodsAndPoints, 0xe60), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[88] = -(g^1216 * z).
              mstore(add(expmodsAndPoints, 0xe80), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[89] = -(g^1280 * z).
              mstore(add(expmodsAndPoints, 0xea0), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[90] = -(g^1344 * z).
              mstore(add(expmodsAndPoints, 0xec0), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[91] = -(g^1408 * z).
              mstore(add(expmodsAndPoints, 0xee0), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[92] = -(g^1472 * z).
              mstore(add(expmodsAndPoints, 0xf00), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[93] = -(g^1536 * z).
              mstore(add(expmodsAndPoints, 0xf20), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[94] = -(g^1600 * z).
              mstore(add(expmodsAndPoints, 0xf40), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[95] = -(g^1664 * z).
              mstore(add(expmodsAndPoints, 0xf60), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[96] = -(g^1728 * z).
              mstore(add(expmodsAndPoints, 0xf80), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[97] = -(g^1792 * z).
              mstore(add(expmodsAndPoints, 0xfa0), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[98] = -(g^1856 * z).
              mstore(add(expmodsAndPoints, 0xfc0), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[99] = -(g^1920 * z).
              mstore(add(expmodsAndPoints, 0xfe0), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[100] = -(g^1984 * z).
              mstore(add(expmodsAndPoints, 0x1000), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[101] = -(g^2048 * z).
              mstore(add(expmodsAndPoints, 0x1020), point)

              // point *= g^26.
              point := mulmod(point, /*traceGenerator^26*/ mload(add(expmodsAndPoints, 0x1e0)), PRIME)
              // expmods_and_points.points[102] = -(g^2074 * z).
              mstore(add(expmodsAndPoints, 0x1040), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[103] = -(g^2075 * z).
              mstore(add(expmodsAndPoints, 0x1060), point)

              // point *= g^5.
              point := mulmod(point, /*traceGenerator^5*/ mload(add(expmodsAndPoints, 0x60)), PRIME)
              // expmods_and_points.points[104] = -(g^2080 * z).
              mstore(add(expmodsAndPoints, 0x1080), point)

              // point *= g^32.
              point := mulmod(point, /*traceGenerator^32*/ mload(add(expmodsAndPoints, 0x240)), PRIME)
              // expmods_and_points.points[105] = -(g^2112 * z).
              mstore(add(expmodsAndPoints, 0x10a0), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[106] = -(g^2176 * z).
              mstore(add(expmodsAndPoints, 0x10c0), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[107] = -(g^2240 * z).
              mstore(add(expmodsAndPoints, 0x10e0), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[108] = -(g^2304 * z).
              mstore(add(expmodsAndPoints, 0x1100), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[109] = -(g^2368 * z).
              mstore(add(expmodsAndPoints, 0x1120), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[110] = -(g^2432 * z).
              mstore(add(expmodsAndPoints, 0x1140), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[111] = -(g^2496 * z).
              mstore(add(expmodsAndPoints, 0x1160), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[112] = -(g^2560 * z).
              mstore(add(expmodsAndPoints, 0x1180), point)

              // point *= g^26.
              point := mulmod(point, /*traceGenerator^26*/ mload(add(expmodsAndPoints, 0x1e0)), PRIME)
              // expmods_and_points.points[113] = -(g^2586 * z).
              mstore(add(expmodsAndPoints, 0x11a0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[114] = -(g^2587 * z).
              mstore(add(expmodsAndPoints, 0x11c0), point)

              // point *= g^37.
              point := mulmod(point, /*traceGenerator^37*/ mload(add(expmodsAndPoints, 0x260)), PRIME)
              // expmods_and_points.points[115] = -(g^2624 * z).
              mstore(add(expmodsAndPoints, 0x11e0), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[116] = -(g^2688 * z).
              mstore(add(expmodsAndPoints, 0x1200), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[117] = -(g^2752 * z).
              mstore(add(expmodsAndPoints, 0x1220), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[118] = -(g^2816 * z).
              mstore(add(expmodsAndPoints, 0x1240), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[119] = -(g^2880 * z).
              mstore(add(expmodsAndPoints, 0x1260), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[120] = -(g^2944 * z).
              mstore(add(expmodsAndPoints, 0x1280), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[121] = -(g^3008 * z).
              mstore(add(expmodsAndPoints, 0x12a0), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[122] = -(g^3072 * z).
              mstore(add(expmodsAndPoints, 0x12c0), point)

              // point *= g^26.
              point := mulmod(point, /*traceGenerator^26*/ mload(add(expmodsAndPoints, 0x1e0)), PRIME)
              // expmods_and_points.points[123] = -(g^3098 * z).
              mstore(add(expmodsAndPoints, 0x12e0), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[124] = -(g^3099 * z).
              mstore(add(expmodsAndPoints, 0x1300), point)

              // point *= g^5.
              point := mulmod(point, /*traceGenerator^5*/ mload(add(expmodsAndPoints, 0x60)), PRIME)
              // expmods_and_points.points[125] = -(g^3104 * z).
              mstore(add(expmodsAndPoints, 0x1320), point)

              // point *= g^32.
              point := mulmod(point, /*traceGenerator^32*/ mload(add(expmodsAndPoints, 0x240)), PRIME)
              // expmods_and_points.points[126] = -(g^3136 * z).
              mstore(add(expmodsAndPoints, 0x1340), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[127] = -(g^3200 * z).
              mstore(add(expmodsAndPoints, 0x1360), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[128] = -(g^3264 * z).
              mstore(add(expmodsAndPoints, 0x1380), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[129] = -(g^3328 * z).
              mstore(add(expmodsAndPoints, 0x13a0), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[130] = -(g^3392 * z).
              mstore(add(expmodsAndPoints, 0x13c0), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[131] = -(g^3456 * z).
              mstore(add(expmodsAndPoints, 0x13e0), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[132] = -(g^3520 * z).
              mstore(add(expmodsAndPoints, 0x1400), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[133] = -(g^3584 * z).
              mstore(add(expmodsAndPoints, 0x1420), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[134] = -(g^3648 * z).
              mstore(add(expmodsAndPoints, 0x1440), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[135] = -(g^3712 * z).
              mstore(add(expmodsAndPoints, 0x1460), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[136] = -(g^3776 * z).
              mstore(add(expmodsAndPoints, 0x1480), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[137] = -(g^3840 * z).
              mstore(add(expmodsAndPoints, 0x14a0), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[138] = -(g^3904 * z).
              mstore(add(expmodsAndPoints, 0x14c0), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[139] = -(g^3968 * z).
              mstore(add(expmodsAndPoints, 0x14e0), point)

              // point *= g^64.
              point := mulmod(point, /*traceGenerator^64*/ mload(add(expmodsAndPoints, 0x2e0)), PRIME)
              // expmods_and_points.points[140] = -(g^4032 * z).
              mstore(add(expmodsAndPoints, 0x1500), point)

              // point *= g^49.
              point := mulmod(point, /*traceGenerator^49*/ mload(add(expmodsAndPoints, 0x280)), PRIME)
              // expmods_and_points.points[141] = -(g^4081 * z).
              mstore(add(expmodsAndPoints, 0x1520), point)

              // point *= g^4.
              point := mulmod(point, /*traceGenerator^4*/ mload(add(expmodsAndPoints, 0x40)), PRIME)
              // expmods_and_points.points[142] = -(g^4085 * z).
              mstore(add(expmodsAndPoints, 0x1540), point)

              // point *= g^4.
              point := mulmod(point, /*traceGenerator^4*/ mload(add(expmodsAndPoints, 0x40)), PRIME)
              // expmods_and_points.points[143] = -(g^4089 * z).
              mstore(add(expmodsAndPoints, 0x1560), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[144] = -(g^4091 * z).
              mstore(add(expmodsAndPoints, 0x1580), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[145] = -(g^4093 * z).
              mstore(add(expmodsAndPoints, 0x15a0), point)

              // point *= g^9.
              point := mulmod(point, /*traceGenerator^9*/ mload(add(expmodsAndPoints, 0xe0)), PRIME)
              // expmods_and_points.points[146] = -(g^4102 * z).
              mstore(add(expmodsAndPoints, 0x15c0), point)

              // point *= g^8.
              point := mulmod(point, /*traceGenerator^8*/ mload(add(expmodsAndPoints, 0xc0)), PRIME)
              // expmods_and_points.points[147] = -(g^4110 * z).
              mstore(add(expmodsAndPoints, 0x15e0), point)

              // point *= g^12.
              point := mulmod(point, /*traceGenerator^12*/ mload(add(expmodsAndPoints, 0x140)), PRIME)
              // expmods_and_points.points[148] = -(g^4122 * z).
              mstore(add(expmodsAndPoints, 0x1600), point)

              // point *= g.
              point := mulmod(point, traceGenerator, PRIME)
              // expmods_and_points.points[149] = -(g^4123 * z).
              mstore(add(expmodsAndPoints, 0x1620), point)

              // point *= g^511.
              point := mulmod(point, /*traceGenerator^511*/ mload(add(expmodsAndPoints, 0x300)), PRIME)
              // expmods_and_points.points[150] = -(g^4634 * z).
              mstore(add(expmodsAndPoints, 0x1640), point)

              // point *= g^512.
              point := mulmod(point, /*traceGenerator^512*/ mload(add(expmodsAndPoints, 0x320)), PRIME)
              // expmods_and_points.points[151] = -(g^5146 * z).
              mstore(add(expmodsAndPoints, 0x1660), point)

              // point *= g^1024.
              point := mulmod(point, /*traceGenerator^1024*/ mload(add(expmodsAndPoints, 0x360)), PRIME)
              // expmods_and_points.points[152] = -(g^6170 * z).
              mstore(add(expmodsAndPoints, 0x1680), point)

              // point *= g^512.
              point := mulmod(point, /*traceGenerator^512*/ mload(add(expmodsAndPoints, 0x320)), PRIME)
              // expmods_and_points.points[153] = -(g^6682 * z).
              mstore(add(expmodsAndPoints, 0x16a0), point)

              // point *= g^512.
              point := mulmod(point, /*traceGenerator^512*/ mload(add(expmodsAndPoints, 0x320)), PRIME)
              // expmods_and_points.points[154] = -(g^7194 * z).
              mstore(add(expmodsAndPoints, 0x16c0), point)

              // point *= g^966.
              point := mulmod(point, /*traceGenerator^966*/ mload(add(expmodsAndPoints, 0x340)), PRIME)
              // expmods_and_points.points[155] = -(g^8160 * z).
              mstore(add(expmodsAndPoints, 0x16e0), point)

              // point *= g^7.
              point := mulmod(point, /*traceGenerator^7*/ mload(add(expmodsAndPoints, 0xa0)), PRIME)
              // expmods_and_points.points[156] = -(g^8167 * z).
              mstore(add(expmodsAndPoints, 0x1700), point)

              // point *= g^8.
              point := mulmod(point, /*traceGenerator^8*/ mload(add(expmodsAndPoints, 0xc0)), PRIME)
              // expmods_and_points.points[157] = -(g^8175 * z).
              mstore(add(expmodsAndPoints, 0x1720), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[158] = -(g^8177 * z).
              mstore(add(expmodsAndPoints, 0x1740), point)

              // point *= g^4.
              point := mulmod(point, /*traceGenerator^4*/ mload(add(expmodsAndPoints, 0x40)), PRIME)
              // expmods_and_points.points[159] = -(g^8181 * z).
              mstore(add(expmodsAndPoints, 0x1760), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[160] = -(g^8183 * z).
              mstore(add(expmodsAndPoints, 0x1780), point)

              // point *= g^2.
              point := mulmod(point, /*traceGenerator^2*/ mload(expmodsAndPoints), PRIME)
              // expmods_and_points.points[161] = -(g^8185 * z).
              mstore(add(expmodsAndPoints, 0x17a0), point)

              // point *= g^4.
              point := mulmod(point, /*traceGenerator^4*/ mload(add(expmodsAndPoints, 0x40)), PRIME)
              // expmods_and_points.points[162] = -(g^8189 * z).
              mstore(add(expmodsAndPoints, 0x17c0), point)

              // point *= g^29.
              point := mulmod(point, /*traceGenerator^29*/ mload(add(expmodsAndPoints, 0x220)), PRIME)
              // expmods_and_points.points[163] = -(g^8218 * z).
              mstore(add(expmodsAndPoints, 0x17e0), point)
            }


            let evalPointsPtr := /*oodsEvalPoints*/ add(context, 0x6d40)
            let evalPointsEndPtr := add(evalPointsPtr,
                                           mul(/*n_unique_queries*/ mload(add(context, 0x140)), 0x20))
            let productsPtr := add(batchInverseArray, 0x20)
            let valuesPtr := add(add(batchInverseArray, 0x20), 0x3e400)
            let partialProduct := 1
            let minusPointPow := sub(PRIME, mulmod(oodsPoint, oodsPoint, PRIME))
            for {} lt(evalPointsPtr, evalPointsEndPtr)
                     {evalPointsPtr := add(evalPointsPtr, 0x20)} {
                let evalPoint := mload(evalPointsPtr)

                // Shift evalPoint to evaluation domain coset.
                let shiftedEvalPoint := mulmod(evalPoint, evalCosetOffset_, PRIME)

                {
                // Calculate denominator for row 0: x - z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x380)))
                mstore(productsPtr, partialProduct)
                mstore(valuesPtr, denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1: x - g * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x3a0)))
                mstore(add(productsPtr, 0x20), partialProduct)
                mstore(add(valuesPtr, 0x20), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 2: x - g^2 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x3c0)))
                mstore(add(productsPtr, 0x40), partialProduct)
                mstore(add(valuesPtr, 0x40), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 3: x - g^3 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x3e0)))
                mstore(add(productsPtr, 0x60), partialProduct)
                mstore(add(valuesPtr, 0x60), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 4: x - g^4 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x400)))
                mstore(add(productsPtr, 0x80), partialProduct)
                mstore(add(valuesPtr, 0x80), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 5: x - g^5 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x420)))
                mstore(add(productsPtr, 0xa0), partialProduct)
                mstore(add(valuesPtr, 0xa0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 6: x - g^6 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x440)))
                mstore(add(productsPtr, 0xc0), partialProduct)
                mstore(add(valuesPtr, 0xc0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 7: x - g^7 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x460)))
                mstore(add(productsPtr, 0xe0), partialProduct)
                mstore(add(valuesPtr, 0xe0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 8: x - g^8 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x480)))
                mstore(add(productsPtr, 0x100), partialProduct)
                mstore(add(valuesPtr, 0x100), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 9: x - g^9 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x4a0)))
                mstore(add(productsPtr, 0x120), partialProduct)
                mstore(add(valuesPtr, 0x120), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 10: x - g^10 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x4c0)))
                mstore(add(productsPtr, 0x140), partialProduct)
                mstore(add(valuesPtr, 0x140), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 11: x - g^11 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x4e0)))
                mstore(add(productsPtr, 0x160), partialProduct)
                mstore(add(valuesPtr, 0x160), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 12: x - g^12 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x500)))
                mstore(add(productsPtr, 0x180), partialProduct)
                mstore(add(valuesPtr, 0x180), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 13: x - g^13 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x520)))
                mstore(add(productsPtr, 0x1a0), partialProduct)
                mstore(add(valuesPtr, 0x1a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 14: x - g^14 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x540)))
                mstore(add(productsPtr, 0x1c0), partialProduct)
                mstore(add(valuesPtr, 0x1c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 15: x - g^15 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x560)))
                mstore(add(productsPtr, 0x1e0), partialProduct)
                mstore(add(valuesPtr, 0x1e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 16: x - g^16 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x580)))
                mstore(add(productsPtr, 0x200), partialProduct)
                mstore(add(valuesPtr, 0x200), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 19: x - g^19 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x5a0)))
                mstore(add(productsPtr, 0x220), partialProduct)
                mstore(add(valuesPtr, 0x220), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 21: x - g^21 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x5c0)))
                mstore(add(productsPtr, 0x240), partialProduct)
                mstore(add(valuesPtr, 0x240), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 22: x - g^22 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x5e0)))
                mstore(add(productsPtr, 0x260), partialProduct)
                mstore(add(valuesPtr, 0x260), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 23: x - g^23 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x600)))
                mstore(add(productsPtr, 0x280), partialProduct)
                mstore(add(valuesPtr, 0x280), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 24: x - g^24 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x620)))
                mstore(add(productsPtr, 0x2a0), partialProduct)
                mstore(add(valuesPtr, 0x2a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 25: x - g^25 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x640)))
                mstore(add(productsPtr, 0x2c0), partialProduct)
                mstore(add(valuesPtr, 0x2c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 26: x - g^26 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x660)))
                mstore(add(productsPtr, 0x2e0), partialProduct)
                mstore(add(valuesPtr, 0x2e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 27: x - g^27 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x680)))
                mstore(add(productsPtr, 0x300), partialProduct)
                mstore(add(valuesPtr, 0x300), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 28: x - g^28 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x6a0)))
                mstore(add(productsPtr, 0x320), partialProduct)
                mstore(add(valuesPtr, 0x320), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 30: x - g^30 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x6c0)))
                mstore(add(productsPtr, 0x340), partialProduct)
                mstore(add(valuesPtr, 0x340), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 31: x - g^31 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x6e0)))
                mstore(add(productsPtr, 0x360), partialProduct)
                mstore(add(valuesPtr, 0x360), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 32: x - g^32 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x700)))
                mstore(add(productsPtr, 0x380), partialProduct)
                mstore(add(valuesPtr, 0x380), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 39: x - g^39 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x720)))
                mstore(add(productsPtr, 0x3a0), partialProduct)
                mstore(add(valuesPtr, 0x3a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 42: x - g^42 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x740)))
                mstore(add(productsPtr, 0x3c0), partialProduct)
                mstore(add(valuesPtr, 0x3c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 43: x - g^43 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x760)))
                mstore(add(productsPtr, 0x3e0), partialProduct)
                mstore(add(valuesPtr, 0x3e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 44: x - g^44 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x780)))
                mstore(add(productsPtr, 0x400), partialProduct)
                mstore(add(valuesPtr, 0x400), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 55: x - g^55 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x7a0)))
                mstore(add(productsPtr, 0x420), partialProduct)
                mstore(add(valuesPtr, 0x420), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 60: x - g^60 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x7c0)))
                mstore(add(productsPtr, 0x440), partialProduct)
                mstore(add(valuesPtr, 0x440), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 63: x - g^63 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x7e0)))
                mstore(add(productsPtr, 0x460), partialProduct)
                mstore(add(valuesPtr, 0x460), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 64: x - g^64 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x800)))
                mstore(add(productsPtr, 0x480), partialProduct)
                mstore(add(valuesPtr, 0x480), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 74: x - g^74 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x820)))
                mstore(add(productsPtr, 0x4a0), partialProduct)
                mstore(add(valuesPtr, 0x4a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 75: x - g^75 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x840)))
                mstore(add(productsPtr, 0x4c0), partialProduct)
                mstore(add(valuesPtr, 0x4c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 76: x - g^76 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x860)))
                mstore(add(productsPtr, 0x4e0), partialProduct)
                mstore(add(valuesPtr, 0x4e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 80: x - g^80 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x880)))
                mstore(add(productsPtr, 0x500), partialProduct)
                mstore(add(valuesPtr, 0x500), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 92: x - g^92 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x8a0)))
                mstore(add(productsPtr, 0x520), partialProduct)
                mstore(add(valuesPtr, 0x520), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 106: x - g^106 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x8c0)))
                mstore(add(productsPtr, 0x540), partialProduct)
                mstore(add(valuesPtr, 0x540), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 107: x - g^107 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x8e0)))
                mstore(add(productsPtr, 0x560), partialProduct)
                mstore(add(valuesPtr, 0x560), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 108: x - g^108 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x900)))
                mstore(add(productsPtr, 0x580), partialProduct)
                mstore(add(valuesPtr, 0x580), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 124: x - g^124 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x920)))
                mstore(add(productsPtr, 0x5a0), partialProduct)
                mstore(add(valuesPtr, 0x5a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 128: x - g^128 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x940)))
                mstore(add(productsPtr, 0x5c0), partialProduct)
                mstore(add(valuesPtr, 0x5c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 138: x - g^138 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x960)))
                mstore(add(productsPtr, 0x5e0), partialProduct)
                mstore(add(valuesPtr, 0x5e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 139: x - g^139 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x980)))
                mstore(add(productsPtr, 0x600), partialProduct)
                mstore(add(valuesPtr, 0x600), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 144: x - g^144 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x9a0)))
                mstore(add(productsPtr, 0x620), partialProduct)
                mstore(add(valuesPtr, 0x620), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 171: x - g^171 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x9c0)))
                mstore(add(productsPtr, 0x640), partialProduct)
                mstore(add(valuesPtr, 0x640), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 192: x - g^192 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x9e0)))
                mstore(add(productsPtr, 0x660), partialProduct)
                mstore(add(valuesPtr, 0x660), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 193: x - g^193 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xa00)))
                mstore(add(productsPtr, 0x680), partialProduct)
                mstore(add(valuesPtr, 0x680), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 196: x - g^196 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xa20)))
                mstore(add(productsPtr, 0x6a0), partialProduct)
                mstore(add(valuesPtr, 0x6a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 197: x - g^197 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xa40)))
                mstore(add(productsPtr, 0x6c0), partialProduct)
                mstore(add(valuesPtr, 0x6c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 203: x - g^203 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xa60)))
                mstore(add(productsPtr, 0x6e0), partialProduct)
                mstore(add(valuesPtr, 0x6e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 208: x - g^208 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xa80)))
                mstore(add(productsPtr, 0x700), partialProduct)
                mstore(add(valuesPtr, 0x700), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 234: x - g^234 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xaa0)))
                mstore(add(productsPtr, 0x720), partialProduct)
                mstore(add(valuesPtr, 0x720), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 251: x - g^251 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xac0)))
                mstore(add(productsPtr, 0x740), partialProduct)
                mstore(add(valuesPtr, 0x740), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 252: x - g^252 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xae0)))
                mstore(add(productsPtr, 0x760), partialProduct)
                mstore(add(valuesPtr, 0x760), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 255: x - g^255 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xb00)))
                mstore(add(productsPtr, 0x780), partialProduct)
                mstore(add(valuesPtr, 0x780), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 256: x - g^256 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xb20)))
                mstore(add(productsPtr, 0x7a0), partialProduct)
                mstore(add(valuesPtr, 0x7a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 267: x - g^267 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xb40)))
                mstore(add(productsPtr, 0x7c0), partialProduct)
                mstore(add(valuesPtr, 0x7c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 299: x - g^299 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xb60)))
                mstore(add(productsPtr, 0x7e0), partialProduct)
                mstore(add(valuesPtr, 0x7e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 320: x - g^320 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xb80)))
                mstore(add(productsPtr, 0x800), partialProduct)
                mstore(add(valuesPtr, 0x800), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 331: x - g^331 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xba0)))
                mstore(add(productsPtr, 0x820), partialProduct)
                mstore(add(valuesPtr, 0x820), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 384: x - g^384 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xbc0)))
                mstore(add(productsPtr, 0x840), partialProduct)
                mstore(add(valuesPtr, 0x840), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 395: x - g^395 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xbe0)))
                mstore(add(productsPtr, 0x860), partialProduct)
                mstore(add(valuesPtr, 0x860), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 427: x - g^427 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xc00)))
                mstore(add(productsPtr, 0x880), partialProduct)
                mstore(add(valuesPtr, 0x880), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 448: x - g^448 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xc20)))
                mstore(add(productsPtr, 0x8a0), partialProduct)
                mstore(add(valuesPtr, 0x8a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 459: x - g^459 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xc40)))
                mstore(add(productsPtr, 0x8c0), partialProduct)
                mstore(add(valuesPtr, 0x8c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 511: x - g^511 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xc60)))
                mstore(add(productsPtr, 0x8e0), partialProduct)
                mstore(add(valuesPtr, 0x8e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 512: x - g^512 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xc80)))
                mstore(add(productsPtr, 0x900), partialProduct)
                mstore(add(valuesPtr, 0x900), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 538: x - g^538 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xca0)))
                mstore(add(productsPtr, 0x920), partialProduct)
                mstore(add(valuesPtr, 0x920), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 539: x - g^539 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xcc0)))
                mstore(add(productsPtr, 0x940), partialProduct)
                mstore(add(valuesPtr, 0x940), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 576: x - g^576 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xce0)))
                mstore(add(productsPtr, 0x960), partialProduct)
                mstore(add(valuesPtr, 0x960), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 640: x - g^640 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xd00)))
                mstore(add(productsPtr, 0x980), partialProduct)
                mstore(add(valuesPtr, 0x980), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 704: x - g^704 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xd20)))
                mstore(add(productsPtr, 0x9a0), partialProduct)
                mstore(add(valuesPtr, 0x9a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 768: x - g^768 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xd40)))
                mstore(add(productsPtr, 0x9c0), partialProduct)
                mstore(add(valuesPtr, 0x9c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 832: x - g^832 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xd60)))
                mstore(add(productsPtr, 0x9e0), partialProduct)
                mstore(add(valuesPtr, 0x9e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 896: x - g^896 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xd80)))
                mstore(add(productsPtr, 0xa00), partialProduct)
                mstore(add(valuesPtr, 0xa00), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 960: x - g^960 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xda0)))
                mstore(add(productsPtr, 0xa20), partialProduct)
                mstore(add(valuesPtr, 0xa20), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1024: x - g^1024 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xdc0)))
                mstore(add(productsPtr, 0xa40), partialProduct)
                mstore(add(valuesPtr, 0xa40), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1050: x - g^1050 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xde0)))
                mstore(add(productsPtr, 0xa60), partialProduct)
                mstore(add(valuesPtr, 0xa60), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1051: x - g^1051 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xe00)))
                mstore(add(productsPtr, 0xa80), partialProduct)
                mstore(add(valuesPtr, 0xa80), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1056: x - g^1056 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xe20)))
                mstore(add(productsPtr, 0xaa0), partialProduct)
                mstore(add(valuesPtr, 0xaa0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1088: x - g^1088 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xe40)))
                mstore(add(productsPtr, 0xac0), partialProduct)
                mstore(add(valuesPtr, 0xac0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1152: x - g^1152 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xe60)))
                mstore(add(productsPtr, 0xae0), partialProduct)
                mstore(add(valuesPtr, 0xae0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1216: x - g^1216 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xe80)))
                mstore(add(productsPtr, 0xb00), partialProduct)
                mstore(add(valuesPtr, 0xb00), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1280: x - g^1280 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xea0)))
                mstore(add(productsPtr, 0xb20), partialProduct)
                mstore(add(valuesPtr, 0xb20), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1344: x - g^1344 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xec0)))
                mstore(add(productsPtr, 0xb40), partialProduct)
                mstore(add(valuesPtr, 0xb40), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1408: x - g^1408 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xee0)))
                mstore(add(productsPtr, 0xb60), partialProduct)
                mstore(add(valuesPtr, 0xb60), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1472: x - g^1472 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xf00)))
                mstore(add(productsPtr, 0xb80), partialProduct)
                mstore(add(valuesPtr, 0xb80), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1536: x - g^1536 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xf20)))
                mstore(add(productsPtr, 0xba0), partialProduct)
                mstore(add(valuesPtr, 0xba0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1600: x - g^1600 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xf40)))
                mstore(add(productsPtr, 0xbc0), partialProduct)
                mstore(add(valuesPtr, 0xbc0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1664: x - g^1664 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xf60)))
                mstore(add(productsPtr, 0xbe0), partialProduct)
                mstore(add(valuesPtr, 0xbe0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1728: x - g^1728 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xf80)))
                mstore(add(productsPtr, 0xc00), partialProduct)
                mstore(add(valuesPtr, 0xc00), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1792: x - g^1792 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xfa0)))
                mstore(add(productsPtr, 0xc20), partialProduct)
                mstore(add(valuesPtr, 0xc20), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1856: x - g^1856 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xfc0)))
                mstore(add(productsPtr, 0xc40), partialProduct)
                mstore(add(valuesPtr, 0xc40), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1920: x - g^1920 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0xfe0)))
                mstore(add(productsPtr, 0xc60), partialProduct)
                mstore(add(valuesPtr, 0xc60), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 1984: x - g^1984 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1000)))
                mstore(add(productsPtr, 0xc80), partialProduct)
                mstore(add(valuesPtr, 0xc80), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 2048: x - g^2048 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1020)))
                mstore(add(productsPtr, 0xca0), partialProduct)
                mstore(add(valuesPtr, 0xca0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 2074: x - g^2074 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1040)))
                mstore(add(productsPtr, 0xcc0), partialProduct)
                mstore(add(valuesPtr, 0xcc0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 2075: x - g^2075 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1060)))
                mstore(add(productsPtr, 0xce0), partialProduct)
                mstore(add(valuesPtr, 0xce0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 2080: x - g^2080 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1080)))
                mstore(add(productsPtr, 0xd00), partialProduct)
                mstore(add(valuesPtr, 0xd00), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 2112: x - g^2112 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x10a0)))
                mstore(add(productsPtr, 0xd20), partialProduct)
                mstore(add(valuesPtr, 0xd20), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 2176: x - g^2176 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x10c0)))
                mstore(add(productsPtr, 0xd40), partialProduct)
                mstore(add(valuesPtr, 0xd40), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 2240: x - g^2240 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x10e0)))
                mstore(add(productsPtr, 0xd60), partialProduct)
                mstore(add(valuesPtr, 0xd60), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 2304: x - g^2304 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1100)))
                mstore(add(productsPtr, 0xd80), partialProduct)
                mstore(add(valuesPtr, 0xd80), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 2368: x - g^2368 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1120)))
                mstore(add(productsPtr, 0xda0), partialProduct)
                mstore(add(valuesPtr, 0xda0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 2432: x - g^2432 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1140)))
                mstore(add(productsPtr, 0xdc0), partialProduct)
                mstore(add(valuesPtr, 0xdc0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 2496: x - g^2496 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1160)))
                mstore(add(productsPtr, 0xde0), partialProduct)
                mstore(add(valuesPtr, 0xde0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 2560: x - g^2560 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1180)))
                mstore(add(productsPtr, 0xe00), partialProduct)
                mstore(add(valuesPtr, 0xe00), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 2586: x - g^2586 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x11a0)))
                mstore(add(productsPtr, 0xe20), partialProduct)
                mstore(add(valuesPtr, 0xe20), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 2587: x - g^2587 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x11c0)))
                mstore(add(productsPtr, 0xe40), partialProduct)
                mstore(add(valuesPtr, 0xe40), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 2624: x - g^2624 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x11e0)))
                mstore(add(productsPtr, 0xe60), partialProduct)
                mstore(add(valuesPtr, 0xe60), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 2688: x - g^2688 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1200)))
                mstore(add(productsPtr, 0xe80), partialProduct)
                mstore(add(valuesPtr, 0xe80), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 2752: x - g^2752 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1220)))
                mstore(add(productsPtr, 0xea0), partialProduct)
                mstore(add(valuesPtr, 0xea0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 2816: x - g^2816 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1240)))
                mstore(add(productsPtr, 0xec0), partialProduct)
                mstore(add(valuesPtr, 0xec0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 2880: x - g^2880 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1260)))
                mstore(add(productsPtr, 0xee0), partialProduct)
                mstore(add(valuesPtr, 0xee0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 2944: x - g^2944 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1280)))
                mstore(add(productsPtr, 0xf00), partialProduct)
                mstore(add(valuesPtr, 0xf00), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 3008: x - g^3008 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x12a0)))
                mstore(add(productsPtr, 0xf20), partialProduct)
                mstore(add(valuesPtr, 0xf20), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 3072: x - g^3072 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x12c0)))
                mstore(add(productsPtr, 0xf40), partialProduct)
                mstore(add(valuesPtr, 0xf40), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 3098: x - g^3098 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x12e0)))
                mstore(add(productsPtr, 0xf60), partialProduct)
                mstore(add(valuesPtr, 0xf60), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 3099: x - g^3099 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1300)))
                mstore(add(productsPtr, 0xf80), partialProduct)
                mstore(add(valuesPtr, 0xf80), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 3104: x - g^3104 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1320)))
                mstore(add(productsPtr, 0xfa0), partialProduct)
                mstore(add(valuesPtr, 0xfa0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 3136: x - g^3136 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1340)))
                mstore(add(productsPtr, 0xfc0), partialProduct)
                mstore(add(valuesPtr, 0xfc0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 3200: x - g^3200 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1360)))
                mstore(add(productsPtr, 0xfe0), partialProduct)
                mstore(add(valuesPtr, 0xfe0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 3264: x - g^3264 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1380)))
                mstore(add(productsPtr, 0x1000), partialProduct)
                mstore(add(valuesPtr, 0x1000), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 3328: x - g^3328 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x13a0)))
                mstore(add(productsPtr, 0x1020), partialProduct)
                mstore(add(valuesPtr, 0x1020), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 3392: x - g^3392 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x13c0)))
                mstore(add(productsPtr, 0x1040), partialProduct)
                mstore(add(valuesPtr, 0x1040), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 3456: x - g^3456 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x13e0)))
                mstore(add(productsPtr, 0x1060), partialProduct)
                mstore(add(valuesPtr, 0x1060), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 3520: x - g^3520 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1400)))
                mstore(add(productsPtr, 0x1080), partialProduct)
                mstore(add(valuesPtr, 0x1080), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 3584: x - g^3584 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1420)))
                mstore(add(productsPtr, 0x10a0), partialProduct)
                mstore(add(valuesPtr, 0x10a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 3648: x - g^3648 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1440)))
                mstore(add(productsPtr, 0x10c0), partialProduct)
                mstore(add(valuesPtr, 0x10c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 3712: x - g^3712 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1460)))
                mstore(add(productsPtr, 0x10e0), partialProduct)
                mstore(add(valuesPtr, 0x10e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 3776: x - g^3776 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1480)))
                mstore(add(productsPtr, 0x1100), partialProduct)
                mstore(add(valuesPtr, 0x1100), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 3840: x - g^3840 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x14a0)))
                mstore(add(productsPtr, 0x1120), partialProduct)
                mstore(add(valuesPtr, 0x1120), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 3904: x - g^3904 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x14c0)))
                mstore(add(productsPtr, 0x1140), partialProduct)
                mstore(add(valuesPtr, 0x1140), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 3968: x - g^3968 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x14e0)))
                mstore(add(productsPtr, 0x1160), partialProduct)
                mstore(add(valuesPtr, 0x1160), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 4032: x - g^4032 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1500)))
                mstore(add(productsPtr, 0x1180), partialProduct)
                mstore(add(valuesPtr, 0x1180), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 4081: x - g^4081 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1520)))
                mstore(add(productsPtr, 0x11a0), partialProduct)
                mstore(add(valuesPtr, 0x11a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 4085: x - g^4085 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1540)))
                mstore(add(productsPtr, 0x11c0), partialProduct)
                mstore(add(valuesPtr, 0x11c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 4089: x - g^4089 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1560)))
                mstore(add(productsPtr, 0x11e0), partialProduct)
                mstore(add(valuesPtr, 0x11e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 4091: x - g^4091 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1580)))
                mstore(add(productsPtr, 0x1200), partialProduct)
                mstore(add(valuesPtr, 0x1200), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 4093: x - g^4093 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x15a0)))
                mstore(add(productsPtr, 0x1220), partialProduct)
                mstore(add(valuesPtr, 0x1220), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 4102: x - g^4102 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x15c0)))
                mstore(add(productsPtr, 0x1240), partialProduct)
                mstore(add(valuesPtr, 0x1240), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 4110: x - g^4110 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x15e0)))
                mstore(add(productsPtr, 0x1260), partialProduct)
                mstore(add(valuesPtr, 0x1260), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 4122: x - g^4122 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1600)))
                mstore(add(productsPtr, 0x1280), partialProduct)
                mstore(add(valuesPtr, 0x1280), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 4123: x - g^4123 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1620)))
                mstore(add(productsPtr, 0x12a0), partialProduct)
                mstore(add(valuesPtr, 0x12a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 4634: x - g^4634 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1640)))
                mstore(add(productsPtr, 0x12c0), partialProduct)
                mstore(add(valuesPtr, 0x12c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 5146: x - g^5146 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1660)))
                mstore(add(productsPtr, 0x12e0), partialProduct)
                mstore(add(valuesPtr, 0x12e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 6170: x - g^6170 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1680)))
                mstore(add(productsPtr, 0x1300), partialProduct)
                mstore(add(valuesPtr, 0x1300), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 6682: x - g^6682 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x16a0)))
                mstore(add(productsPtr, 0x1320), partialProduct)
                mstore(add(valuesPtr, 0x1320), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 7194: x - g^7194 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x16c0)))
                mstore(add(productsPtr, 0x1340), partialProduct)
                mstore(add(valuesPtr, 0x1340), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 8160: x - g^8160 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x16e0)))
                mstore(add(productsPtr, 0x1360), partialProduct)
                mstore(add(valuesPtr, 0x1360), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 8167: x - g^8167 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1700)))
                mstore(add(productsPtr, 0x1380), partialProduct)
                mstore(add(valuesPtr, 0x1380), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 8175: x - g^8175 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1720)))
                mstore(add(productsPtr, 0x13a0), partialProduct)
                mstore(add(valuesPtr, 0x13a0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 8177: x - g^8177 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1740)))
                mstore(add(productsPtr, 0x13c0), partialProduct)
                mstore(add(valuesPtr, 0x13c0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 8181: x - g^8181 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1760)))
                mstore(add(productsPtr, 0x13e0), partialProduct)
                mstore(add(valuesPtr, 0x13e0), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 8183: x - g^8183 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x1780)))
                mstore(add(productsPtr, 0x1400), partialProduct)
                mstore(add(valuesPtr, 0x1400), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 8185: x - g^8185 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x17a0)))
                mstore(add(productsPtr, 0x1420), partialProduct)
                mstore(add(valuesPtr, 0x1420), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 8189: x - g^8189 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x17c0)))
                mstore(add(productsPtr, 0x1440), partialProduct)
                mstore(add(valuesPtr, 0x1440), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate denominator for row 8218: x - g^8218 * z.
                let denominator := add(shiftedEvalPoint, mload(add(expmodsAndPoints, 0x17e0)))
                mstore(add(productsPtr, 0x1460), partialProduct)
                mstore(add(valuesPtr, 0x1460), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                {
                // Calculate the denominator for the composition polynomial columns: x - z^2.
                let denominator := add(shiftedEvalPoint, minusPointPow)
                mstore(add(productsPtr, 0x1480), partialProduct)
                mstore(add(valuesPtr, 0x1480), denominator)
                partialProduct := mulmod(partialProduct, denominator, PRIME)
                }

                // Add evalPoint to batch inverse inputs.
                // inverse(evalPoint) is going to be used by FRI.
                mstore(add(productsPtr, 0x14a0), partialProduct)
                mstore(add(valuesPtr, 0x14a0), evalPoint)
                partialProduct := mulmod(partialProduct, evalPoint, PRIME)

                // Advance pointers.
                productsPtr := add(productsPtr, 0x14c0)
                valuesPtr := add(valuesPtr, 0x14c0)
            }

            let productsToValuesOffset := 0x3e400
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
