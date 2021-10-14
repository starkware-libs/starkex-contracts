// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.11;

import "./Identity.sol";

interface SubContractor is Identity {
    function initialize(bytes calldata data) external;

    function initializerSize() external view returns (uint256);
}
