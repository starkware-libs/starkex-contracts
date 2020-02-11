pragma solidity ^0.5.2;

contract MFreezable {
    /*
      Forbids calling the function if the exchange is frozen.
    */
    modifier notFrozen()
    {
        // Pure modifier declarations are not supported. Instead we provide
        // a dummy definition.
        revert("UNIMPLEMENTED");
        _;
    }

    /*
      Allows calling the function only if the exchange is frozen.
    */
    modifier onlyFrozen()
    {
        // Pure modifier declarations are not supported. Instead we provide
        // a dummy definition.
        revert("UNIMPLEMENTED");
        _;
    }

    /*
      Freezes the exchange.
    */
    function freeze()
        internal;

    /*
      Returns true if the exchange is frozen.
    */
    function isFrozen()
        external view
        returns (bool);

}
