// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.11;

import "../components/PerpetualTokenRegister.sol";
import "../../components/TokenTransfers.sol";
import "../../components/ERC721Receiver.sol";
import "../../components/Freezable.sol";
import "../../components/KeyGetters.sol";
import "../../components/Users.sol";
import "../../components/MainGovernance.sol";
import "../../interactions/AcceptModifications.sol";
import "../../interactions/Deposits.sol";
import "../../interactions/CompositeActions.sol";
import "../../interactions/TokenAssetData.sol";
import "../../interactions/TokenQuantization.sol";
import "../../interactions/Withdrawals.sol";
import "../../interfaces/SubContractor.sol";

contract PerpetualTokensAndRamping is
    ERC721Receiver,
    SubContractor,
    Freezable,
    MainGovernance,
    AcceptModifications,
    TokenAssetData,
    TokenQuantization,
    TokenTransfers,
    PerpetualTokenRegister,
    KeyGetters,
    Users,
    Deposits,
    CompositeActions,
    Withdrawals
{
    function initialize(
        bytes calldata /* data */
    ) external override {
        revert("NOT_IMPLEMENTED");
    }

    function initializerSize() external override view returns (uint256) {
        return 0;
    }

    function identify() external override pure returns (string memory) {
        return "StarkWare_PerpetualTokensAndRamping_2020_1";
    }
}
