pragma solidity ^0.5.2;

import "./components/ApprovalChain.sol";
import "./components/AvailabilityVerifiers.sol";
import "./components/Freezable.sol";
import "./components/MainGovernance.sol";
import "./components/Verifiers.sol";
import "./interfaces/SubContractor.sol";

contract AllVerifiers is
    SubContractor,
    MainGovernance,
    Freezable,
    ApprovalChain,
    AvailabilityVerifiers,
    Verifiers
{
    function initialize(bytes calldata /* data */)
        external {
        revert("NOT_IMPLEMENTED");
    }

    function initializerSize()
        external view
        returns(uint256){
        return 0;
    }

    function identify()
        external pure
        returns(string memory){
        return "StarkWare_AllVerifiers_2020_1";
    }
}
