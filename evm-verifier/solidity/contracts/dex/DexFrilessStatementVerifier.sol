pragma solidity ^0.5.2;

import "./DexStatementVerifier.sol";
import "../MerkleStatementVerifier.sol";
import "./FriStatementVerifier.sol";

contract DexFrilessStatementVerifier is DexStatementVerifier,
    MerkleStatementVerifier, FriStatementVerifier {

    constructor(address[] memory auxPolynomials, address oodsContract,
        address merkleStatementContractAddress, address friStatementContractAddress,
        uint256 numSecurityBits_, uint256 minProofOfWorkBits_) public
        MerkleStatementVerifier(merkleStatementContractAddress)
        FriStatementVerifier(friStatementContractAddress)
        DexStatementVerifier(auxPolynomials, oodsContract, numSecurityBits_, minProofOfWorkBits_) {
        // solium-disable-previous-line no-empty-blocks
    }

    function identify()
        external pure
        returns(string memory)
    {
        return "StarkWare_DexFrilessStatementVerifier_2019_1";
    }

}
