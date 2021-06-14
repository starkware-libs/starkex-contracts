// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.11;

abstract contract MTokenTransfers {
    function transferIn(uint256 assetType, uint256 quantizedAmount) internal virtual;

    function transferInNft(uint256 assetType, uint256 tokenId) internal virtual;

    function transferOut(
        address payable recipient, uint256 assetType, uint256 quantizedAmount) internal virtual;

    function transferOutNft(address recipient, uint256 assetType, uint256 tokenId) internal virtual;

    function transferOutMint(
        uint256 assetType, uint256 quantizedAmount, bytes memory mintingBlob) internal virtual;
}
