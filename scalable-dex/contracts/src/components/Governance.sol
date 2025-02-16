pragma solidity ^0.5.2;

import "./GovernanceStorage.sol";
import "../interfaces/MGovernance.sol";

/*
  Implements Generic Governance, applicable for both proxy and main contract, and possibly others.
  Notes:
  1. This class is virtual (getGovernanceTag is not implemented).
  2. The use of the same function names by both the Proxy and a delegated implementation
     is not possible since calling the implementation functions is done via the default function
     of the Proxy. For this reason, for example, the implementation of MainContract (MainGovernance)
     exposes mainIsGovernor, which calls the internal isGovernor method.
*/
contract Governance is GovernanceStorage, MGovernance {
    event LogNominatedGovernor(address nominatedGovernor);
    event LogNewGovernorAccepted(address acceptedGovernor);
    event LogRemovedGovernor(address removedGovernor);
    event LogNominationCancelled();

    address internal constant ZERO_ADDRESS = address(0x0);

    /*
      Returns a string which uniquely identifies the type of the governance mechanism.
    */
    function getGovernanceTag()
        internal
        view
        returns (string memory);

    /*
      Returns the GovernanceInfoStruct associated with the governance tag.
    */
    function contractGovernanceInfo()
        internal
        view
        returns (GovernanceInfoStruct storage) {
        string memory tag = getGovernanceTag();
        GovernanceInfoStruct storage gub = governanceInfo[tag];
        require(gub.initialized == true, "NOT_INITIALIZED");
        return gub;
    }

    function initGovernance()
        internal
    {
        string memory tag = getGovernanceTag();
        GovernanceInfoStruct storage gub = governanceInfo[tag];
        require(gub.initialized == false, "ALREADY_INITIALIZED");
        gub.initialized = true;  // to ensure addGovernor() won't fail.
        // Add the initial governer.
        addGovernor(msg.sender);
    }

    modifier onlyGovernance()
    {
        require(isGovernor(msg.sender), "ONLY_GOVERNANCE");
        _;
    }

    function isGovernor(address testGovernor)
        internal view
        returns (bool addressIsGovernor){
        GovernanceInfoStruct storage gub = contractGovernanceInfo();
        addressIsGovernor = gub.effectiveGovernors[testGovernor];
    }

    /*
      Cancels the nomination of a governor condidate.
    */
    function cancelNomination() internal onlyGovernance() {
        GovernanceInfoStruct storage gub = contractGovernanceInfo();
        gub.candidateGovernor = ZERO_ADDRESS;
        emit LogNominationCancelled();
    }

    function nominateNewGovernor(address newGovernor) internal onlyGovernance() {
        GovernanceInfoStruct storage gub = contractGovernanceInfo();
        require(isGovernor(newGovernor) == false, "ALREADY_GOVERNOR");
        gub.candidateGovernor = newGovernor;
        emit LogNominatedGovernor(newGovernor);
    }

    /*
      The addGovernor is called in two cases:
      1. by acceptGovernance when a new governor accepts its role.
      2. by initGovernance to add the initial governor.
      The difference is that the init path skips the nominate step
      that would fail because of the onlyGovernance modifier.
    */
    function addGovernor(address newGovernor) private {
        require(isGovernor(newGovernor) == false, "ALREADY_GOVERNOR");
        GovernanceInfoStruct storage gub = contractGovernanceInfo();
        gub.effectiveGovernors[newGovernor] = true;
    }

    function acceptGovernance()
        internal
    {
        // The new governor was proposed as a candidate by the current governor.
        GovernanceInfoStruct storage gub = contractGovernanceInfo();
        require(msg.sender == gub.candidateGovernor, "ONLY_CANDIDATE_GOVERNOR");

        // Update state.
        addGovernor(gub.candidateGovernor);
        gub.candidateGovernor = ZERO_ADDRESS;

        // Send a notification about the change of governor.
        emit LogNewGovernorAccepted(msg.sender);
    }

    /*
      Remove a governor from office.
    */
    function removeGovernor(address governorForRemoval) internal onlyGovernance() {
        require(msg.sender != governorForRemoval, "GOVERNOR_SELF_REMOVE");
        GovernanceInfoStruct storage gub = contractGovernanceInfo();
        require (isGovernor(governorForRemoval), "NOT_GOVERNOR");
        gub.effectiveGovernors[governorForRemoval] = false;
        emit LogRemovedGovernor(governorForRemoval);
    }
}
