pragma solidity ^0.5.2;

contract MKeyGetters {
    // NOLINTNEXTLINE: external-function.
    function getEthKey(uint256 starkKey) public view returns (address ethKey);

    function isMsgSenderStarkKeyOwner(uint256 starkKey) internal view returns (bool);

    /*
      Allows calling the function only if starkKey is registered to msg.sender.
    */
    modifier isSenderStarkKey(uint256 starkKey)
    {
        // Pure modifier declarations are not supported. Instead we provide
        // a dummy definition.
        revert("UNIMPLEMENTED");
        _;
    }
}
