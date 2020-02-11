pragma solidity ^0.5.2;

import "./StarkVerifier.sol";
import "./StarkParameters.sol";
import "./PublicInputOffsets.sol";
import "./DexConstraintPoly.sol";

contract PeriodicColumnContract {
    function compute(uint256 x) external pure returns(uint256 result);
}

contract DexVerifier is StarkParameters, StarkVerifier, PublicInputOffsets {
    DexConstraintPoly constraintPoly;
    PeriodicColumnContract hashPointsX;
    PeriodicColumnContract hashPointsY;
    PeriodicColumnContract ecdsaPointsX;
    PeriodicColumnContract ecdsaPointsY;

    constructor(
        address[] memory auxPolynomials,
        address oodsContract,
        uint256 numSecurityBits_,
        uint256 minProofOfWorkBits_)
        StarkVerifier(
            numSecurityBits_,
            minProofOfWorkBits_
        )
        public {
        constraintPoly = DexConstraintPoly(auxPolynomials[0]);
        hashPointsX = PeriodicColumnContract(auxPolynomials[1]);
        hashPointsY = PeriodicColumnContract(auxPolynomials[2]);
        ecdsaPointsX = PeriodicColumnContract(auxPolynomials[3]);
        ecdsaPointsY = PeriodicColumnContract(auxPolynomials[4]);
        oodsContractAddress = oodsContract;
    }

    function getNColumnsInTrace() internal pure returns(uint256) {
        return N_COLUMNS_IN_MASK;
    }

    function getNColumnsInComposition() internal pure returns(uint256) {
        return CONSTRAINTS_DEGREE_BOUND;
    }

    function getMmCoefficients() internal pure returns(uint256) {
        return MM_COEFFICIENTS;
    }

    function getMmOodsValues() internal pure returns(uint256) {
        return MM_OODS_VALUES;
    }

    function getMmOodsCoefficients() internal pure returns(uint256) {
        return MM_OODS_COEFFICIENTS;
    }

    function getNCoefficients() internal pure returns(uint256) {
        return N_COEFFICIENTS;
    }

    function getNOodsValues() internal pure returns(uint256) {
        return N_OODS_VALUES;
    }

    function getNOodsCoefficients() internal pure returns(uint256) {
        return N_OODS_COEFFICIENTS;
    }

    function getModificationRow(uint256[] memory publicInput, uint256 modificationId)
        internal pure returns (uint256) {
        return (
            publicInput[OFFSET_MODIFICATION_DATA + N_WORDS_PER_MODIFICATION *
            modificationId + 2] >> 80) & ((1 << 16) - 1);
    }

    function airSpecificInit(uint256[] memory publicInput)
        internal returns (uint256[] memory ctx, uint256 logTraceLength)
    {
        ctx = new uint256[](MM_CONTEXT_SIZE);

        require(
            publicInput.length >= OFFSET_MODIFICATION_DATA,
            "Missing public input parameters.");

        uint256 logBatchSize = publicInput[OFFSET_LOG_BATCH_SIZE];
        require(logBatchSize < 15, "Only support up to 16K transactions per proof");
        uint256 batchSize = 2**logBatchSize;
        publicInput[OFFSET_LOG_BATCH_SIZE] = batchSize;

        {
        // Check validity of global timestamp value.
        uint256 globalExpirationTimestamp = publicInput[OFFSET_GLOBAL_EXPIRATION_TIMESTAMP];
        require(
            0 <= globalExpirationTimestamp && globalExpirationTimestamp <
            2**EXPIRATION_TIMESTAMP_RANGE_CHECK_BITS,
            "Global expiration timestamp is out of range.");
        ctx[MM_GLOBAL_EXPIRATION_TIMESTAMP_ELM] = globalExpirationTimestamp;

        // Make sure globalExpirationTimestamp > timestamp of the current block.
        require(
            // solium-disable-next-line security/no-block-members
            globalExpirationTimestamp > now / 3600,
            "Timestamp of the current block passed the threshold for the transaction batch.");
        }

        uint256 nTransactions = publicInput[OFFSET_N_TRANSACTIONS];
        require(
            0 < nTransactions && nTransactions <= batchSize,
            "nTransaction should be between 1 and batchSize.");

        require(
            (publicInput.length - OFFSET_MODIFICATION_DATA) % N_WORDS_PER_MODIFICATION == 0,
            "Invalid public input length.");
        uint256 nModifications = (
            (publicInput.length - OFFSET_MODIFICATION_DATA) / N_WORDS_PER_MODIFICATION
        );
        require(
            getModificationRow(publicInput, nModifications - 1) < nTransactions,
            "There is a Modification after the final transaction in the batch.");
        ctx[MM_N_TRANSACTIONS] = nTransactions;
        require(nModifications <= nTransactions, "More modifications than nTransactions.");
        ctx[MM_N_MODIFICATIONS] = nModifications;
        ctx[MM_N_SETTLEMENTS] = batchSize - nModifications;

        uint256 initialVaultsRoot = publicInput[OFFSET_VAULT_INITIAL_ROOT];
        require(initialVaultsRoot < K_MODULUS, "Invalid initial vaults root");
        ctx[MM_INITIAL_VAULTS_ROOT] = initialVaultsRoot;
        uint256 finalVaultsRoot = publicInput[OFFSET_VAULT_FINAL_ROOT];
        require(finalVaultsRoot < K_MODULUS, "Invalid final vaults root");
        ctx[MM_FINAL_VAULTS_ROOT] = finalVaultsRoot;
        uint256 vaultsPathLength = publicInput[OFFSET_VAULT_TREE_HEIGHT];
        require(
            vaultsPathLength > 0 && vaultsPathLength < VAULTS_PATH_HEIGHT,
            "Vaults path length is wrong");
        ctx[MM_VAULTS_PATH_LENGTH] = vaultsPathLength;

        uint256 initialSettlementRoot = publicInput[OFFSET_ORDER_INITIAL_ROOT];
        require(initialSettlementRoot < K_MODULUS, "Invalid initial settlement root");
        ctx[MM_INITIAL_SETTLEMENT_ROOT] = initialSettlementRoot;
        uint256 finalSettlementRoot = publicInput[OFFSET_ORDER_FINAL_ROOT];
        require(finalSettlementRoot < K_MODULUS, "Invalid final settlement root");
        ctx[MM_FINAL_SETTLEMENT_ROOT] = finalSettlementRoot;
        uint256 settlementPathLength = publicInput[OFFSET_ORDER_TREE_HEIGHT];
        require(
            settlementPathLength == SETTLEMENT_PATH_LENGTH,
            "Settlement path length is wrong");

        uint256 lmmPublicInputPtr = MM_PUBLIC_INPUT_PTR;
        assembly {
            // Set public input pointer to point at the first word of the public input
            // (skipping length word).
            mstore(add(ctx, mul(add(lmmPublicInputPtr, 1), 0x20)), add(publicInput, 0x20))
        }

        // shiftPoint.x
        ctx[MM_SHIFT_POINT_X] = 0x49ee3eba8c1600700ee1b87eb599f16716b0b1022947733551fde4050ca6804;
        // shiftPoint.y
        ctx[MM_SHIFT_POINT_Y] = 0x3ca0cfe4b3bc6ddf346d49d06ea0ed34e621062c0e056c1d0405d266e10268a;

        ctx[MM_SIG_CONFIG_ALPHA] = 1;
        ctx[MM_SIG_CONFIG_BETA] = 0x6f21413efbe40de150e596d72f7a8c5609ad26c15c915c1f4cdfcb99cee9e89;

        ctx[MM_VAULT_SHIFT] = 2**(VAULTS_PATH_HEIGHT-1);
        ctx[MM_AMOUNT_SHIFT] = 2**RANGE_CHECK_BITS; // 2**kRangeCheckBits
        ctx[MM_NONCE_SHIFT] = 2**NONCE_RANGE_CHECK_BITS;
        ctx[MM_EXPIRATION_TIMESTAMP_SHIFT] = 2**EXPIRATION_TIMESTAMP_RANGE_CHECK_BITS;

        logTraceLength = (
            logBatchSize +
            1 /* maker and taker */ +
            1 /* token A and token B */ +
            5 /* Merkle tree depth */ +
            8 /* num steps per hash */ +
            1 /* two to one hash per step */
        );
    }

    function getPublicInputHash(uint256[] memory publicInput)
        internal pure
        returns (bytes32 publicInputHash) {
        uint256 publicInputLength = publicInput.length;

        assembly {
            let length := mul(publicInputLength, 0x20)
            publicInputHash := keccak256(add(publicInput, 0x20), length)
        }
    }

    /*
      Computes the value of the boundary periodic columns at the given point.

      Modification action format:
        prevAmount (64b) + newAmount (64b) + vaultId (32b) + row (16b) + reserved (80b).
    */
    function computeBoundaryPeriodicColumn(
        uint256 modificationsPtr, uint256 nModifications, uint256 nTransactions, uint256 point,
        uint256 prime, uint256 gen, uint256 resultArrayPtr)
        internal view {
        require(nTransactions < 0x1000000, "Overflow protection failed.");
        require(nModifications <= nTransactions, "nModifications > nTransactions.");
        bool sorted = true;
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

            let lastOffset := mul(nModifications, 0x20)

            // pointMinusXValues = freePtr;
            let pointMinusXValues := mload(0x40)
            let cumulativeProduct := add(pointMinusXValues, lastOffset)

            // Bump free pointer as it is used in expmod.
            mstore(0x40, add(cumulativeProduct, lastOffset))

            {
            // Initialize prevRow to (nTransactions + 1) to avoid special casing the first row.
                let prevRow := nTransactions
                let prod := 1
                // Skip first 2 words of first update.
                let rowsPtr := add(modificationsPtr, 0x40)
                for { let offset := lastOffset } gt(offset, 0) { } {
                    offset := sub(offset, 0x20)

                    mstore(add(cumulativeProduct, offset), prod)

                    // Extract the row represented by the 16 bits at offset 95:80 in the word.
                    let currentRow := and(div(mload(add(rowsPtr,
                                                      mul(offset, /*itemsPerUpdate*/ 3))),
                                               0x100000000000000000000),
                                           0xFFFF)

                    // We go over the rows in reverse order so we expect them to be
                    // strictly decreasing (!(currentRow < prevRow) <=> currentRow >= prevRow).
                    if iszero(lt(currentRow, prevRow)) {
                        // If currentRow >= prevRow the rows are not sorted.
                        // Set sorted to False.
                        sorted := 0
                    }
                    prevRow := currentRow

                    let pointMinusXValue := add(point, sub(prime, expmod(gen, currentRow, prime)))
                    mstore(add(pointMinusXValues, offset), pointMinusXValue)

                    prod := mulmod(prod, pointMinusXValue, prime)
                }

                mstore(add(resultArrayPtr, 0x40), prod)
                let prodInv := expmod(prod, sub(prime, 2), prime)
                let numerator := sub(expmod(point, nTransactions, prime), 1)
                mstore(add(resultArrayPtr, 0x20), mulmod(numerator, prodInv, prime))
            }

            let boundaryBase := 0
            let values := modificationsPtr
            let prod := 1
            for { let offset := 0 } lt(offset, lastOffset) { offset := add(offset, 0x20) } {
                let pointMinusXValue := mload(add(pointMinusXValues, offset))
                let othersProd := mulmod(prod, mload(add(cumulativeProduct, offset)), prime)
                boundaryBase := addmod(boundaryBase, othersProd, prime)
                let modificationAction := mload(add(values, 0x40))
                // Handle key.
                mstore(add(resultArrayPtr, 0x60), addmod(
                    mload(add(resultArrayPtr, 0x60)),
                    mulmod(othersProd, mload(values), prime),
                    prime))
                // Handle token.
                mstore(add(resultArrayPtr, 0x80), addmod(
                    mload(add(resultArrayPtr, 0x80)),
                    mulmod(othersProd, mload(add(values, 0x20)), prime),
                    prime))
                // Handle prevAmount.
                mstore(add(resultArrayPtr, 0xa0), addmod(
                    mload(add(resultArrayPtr, 0xa0)),
                    mulmod(othersProd,
                // Extract the prev amount represented by the 63 bits at offset 254:192 in the word.
                           and(div(modificationAction,
                                   0x1000000000000000000000000000000000000000000000000),
                               0x7FFFFFFFFFFFFFFF),
                           prime),
                    prime))
                // Handle newAmount.
                mstore(add(resultArrayPtr, 0xc0), addmod(
                    mload(add(resultArrayPtr, 0xc0)),
                    mulmod(othersProd,
                // Extract the new amount represented by the 63 bits at offset 190:128 in the word.
                           and(div(modificationAction,
                                   0x100000000000000000000000000000000),
                               0x7FFFFFFFFFFFFFFF),
                           prime),
                    prime))
                // Handle vaultId.
                mstore(add(resultArrayPtr, 0xe0), addmod(
                    mload(add(resultArrayPtr, 0xe0)),
                    mulmod(othersProd,
                // Extract the vaultId represented by the 31 bits at offset 126:96 in the word.
                           and(div(mload(add(values, 0x40)),
                                   0x1000000000000000000000000),
                               0x7FFFFFFF),
                           prime),
                    prime))
                prod := mulmod(prod, pointMinusXValue, prime)

                // Skip 8 values: 7 x update items + 1 x row number encoded in 3 words.
                values := add(values, /*(3*0x20)*/ 0x60)
            }

            mstore(resultArrayPtr, boundaryBase)
            // Deallocate pointMinusXValues and cumulativeProduct, and restore freePtr.
            mstore(0x40, pointMinusXValues)
        }

        require(
            sorted,
            "The list of rows is not sorted or not unique or row is greater than nTransactions."
        );
    }

    function getNTransactions(uint256[] memory ctx)
        internal pure returns (uint256 nTransactions) {
        uint256 publicInputPtr = ctx[MM_PUBLIC_INPUT_PTR];
        assembly {
            nTransactions := /*nTransactions*/ mload(publicInputPtr)
        }
    }

    /*
      Checks that the trace and the composition agree on the Out of Domain Sampling point,
      assuming the prover provided us with the proper evaluations.

      Later, we use boundary constraints to check that those evaluations
      are actually consistent with the committed trace and composition polynomials.
    */
    function oodsConsistencyCheck(uint256[] memory ctx)
    internal {
        uint256 oodsPoint = ctx[MM_OODS_POINT];
        uint256 subGroupGenerator = fpow(
            ctx[MM_TRACE_GENERATOR], ctx[MM_TRACE_LENGTH] / getNTransactions(ctx));

        computeBoundaryPeriodicColumn(
            ctx[MM_PUBLIC_INPUT_PTR] + 0x20 * OFFSET_MODIFICATION_DATA, ctx[MM_N_MODIFICATIONS],
            getNTransactions(ctx), oodsPoint, K_MODULUS, subGroupGenerator,
            getPtr(ctx, MM_PERIODIC_COLUMN__BOUNDARY_BASE));

        // emit LogGas("Boundry periodic column", gasleft());

        // The ecdsaPoints columns have 256 values and a step of ECDSA_POINTS_STEP
        // => nCopies = traceLength / (256 * ECDSA_POINTS_STEP).
        uint256 zPointPow = fpow(oodsPoint, ctx[MM_TRACE_LENGTH] / (256 * ECDSA_POINTS_STEP));

        ctx[MM_PERIODIC_COLUMN__ECDSA_POINTS__X] = ecdsaPointsX.compute(zPointPow);
        ctx[MM_PERIODIC_COLUMN__ECDSA_POINTS__Y] = ecdsaPointsY.compute(zPointPow);

        // The hashPoolPoints columns have 512 values with a step of PERIODIC_HASH_POOL_STEP
        // => nCopies = traceLength / (512 * PERIODIC_HASH_POOL_STEP).
        zPointPow = fpow(oodsPoint, ctx[MM_TRACE_LENGTH] / (512 * PERIODIC_HASH_POOL_STEP));

        ctx[MM_PERIODIC_COLUMN__HASH_POOL_POINTS__X] = hashPointsX.compute(zPointPow);
        ctx[MM_PERIODIC_COLUMN__HASH_POOL_POINTS__Y] = hashPointsY.compute(zPointPow);

        // The vaultsMerkleHashPoints columns have 512 values
        // and a step of VAULTS_PERIODIC_MERKLE_HASH_STEP
        // => nCopies = traceLength / (512 * VAULTS_PERIODIC_MERKLE_HASH_STEP).
        zPointPow = (
            fpow(oodsPoint, ctx[MM_TRACE_LENGTH] / (512 * VAULTS_PERIODIC_MERKLE_HASH_STEP))
        );
        ctx[MM_PERIODIC_COLUMN__VAULTS_MERKLE_HASH_POINTS__X] = hashPointsX.compute(zPointPow);
        ctx[MM_PERIODIC_COLUMN__VAULTS_MERKLE_HASH_POINTS__Y] = hashPointsY.compute(zPointPow);

        // The settlmentMerkleHashPoints columns have 512 values
        // and a step of SETTLEMENT_PERIODIC_MERKLE_HASH_STEP
        // => nCopies = trace_length / (512 * SETTLEMENT_PERIODIC_MERKLE_HASH_STEP).
        zPointPow = (
            fpow(oodsPoint, ctx[MM_TRACE_LENGTH] / (512 * SETTLEMENT_PERIODIC_MERKLE_HASH_STEP))
        );
        ctx[MM_PERIODIC_COLUMN__SETTLEMENT_MERKLE_HASH_POINTS__X] = (
            hashPointsX.compute(zPointPow)
        );
        ctx[MM_PERIODIC_COLUMN__SETTLEMENT_MERKLE_HASH_POINTS__Y] = (
            hashPointsY.compute(zPointPow)
        );

        // emit LogGas("Other periodic columns", gasleft());

        // emit log_debug(oods_point);
        // emit log_debug(ctx[mm_periodic_column__hash_pool_points__x]);
        // emit log_debug(ctx[mm_periodic_column__hash_pool_points__y]);
        // emit log_debug(ctx[mm_periodic_column__vaults_merkle_hash_points__x]);
        // emit log_debug(ctx[mm_periodic_column__vaults_merkle_hash_points__y]);
        // emit log_debug(ctx[mm_periodic_column__boundary_base]);
        // emit log_debug(ctx[mm_periodic_column__is_modification]);
        // emit log_debug(ctx[mm_periodic_column__is_settlement]);
        // emit log_debug(ctx[mm_periodic_column__boundary_key]);
        // emit log_debug(ctx[mm_periodic_column__boundary_token]);
        // emit log_debug(ctx[mm_periodic_column__boundary_amount0]);
        // emit log_debug(ctx[mm_periodic_column__boundary_amount1]);
        // emit log_debug(ctx[mm_periodic_column__boundary_vault_id]);
        // emit log_debug(ctx[mm_periodic_column__settlement_merkle_hash_points__x]);
        // emit log_debug(ctx[mm_periodic_column__settlement_merkle_hash_points__y]);
        // emit log_debug(ctx[mm_periodic_column__ecdsa_points__x]);
        // emit log_debug(ctx[mm_periodic_column__ecdsa_points__y]);

        uint256 compositionFromTraceValue;
        address lconstraintPoly = address(constraintPoly);
        uint256 offset = 0x20 * (1 + MM_CONSTRAINT_POLY_ARGS_START);
        uint256 size = 0x20 * (MM_CONSTRAINT_POLY_ARGS_END - MM_CONSTRAINT_POLY_ARGS_START);
        assembly {
            // Call DexConstraintPoly contract.
            let p := mload(0x40)
            if iszero(staticcall(not(0), lconstraintPoly, add(ctx, offset), size, p, 0x20)) {
                returndatacopy(0, 0, returndatasize)
                revert(0, returndatasize)
            }
            compositionFromTraceValue := mload(p)
        }

        uint256 claimedComposition = fadd(
            ctx[MM_OODS_VALUES + MASK_SIZE],
            fmul(oodsPoint, ctx[MM_OODS_VALUES + MASK_SIZE + 1]));

        require(
            compositionFromTraceValue == claimedComposition,
            "claimedComposition does not match trace");
    }
}
