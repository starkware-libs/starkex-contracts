pragma solidity ^0.5.2;

import "../interfaces/IFactRegistry.sol";
import "../interfaces/IQueryableFactRegistry.sol";
import "../interfaces/Identity.sol";
import "../interfaces/MApprovalChain.sol";
import "../interfaces/MFreezable.sol";
import "../interfaces/MGovernance.sol";
import "./MainStorage.sol";

/*
  Implements a data structure that supports instant registration
  and slow time-locked removal of entries.
*/
contract ApprovalChain is MainStorage, MApprovalChain, MGovernance, MFreezable {

    function addEntry(
        ApprovalChainData storage chain, address entry, uint256 maxLength, string memory identifier)
        internal
        onlyGovernance()
        notFrozen()
    {
        address[] storage list = chain.list;
        bytes32 hash_real = keccak256(abi.encodePacked(Identity(entry).identify()));
        bytes32 hash_identifier = keccak256(abi.encodePacked(identifier));
        require(hash_real == hash_identifier, "UNEXPECTED_CONTRACT_IDENTIFIER");
        require(list.length < maxLength, "CHAIN_AT_MAX_CAPACITY");
        require(findEntry(list, entry) == ENTRY_NOT_FOUND, "ENTRY_ALREADY_EXISTS");

        // Verifier must have at least one fact registered before adding to chain,
        // unless it's the first verifier in te chain.
        require(
            list.length == 0 || IQueryableFactRegistry(entry).hasRegisteredFact(),
            "ENTRY_NOT_ENABLED");
        chain.list.push(entry);
        chain.unlockedForRemovalTime[entry] = 0;
    }

    function findEntry(address[] storage list, address entry)
        internal view returns (uint256)
    {
        uint256 n_entries = list.length;
        for (uint256 i = 0; i < n_entries; i++) {
            if (list[i] == entry) {
                return i;
            }
        }

        return ENTRY_NOT_FOUND;
    }


    function safeFindEntry(address[] storage list, address entry)
        internal view returns (uint256 idx)
    {
        idx = findEntry(list, entry);

        require(idx != ENTRY_NOT_FOUND, "ENTRY_DOES_NOT_EXIST");
    }

    function announceRemovalIntent(
        ApprovalChainData storage chain, address entry, uint256 removalDelay)
        internal
        onlyGovernance()
        notFrozen()
    {
        safeFindEntry(chain.list, entry);
        require(now + removalDelay > now, "INVALID_REMOVAL_DELAY");
        // solium-disable-next-line security/no-block-members
        chain.unlockedForRemovalTime[entry] = now + removalDelay;
    }


    function removeEntry(ApprovalChainData storage chain, address entry)
        internal
        onlyGovernance()
        notFrozen()
    {
        address[] storage list = chain.list;
        // Make sure entry exists.
        uint256 idx = safeFindEntry(list, entry);
        uint256 unlockedForRemovalTime = chain.unlockedForRemovalTime[entry];

        // solium-disable-next-line security/no-block-members
        require(unlockedForRemovalTime > 0, "REMOVAL_NOT_ANNOUNCED");
        // solium-disable-next-line security/no-block-members
        require(now >= unlockedForRemovalTime, "REMOVAL_NOT_ENABLED_YET");

        uint256 n_entries = list.length;

        // Removal of last entry is forbidden.
        require(n_entries > 1, "LAST_ENTRY_MAY_NOT_BE_REMOVED");

        if (idx != n_entries - 1) {
            list[idx] = list[n_entries - 1];
        }
        list.pop();
    }

    function verifyFact(
        ApprovalChainData storage chain, bytes32 fact, string memory noVerifiersErrorMessage,
        string memory invalidFactErrorMessage)
        internal view
    {
        address[] storage list = chain.list;
        uint256 n_entries = list.length;
        require(n_entries > 0, noVerifiersErrorMessage);
        for (uint256 i = 0; i < n_entries; i++) {
            require(IFactRegistry(list[i]).isValid(fact), invalidFactErrorMessage);
        }
    }
}
