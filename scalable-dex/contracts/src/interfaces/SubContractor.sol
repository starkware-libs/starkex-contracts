pragma solidity ^0.5.2;

import "./Identity.sol";

contract SubContractor is Identity {

    function initialize(bytes calldata data)
        external;

    function initializerSize()
        external view
        returns(uint256);

}
