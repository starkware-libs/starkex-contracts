// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.11;

import "../interfaces/MainDispatcher.sol";

contract StarkExchange is MainDispatcher {
    string public constant VERSION = "3.0.0";

    // Salt for a 8 bit unique spread of all relevant selectors. Pre-caclulated.
    // ---------- The following code was auto-generated. PLEASE DO NOT EDIT. ----------
    uint256 constant MAGIC_SALT = 120;
    uint256 constant IDX_MAP_0 = 0x2000000000000000002010000001000000000000200010300010002002000330;
    uint256 constant IDX_MAP_1 = 0x4300000202002011010000101200100030000000022030010000000121000000;
    uint256 constant IDX_MAP_2 = 0x2000000100300230002000400000000001013000201010100001011000;
    uint256 constant IDX_MAP_3 = 0x2020000003002002000002020000000002000000000001200320000000002000;
    // ---------- End of auto-generated code. ----------

    function getNumSubcontracts() internal pure override returns (uint256) {
        return 4;
    }

    function magicSalt() internal pure override returns(uint256) {
        return MAGIC_SALT;
    }

    function handlerMapSection(uint256 section) internal view override returns(uint256) {
        if(section == 0) {
            return IDX_MAP_0;
        }
        else if(section == 1) {
            return IDX_MAP_1;
        }
        else if(section == 2) {
            return IDX_MAP_2;
        }
        else if(section == 3) {
            return IDX_MAP_3;
        }
        revert("BAD_IDX_MAP_SECTION");
    }

    function expectedIdByIndex(uint256 index)
        internal pure override returns (string memory id) {
        if (index == 1) {
            id = "StarkWare_AllVerifiers_2020_1";
        } else if (index == 2) {
            id = "StarkWare_TokensAndRamping_2020_1";
        } else if (index == 3) {
            id = "StarkWare_StarkExState_2020_1";
        } else if (index == 4) {
            id = "StarkWare_ForcedActions_2020_1";
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
