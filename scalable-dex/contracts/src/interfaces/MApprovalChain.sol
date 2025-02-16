pragma solidity ^0.5.2;

import "../components/MainStorage.sol";

/*
  Implements a data structure that supports instant registration
  and slow time-locked removal of entries.
*/
contract MApprovalChain is MainStorage {
    uint256 constant ENTRY_NOT_FOUND = uint256(~0);

    /*
      Adds the given verifier (entry) to the chain.
      Fails if the size of the chain is already >= maxLength.
      Fails if identifier is not identical to the value returned from entry.identify().
    */
    function addEntry(
        ApprovalChainData storage chain, address entry, uint256 maxLength, string memory identifier)
        internal;

    /*
      Returns the index of the verifier in the list if it exists and returns ENTRY_NOT_FOUND
      otherwise.
    */
    function findEntry(address[] storage list, address entry)
        internal view returns (uint256);

    /*
      Same as findEntry(), except that it reverts if the verifier is not found.
    */
    function safeFindEntry(address[] storage list, address entry)
        internal view returns (uint256 idx);

    /*
      Updates the unlockedForRemovalTime field of the given verifier to
        current time + removalDelay.
      Reverts if the verifier is not found.
    */
    function announceRemovalIntent(
        ApprovalChainData storage chain, address entry, uint256 removalDelay)
        internal;

    /*
      Removes a verifier assuming the expected time has passed.
    */
    function removeEntry(ApprovalChainData storage chain, address entry)
        internal;

    /*
      Verifies a given fact on all existing verifiers.
      Reverts if the fact is not accepted by one or more verifiers.
    */
    function verifyFact(
        ApprovalChainData storage chain, bytes32 fact, string memory noVerifiersErrorMessage,
        string memory invalidFactErrorMessage)
        internal view;
}
