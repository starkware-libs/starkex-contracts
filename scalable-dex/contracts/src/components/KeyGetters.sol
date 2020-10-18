pragma solidity ^0.5.2;

import "../components/MainStorage.sol";
import "../interfaces/MKeyGetters.sol";

/*
  Implements MKeyGetters.
*/
contract KeyGetters is MainStorage, MKeyGetters {
    function getEthKey(uint256 starkKey) public view returns (address ethKey) {
        // Fetch the user's Ethereum key.
        ethKey = ethKeys[starkKey];
        require(ethKey != address(0x0), "USER_UNREGISTERED");
    }

    function isMsgSenderStarkKeyOwner(uint256 starkKey) internal view returns (bool) {
        return msg.sender == getEthKey(starkKey);
    }

    modifier isSenderStarkKey(uint256 starkKey) {
        // Require the calling user to own the stark key.
        require(isMsgSenderStarkKeyOwner(starkKey), "MISMATCHING_STARK_ETH_KEYS");
        _;
    }
}
