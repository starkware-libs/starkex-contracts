pragma solidity ^0.5.2;

contract IStarkVerifier {

    function verifyProof(
        uint256[] calldata proofParams,
        uint256[] calldata proof,
        uint256[] calldata publicInput
    )
        external;
}
