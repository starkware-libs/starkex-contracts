// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

import "../../interfaces/ExternalInitializer.sol";
import "../../libraries/LibConstants.sol";
import "../../components/MainStorage.sol";

/*
  This contract is an external initializing contract that updates the globalConfigCode value.
*/
contract ChangeGlobalConfigExternalInitializer is ExternalInitializer, MainStorage, LibConstants {
    event GlobalConfigCodeChange(uint256 oldGlobalConfigCode, uint256 newGlobalConfigCode);

    function initialize(bytes calldata data) external override {
        require(data.length == 32, "INCORRECT_INIT_DATA_SIZE_32");
        uint256 newGlobalConfigCode = abi.decode(data, (uint256));
        require(newGlobalConfigCode < K_MODULUS, "GLOBAL_CONFIG_CODE >= PRIME");

        if (globalConfigCode != newGlobalConfigCode) {
            emit GlobalConfigCodeChange(globalConfigCode, newGlobalConfigCode);
            globalConfigCode = newGlobalConfigCode;
        }
        emit LogExternalInitialize(data);
    }
}
