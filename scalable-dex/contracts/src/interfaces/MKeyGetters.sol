// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.11;

abstract contract MKeyGetters {
    // NOLINTNEXTLINE: external-function.
    function getEthKey(uint256 starkKey) public view virtual returns (address ethKey);

    function isMsgSenderStarkKeyOwner(uint256 starkKey) internal view virtual returns (bool);

    /*
      Allows calling the function only if starkKey is registered to msg.sender.
    */
    modifier isSenderStarkKey(uint256 starkKey) virtual; // NOLINT incorrect-modifier.
}
