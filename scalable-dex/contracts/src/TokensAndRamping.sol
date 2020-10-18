pragma solidity ^0.5.2;

import "./components/ERC721Receiver.sol";
import "./components/Freezable.sol";
import "./components/KeyGetters.sol";
import "./components/Operator.sol";
import "./components/Tokens.sol";
import "./components/Users.sol";
import "./components/MainGovernance.sol";
import "./interactions/AcceptModifications.sol";
import "./interactions/Deposits.sol";
import "./interactions/FullWithdrawals.sol";
import "./interactions/Withdrawals.sol";
import "./interfaces/SubContractor.sol";

contract TokensAndRamping is
    ERC721Receiver,
    SubContractor,
    Operator,
    Freezable,
    MainGovernance,
    AcceptModifications,
    Tokens,
    KeyGetters,
    Users,
    Deposits,
    Withdrawals,
    FullWithdrawals
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
        return "StarkWare_TokensAndRamping_2020_1";
    }
}
