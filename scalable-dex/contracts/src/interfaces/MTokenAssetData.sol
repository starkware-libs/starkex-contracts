// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.11;

abstract contract MTokenAssetData {
    // NOLINTNEXTLINE: external-function.
    function getAssetInfo(uint256 assetType) public view virtual returns (bytes memory assetInfo);

    function extractTokenSelector(bytes memory assetInfo)
        internal
        pure
        virtual
        returns (bytes4 selector);

    function isEther(uint256 assetType) internal view virtual returns (bool);

    function isERC20(uint256 assetType) internal view virtual returns (bool);

    function isERC721(uint256 assetType) internal view virtual returns (bool);

    function isFungibleAssetType(uint256 assetType) internal view virtual returns (bool);

    function isMintableAssetType(uint256 assetType) internal view virtual returns (bool);

    function extractContractAddress(uint256 assetType) internal view virtual returns (address);

    function verifyAssetInfo(bytes memory assetInfo) internal view virtual;

    function isNonFungibleAssetInfo(bytes memory assetInfo) internal pure virtual returns (bool);

    function calculateNftAssetId(uint256 assetType, uint256 tokenId)
        internal
        pure
        virtual
        returns (uint256 assetId);

    function calculateMintableAssetId(uint256 assetType, bytes memory mintingBlob)
        internal
        pure
        virtual
        returns (uint256 assetId);
}
