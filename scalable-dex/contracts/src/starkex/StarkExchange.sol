// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.11;

import "../interfaces/MainDispatcher.sol";

contract StarkExchange is MainDispatcher {
    string public constant VERSION = "4.0.0";

    // Salt for a 8 bit unique spread of all relevant selectors. Pre-caclulated.
    // ---------- The following code was auto-generated. PLEASE DO NOT EDIT. ----------
    uint256 constant MAGIC_SALT = 25249;
    uint256 constant IDX_MAP_0 = 0x302000300020020000502000000100000230000550000020220001050200000;
    uint256 constant IDX_MAP_1 = 0x2001000000001000000000000220120204000002023062500000300002400132;
    uint256 constant IDX_MAP_2 = 0x100000011000000100030550001200120001003000000000005100000002032;
    uint256 constant IDX_MAP_3 = 0x1010000105100000000300000321012000002150002002002000001100020300;

    // ---------- End of auto-generated code. ----------

    function getNumSubcontracts() internal pure override returns (uint256) {
        return 6;
    }

    function magicSalt() internal pure override returns (uint256) {
        return MAGIC_SALT;
    }

    function handlerMapSection(uint256 section) internal view override returns (uint256) {
        if (section == 0) {
            return IDX_MAP_0;
        } else if (section == 1) {
            return IDX_MAP_1;
        } else if (section == 2) {
            return IDX_MAP_2;
        } else if (section == 3) {
            return IDX_MAP_3;
        }
        revert("BAD_IDX_MAP_SECTION");
    }

    function expectedIdByIndex(uint256 index) internal pure override returns (string memory id) {
        if (index == 1) {
            id = "StarkWare_AllVerifiers_2020_1";
        } else if (index == 2) {
            id = "StarkWare_TokensAndRamping_2020_1";
        } else if (index == 3) {
            id = "StarkWare_StarkExState_2021_1";
        } else if (index == 4) {
            id = "StarkWare_ForcedActions_2020_1";
        } else if (index == 5) {
            id = "StarkWare_OnchainVaults_2021_1";
        } else if (index == 6) {
            id = "StarkWare_ProxyUtils_2021_1";
        } else {
            revert("UNEXPECTED_INDEX");
        }
    }

    function initializationSentinel() internal view override {
        string memory REVERT_MSG = "INITIALIZATION_BLOCKED";
        // This initializer sets roots etc. It must not be applied twice.
        // I.e. it can run only when the state is still empty.
        require(vaultRoot == 0, REVERT_MSG);
        require(vaultTreeHeight == 0, REVERT_MSG);
        require(orderRoot == 0, REVERT_MSG);
        require(orderTreeHeight == 0, REVERT_MSG);
    }
}
