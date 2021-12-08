// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.11;

/**
  Required interface of an ERC721 compliant contract.
*/
interface IERC721 {
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    /**
      Returns the number of NFTs in ``owner``'s account.
    */
    function balanceOf(address owner) external view returns (uint256 balance);

    /**
      Returns the owner of the NFT specified by `tokenId`.
    */
    function ownerOf(uint256 tokenId) external view returns (address owner);

    /**
      Transfers a specific NFT (`tokenId`) from one account (`from`) to
      another (`to`).



      Requirements:
      - `from`, `to` cannot be zero.
      - `tokenId` must be owned by `from`.
      - If the caller is not `from`, it must be have been allowed to move this
      NFT by either {approve} or {setApprovalForAll}.
    */
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external;

    /**
      Transfers a specific NFT (`tokenId`) from one account (`from`) to
      another (`to`).
           Requirements:
      - If the caller is not `from`, it must be approved to move this NFT by
      either {approve} or {setApprovalForAll}.
    */
    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external;

    function approve(address to, uint256 tokenId) external;

    function getApproved(uint256 tokenId) external view returns (address operator);

    function setApprovalForAll(address operator, bool _approved) external;

    function isApprovedForAll(address owner, address operator) external view returns (bool);

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes calldata data
    ) external;
}
