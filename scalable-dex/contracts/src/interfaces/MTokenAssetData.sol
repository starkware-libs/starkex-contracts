pragma solidity ^0.5.2;

contract MTokenAssetData {

    // NOLINTNEXTLINE: external-function.
    function getAssetInfo(uint256 assetType)
        public
        view
        returns (bytes memory assetInfo);

    function extractTokenSelector(bytes memory assetInfo)
        internal
        pure
        returns (bytes4 selector);

    function isEther(uint256 assetType)
        internal
        view
        returns (bool);

    function isMintableAssetType(uint256 assetType)
        internal
        view
        returns (bool);

    function extractContractAddress(bytes memory assetInfo)
        internal
        pure
        returns (address _contract);

    function calculateNftAssetId(uint256 assetType, uint256 tokenId)
        internal
        pure
        returns(uint256 assetId);

    function calculateMintableAssetId(uint256 assetType, bytes memory mintingBlob)
        internal
        pure
        returns(uint256 assetId);

}
