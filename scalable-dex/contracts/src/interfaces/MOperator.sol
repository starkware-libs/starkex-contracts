pragma solidity ^0.5.2;

contract MOperator {

    modifier onlyOperator()
    {
        // Pure modifier declarations are not supported. Instead we provide
        // a dummy definition.
        revert("UNIMPLEMENTED");
        _;
    }

    function addNewOperator(address newOperator)
        external;

    function removeOperator(address removedOperator)
        external;

}
