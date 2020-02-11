pragma solidity ^0.5.2;

contract MTokens {
    function toQuantized(
        uint256 tokenId,
        uint256 amount
    )
        internal view
        returns (uint256 quantizedAmount);

    function fromQuantized(
        uint256 tokenId,
        uint256 quantizedAmount
    )
        internal view
        returns (uint256 amount);

    function isEther(
        uint256 tokenId)
        internal view returns (bool);

    function transferIn(
        uint256 tokenId,
        uint256 quantizedAmount
    )
        internal;

    function transferOut(
        uint256 tokenId,
        uint256 quantizedAmount
    )
        internal;
}
