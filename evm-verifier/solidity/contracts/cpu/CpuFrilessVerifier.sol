// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

import "./CpuVerifier.sol";
import "./FriStatementVerifier.sol";
import "../../MerkleStatementVerifier.sol";

contract CpuFrilessVerifier is CpuVerifier, MerkleStatementVerifier, FriStatementVerifier {
    constructor(
        address[] memory auxPolynomials,
        address oodsContract,
        address memoryPageFactRegistry_,
        address merkleStatementContractAddress,
        address friStatementContractAddress,
        uint256 numSecurityBits_,
        uint256 minProofOfWorkBits_
    )
        public
        MerkleStatementVerifier(merkleStatementContractAddress)
        FriStatementVerifier(friStatementContractAddress)
        CpuVerifier(
            auxPolynomials,
            oodsContract,
            memoryPageFactRegistry_,
            numSecurityBits_,
            minProofOfWorkBits_
        )
    {}

    function verifyMerkle(
        uint256 channelPtr,
        uint256 queuePtr,
        bytes32 root,
        uint256 n
    ) internal view override(MerkleStatementVerifier, MerkleVerifier) returns (bytes32) {
        return MerkleStatementVerifier.verifyMerkle(channelPtr, queuePtr, root, n);
    }

    function friVerifyLayers(uint256[] memory ctx)
        internal
        view
        override(FriStatementVerifier, Fri)
    {
        FriStatementVerifier.friVerifyLayers(ctx);
    }
}
