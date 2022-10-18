// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

import "../CpuPublicInputOffsetsBase.sol";

contract CpuPublicInputOffsets is CpuPublicInputOffsetsBase {
    // The following constants are offsets of data expected in the public input.
    uint256 internal constant OFFSET_ECDSA_BEGIN_ADDR = 14;
    uint256 internal constant OFFSET_ECDSA_STOP_PTR = 15;
    uint256 internal constant OFFSET_BITWISE_BEGIN_ADDR = 16;
    uint256 internal constant OFFSET_BITWISE_STOP_ADDR = 17;
    uint256 internal constant OFFSET_PUBLIC_MEMORY_PADDING_ADDR = 18;
    uint256 internal constant OFFSET_PUBLIC_MEMORY_PADDING_VALUE = 19;
    uint256 internal constant OFFSET_N_PUBLIC_MEMORY_PAGES = 20;
    uint256 internal constant OFFSET_PUBLIC_MEMORY = 21;

    // The format of the public input, starting at OFFSET_PUBLIC_MEMORY is as follows:
    //   * For each page:
    //     * First address in the page (this field is not included for the first page).
    //     * Page size.
    //     * Page hash.
    //   # All data above this line, appears in the initial seed of the proof.
    //   * For each page:
    //     * Cumulative product.
}
