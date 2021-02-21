// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.11;

/*
  Holds the governance slots for ALL entities, including proxy and the main contract.
*/
contract GovernanceStorage {

    struct GovernanceInfoStruct {
        mapping (address => bool) effectiveGovernors;
        address candidateGovernor;
        bool initialized;
    }

    // A map from a Governor tag to its own GovernanceInfoStruct.
    mapping (string => GovernanceInfoStruct) internal governanceInfo;
}
