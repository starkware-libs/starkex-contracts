// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

abstract contract IStarkVerifier {
    function verifyProof(
        uint256[] memory proofParams,
        uint256[] memory proof,
        uint256[] memory publicInput
    ) internal view virtual;
}
