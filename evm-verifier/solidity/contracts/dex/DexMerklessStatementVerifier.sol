pragma solidity ^0.5.2;

import "./DexStatementVerifier.sol";
import "../MerkleStatementVerifier.sol";

contract DexMerklessStatementVerifier is DexStatementVerifier, MerkleStatementVerifier {

    constructor(address[] memory auxPolynomials, address oodsContract,
        address merkleStatementContractAddress,
        uint256 numSecurityBits_, uint256 minProofOfWorkBits_) public
        DexStatementVerifier(auxPolynomials, oodsContract, numSecurityBits_, minProofOfWorkBits_)
        MerkleStatementVerifier(merkleStatementContractAddress) {
        // solium-disable-previous-line no-empty-blocks
    }
}
