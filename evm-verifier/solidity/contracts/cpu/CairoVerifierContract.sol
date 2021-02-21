// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.11;

interface CairoVerifierContract {
    function verifyProofExternal(
        uint256[] calldata proofParams, uint256[] calldata proof, uint256[] calldata publicInput)
        external;
}
