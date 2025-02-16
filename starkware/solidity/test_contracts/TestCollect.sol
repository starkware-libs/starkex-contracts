// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.8.24;

contract TestCollect {
    function collect(uint256 eth_value) external payable {
        require(eth_value > 0, "ETH_VALUE_ZERO");
        require(msg.value > 0, "MSG_VALUE_ZERO");
        require(msg.value == eth_value, "INACCURATE_SUM");
    }
}
