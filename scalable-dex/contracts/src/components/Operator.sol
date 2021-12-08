// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.11;

import "../interfaces/MOperator.sol";
import "../interfaces/MGovernance.sol";
import "./MainStorage.sol";

/**
  The Operator of the contract is the entity entitled to submit state update requests
  by calling :sol:func:`updateState`.

  An Operator may be instantly appointed or removed by the contract Governor
  (see :sol:mod:`MainGovernance`). Typically, the Operator is the hot wallet of the StarkEx service
  submitting proofs for state updates.
*/
abstract contract Operator is MainStorage, MGovernance, MOperator {
    event LogOperatorAdded(address operator);
    event LogOperatorRemoved(address operator);

    function initialize() internal {
        operators[msg.sender] = true;
        emit LogOperatorAdded(msg.sender);
    }

    function registerOperator(address newOperator) external override onlyGovernance {
        operators[newOperator] = true;
        emit LogOperatorAdded(newOperator);
    }

    function unregisterOperator(address removedOperator) external override onlyGovernance {
        operators[removedOperator] = false;
        emit LogOperatorRemoved(removedOperator);
    }

    function isOperator(address testedOperator) public view override returns (bool) {
        return operators[testedOperator];
    }
}
