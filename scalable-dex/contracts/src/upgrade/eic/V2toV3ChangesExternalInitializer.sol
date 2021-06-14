// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.11;

import "../../interfaces/ExternalInitializer.sol";
import "../../starkex/components/StarkExStorage.sol";
import "../../libraries/Common.sol";

/*
  This contract is an external initializing contract that modifies the onchain data version.
*/
contract V2toV3ChangesExternalInitializer is ExternalInitializer, StarkExStorage {

    using Addresses for address;

    function initialize(bytes calldata data) external override {
        require(data.length == 128, "INCORRECT_INIT_DATA_SIZE_128");
        (
          uint256 newOnchainDataVersion,
          bool newVaultBalancePolicy,
          address newOrderRegistryAddress,
          bytes32 messageRegistryIdHash
        ) = abi.decode(data, (uint256, bool, address, bytes32));
        onchainDataVersion = newOnchainDataVersion;
        strictVaultBalancePolicy = newVaultBalancePolicy;
        orderRegistryAddress = newOrderRegistryAddress;
        newOrderRegistryAddress.validateContractId(messageRegistryIdHash);
        emit LogExternalInitialize(data);
    }
}
