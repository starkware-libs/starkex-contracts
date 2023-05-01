// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

import "./MainStorage.sol";
import "../interfaces/IFactRegistry.sol";
import {ApprovalChainData} from "../libraries/StarkExTypes.sol";

contract VerifyFactChain is MainStorage {
    function verifyFact(
        ApprovalChainData storage chain,
        bytes32 fact,
        string memory noVerifiersErrorMessage,
        string memory invalidFactErrorMessage
    ) internal view {
        address[] storage verifiers = chain.verifiers;
        uint256 n_entries = verifiers.length;
        require(n_entries > 0, noVerifiersErrorMessage);
        for (uint256 i = 0; i < n_entries; i++) {
            // NOLINTNEXTLINE: calls-loop.
            require(IFactRegistry(verifiers[i]).isValid(fact), invalidFactErrorMessage);
        }
    }
}
