// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.11;

import "../../interfaces/ExternalInitializer.sol";
import "../../interfaces/Identity.sol";
import "../../libraries/Common.sol";
import "../../libraries/LibConstants.sol";
import "../../starkex/components/StarkExStorage.sol";

/*
  This contract is an external initializing contract that performs required adjustments for V2->V3
  ugrade:
  1. Replace verifier adapter & committee address.
  2. Set onchain data version.
  3. Store MessageRegistry address.
*/
contract V2toV3ChangesExternalInitializer is ExternalInitializer, StarkExStorage, LibConstants {
    using Addresses for address;
    uint256 constant ENTRY_NOT_FOUND = uint256(~0);

    function initialize(bytes calldata data) external override {
        require(data.length == 256, "INCORRECT_INIT_DATA_SIZE_256");
        (
            address newVerifierAddress,
            bytes32 verifierIdHash,
            address newAvailabilityVerifierAddress,
            bytes32 availabilityVerifierIdHash,
            uint256 newOnchainDataVersion,
            bool newVaultBalancePolicy,
            address newOrderRegistryAddress,
            bytes32 messageRegistryIdHash
        ) = abi.decode(data, (address, bytes32, address, bytes32, uint256, bool, address, bytes32));

        // Flush the current verifiers & availabilityVerifier list.
        delete verifiersChain.list;
        delete availabilityVerifiersChain.list;

        // ApprovalChain addEntry performs all the required checks for us.
        addEntry(verifiersChain, newVerifierAddress, MAX_VERIFIER_COUNT, verifierIdHash);
        addEntry(
            availabilityVerifiersChain,
            newAvailabilityVerifierAddress,
            MAX_VERIFIER_COUNT,
            availabilityVerifierIdHash
        );

        onchainDataVersion = newOnchainDataVersion;
        strictVaultBalancePolicy = newVaultBalancePolicy;
        orderRegistryAddress = newOrderRegistryAddress;
        newOrderRegistryAddress.validateContractId(messageRegistryIdHash);
        emit LogExternalInitialize(data);
    }

    /*
      The two functions below are taken from ApprovalChain.sol, with minor changes:
      1. No governance needed (we are under the context where proxy governance is granted).
      2. The verifier ID is passed as hash, and not as string.
    */
    function addEntry(
        StarkExTypes.ApprovalChainData storage chain,
        address entry,
        uint256 maxLength,
        bytes32 hashExpectedId
    ) internal {
        address[] storage list = chain.list;
        require(entry.isContract(), "ADDRESS_NOT_CONTRACT");
        bytes32 hashRealId = keccak256(abi.encodePacked(Identity(entry).identify()));
        require(hashRealId == hashExpectedId, "UNEXPECTED_CONTRACT_IDENTIFIER");
        require(list.length < maxLength, "CHAIN_AT_MAX_CAPACITY");
        require(findEntry(list, entry) == ENTRY_NOT_FOUND, "ENTRY_ALREADY_EXISTS");
        chain.list.push(entry); // NOLINT controlled-array-length;
        chain.unlockedForRemovalTime[entry] = 0;
    }

    function findEntry(address[] storage list, address entry) internal view returns (uint256) {
        uint256 n_entries = list.length;
        for (uint256 i = 0; i < n_entries; i++) {
            if (list[i] == entry) {
                return i;
            }
        }
        return ENTRY_NOT_FOUND;
    }
}
