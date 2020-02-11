pragma solidity ^0.5.2;

import "../interfaces/IFactRegistry.sol";
import "../upgrade/ProxyStorage.sol";

/*
  Holds ALL the main contract state (storage) variables.
*/
contract MainStorage is ProxyStorage {

    // Structure representing a list of verifiers (validity/availability).
    // A statement is valid only if all the verifiers in the list agree on it.
    // Adding a verifier to the list is immediate - this is used for fast resolution of
    // any soundness issues.
    // Removing from the list is time-locked, to ensure that any user of the system
    // not content with the announced removal has ample time to leave the system before it is
    // removed.
    struct ApprovalChainData {
        address[] list;
        // Represents the time after which the verifier with the given address can be removed.
        // Removal of the verifier with address A is allowed only in the case the value
        // of unlockedForRemovalTime[A] != 0 and unlockedForRemovalTime[A] < (current time).
        mapping (address => uint256) unlockedForRemovalTime;
    }

    IFactRegistry escapeVerifier_;

    // Global dex-frozen flag.
    bool stateFrozen;

    // Time when unFreeze can be successfully called (UNFREEZE_DELAY after freeze).
    uint256 unFreezeTime;

    // Pending deposits.
    // A map STARK key => token id => vault id => quantized amount.
    mapping (uint256 => mapping (uint256 => mapping (uint256 => uint256))) pendingDeposits;

    // Cancellation requests.
    // A map STARK key => token id => vault id => request timestamp.
    mapping (uint256 => mapping (uint256 => mapping (uint256 => uint256))) cancellationRequests;

    // Pending withdrawals.
    // A map STARK key => token id => quantized amount.
    mapping (uint256 => mapping (uint256 => uint256)) pendingWithdrawals;

    // vault_id => escape used boolean.
    mapping (uint256 => bool) escapesUsed;

    // Number of escapes that were performed when frozen.
    uint256 escapesUsedCount;

    // Full withdrawal requests: stark key => vaultId => requestTime.
    // stark key => vaultId => requestTime.
    mapping (uint256 => mapping (uint256 => uint256)) fullWithdrawalRequests;

    // State sequence number.
    uint256 sequenceNumber;

    // Vaults Tree Root & Height.
    uint256 vaultRoot;
    uint256 vaultTreeHeight;

    // Order Tree Root & Height.
    uint256 orderRoot;
    uint256 orderTreeHeight;

    // True if and only if the address is allowed to add tokens.
    mapping (address => bool) tokenAdmins;

    // True if and only if the address is allowed to register users.
    mapping (address => bool) userAdmins;

    // True if and only if the address is an operator (allowed to update state).
    mapping (address => bool) operators;

    // Mapping of token ID to asset data.
    mapping (uint256 => bytes) tokenIdToAssetData;

    // Mapping of registered token IDs.
    mapping (uint256 => bool) registeredTokenId;

    // Mapping from token ID to quantum.
    mapping (uint256 => uint256) tokenIdToQuantum;

    // Correspondence between addresses and STARK public keys.
    mapping (address => uint256) starkKeys;
    mapping (uint256 => address) etherKeys;

    // Timelocked state transition and availability verification chain.
    ApprovalChainData verifiersChain;
    ApprovalChainData availabilityVerifiersChain;
}
