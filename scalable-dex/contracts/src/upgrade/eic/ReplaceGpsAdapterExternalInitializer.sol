// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

import "../../interfaces/ExternalInitializer.sol";
import "../../interfaces/Identity.sol";
import "../../components/MainStorage.sol";
import "../../libraries/Addresses.sol";
import "../../libraries/StarkExTypes.sol";
import "../../libraries/LibConstants.sol";

/*
  This contract is a simple implementation of an external initializing contract
  that removes all existing gps verifier adapters and replace them with the one provided in params.
*/
contract ReplaceGpsAdapterExternalInitializer is ExternalInitializer, MainStorage, LibConstants {
    using Addresses for address;
    uint256 constant ENTRY_NOT_FOUND = uint256(~0);

    /*
      The initiatialize function gets two parameters in the bytes array:
      1. New verifier adapter address,
      2. Keccak256 of the expected verifier adapter id.
    */
    function initialize(bytes calldata data) public virtual override {
        require(data.length == 64, "UNEXPECTED_DATA_SIZE");
        address newGpsAdapterAddress;
        bytes32 gpsAdapterIdHash;

        // Extract sub-contract address and hash of verifierId.
        (newGpsAdapterAddress, gpsAdapterIdHash) = abi.decode(data, (address, bytes32));

        // Flush the entire verifiers list.
        delete verifiersChain.verifiers;

        // ApprovalChain addEntry performs all the required checks for us.
        addEntry(verifiersChain, newGpsAdapterAddress, MAX_VERIFIER_COUNT, gpsAdapterIdHash);

        emit LogExternalInitialize(data);
    }

    /*
      The functions below are taken from ApprovalChain.sol, with minor changes:
      1. No governance needed (we are under the context where proxy governance is granted).
      2. The verifier ID is passed as hash, and not as string.
    */
    function addEntry(
        ApprovalChainData storage chain,
        address entry,
        uint256 maxLength,
        bytes32 hashExpectedId
    ) internal {
        address[] storage verifiers = chain.verifiers;
        require(entry.isContract(), "ADDRESS_NOT_CONTRACT");
        bytes32 hashRealId = keccak256(abi.encodePacked(Identity(entry).identify()));
        require(hashRealId == hashExpectedId, "UNEXPECTED_CONTRACT_IDENTIFIER");
        require(verifiers.length < maxLength, "CHAIN_AT_MAX_CAPACITY");
        require(findEntry(verifiers, entry) == ENTRY_NOT_FOUND, "ENTRY_ALREADY_EXISTS");
        chain.verifiers.push(entry); // NOLINT controlled-array-length;
        chain.verifierAllowedRemovalTime[entry] = 0;
    }

    function findEntry(address[] storage verifiers, address entry) internal view returns (uint256) {
        uint256 n_entries = verifiers.length;
        for (uint256 i = 0; i < n_entries; i++) {
            if (verifiers[i] == entry) {
                return i;
            }
        }
        return ENTRY_NOT_FOUND;
    }
}
