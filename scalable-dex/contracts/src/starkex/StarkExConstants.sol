// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.11;

import "../libraries/LibConstants.sol";

contract StarkExConstants is LibConstants {
    uint256 constant STARKEX_VAULT_ID_UPPER_BOUND = 2**31;
    uint256 constant STARKEX_EXPIRATION_TIMESTAMP_BITS = 22;
    uint256 public constant STARKEX_MAX_DEFAULT_VAULT_LOCK = 7 days;
}
