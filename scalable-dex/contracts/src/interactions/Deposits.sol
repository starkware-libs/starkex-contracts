pragma solidity ^0.5.2;

import "../libraries/LibErrors.sol";
import "../libraries/LibConstants.sol";
import "../interfaces/IVerifierActions.sol";
import "../interfaces/MFreezable.sol";
import "../interfaces/MOperator.sol";
import "../interfaces/MUsers.sol";
import "../interfaces/MTokens.sol";
import "../components/MainStorage.sol";

/**
  For a user to perform a deposit to the contract two calls need to take place:

  1. A call to an ERC20 contract, authorizing this contract to trasnfer funds on behalf of the user.
  2. A call to :sol:func:`deposit` indicating the amount, token ID and target vault ID to which to send the deposit.

  The amount should be quantized, according to the specific quantization defined for the token ID.

  The result of the operation, assuming all requirements are met, is that an amount of ERC20 tokens
  equaling the amount specified in the :sol:func:`deposit` call times the quantization factor is
  transferred on behalf of the user to the contract. In addition, the contract adds the funds to an
  accumulator of pending deposits for the provided user, token ID and vault ID.

  Once a deposit is made, the exchange may include it in a proof which will result in addition
  of the amount(s) deposited to the off-chain vault with the specified ID. When the contract
  receives such valid proof, it deducts the transfered funds from the pending deposits for the
  specified user, token ID and vault ID.

  The exchange will not be able to move the deposited funds to the off-chain vault if the vault does
  not belong to the StarkKey associated with the user EthKey. However, this is not enforced by the
  contract but by the inability to create a valid STARK proof for such transfer.

  Until that point, the user may cancel the deposit by performing a time-locked cancel-deposit
  operation consisting of two calls:

  1. A call to :sol:func:`depositCancel`, setting a timer to enable reclaiming the deposit. Until this timer expires the user cannot reclaim funds as the exchange may still be processing the deposit for inclusion in the off chain vault.
  2. A call to :sol:func:`depositReclaim`, to perform the actual transfer of funds from the contract back to the ERC20 contract. This will only succeed if the timer set in the previous call has expired. The result should be the transfer of all funds not accounted for in proofs for off-chain inclusion, back to the user account on the ERC20 contract.

  Implements IVerifierActions.acceptDeposit.
  Uses MFreezable, MVerifiers, MUsers and MTokens.
*/
contract Deposits is MainStorage, LibErrors, LibConstants, IVerifierActions, MFreezable, MOperator,
                     MUsers, MTokens {
    event LogDeposit(
        uint256 starkKey,
        uint256 vaultId,
        uint256 tokenId,
        uint256 quantizedAmount
    );

    event LogDepositCancel(
        uint256 starkKey,
        uint256 vaultId,
        uint256 tokenId
    );

    event LogDepositCancelReclaimed(
        uint256 starkKey,
        uint256 vaultId,
        uint256 tokenId
    );

    function getDepositBalance(
        uint256 starkKey,
        uint256 tokenId,
        uint256 vaultId
    )
        external view
        returns (uint256 balance)
    {
        balance = fromQuantized(tokenId, pendingDeposits[starkKey][tokenId][vaultId]);
    }

    function deposit(
        uint256 tokenId,
        uint256 vaultId,
        uint256 quantizedAmount
    )
        public
        notFrozen()
    {
        // No need to verify amount > 0, a deposit with amount = 0 can be used to undo cancellation.
        require(vaultId <= MAX_VAULT_ID, OUT_OF_RANGE_VAULT_ID);

        // Fetch user and key.
        address user = msg.sender;
        uint256 starkKey = getStarkKey(user);

        // Update the balance.
        pendingDeposits[starkKey][tokenId][vaultId] += quantizedAmount;
        require(pendingDeposits[starkKey][tokenId][vaultId] >= quantizedAmount, DEPOSIT_OVERFLOW);

        // Disable the timeout.
        delete cancellationRequests[starkKey][tokenId][vaultId];

        // Transfer the tokens to the Deposit contract.
        transferIn(tokenId, quantizedAmount);

        // Log event.
        emit LogDeposit(starkKey, vaultId, tokenId, quantizedAmount);
    }

    function deposit(
        uint256 tokenId,
        uint256 vaultId
    )
        external payable
    {
        require(isEther(tokenId), INVALID_TOKEN_ID);
        deposit(tokenId, vaultId, toQuantized(tokenId, msg.value));
    }


    function depositCancel(uint256 tokenId, uint256 vaultId)
        external
        // No modifiers: This function can always be used, even when frozen.
    {
        require(vaultId <= MAX_VAULT_ID, OUT_OF_RANGE_VAULT_ID);

        // Fetch user and key.
        address user = msg.sender;
        uint256 starkKey = getStarkKey(user);

        // Start the timeout.
        // solium-disable-next-line security/no-block-members
        cancellationRequests[starkKey][tokenId][vaultId] = now;

        // Log event.
        emit LogDepositCancel(starkKey, vaultId, tokenId);
    }

    function depositReclaim(uint256 tokenId, uint256 vaultId)
        external
        // No modifiers: This function can always be used, even when frozen.
    {
        require(vaultId <= MAX_VAULT_ID, OUT_OF_RANGE_VAULT_ID);

        // Fetch user and key.
        address user = msg.sender;
        uint256 starkKey = getStarkKey(user);

        // Make sure enough time has passed.
        uint256 requestTime = cancellationRequests[starkKey][tokenId][vaultId];
        require(requestTime != 0, DEPOSIT_NOT_CANCELED);
        uint256 freeTime = requestTime + DEPOSIT_CANCEL_DELAY;
        assert(freeTime >= DEPOSIT_CANCEL_DELAY);
        // solium-disable-next-line security/no-block-members
        require(now >= freeTime, DEPOSIT_LOCKED);

        // Clear deposit.
        uint256 quantizedAmount = pendingDeposits[starkKey][tokenId][vaultId];
        delete pendingDeposits[starkKey][tokenId][vaultId];
        delete cancellationRequests[starkKey][tokenId][vaultId];

        // Refund deposit.
        transferOut(tokenId, quantizedAmount);

        // Log event.
        emit LogDepositCancelReclaimed(starkKey, vaultId, tokenId);
    }

    function acceptDeposit(
        uint256 starkKey,
        uint256 vaultId,
        uint256 tokenId,
        uint256 quantizedAmount
    )
        internal
    {
        // Fetch deposit.
        require(
            pendingDeposits[starkKey][tokenId][vaultId] >= quantizedAmount,
            DEPOSIT_INSUFFICIENT);

        // Subtract accepted quantized amount.
        pendingDeposits[starkKey][tokenId][vaultId] -= quantizedAmount;
    }
}
