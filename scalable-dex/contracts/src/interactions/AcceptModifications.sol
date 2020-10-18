pragma solidity ^0.5.2;

import "../libraries/LibConstants.sol";
import "../interfaces/MAcceptModifications.sol";
import "../interfaces/MTokenQuantization.sol";
import "../components/MainStorage.sol";

/*
  Interface containing actions a verifier can invoke on the state.
  The contract containing the state should implement these and verify correctness.
*/
contract AcceptModifications is
    MainStorage,
    LibConstants,
    MAcceptModifications,
    MTokenQuantization
{
    event LogWithdrawalAllowed(
        uint256 starkKey,
        uint256 assetType,
        uint256 nonQuantizedAmount,
        uint256 quantizedAmount
    );

    event LogNftWithdrawalAllowed(uint256 starkKey, uint256 assetId);

    event LogMintableWithdrawalAllowed(
        uint256 starkKey,
        uint256 assetId,
        uint256 quantizedAmount
    );

    /*
      Transfers funds from the on-chain deposit area to the off-chain area.
      Implemented in the Deposits contracts.
    */
    function acceptDeposit(
        uint256 starkKey,
        uint256 vaultId,
        uint256 assetId,
        uint256 quantizedAmount
    ) internal {
        // Fetch deposit.
        require(
            pendingDeposits[starkKey][assetId][vaultId] >= quantizedAmount,
            "DEPOSIT_INSUFFICIENT"
        );

        // Subtract accepted quantized amount.
        pendingDeposits[starkKey][assetId][vaultId] -= quantizedAmount;
    }

    /*
      Transfers funds from the off-chain area to the on-chain withdrawal area.
    */
    function allowWithdrawal(
        uint256 starkKey,
        uint256 assetId,
        uint256 quantizedAmount
    )
        internal
    {
        // Fetch withdrawal.
        uint256 withdrawal = pendingWithdrawals[starkKey][assetId];

        // Add accepted quantized amount.
        withdrawal += quantizedAmount;
        require(withdrawal >= quantizedAmount, "WITHDRAWAL_OVERFLOW");

        // Store withdrawal.
        pendingWithdrawals[starkKey][assetId] = withdrawal;

        // Log event.
        uint256 presumedAssetType = assetId;
        if (registeredAssetType[presumedAssetType]) {
            emit LogWithdrawalAllowed(
                starkKey,
                presumedAssetType,
                fromQuantized(presumedAssetType, quantizedAmount),
                quantizedAmount
            );
        } else if(assetId == ((assetId & MASK_240) | MINTABLE_ASSET_ID_FLAG)) {
            emit LogMintableWithdrawalAllowed(
                starkKey,
                assetId,
                quantizedAmount
            );
        }
        else {
            // In ERC721 case, assetId is not the assetType.
            require(withdrawal <= 1, "INVALID_NFT_AMOUNT");
            emit LogNftWithdrawalAllowed(starkKey, assetId);
        }
    }


    // Verifier authorizes withdrawal.
    function acceptWithdrawal(
        uint256 starkKey,
        uint256 assetId,
        uint256 quantizedAmount
    ) internal {
        allowWithdrawal(starkKey, assetId, quantizedAmount);
    }

    /*
      Implemented in the FullWithdrawal contracts.
    */
    function clearFullWithdrawalRequest(
        uint256 starkKey,
        uint256 vaultId
    )
        internal
    {
        // Reset escape request.
        fullWithdrawalRequests[starkKey][vaultId] = 0;  // NOLINT: reentrancy-benign.
    }
}
