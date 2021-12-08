// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.11;

import "./SubContractor.sol";
import "./IDispatcherBase.sol";
import "../interfaces/BlockDirectCall.sol";
import "../libraries/Common.sol";

abstract contract MainDispatcherBase is IDispatcherBase, BlockDirectCall {
    using Addresses for address;

    /*
      This entry point serves only transactions with empty calldata. (i.e. pure value transfer tx).
      We don't expect to receive such, thus block them.
    */
    receive() external payable {
        revert("CONTRACT_NOT_EXPECTED_TO_RECEIVE");
    }

    fallback() external payable {
        address subContractAddress = getSubContract(msg.sig);
        require(subContractAddress != address(0x0), "NO_CONTRACT_FOR_FUNCTION");

        assembly {
            // Copy msg.data. We take full control of memory in this inline assembly
            // block because it will not return to Solidity code. We overwrite the
            // Solidity scratch pad at memory position 0.
            calldatacopy(0, 0, calldatasize())

            // Call the implementation.
            // out and outsize are 0 for now, as we don"t know the out size yet.
            let result := delegatecall(gas(), subContractAddress, 0, calldatasize(), 0, 0)

            // Copy the returned data.
            returndatacopy(0, 0, returndatasize())

            switch result
            // delegatecall returns 0 on error.
            case 0 {
                revert(0, returndatasize())
            }
            default {
                return(0, returndatasize())
            }
        }
    }

    /*
      1. Extract subcontracts.
      2. Verify correct sub-contract initializer size.
      3. Extract sub-contract initializer data.
      4. Call sub-contract initializer.

      The init data bytes passed to initialize are structed as following:
      I. N slots (uin256 size) addresses of the deployed sub-contracts.
      II. An address of an external initialization contract (optional, or ZERO_ADDRESS).
      III. (Up to) N bytes sections of the sub-contracts initializers.

      If already initialized (i.e. upgrade) we expect the init data to be consistent with this.
      and if a different size of init data is expected when upgrading, the initializerSize should
      reflect this.

      If an external initializer contract is not used, ZERO_ADDRESS is passed in its slot.
      If the external initializer contract is used, all the remaining init data is passed to it,
      and internal initialization will not occur.

      External Initialization Contract
      --------------------------------
      External Initialization Contract (EIC) is a hook for custom initialization.
      Typically in an upgrade flow, the expected initialization contains only the addresses of
      the sub-contracts. Normal initialization of the sub-contracts is such that is not needed
      in an upgrade, and actually may be very dangerous, as changing of state on a working system
      may corrupt it.

      In the event that some state initialization is required, the EIC is a hook that allows this.
      It may be deployed and called specifically for this purpose.

      The address of the EIC must be provided (if at all) when a new implementation is added to
      a Proxy contract (as part of the initialization vector).
      Hence, it is considered part of the code open to reviewers prior to a time-locked upgrade.

      When a custom initialization is performed using an EIC,
      the main dispatcher initialize extracts and stores the sub-contracts addresses, and then
      yields to the EIC, skipping the rest of its initialization code.


      Flow of MainDispatcher initialize
      ---------------------------------
      1. Extraction and assignment of subcontracts addresses
         Main dispatcher expects a valid and consistent set of addresses in the passed data.
         It validates that, extracts the addresses from the data, and validates that the addresses
         are of the expected type and order. Then those addresses are stored.

      2. Extraction of EIC address
         The address of the EIC is extracted from the data.
         External Initializer Contract is optional. ZERO_ADDRESS indicates it is not used.

      3a. EIC is used
          Dispatcher calls the EIC initialize function with the remaining data.
          Note - In this option 3b is not performed.

      3b. EIC is not used
          If there is additional initialization data then:
          I. Sentitenl function is called to permit subcontracts initialization.
          II. Dispatcher loops through the subcontracts and for each one it extracts the
              initializing data and passes it to the subcontract's initialize function.

    */
    function initialize(bytes calldata data) external virtual notCalledDirectly {
        // Number of sub-contracts.
        uint256 nSubContracts = getNumSubcontracts();

        // We support currently 4 bits per contract, i.e. 16, reserving 00 leads to 15.
        require(nSubContracts <= 15, "TOO_MANY_SUB_CONTRACTS");

        // Sum of subcontract initializers. Aggregated for verification near the end.
        uint256 totalInitSizes = 0;

        // Offset (within data) of sub-contract initializer vector.
        // Just past the sub-contract+eic addresses.
        uint256 initDataContractsOffset = 32 * (nSubContracts + 1);

        // Init data MUST include addresses for all sub-contracts + EIC.
        require(data.length >= initDataContractsOffset, "SUB_CONTRACTS_NOT_PROVIDED");

        // Size of passed data, excluding sub-contract addresses.
        uint256 additionalDataSize = data.length - initDataContractsOffset;

        // Extract & update contract addresses.
        for (uint256 nContract = 1; nContract <= nSubContracts; nContract++) {
            // Extract sub-contract address.
            address contractAddress = abi.decode(
                data[32 * (nContract - 1):32 * nContract],
                (address)
            );

            validateSubContractIndex(nContract, contractAddress);

            // Contracts are indexed from 1 and 0 is not in use here.
            setSubContractAddress(nContract, contractAddress);
        }

        // Check if we have an external initializer contract.
        address externalInitializerAddr = abi.decode(
            data[initDataContractsOffset - 32:initDataContractsOffset],
            (address)
        );

        // 3(a). Yield to EIC initialization.
        if (externalInitializerAddr != address(0x0)) {
            callExternalInitializer(externalInitializerAddr, data[initDataContractsOffset:]);
            return;
        }

        // 3(b). Subcontracts initialization.
        // I. If no init data passed besides sub-contracts, return.
        if (additionalDataSize == 0) {
            return;
        }

        // Just to be on the safe side.
        assert(externalInitializerAddr == address(0x0));

        // II. Gate further initialization.
        initializationSentinel();

        // III. Loops through the subcontracts, extracts their data and calls their initializer.
        for (uint256 nContract = 1; nContract <= nSubContracts; nContract++) {
            // Extract sub-contract address.
            address contractAddress = abi.decode(
                data[32 * (nContract - 1):32 * nContract],
                (address)
            );

            // The initializerSize is called via delegatecall, so that it can relate to the state,
            // and not only to the new contract code. (e.g. return 0 if state-intialized else 192).
            // NOLINTNEXTLINE: controlled-delegatecall low-level-calls calls-loop.
            (bool success, bytes memory returndata) = contractAddress.delegatecall(
                abi.encodeWithSelector(SubContractor(contractAddress).initializerSize.selector)
            );
            require(success, string(returndata));
            uint256 initSize = abi.decode(returndata, (uint256));
            require(initSize <= additionalDataSize, "INVALID_INITIALIZER_SIZE");
            require(totalInitSizes + initSize <= additionalDataSize, "INVALID_INITIALIZER_SIZE");

            if (initSize == 0) {
                continue;
            }

            // Call sub-contract initializer.
            // NOLINTNEXTLINE: controlled-delegatecall calls-loop.
            (success, returndata) = contractAddress.delegatecall(
                abi.encodeWithSelector(
                    this.initialize.selector,
                    data[initDataContractsOffset:initDataContractsOffset + initSize]
                )
            );
            require(success, string(returndata));
            totalInitSizes += initSize;
            initDataContractsOffset += initSize;
        }
        require(additionalDataSize == totalInitSizes, "MISMATCHING_INIT_DATA_SIZE");
    }

    function callExternalInitializer(address externalInitializerAddr, bytes calldata extInitData)
        private
    {
        require(externalInitializerAddr.isContract(), "NOT_A_CONTRACT");

        // NOLINTNEXTLINE: low-level-calls, controlled-delegatecall.
        (bool success, bytes memory returndata) = externalInitializerAddr.delegatecall(
            abi.encodeWithSelector(this.initialize.selector, extInitData)
        );
        require(success, string(returndata));
        require(returndata.length == 0, string(returndata));
    }
}
