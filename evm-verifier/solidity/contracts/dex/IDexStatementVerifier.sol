pragma solidity ^0.5.2;


contract IDexStatementVerifier {

    function verifyProofAndRegister(
        uint256[] calldata proofParams,
        uint256[] calldata proof,
        uint256[] calldata publicInput
    )
        external;

    function isValid(bytes32 fact)
        external view
        returns(bool);
}
