pragma solidity ^0.5.2;

contract Identity {

    /*
      Allows a caller, typically another contract,
      to ensure that the provided address is of the expected type and version.
    */
    function identify()
        external pure
        returns(string memory);
}
