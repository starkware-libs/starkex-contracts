// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.11;

abstract contract MOperator {

    modifier onlyOperator() virtual; // NOLINT incorrect-modifier.

    function registerOperator(address newOperator)
        external
        virtual;

    function unregisterOperator(address removedOperator)
        virtual
        external;

}
