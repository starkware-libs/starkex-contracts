// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.11;

abstract contract MUsers {
    function registerUser( // NOLINT external-function.
        address ethKey,
        uint256 starkKey,
        bytes calldata signature)
        public virtual;
}
