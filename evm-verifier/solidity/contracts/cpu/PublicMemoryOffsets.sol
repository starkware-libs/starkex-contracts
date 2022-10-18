// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

import "./PageInfo.sol";

abstract contract PublicMemoryOffsets is PageInfo {
    /*
      Returns the offset in the public input where the public memory related information starts.
      The offset is layout specific and each layout needs to override this function.
    */
    function getPublicMemoryOffset() internal pure virtual returns (uint256);

    // The format of the public input, starting at getPublicMemoryOffset() is as follows:
    //   * For each page:
    //     * First address in the page (this field is not included for the first page).
    //     * Page size.
    //     * Page hash.
    //   # All data above this line, appears in the initial seed of the proof.
    //   * For each page:
    //     * Cumulative product.
    function getOffsetPageSize(uint256 pageId) internal pure returns (uint256) {
        return getPublicMemoryOffset() + PAGE_INFO_SIZE * pageId - 1 + PAGE_INFO_SIZE_OFFSET;
    }

    function getOffsetPageHash(uint256 pageId) internal pure returns (uint256) {
        return getPublicMemoryOffset() + PAGE_INFO_SIZE * pageId - 1 + PAGE_INFO_HASH_OFFSET;
    }

    function getOffsetPageAddr(uint256 pageId) internal pure returns (uint256) {
        require(pageId >= 1, "Address of page 0 is not part of the public input.");
        return getPublicMemoryOffset() + PAGE_INFO_SIZE * pageId - 1 + PAGE_INFO_ADDRESS_OFFSET;
    }

    function getOffsetPageProd(uint256 pageId, uint256 nPages) internal pure returns (uint256) {
        return getPublicMemoryOffset() + PAGE_INFO_SIZE * nPages - 1 + pageId;
    }

    function getPublicInputLength(uint256 nPages) internal pure returns (uint256) {
        return getPublicMemoryOffset() + (PAGE_INFO_SIZE + 1) * nPages - 1;
    }
}
