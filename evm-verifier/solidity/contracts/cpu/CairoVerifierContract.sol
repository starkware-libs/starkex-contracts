// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

abstract contract CairoVerifierContract {
    function verifyProofExternal(
        uint256[] calldata proofParams,
        uint256[] calldata proof,
        uint256[] calldata publicInput
    ) external virtual;

    /*
      Returns information that is related to the layout.

      publicMemoryOffset is the offset of the public memory pages' information in the public input.
      selectedBuiltins is a bit-map of builtins that are present in the layout.
    */
    function getLayoutInfo()
        external
        pure
        virtual
        returns (uint256 publicMemoryOffset, uint256 selectedBuiltins);

    uint256 internal constant OUTPUT_BUILTIN_BIT = 0;
    uint256 internal constant PEDERSEN_BUILTIN_BIT = 1;
    uint256 internal constant RANGE_CHECK_BUILTIN_BIT = 2;
    uint256 internal constant ECDSA_BUILTIN_BIT = 3;
    uint256 internal constant BITWISE_BUILTIN_BIT = 4;
    uint256 internal constant EC_OP_BUILTIN_BIT = 5;
    uint256 internal constant KECCAK_BUILTIN_BIT = 6;
    uint256 internal constant POSEIDON_BUILTIN_BIT = 7;
}
