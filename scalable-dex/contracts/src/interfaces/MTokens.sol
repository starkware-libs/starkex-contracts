pragma solidity ^0.5.2;

contract MTokens {
    function transferIn(uint256 assetType, uint256 quantizedAmount) internal;

    function transferInNft(uint256 assetType, uint256 tokenId) internal;

    function transferOut(address payable recipient, uint256 assetType, uint256 quantizedAmount)
        internal;

    function transferOutNft(address recipient, uint256 assetType, uint256 tokenId) internal;

    function transferOutMint(
        uint256 assetType, uint256 quantizedAmount, bytes memory mintingBlob) internal;
}
