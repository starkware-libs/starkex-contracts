pragma solidity ^0.5.2;

import "../interfaces/IDexStatementVerifier.sol";
import "../interfaces/IVerifierActions.sol";
import "../interfaces/MApprovalChain.sol";
import "../interfaces/MFreezable.sol";
import "../interfaces/MOperator.sol";
import "../libraries/LibConstants.sol";
import "../libraries/LibErrors.sol";
import "../public/PublicInputOffsets.sol";

/**
  The StarkEx contract tracks the state of the off-chain exchange service by storing Merkle roots
  of the vault state (off-chain account state) and the order state (including fully executed and
  partially fulfilled orders).

  The :sol:mod:`Operator` is the only entity entitled to submit state updates by
  calling :sol:func:`updateState` and this is only allowed if the contract is not in the `frozen`
  state (see :sol:mod:`FullWithdrawals`). The call includes the public input of a STARK proof, and
  additional data (`applicationData`) that includes information not attested to by the proof.

  The public input includes the current (initial) and next (final) Merkle roots as mentioned above,
  the heights of the Merkle trees and for each ramping operation (deposit, withdraw, full withdraw)
  the following information:

  1. ID of the vault (off-chain account)
  2. Stark Key of the vault owner
  3. Token ID of the currency in the vault
  4. Vault balance before the operation
  5. Vault balance after the operation

  The above information is used by the exchange contract in order to update the pending accounts
  used for deposits (see :sol:mod:`Deposits`) and withdrawals (see :sol:mod:`Withdrawals`).

  The `applicationData` holds the number of ramping operations included in the batch as well as the
  key of the entity requesting each full withdrawal (see :sol:mod:`FullWithdrawals`). The latter is
  required in case an entity that isn't the owner of a vault requests a full withdrawal for that
  vault. In such a case the exchange contract marks the request as serviced but without performing
  the withdrawal.

  The STARK proof attesting to the validity of the state update is submitted separately by the
  exchange service to (one or more) STARK integrity verifier contract(s)
  (see :sol:mod:`IDexStatementVerifier`). Likewise, the signatures of committee members attesting to
  the availability of the vault and order data is submitted separately by the exchange service to
  (one or more) availability verifier contract(s) (see :sol:mod:`Committee`).

  The state update is only accepted by the exchange contract if the integrity verifier and
  availability verifier contracts have indeed received such proof of soundness and data
  availability.
*/
contract UpdateState is
    MApprovalChain,
    LibErrors,
    LibConstants,
    IVerifierActions,
    MFreezable,
    MOperator,
    PublicInputOffsets
{

    function updateState(
        uint256[] calldata publicInput,
        uint256[] calldata applicationData
    )
        external
        notFrozen()
        onlyOperator()
    {
        require(
            publicInput.length >= OFFSET_MODIFICATION_DATA,
            "publicInput does not contain all required fields.");
        require(publicInput[OFFSET_VAULT_FINAL_ROOT] < K_MODULUS, "New vault root >= PRIME.");
        require(publicInput[OFFSET_ORDER_FINAL_ROOT] < K_MODULUS, "New order root >= PRIME.");

        bytes32 publicInputFact = keccak256(abi.encodePacked(publicInput));
        verifyFact(
            verifiersChain, publicInputFact, NO_STATE_TRANSITION_VERIFIERS,
            NO_STATE_TRANSITION_PROOF);

        bytes32 availabilityFact = keccak256(
            abi.encodePacked(
            publicInput[OFFSET_VAULT_FINAL_ROOT], publicInput[OFFSET_VAULT_TREE_HEIGHT],
            publicInput[OFFSET_ORDER_FINAL_ROOT], publicInput[OFFSET_ORDER_TREE_HEIGHT],
            sequenceNumber + 1));
        verifyFact(
            availabilityVerifiersChain, availabilityFact, NO_AVAILABILITY_VERIFIERS,
            NO_AVAILABILITY_PROOF);

        performUpdateState(publicInput, applicationData);
    }

    function performUpdateState(
        uint256[] memory publicInput,
        uint256[] memory applicationData
    )
        internal
    {
        rootUpdate(
            publicInput[OFFSET_VAULT_INITIAL_ROOT],
            publicInput[OFFSET_VAULT_FINAL_ROOT],
            publicInput[OFFSET_ORDER_INITIAL_ROOT],
            publicInput[OFFSET_ORDER_FINAL_ROOT],
            publicInput[OFFSET_VAULT_TREE_HEIGHT],
            publicInput[OFFSET_ORDER_TREE_HEIGHT]
        );
        sendModifications(publicInput, applicationData);
    }

    function sendModifications(
        uint256[] memory publicInput,
        uint256[] memory applicationData
    ) private {
        require(
            applicationData.length >= APPLICATION_DATA_MODIFICATIONS_OFFSET,
            "applicationData does not contain all required fields.");
        uint256 nModifications = applicationData[APPLICATION_DATA_N_MODIFICATIONS_OFFSET];
        require(
            nModifications == (publicInput.length - OFFSET_MODIFICATION_DATA) / N_WORDS_PER_MODIFICATION,
            "Inconsistent number of modifications.");
        require(
            applicationData.length == nModifications + APPLICATION_DATA_MODIFICATIONS_OFFSET,
            "Inconsistent number of modifications in applicationData and publicInput.");

        for (uint256 i = 0; i < nModifications; i++) {
            uint256 modificationOffset = OFFSET_MODIFICATION_DATA + i * N_WORDS_PER_MODIFICATION;
            uint256 starkKey = publicInput[modificationOffset];
            uint256 requestingKey = applicationData[i + 1];
            uint256 tokenId = publicInput[modificationOffset + 1];

            require(starkKey < K_MODULUS, "Stark key >= PRIME");
            require(requestingKey < K_MODULUS, "Requesting key >= PRIME");
            require(tokenId < K_MODULUS, "Token id >= PRIME");

            uint256 actionParams = publicInput[modificationOffset + 2];
            uint256 amountBefore = (actionParams >> 192) & ((1 << 63) - 1);
            uint256 amountAfter = (actionParams >> 128) & ((1 << 63) - 1);
            uint256 vaultId = (actionParams >> 96) & ((1 << 31) - 1);

            if (requestingKey != 0) {
                // This is a false full withdrawal.
                require(
                    starkKey != requestingKey,
                    "False full withdrawal requesting_key should differ from the vault owner key.");
                require(amountBefore == amountAfter, "Amounts differ in false full withdrawal.");
                // The verified publicInput implies that the vaultId is currently owned by the
                // starkKey. Hence, any full withdrawal request coming from a different key for this
                // vaultId is false and may be cleared.
                clearFullWithdrawalRequest(requestingKey, vaultId);
                continue;
            }

            // This is a deposit.
            if (amountAfter > amountBefore) {
                uint256 quantizedAmount = amountAfter - amountBefore;
                acceptDeposit(starkKey, vaultId, tokenId, quantizedAmount);
            } else {
                // This is a withdrawal, in case the final amount is zero,
                // handled as a full withdrawal.
                if (amountBefore > amountAfter) {
                    uint256 quantizedAmount = amountBefore - amountAfter;
                    acceptWithdrawal(starkKey, tokenId, quantizedAmount);
                }
                if (amountAfter == 0) {
                    clearFullWithdrawalRequest(starkKey, vaultId);
                }
            }
        }
    }
}
