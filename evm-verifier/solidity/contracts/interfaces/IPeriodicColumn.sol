// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.11;

interface IPeriodicColumn {
    function compute(uint256 x) external pure returns (uint256 result);
}
