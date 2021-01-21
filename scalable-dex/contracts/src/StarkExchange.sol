pragma solidity ^0.5.2;

import "./components/MainStorage.sol";
import "./interfaces/MainDispatcher.sol";

contract StarkExchange is MainStorage, MainDispatcher {
    string public constant VERSION = "2.0.4";

    uint256 constant SUBCONTRACT_BITS = 4;

    // Salt for a 7 bit unique spread of all relevant selectors. Pre-calculated.
    // ---------- The following code was auto-generated. PLEASE DO NOT EDIT. ----------
    uint256 constant MAGIC_SALT = 48922;
    uint256 constant IDX_MAP_0 = 0x2000210003222202003002100001000001202222220021203022313011;
    uint256 constant IDX_MAP_1 = 0x20312200100120112200001020000002021230210020010012000010013000;
    // ---------- End of auto-generated code. ----------

    function validateSubContractIndex(uint256 index, address subContract) internal pure{
        string memory id = SubContractor(subContract).identify();
        bytes32 hashed_expected_id = keccak256(abi.encodePacked(expectedIdByIndex(index)));
        require(
            hashed_expected_id == keccak256(abi.encodePacked(id)),
            "MISPLACED_INDEX_OR_BAD_CONTRACT_ID");
    }

    function expectedIdByIndex(uint256 index)
        private pure returns (string memory id) {
        if (index == 1){
            id = "StarkWare_AllVerifiers_2020_1";
        } else if (index == 2){
            id = "StarkWare_TokensAndRamping_2020_1";
        } else if (index == 3){
            id = "StarkWare_StarkExState_2020_1";
        } else {
            revert("UNEXPECTED_INDEX");
        }
    }

    function getNumSubcontracts() internal pure returns (uint256) {
        return 3;
    }

    function getSubContract(bytes4 selector)
        internal view returns (address) {
        uint256 location = 0x7F & uint256(keccak256(abi.encodePacked(selector, MAGIC_SALT)));
        uint256 subContractIdx;
        uint256 offset = SUBCONTRACT_BITS * location % 256;
        if (location < 64) {
            subContractIdx = (IDX_MAP_0 >> offset) & 0xF;
        } else {
            subContractIdx = (IDX_MAP_1 >> offset) & 0xF;
        }
        return subContracts[subContractIdx];
    }

    function setSubContractAddress(uint256 index, address subContractAddress) internal {
        subContracts[index] = subContractAddress;
    }

    function initializationSentinel()
        internal view {
        string memory REVERT_MSG = "INITIALIZATION_BLOCKED";
        // This initializer sets roots etc. It must not be applied twice.
        // I.e. it can run only when the state is still empty.
        require(vaultRoot == 0, REVERT_MSG);
        require(vaultTreeHeight == 0, REVERT_MSG);
        require(orderRoot == 0, REVERT_MSG);
        require(orderTreeHeight == 0, REVERT_MSG);
    }
}
