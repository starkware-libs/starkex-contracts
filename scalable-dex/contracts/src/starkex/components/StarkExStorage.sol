// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.11;

import "../../components/MainStorage.sol";

/*
  Extends MainStorage, holds StarkEx App specific state (storage) variables.

  ALL State variables that are common to all applications, reside in MainStorage,
  whereas ALL the StarkEx app specific ones reside here.
*/
contract StarkExStorage is MainStorage {

    // Reserved storage space for Extensibility.
    // Every added MUST be added above the end gap, and the __endGap size must be reduced
    // accordingly.
    // NOLINTNEXTLINE: naming-convention shadowing-abstract.
    uint256[LAYOUT_LENGTH] private __endGap;  // __endGap complements layout to LAYOUT_LENGTH.
}
