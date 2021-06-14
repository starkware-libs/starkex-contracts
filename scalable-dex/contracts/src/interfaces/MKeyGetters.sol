// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.11;

abstract contract MKeyGetters {
    // NOLINTNEXTLINE: external-function.
    function getEthKey(uint256 starkKey) public view virtual returns (address ethKey);

    function isMsgSenderStarkKeyOwner(uint256 starkKey) internal view virtual returns (bool);

    /*
      Allows calling the function only if starkKey is registered to msg.sender.
    */
    modifier onlyStarkKeyOwner(uint256 starkKey) {
        // Require the calling user to own the stark key.
        require(isMsgSenderStarkKeyOwner(starkKey), "MISMATCHING_STARK_ETH_KEYS");
        _;
    }
}
