pragma solidity ^0.5.2;

import "../libraries/LibErrors.sol";
import "../interfaces/IVerifierActions.sol";
import "../interfaces/MFreezable.sol";
import "../interfaces/MOperator.sol";
import "../interfaces/MUsers.sol";
import "../interfaces/MTokens.sol";
import "../interfaces/MWithdrawal.sol";
import "../components/MainStorage.sol";

/**
  For a user to perform a withdrawal operation from the Stark Exchange during normal operation
  two calls are required:

  1. A call to an offchain exchange API, requesting a withdrawal from a user account (vault).
  2. A call to the on-chain :sol:func:`withdraw` function to perform the actual withdrawal of funds transfering them to the users Eth or ERC20 account (depending on the token type).

  For simplicity, hereafter it is assumed that all tokens are ERC20 tokens but the text below
  applies to Eth in the same manner.

  In the first call mentioned above, anyone can call the API to request the withdrawal of an
  amount from a given vault. Following the request, the exchange may include the withdrawal in a
  STARK proof. The submission of a proof then results in the addition of the amount(s) withdrawn to
  an on-chain pending withdrawals account under the stark key of the vault owner and the appropriate
  token ID. At the same time, this also implies that this amount is deducted from the off-chain
  vault.

  Once the amount to be withdrawn has been transfered to the on-chain pending withdrawals account,
  the user may perform the second call mentioned above to complete the transfer of funds from the
  Stark Exchange contract to the appropriate ERC20 account. Only a user holding the Eth key
  corresponding to the Stark Key of a pending withdrawals account may perform this operation.

  It is possible that for multiple withdrawal calls to the API, a single withdrawal call to the
  contract may retrieve all funds, as long as they are all for the same token ID.

  The result of the operation, assuming all requirements are met, is that an amount of ERC20 tokens
  in the pending withdrawal account times the quantization factor is transferred to the ERC20
  account of the user.

  A withdrawal request cannot be cancelled. Once funds reach the pending withdrawals account
  on-chain, they cannot be moved back into an off-chain vault before completion of the withdrawal
  to the ERC20 account of the user.

  In the event that the exchange reaches a frozen state the user may perform a withdrawal operation
  via an alternative flow, known as the "Escape" flow. In this flow, the API call above is replaced
  with an :sol:func:`escape` call to the on-chain contract (see :sol:mod:`Escapes`) proving the
  ownership of off-chain funds. If such proof is accepted, the user may proceed as above with
  the :sol:func:`withdraw` call to the contract to complete the operation.

  Implements IVerifierActions.acceptWithdrawal.
  Uses MFreezable, MOperator, MVerifiers, MUsers and MTokens.
*/
contract Withdrawals is MainStorage, LibErrors, IVerifierActions, MFreezable, MOperator,
                        MUsers, MTokens, MWithdrawal {
    event LogWithdrawal(
        uint256 starkKey,
        uint256 tokenId,
        uint256 quantizedAmount
    );

    event LogUserWithdrawal(
        uint256 starkKey,
        uint256 tokenId,
        uint256 quantizedAmount
    );

    function getWithdrawalBalance(
        uint256 starkKey,
        uint256 tokenId
    )
        external view
        returns (uint256 balance)
    {
        balance = fromQuantized(tokenId, pendingWithdrawals[starkKey][tokenId]);
    }

    /*
      Allows a user to withdraw accepted funds.
      This function can be called normally while frozen.
    */
    function withdraw(
        uint256 tokenId
    )
        external
        // Can be called normally and while frozen.
    {
        // Fetch user and key.
        address etherKey = msg.sender;
        uint256 starkKey = getStarkKey(etherKey);

        // Fetch and clear quantized amount.
        uint256 quantizedAmount = pendingWithdrawals[starkKey][tokenId];
        pendingWithdrawals[starkKey][tokenId] = 0;

        // Transfer funds.
        transferOut(tokenId, quantizedAmount);
        emit LogUserWithdrawal(starkKey, tokenId, quantizedAmount);
    }

    /*
      Allows a verifier to authorize a withdrawal.
    */
    function allowWithdrawal(
        uint256 starkKey,
        uint256 tokenId,
        uint256 quantizedAmount
    )
        internal
    {
        // Fetch withdrawal.
        uint256 withdrawal = pendingWithdrawals[starkKey][tokenId];

        // Add accepted quantized amount.
        withdrawal += quantizedAmount;
        require(withdrawal >= quantizedAmount, WITHDRAWAL_OVERFLOW);

        // Store withdrawal.
        pendingWithdrawals[starkKey][tokenId] = withdrawal;

        // Log event.
        emit LogWithdrawal(starkKey, tokenId, quantizedAmount);
    }


    // Verifier authorizes withdrawal.
    function acceptWithdrawal(
        uint256 starkKey,
        uint256 tokenId,
        uint256 quantizedAmount
    )
        internal
    {
        allowWithdrawal(starkKey, tokenId, quantizedAmount);
    }
}
