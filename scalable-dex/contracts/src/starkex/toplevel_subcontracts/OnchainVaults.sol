// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.11;

import "../components/VaultDepositWithdrawal.sol";
import "../components/VaultLocks.sol";
import "../../components/MainGovernance.sol";
import "../../components/TokenTransfers.sol";
import "../../interactions/TokenAssetData.sol";
import "../../interactions/TokenQuantization.sol";
import "../../interfaces/SubContractor.sol";

contract OnchainVaults is
    SubContractor,
    MainGovernance,
    VaultLocks,
    TokenAssetData,
    TokenTransfers,
    TokenQuantization,
    VaultDepositWithdrawal
{
    function identify() external override pure returns (string memory) {
        return "StarkWare_OnchainVaults_2021_1";
    }

    function initialize(bytes calldata) external override {
        revert("NOT_IMPLEMENTED");
    }

    function initializerSize() external override view returns (uint256) {
        return 0;
    }

    function isStrictVaultBalancePolicy() external view returns (bool) {
        return strictVaultBalancePolicy;
    }
}
