pragma solidity ^0.5.2;

import "../libraries/LibConstants.sol";
import "../interfaces/MFreezable.sol";
import "../interfaces/MGovernance.sol";
import "./MainStorage.sol";

/*
  Implements MFreezable.
*/
contract Freezable is MainStorage, LibConstants, MGovernance, MFreezable {
    event LogFrozen();
    event LogUnFrozen();

    modifier notFrozen()
    {
        require(!stateFrozen, "STATE_IS_FROZEN");
        _;
    }

    modifier onlyFrozen()
    {
        require(stateFrozen, "STATE_NOT_FROZEN");
        _;
    }

    function isFrozen()
        external view
        returns (bool frozen) {
        frozen = stateFrozen;
    }

    function freeze()
        internal
        notFrozen()
    {
        // solium-disable-next-line security/no-block-members
        unFreezeTime = now + UNFREEZE_DELAY;

        // Update state.
        stateFrozen = true;

        // Log event.
        emit LogFrozen();
    }

    function unFreeze()
        external
        onlyFrozen()
        onlyGovernance()
    {
        // solium-disable-next-line security/no-block-members
        require(now >= unFreezeTime, "UNFREEZE_NOT_ALLOWED_YET");  // NOLINT: timestamp.

        // Update state.
        stateFrozen = false;

        // Increment roots to invalidate them, w/o losing information.
        vaultRoot += 1;
        orderRoot += 1;

        // Log event.
        emit LogUnFrozen();
    }

}
