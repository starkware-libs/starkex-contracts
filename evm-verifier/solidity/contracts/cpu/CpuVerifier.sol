// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

import "../CairoVerifierContract.sol";
import "../MemoryPageFactRegistry.sol";
import "./CpuConstraintPoly.sol";
import "./LayoutSpecific.sol";
import "./StarkVerifier.sol";

/*
  Verifies a Cairo statement: there exists a memory assignment and a valid corresponding program
  trace satisfying the public memory requirements, for which if a program starts at pc=INITIAL_PC,
  it runs successfully and ends with pc=FINAL_PC.

  This contract verifies that:
  * Initial pc is INITIAL_PC and final pc is FINAL_PC.
  * The memory assignment satisfies the given public memory requirements.
  * The 16-bit range-checks are properly configured (0 <= rc_min <= rc_max < 2^16).
  * The segments for the builtins do not exceed their maximum length (thus
    when these builtins are properly used in the program, they will function correctly).
  * The layout is valid.

  This contract DOES NOT (those should be verified outside of this contract):
  * verify that the requested program is loaded, starting from INITIAL_PC.
  * verify that the arguments and return values for main() are properly set (e.g., the segment
    pointers).
  * check anything on the program output.
  * verify that [initial_fp - 2] = initial_fp, which is required to guarantee the "safe call"
    feature (that is, all "call" instructions will return, even if the called function is
    malicious). It guarantees that it's not possible to create a cycle in the call stack.
*/
contract CpuVerifier is StarkVerifier, MemoryPageFactRegistryConstants, LayoutSpecific {
    CpuConstraintPoly constraintPoly;
    IFactRegistry memoryPageFactRegistry;

    constructor(
        address[] memory auxPolynomials,
        address oodsContract,
        address memoryPageFactRegistry_,
        uint256 numSecurityBits_,
        uint256 minProofOfWorkBits_
    ) public StarkVerifier(numSecurityBits_, minProofOfWorkBits_, oodsContract) {
        constraintPoly = CpuConstraintPoly(auxPolynomials[0]);
        initPeriodicColumns(auxPolynomials);
        memoryPageFactRegistry = IFactRegistry(memoryPageFactRegistry_);
    }

    function verifyProofExternal(
        uint256[] calldata proofParams,
        uint256[] calldata proof,
        uint256[] calldata publicInput
    ) external override {
        verifyProof(proofParams, proof, publicInput);
    }

    function getNColumnsInTrace() internal pure override returns (uint256) {
        return N_COLUMNS_IN_MASK;
    }

    function getNColumnsInTrace0() internal pure override returns (uint256) {
        return N_COLUMNS_IN_TRACE0;
    }

    function getNColumnsInTrace1() internal pure override returns (uint256) {
        return N_COLUMNS_IN_TRACE1;
    }

    function getNColumnsInComposition() internal pure override returns (uint256) {
        return CONSTRAINTS_DEGREE_BOUND;
    }

    function getMmInteractionElements() internal pure override returns (uint256) {
        return MM_INTERACTION_ELEMENTS;
    }

    function getMmCoefficients() internal pure override returns (uint256) {
        return MM_COEFFICIENTS;
    }

    function getMmOodsValues() internal pure override returns (uint256) {
        return MM_OODS_VALUES;
    }

    function getMmOodsCoefficients() internal pure override returns (uint256) {
        return MM_OODS_COEFFICIENTS;
    }

    function getNInteractionElements() internal pure override returns (uint256) {
        return N_INTERACTION_ELEMENTS;
    }

    function getNCoefficients() internal pure override returns (uint256) {
        return N_COEFFICIENTS;
    }

    function getNOodsValues() internal pure override returns (uint256) {
        return N_OODS_VALUES;
    }

    function getNOodsCoefficients() internal pure override returns (uint256) {
        return N_OODS_COEFFICIENTS;
    }

    function airSpecificInit(uint256[] memory publicInput)
        internal
        view
        override
        returns (uint256[] memory ctx, uint256 logTraceLength)
    {
        require(publicInput.length >= OFFSET_PUBLIC_MEMORY, "publicInput is too short.");
        ctx = new uint256[](MM_CONTEXT_SIZE);

        // Context for generated code.
        ctx[MM_OFFSET_SIZE] = 2**16;
        ctx[MM_HALF_OFFSET_SIZE] = 2**15;

        // Number of steps.
        uint256 logNSteps = publicInput[OFFSET_LOG_N_STEPS];
        require(logNSteps < 50, "Number of steps is too large.");
        ctx[MM_LOG_N_STEPS] = logNSteps;
        logTraceLength = logNSteps + LOG_CPU_COMPONENT_HEIGHT;

        // Range check limits.
        ctx[MM_RC_MIN] = publicInput[OFFSET_RC_MIN];
        ctx[MM_RC_MAX] = publicInput[OFFSET_RC_MAX];
        require(ctx[MM_RC_MIN] <= ctx[MM_RC_MAX], "rc_min must be <= rc_max");
        require(ctx[MM_RC_MAX] < ctx[MM_OFFSET_SIZE], "rc_max out of range");

        // Layout.
        require(publicInput[OFFSET_LAYOUT_CODE] == LAYOUT_CODE, "Layout code mismatch.");

        // Initial and final pc ("program" memory segment).
        ctx[MM_INITIAL_PC] = publicInput[OFFSET_PROGRAM_BEGIN_ADDR];
        ctx[MM_FINAL_PC] = publicInput[OFFSET_PROGRAM_STOP_PTR];
        // Invalid final pc may indicate that the program end was moved, or the program didn't
        // complete.
        require(ctx[MM_INITIAL_PC] == INITIAL_PC, "Invalid initial pc");
        require(ctx[MM_FINAL_PC] == FINAL_PC, "Invalid final pc");

        // Initial and final ap ("execution" memory segment).
        ctx[MM_INITIAL_AP] = publicInput[OFFSET_EXECUTION_BEGIN_ADDR];
        ctx[MM_FINAL_AP] = publicInput[OFFSET_EXECUTION_STOP_PTR];

        // Public memory.
        require(
            publicInput[OFFSET_N_PUBLIC_MEMORY_PAGES] >= 1 &&
                publicInput[OFFSET_N_PUBLIC_MEMORY_PAGES] < 100000,
            "Invalid number of memory pages."
        );
        ctx[MM_N_PUBLIC_MEM_PAGES] = publicInput[OFFSET_N_PUBLIC_MEMORY_PAGES];

        {
            // Compute the total number of public memory entries.
            uint256 n_public_memory_entries = 0;
            for (uint256 page = 0; page < ctx[MM_N_PUBLIC_MEM_PAGES]; page++) {
                uint256 n_page_entries = publicInput[getOffsetPageSize(page)];
                require(n_page_entries < 2**30, "Too many public memory entries in one page.");
                n_public_memory_entries += n_page_entries;
            }
            ctx[MM_N_PUBLIC_MEM_ENTRIES] = n_public_memory_entries;
        }

        uint256 expectedPublicInputLength = getPublicInputLength(ctx[MM_N_PUBLIC_MEM_PAGES]);
        require(expectedPublicInputLength == publicInput.length, "Public input length mismatch.");

        uint256 lmmPublicInputPtr = MM_PUBLIC_INPUT_PTR;
        assembly {
            // Set public input pointer to point at the first word of the public input
            // (skipping length word).
            mstore(add(ctx, mul(add(lmmPublicInputPtr, 1), 0x20)), add(publicInput, 0x20))
        }

        layoutSpecificInit(ctx, publicInput);
    }

    function getPublicInputHash(uint256[] memory publicInput)
        internal
        pure
        override
        returns (bytes32 publicInputHash)
    {
        // The initial seed consists of the first part of publicInput. Specifically, it does not
        // include the page products (which are only known later in the process, as they depend on
        // the values of z and alpha).
        uint256 nPages = publicInput[OFFSET_N_PUBLIC_MEMORY_PAGES];
        uint256 publicInputSizeForHash = 0x20 * getOffsetPageProd(0, nPages);

        assembly {
            publicInputHash := keccak256(add(publicInput, 0x20), publicInputSizeForHash)
        }
    }

    /*
      Computes the value of the public memory quotient:
        numerator / (denominator * padding)
      where:
        numerator = (z - (0 + alpha * 0))^S,
        denominator = \prod_i( z - (addr_i + alpha * value_i) ),
        padding = (z - (padding_addr + alpha * padding_value))^(S - N),
        N is the actual number of public memory cells,
        and S is the number of cells allocated for the public memory (which includes the padding).
    */
    function computePublicMemoryQuotient(uint256[] memory ctx) internal view returns (uint256) {
        uint256 nValues = ctx[MM_N_PUBLIC_MEM_ENTRIES];
        uint256 z = ctx[MM_MEMORY__MULTI_COLUMN_PERM__PERM__INTERACTION_ELM];
        uint256 alpha = ctx[MM_MEMORY__MULTI_COLUMN_PERM__HASH_INTERACTION_ELM0];
        // The size that is allocated to the public memory.
        uint256 publicMemorySize = safeDiv(ctx[MM_TRACE_LENGTH], PUBLIC_MEMORY_STEP);

        require(nValues < 0x1000000, "Overflow protection failed.");
        require(nValues <= publicMemorySize, "Number of values of public memory is too large.");

        uint256 nPublicMemoryPages = ctx[MM_N_PUBLIC_MEM_PAGES];
        uint256 cumulativeProdsPtr = ctx[MM_PUBLIC_INPUT_PTR] +
            getOffsetPageProd(0, nPublicMemoryPages) *
            0x20;
        uint256 denominator = computePublicMemoryProd(
            cumulativeProdsPtr,
            nPublicMemoryPages,
            K_MODULUS
        );

        // Compute address + alpha * value for the first address-value pair for padding.
        uint256 publicInputPtr = ctx[MM_PUBLIC_INPUT_PTR];
        uint256 paddingAddr;
        uint256 paddingValue;
        assembly {
            paddingAddr := mload(add(publicInputPtr, mul(0x20, OFFSET_PUBLIC_MEMORY_PADDING_ADDR)))
            paddingValue := mload(
                add(publicInputPtr, mul(0x20, add(OFFSET_PUBLIC_MEMORY_PADDING_ADDR, 1)))
            )
        }
        uint256 hash_first_address_value = fadd(paddingAddr, fmul(paddingValue, alpha));

        // Pad the denominator with the shifted value of hash_first_address_value.
        uint256 denom_pad = fpow(fsub(z, hash_first_address_value), publicMemorySize - nValues);
        denominator = fmul(denominator, denom_pad);

        // Calculate the numerator.
        uint256 numerator = fpow(z, publicMemorySize);

        // Compute the final result: numerator * denominator^(-1).
        return fmul(numerator, inverse(denominator));
    }

    /*
      Computes the cumulative product of the public memory cells:
        \prod_i( z - (addr_i + alpha * value_i) ).

      publicMemoryPtr is an array of nValues pairs (address, value).
      z and alpha are the perm and hash interaction elements required to calculate the product.
    */
    function computePublicMemoryProd(
        uint256 cumulativeProdsPtr,
        uint256 nPublicMemoryPages,
        uint256 prime
    ) internal pure returns (uint256 res) {
        assembly {
            let lastPtr := add(cumulativeProdsPtr, mul(nPublicMemoryPages, 0x20))
            res := 1
            for {
                let ptr := cumulativeProdsPtr
            } lt(ptr, lastPtr) {
                ptr := add(ptr, 0x20)
            } {
                res := mulmod(res, mload(ptr), prime)
            }
        }
    }

    /*
      Verifies that all the information on each public memory page (size, hash, prod, and possibly
      address) is consistent with z and alpha, by checking that the corresponding facts were
      registered on memoryPageFactRegistry.
    */
    function verifyMemoryPageFacts(uint256[] memory ctx) internal view {
        uint256 nPublicMemoryPages = ctx[MM_N_PUBLIC_MEM_PAGES];

        for (uint256 page = 0; page < nPublicMemoryPages; page++) {
            // Fetch page values from the public input (hash, product and size).
            uint256 memoryHashPtr = ctx[MM_PUBLIC_INPUT_PTR] + getOffsetPageHash(page) * 0x20;
            uint256 memoryHash;

            uint256 prodPtr = ctx[MM_PUBLIC_INPUT_PTR] +
                getOffsetPageProd(page, nPublicMemoryPages) *
                0x20;
            uint256 prod;

            uint256 pageSizePtr = ctx[MM_PUBLIC_INPUT_PTR] + getOffsetPageSize(page) * 0x20;
            uint256 pageSize;

            assembly {
                pageSize := mload(pageSizePtr)
                prod := mload(prodPtr)
                memoryHash := mload(memoryHashPtr)
            }

            uint256 pageAddr = 0;
            if (page > 0) {
                uint256 pageAddrPtr = ctx[MM_PUBLIC_INPUT_PTR] + getOffsetPageAddr(page) * 0x20;
                assembly {
                    pageAddr := mload(pageAddrPtr)
                }
            }

            // Verify that a corresponding fact is registered attesting to the consistency of the page
            // information with z and alpha.
            bytes32 factHash = keccak256(
                abi.encodePacked(
                    page == 0 ? REGULAR_PAGE : CONTINUOUS_PAGE,
                    K_MODULUS,
                    pageSize,
                    /*z=*/
                    ctx[MM_INTERACTION_ELEMENTS],
                    /*alpha=*/
                    ctx[MM_INTERACTION_ELEMENTS + 1],
                    prod,
                    memoryHash,
                    pageAddr
                )
            );

            require( // NOLINT: calls-loop.
                memoryPageFactRegistry.isValid(factHash),
                "Memory page fact was not registered."
            );
        }
    }

    /*
      Checks that the trace and the compostion agree at oodsPoint, assuming the prover provided us
      with the proper evaluations.

      Later, we will use boundery constraints to check that those evaluations are actully consistent
      with the commited trace and composition ploynomials.
    */
    function oodsConsistencyCheck(uint256[] memory ctx) internal view override {
        verifyMemoryPageFacts(ctx);
        ctx[MM_MEMORY__MULTI_COLUMN_PERM__PERM__INTERACTION_ELM] = ctx[MM_INTERACTION_ELEMENTS];
        ctx[MM_MEMORY__MULTI_COLUMN_PERM__HASH_INTERACTION_ELM0] = ctx[MM_INTERACTION_ELEMENTS + 1];
        ctx[MM_RC16__PERM__INTERACTION_ELM] = ctx[MM_INTERACTION_ELEMENTS + 2];
        {
            uint256 public_memory_prod = computePublicMemoryQuotient(ctx);
            ctx[MM_MEMORY__MULTI_COLUMN_PERM__PERM__PUBLIC_MEMORY_PROD] = public_memory_prod;
        }
        prepareForOodsCheck(ctx);

        uint256 compositionFromTraceValue;
        address lconstraintPoly = address(constraintPoly);
        uint256 offset = 0x20 * (1 + MM_CONSTRAINT_POLY_ARGS_START);
        uint256 size = 0x20 * (MM_CONSTRAINT_POLY_ARGS_END - MM_CONSTRAINT_POLY_ARGS_START);
        assembly {
            // Call CpuConstraintPoly contract.
            let p := mload(0x40)
            if iszero(staticcall(not(0), lconstraintPoly, add(ctx, offset), size, p, 0x20)) {
                returndatacopy(0, 0, returndatasize())
                revert(0, returndatasize())
            }
            compositionFromTraceValue := mload(p)
        }

        uint256 claimedComposition = fadd(
            ctx[MM_OODS_VALUES + MASK_SIZE],
            fmul(ctx[MM_OODS_POINT], ctx[MM_OODS_VALUES + MASK_SIZE + 1])
        );

        require(
            compositionFromTraceValue == claimedComposition,
            "claimedComposition does not match trace"
        );
    }
}
