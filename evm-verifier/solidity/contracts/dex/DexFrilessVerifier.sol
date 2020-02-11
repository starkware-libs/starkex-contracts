pragma solidity ^0.5.2;

import "./DexVerifier.sol";
import "../MerkleStatementVerifier.sol";
import "./FriStatementVerifier.sol";

contract DexFrilessVerifier is DexVerifier, MerkleStatementVerifier, FriStatementVerifier {

    constructor(address[] memory auxPolynomials, address oodsContract,
        address merkleStatementContractAddress, address friStatementContractAddress,
        uint256 numSecurityBits_, uint256 minProofOfWorkBits_) public
        MerkleStatementVerifier(merkleStatementContractAddress)
        FriStatementVerifier(friStatementContractAddress)
        DexVerifier(auxPolynomials, oodsContract, numSecurityBits_, minProofOfWorkBits_) {
        // solium-disable-previous-line no-empty-blocks
    }
}
