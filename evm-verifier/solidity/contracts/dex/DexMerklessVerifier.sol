pragma solidity ^0.5.2;

import "./DexVerifier.sol";
import "../MerkleStatementVerifier.sol";

contract DexMerklessVerifier is DexVerifier, MerkleStatementVerifier {

    constructor(address[] memory auxPolynomials, address oodsContract,
        address merkleStatementContractAddress,
        uint256 numSecurityBits_, uint256 minProofOfWorkBits_) public
        MerkleStatementVerifier(merkleStatementContractAddress)
        DexVerifier(auxPolynomials, oodsContract, numSecurityBits_, minProofOfWorkBits_) {
        // solium-disable-previous-line no-empty-blocks
    }
}
