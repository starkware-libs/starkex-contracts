// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

import "starkware/solidity/components/FactRegistry.sol";
import "starkware/solidity/interfaces/Identity.sol";

contract MockFactRegistry is FactRegistry, Identity {
    function mockRegisterFact(bytes32 factHash) external {
        super.registerFact(factHash);
    }

    function identify() external pure virtual override returns (string memory) {
        return "StarkWare_MockFactRegistry_2019_1";
    }
}
