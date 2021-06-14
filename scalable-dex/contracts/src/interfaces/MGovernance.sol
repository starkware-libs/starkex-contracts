// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.11;

abstract contract MGovernance {

    function isGovernor(address testGovernor)
        internal
        view
        virtual
        returns (bool);

    /*
      Allows calling the function only by a Governor.
    */
    modifier onlyGovernance ()
    {
        require(isGovernor(msg.sender), "ONLY_GOVERNANCE");
        _;
    }
}
