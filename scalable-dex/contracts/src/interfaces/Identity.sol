// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.11;

interface Identity {
    /*
      Allows a caller, typically another contract,
      to ensure that the provided address is of the expected type and version.
    */
    function identify() external pure returns (string memory);
}
