// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

import "./MerkleStatementContract.sol";

abstract contract MerkleStatementVerifier is IMerkleVerifier {
    MerkleStatementContract merkleStatementContract;

    constructor(address merkleStatementContractAddress) public {
        merkleStatementContract = MerkleStatementContract(merkleStatementContractAddress);
    }

    // Computes the hash of the Merkle statement, and verifies that it is registered in the
    // Merkle Fact Registry. Receives as input the queuePtr (as address), its length
    // the numbers of queries n, and the root. The channelPtr is is ignored.
    function verifyMerkle(
        uint256, /*channelPtr*/
        uint256 queuePtr,
        bytes32 root,
        uint256 n
    ) internal view virtual override returns (bytes32) {
        bytes32 statement;
        require(n <= MAX_N_MERKLE_VERIFIER_QUERIES, "TOO_MANY_MERKLE_QUERIES");

        assembly {
            let dataToHashPtrStart := mload(0x40) // freePtr.
            let dataToHashPtrCur := dataToHashPtrStart

            let queEndPtr := add(queuePtr, mul(n, 0x40))

            for {

            } lt(queuePtr, queEndPtr) {

            } {
                mstore(dataToHashPtrCur, mload(queuePtr))
                dataToHashPtrCur := add(dataToHashPtrCur, 0x20)
                queuePtr := add(queuePtr, 0x20)
            }

            mstore(dataToHashPtrCur, root)
            dataToHashPtrCur := add(dataToHashPtrCur, 0x20)
            mstore(0x40, dataToHashPtrCur)

            statement := keccak256(dataToHashPtrStart, sub(dataToHashPtrCur, dataToHashPtrStart))
        }
        require(merkleStatementContract.isValid(statement), "INVALIDATED_MERKLE_STATEMENT");
        return root;
    }
}
