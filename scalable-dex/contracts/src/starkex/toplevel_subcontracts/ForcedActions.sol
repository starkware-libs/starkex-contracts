// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.11;

import "../interactions/FullWithdrawals.sol";
import "../interactions/StarkExForcedActionState.sol";
import "../../components/Freezable.sol";
import "../../components/KeyGetters.sol";
import "../../components/MainGovernance.sol";
import "../../interfaces/SubContractor.sol";

contract ForcedActions is
    SubContractor,
    MainGovernance,
    Freezable,
    KeyGetters,
    FullWithdrawals,
    StarkExForcedActionState
{
    function initialize(
        bytes calldata /* data */
    ) external override {
        revert("NOT_IMPLEMENTED");
    }

    function initializerSize() external view override returns (uint256) {
        return 0;
    }

    function identify() external pure override returns (string memory) {
        return "StarkWare_ForcedActions_2020_1";
    }
}
