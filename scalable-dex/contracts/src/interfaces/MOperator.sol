pragma solidity ^0.5.2;

contract MOperator {

    modifier onlyOperator()
    {
        // Pure modifier declarations are not supported. Instead we provide
        // a dummy definition.
        revert("UNIMPLEMENTED");
        _;
    }

    function registerOperator(address newOperator)
        external;

    function unregisterOperator(address removedOperator)
        external;

}
