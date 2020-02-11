pragma solidity ^0.5.2;

import "../components/Governance.sol";

/**
  The Proxy contract is governed by one or more Governors of which the initial one is the
  deployer of the contract.

  A governor has the sole authority to perform the following operations:

  1. Nominate additional governors (:sol:func:`proxyNominateNewGovernor`)
  2. Remove other governors (:sol:func:`proxyRemoveGovernor`)
  3. Add new `implementations` (proxied contracts)
  4. Remove (new or old) `implementations`
  5. Update `implementations` after a timelock allows it

  Adding governors is performed in a two step procedure:

  1. First, an existing governor nominates a new governor (:sol:func:`proxyNominateNewGovernor`)
  2. Then, the new governor must accept governance to become a governor (:sol:func:`proxyAcceptGovernance`)

  This two step procedure ensures that a governor public key cannot be nominated unless there is an
  entity that has the corresponding private key. This is intended to prevent errors in the addition
  process.

  The governor private key should typically be held in a secure cold wallet or managed via a
  multi-sig contract.
*/
/*
  Implements Governance for the proxy contract.
  It is a thin wrapper to the Governance contract,
  which is needed so that it can have non-colliding function names,
  and a specific tag (key) to allow unique state storage.
*/
contract ProxyGovernance is Governance {

    // The tag is the string key that is used in the Governance storage mapping.
    string public constant PROXY_GOVERNANCE_TAG = "StarkEx.Proxy.2019.GovernorsInformation";

    function getGovernanceTag()
        internal
        view
        returns (string memory tag) {
        tag = PROXY_GOVERNANCE_TAG;
    }

    function proxyIsGovernor(address testGovernor) external view returns (bool) {
        return isGovernor(testGovernor);
    }

    function proxyNominateNewGovernor(address newGovernor) external {
        nominateNewGovernor(newGovernor);
    }

    function proxyRemoveGovernor(address governorForRemoval) external {
        removeGovernor(governorForRemoval);
    }

    function proxyAcceptGovernance()
        external
    {
        acceptGovernance();
    }

    function proxyCancelNomination() external {
        cancelNomination();
    }
}
