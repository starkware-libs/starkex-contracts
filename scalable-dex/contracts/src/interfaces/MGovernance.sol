pragma solidity ^0.5.2;

contract MGovernance {
    /*
      Allows calling the function only by a Governor.
    */
    modifier onlyGovernance()
    {
        // Pure modifier declarations are not supported. Instead we provide
        // a dummy definition.
        revert("UNIMPLEMENTED");
        _;
    }
}
