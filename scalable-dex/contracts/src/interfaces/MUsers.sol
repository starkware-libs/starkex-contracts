pragma solidity ^0.5.2;

contract MUsers {
    function getStarkKey(
        address etherKey
    )
        public view
        returns (uint256 starkKey);

    function getEtherKey(
        uint256 starkKey
    )
        external view
        returns (address etherKey);
}
