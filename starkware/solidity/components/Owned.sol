// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.8.0;

/**
  Simple Ownership implementation.
  Applicable for non-upgradable contracts.
*/
abstract contract Owned {
    address public owner;
    address private pendingOwner;

    event OwnershipAccepted(address indexed newOwner);
    event OwnershipNominated(address indexed currentOwner, address indexed newOwner);
    event OwnershipNominationCleared();

    modifier onlyOwner() {
        require(msg.sender == owner, "ONLY_OWNER");
        _;
    }

    function transferOwnership(address newOwner) external onlyOwner {
        require(owner != newOwner, "ALREADY_OWNER");
        pendingOwner = newOwner;
        if (newOwner == address(0x0)) {
            emit OwnershipNominationCleared();
        } else {
            emit OwnershipNominated(owner, newOwner);
        }
    }

    function acceptOwnership() external {
        require(msg.sender == pendingOwner, "NOT_DESIGNATED_OWNER");
        _acceptOwnership(pendingOwner);
    }

    constructor(address _owner) {
        _acceptOwnership(_owner);
    }

    function _acceptOwnership(address newOwner) private {
        require(newOwner != address(0x0), "ZERO_OWNER_ADDRESS");
        delete pendingOwner;
        emit OwnershipAccepted(newOwner);
        owner = newOwner;
    }
}
