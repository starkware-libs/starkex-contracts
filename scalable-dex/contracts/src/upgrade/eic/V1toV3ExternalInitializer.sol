// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.11;

import "../StorageSlots.sol";
import "../../interfaces/ExternalInitializer.sol";
import "../../interfaces/Identity.sol";
import "../../libraries/Common.sol";
import "../../libraries/LibConstants.sol";
import "../../starkex/components/StarkExStorage.sol";

/*
  This contract is an external initializing contract that performs required adjustments for upgrade
  to V3 on a system that is with an old (V1) Proxy.

  Actions taken:
  1. Replace verifier adapter & committee address.
  2. Set onchain data version.
  3. Store MessageRegistry address.
  4. Set upgrade delay value.
*/
contract V1toV3ExternalInitializer is
    ExternalInitializer,
    StarkExStorage,
    StorageSlots,
    LibConstants
{
    using Addresses for address;
    uint256 constant ENTRY_NOT_FOUND = uint256(~0);
    uint256 constant MAX_DELAY = 28 days;

    function initialize(bytes calldata data) external override {
        require(data.length == 288, "INCORRECT_INIT_DATA_SIZE_288");
        (
            address newVerifierAddress,
            bytes32 verifierIdHash,
            address newAvailabilityVerifierAddress,
            bytes32 availabilityVerifierIdHash,
            uint256 newOnchainDataVersion,
            bool newVaultBalancePolicy,
            address newOrderRegistryAddress,
            bytes32 messageRegistryIdHash,
            uint256 delayInSeconds
        ) = abi.decode(
                data,
                (address, bytes32, address, bytes32, uint256, bool, address, bytes32, uint256)
            );

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
        setActivationDelay(delayInSeconds);
        emit LogExternalInitialize(data);
    }

    function setActivationDelay(uint256 delayInSeconds) private {
        require(delayInSeconds <= MAX_DELAY, "DELAY_TOO_LONG");

        bytes32 slot = UPGRADE_DELAY_SLOT;
        assembly {
            sstore(slot, delayInSeconds)
        }
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
