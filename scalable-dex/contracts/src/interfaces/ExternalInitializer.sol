// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.11;

interface ExternalInitializer {

    event LogExternalInitialize(bytes data);

    function initialize(bytes calldata data) external;
}
