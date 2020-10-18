pragma solidity ^0.5.2;

contract ExternalInitializer {

    event LogExternalInitialize(bytes data);

    function initialize(bytes calldata data) external;
}
