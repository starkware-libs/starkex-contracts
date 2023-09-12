// ---------- The following code was auto-generated. PLEASE DO NOT EDIT. ----------
// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

import "../../interfaces/IPeriodicColumn.sol";
import "./MemoryMap.sol";
import "./StarkParameters.sol";
import "./CpuPublicInputOffsets.sol";
import "../CairoVerifierContract.sol";

abstract contract LayoutSpecific is MemoryMap, StarkParameters, CpuPublicInputOffsets, CairoVerifierContract {
    IPeriodicColumn pedersenPointsX;
    IPeriodicColumn pedersenPointsY;
    IPeriodicColumn ecdsaPointsX;
    IPeriodicColumn ecdsaPointsY;

    function initPeriodicColumns(address[] memory auxPolynomials) internal {
        pedersenPointsX = IPeriodicColumn(auxPolynomials[1]);
        pedersenPointsY = IPeriodicColumn(auxPolynomials[2]);
        ecdsaPointsX = IPeriodicColumn(auxPolynomials[3]);
        ecdsaPointsY = IPeriodicColumn(auxPolynomials[4]);
    }

    function getLayoutInfo()
        external pure override returns (uint256 publicMemoryOffset, uint256 selectedBuiltins) {
        publicMemoryOffset = OFFSET_N_PUBLIC_MEMORY_PAGES;
        selectedBuiltins =
            (1 << OUTPUT_BUILTIN_BIT) |
            (1 << PEDERSEN_BUILTIN_BIT) |
            (1 << RANGE_CHECK_BUILTIN_BIT) |
            (1 << ECDSA_BUILTIN_BIT);
    }

    function safeDiv(uint256 numerator, uint256 denominator) internal pure returns (uint256) {
        require(denominator > 0, "The denominator must not be zero");
        require(numerator % denominator == 0, "The numerator is not divisible by the denominator.");
        return numerator / denominator;
    }

    function validateBuiltinPointers(
        uint256 initialAddress, uint256 stopAddress, uint256 builtinRatio, uint256 cellsPerInstance,
        uint256 nSteps, string memory builtinName)
        internal pure {
        require(
            initialAddress < 2**64,
            string(abi.encodePacked("Out of range ", builtinName, " begin_addr.")));
        uint256 maxStopPtr = initialAddress + cellsPerInstance * safeDiv(nSteps, builtinRatio);
        require(
            initialAddress <= stopAddress && stopAddress <= maxStopPtr,
            string(abi.encodePacked("Invalid ", builtinName, " stop_ptr.")));
    }

    function layoutSpecificInit(uint256[] memory ctx, uint256[] memory publicInput)
        internal pure {
        // "output" memory segment.
        uint256 outputBeginAddr = publicInput[OFFSET_OUTPUT_BEGIN_ADDR];
        uint256 outputStopPtr = publicInput[OFFSET_OUTPUT_STOP_PTR];
        require(outputBeginAddr <= outputStopPtr, "output begin_addr must be <= stop_ptr");
        require(outputStopPtr < 2**64, "Out of range output stop_ptr.");

        uint256 nSteps = 2 ** ctx[MM_LOG_N_STEPS];

        // "pedersen" memory segment.
        ctx[MM_INITIAL_PEDERSEN_ADDR] = publicInput[OFFSET_PEDERSEN_BEGIN_ADDR];
        validateBuiltinPointers(
            ctx[MM_INITIAL_PEDERSEN_ADDR], publicInput[OFFSET_PEDERSEN_STOP_PTR],
            PEDERSEN_BUILTIN_RATIO, 3, nSteps, 'pedersen');

        // Pedersen's shiftPoint values.
        ctx[MM_PEDERSEN__SHIFT_POINT_X] =
            0x49ee3eba8c1600700ee1b87eb599f16716b0b1022947733551fde4050ca6804;
        ctx[MM_PEDERSEN__SHIFT_POINT_Y] =
            0x3ca0cfe4b3bc6ddf346d49d06ea0ed34e621062c0e056c1d0405d266e10268a;

        // "range_check" memory segment.
        ctx[MM_INITIAL_RC_ADDR] = publicInput[OFFSET_RANGE_CHECK_BEGIN_ADDR];
        validateBuiltinPointers(
            ctx[MM_INITIAL_RC_ADDR], publicInput[OFFSET_RANGE_CHECK_STOP_PTR],
            RC_BUILTIN_RATIO, 1, nSteps, 'range_check');
        ctx[MM_RC16__PERM__PUBLIC_MEMORY_PROD] = 1;

        // "ecdsa" memory segment.
        ctx[MM_INITIAL_ECDSA_ADDR] = publicInput[OFFSET_ECDSA_BEGIN_ADDR];
        validateBuiltinPointers(
            ctx[MM_INITIAL_ECDSA_ADDR], publicInput[OFFSET_ECDSA_STOP_PTR],
            ECDSA_BUILTIN_RATIO, 2, nSteps, 'ecdsa');

        ctx[MM_ECDSA__SIG_CONFIG_ALPHA] = 1;
        ctx[MM_ECDSA__SIG_CONFIG_BETA] =
            0x6f21413efbe40de150e596d72f7a8c5609ad26c15c915c1f4cdfcb99cee9e89;
        ctx[MM_ECDSA__SIG_CONFIG_SHIFT_POINT_X] =
            0x49ee3eba8c1600700ee1b87eb599f16716b0b1022947733551fde4050ca6804;
        ctx[MM_ECDSA__SIG_CONFIG_SHIFT_POINT_Y] =
            0x3ca0cfe4b3bc6ddf346d49d06ea0ed34e621062c0e056c1d0405d266e10268a;
    }

    function prepareForOodsCheck(uint256[] memory ctx) internal view {
        uint256 oodsPoint = ctx[MM_OODS_POINT];
        uint256 nSteps = 2 ** ctx[MM_LOG_N_STEPS];

        // The number of copies in the pedersen hash periodic columns is
        // nSteps / PEDERSEN_BUILTIN_RATIO / PEDERSEN_BUILTIN_REPETITIONS.
        uint256 nPedersenHashCopies = safeDiv(
            nSteps,
            PEDERSEN_BUILTIN_RATIO * PEDERSEN_BUILTIN_REPETITIONS);
        uint256 zPointPowPedersen = fpow(oodsPoint, nPedersenHashCopies);
        ctx[MM_PERIODIC_COLUMN__PEDERSEN__POINTS__X] = pedersenPointsX.compute(zPointPowPedersen);
        ctx[MM_PERIODIC_COLUMN__PEDERSEN__POINTS__Y] = pedersenPointsY.compute(zPointPowPedersen);

        // The number of copies in the ECDSA signature periodic columns is
        // nSteps / ECDSA_BUILTIN_RATIO / ECDSA_BUILTIN_REPETITIONS.
        uint256 nEcdsaSignatureCopies = safeDiv(
            2 ** ctx[MM_LOG_N_STEPS],
            ECDSA_BUILTIN_RATIO * ECDSA_BUILTIN_REPETITIONS);
        uint256 zPointPowEcdsa = fpow(oodsPoint, nEcdsaSignatureCopies);

        ctx[MM_PERIODIC_COLUMN__ECDSA__GENERATOR_POINTS__X] = ecdsaPointsX.compute(zPointPowEcdsa);
        ctx[MM_PERIODIC_COLUMN__ECDSA__GENERATOR_POINTS__Y] = ecdsaPointsY.compute(zPointPowEcdsa);
    }
}
// ---------- End of auto-generated code. ----------
