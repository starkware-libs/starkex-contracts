// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.11;

abstract contract MGovernance {
    /*
      Allows calling the function only by a Governor.
    */
    modifier onlyGovernance () virtual; // NOLINT incorrect-modifier.
}
