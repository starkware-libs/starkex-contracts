// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.11;

abstract contract IMerkleVerifier {
    uint256 internal constant MAX_N_MERKLE_VERIFIER_QUERIES = 128;

    function verifyMerkle(
        uint256 channelPtr,
        uint256 queuePtr,
        bytes32 root,
        uint256 n
    ) internal view virtual returns (bytes32 hash);
}
