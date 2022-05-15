// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

interface IPeriodicColumn {
    function compute(uint256 x) external pure returns (uint256 result);
}
