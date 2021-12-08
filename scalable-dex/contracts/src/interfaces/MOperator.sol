// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.11;

abstract contract MOperator {
    function isOperator(address testedOperator) public view virtual returns (bool);

    modifier onlyOperator() {
        require(isOperator(msg.sender), "ONLY_OPERATOR");
        _;
    }

    function registerOperator(address newOperator) external virtual;

    function unregisterOperator(address removedOperator) external virtual;
}
