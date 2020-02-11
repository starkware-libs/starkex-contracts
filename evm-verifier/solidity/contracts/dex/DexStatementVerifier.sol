pragma solidity ^0.5.2;

import "./DexVerifier.sol";
import "./IDexStatementVerifier.sol";
import "../FactRegistry.sol";
import "../interfaces/Identity.sol";

contract DexStatementVerifier is IDexStatementVerifier, DexVerifier, FactRegistry, Identity {

    // auxPolynomials contains constraintPolynomial and periodic columns.
    constructor(address[] memory auxPolynomials, address oodsContract,
        uint256 numSecurityBits_, uint256 minProofOfWorkBits_) public
        DexVerifier(auxPolynomials, oodsContract, numSecurityBits_, minProofOfWorkBits_) {
        // solium-disable-previous-line no-empty-blocks
    }

    function identify()
        external pure
        returns(string memory)
    {
        return "StarkWare_DexStatementVerifier_2019_1";
    }

    function verifyProofAndRegister(
        uint256[] calldata proofParams,
        uint256[] calldata proof,
        uint256[] calldata publicInput
    )
        external
    {
        verifyProof(proofParams, proof, publicInput);
        registerFact(keccak256(abi.encodePacked(publicInput)));
    }
}
