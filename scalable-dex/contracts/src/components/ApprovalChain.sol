// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

import "./MainStorage.sol";
import "../interfaces/IFactRegistry.sol";
import "../interfaces/IQueryableFactRegistry.sol";
import "../interfaces/Identity.sol";
import "../interfaces/MApprovalChain.sol";
import "../interfaces/MFreezable.sol";
import "../interfaces/MGovernance.sol";
import "../libraries/Addresses.sol";
import {ApprovalChainData} from "../libraries/StarkExTypes.sol";

/*
  Implements a data structure that supports instant registration
  and slow time-locked removal of entries.
*/
abstract contract ApprovalChain is MainStorage, MApprovalChain, MGovernance, MFreezable {
    using Addresses for address;

    event LogRemovalIntent(address entry, string entryId);
    event LogRegistered(address entry, string entryId);
    event LogRemoved(address entry, string entryId);

    function addEntry(
        ApprovalChainData storage chain,
        address entry,
        uint256 maxLength,
        string memory identifier
    ) internal override onlyGovernance notFrozen {
        address[] storage verifiers = chain.verifiers;
        require(entry.isContract(), "ADDRESS_NOT_CONTRACT");
        bytes32 hash_real = keccak256(abi.encodePacked(Identity(entry).identify()));
        bytes32 hash_identifier = keccak256(abi.encodePacked(identifier));
        require(hash_real == hash_identifier, "UNEXPECTED_CONTRACT_IDENTIFIER");
        require(verifiers.length < maxLength, "CHAIN_AT_MAX_CAPACITY");
        require(findEntry(verifiers, entry) == ENTRY_NOT_FOUND, "ENTRY_ALREADY_EXISTS");

        // Verifier must have at least one fact registered before adding to chain,
        // unless it's the first verifier in the chain.
        require(
            verifiers.length == 0 || IQueryableFactRegistry(entry).hasRegisteredFact(),
            "ENTRY_NOT_ENABLED"
        );
        chain.verifiers.push(entry);
        emit LogRegistered(entry, identifier);
    }

    function findEntry(address[] storage verifiers, address entry)
        internal
        view
        override
        returns (uint256)
    {
        uint256 n_entries = verifiers.length;
        for (uint256 i = 0; i < n_entries; i++) {
            if (verifiers[i] == entry) {
                return i;
            }
        }

        return ENTRY_NOT_FOUND;
    }

    function safeFindEntry(address[] storage verifiers, address entry)
        internal
        view
        override
        returns (uint256 idx)
    {
        idx = findEntry(verifiers, entry);

        require(idx != ENTRY_NOT_FOUND, "ENTRY_DOES_NOT_EXIST");
    }

    function announceRemovalIntent(
        ApprovalChainData storage chain,
        address entry,
        uint256 removalDelay
    ) internal override onlyGovernance notFrozen {
        safeFindEntry(chain.verifiers, entry);
        require(block.timestamp + removalDelay > block.timestamp, "INVALID_REMOVAL_DELAY");
        require(chain.verifierAllowedRemovalTime[entry] == 0, "ALREADY_ANNOUNCED");

        chain.verifierAllowedRemovalTime[entry] = block.timestamp + removalDelay;
        emit LogRemovalIntent(entry, Identity(entry).identify());
    }

    function removeEntry(ApprovalChainData storage chain, address entry)
        internal
        override
        onlyGovernance
        notFrozen
    {
        address[] storage verifiers = chain.verifiers;
        // Make sure entry exists.
        uint256 idx = safeFindEntry(verifiers, entry);
        uint256 verifierAllowedRemovalTime = chain.verifierAllowedRemovalTime[entry];

        require(verifierAllowedRemovalTime > 0, "REMOVAL_NOT_ANNOUNCED");
        require(block.timestamp >= verifierAllowedRemovalTime, "REMOVAL_NOT_ENABLED_YET");

        uint256 n_entries = verifiers.length;

        // Removal of last entry is forbidden.
        require(n_entries > 1, "LAST_ENTRY_MAY_NOT_BE_REMOVED");

        if (idx != n_entries - 1) {
            verifiers[idx] = verifiers[n_entries - 1];
        }
        verifiers.pop();
        delete chain.verifierAllowedRemovalTime[entry];
        emit LogRemoved(entry, Identity(entry).identify());
    }
}
