// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.11;

interface IERC721Receiver {
    function onERC721Received(address operator, address from, uint256 tokenId, bytes memory data)
        external returns (bytes4);
}
