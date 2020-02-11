pragma solidity ^0.5.2;

contract IAvailabilityVerifier {
    function verifyAvailabilityProof(
        uint256 newVaultRoot,
        uint256 heightVaultTree,
        uint256 sequenceNumber,
        bytes calldata opaqueAvailabilityProofs
    )
        external view;
}
