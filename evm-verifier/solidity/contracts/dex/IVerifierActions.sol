pragma solidity ^0.5.2;

/*
  Interface containing actions a verifier can invoke on the state.
  The contract containing the state should implement these and verify correctness.
*/
contract IVerifierActions {

    function updateState(
        uint256[] calldata publicInput,
        uint256[] calldata applicationData
    )
        external;
    /*
      Update state roots
      Verify that the old roots match.
      Implemented in the StateRoot contract.
    */
    function rootUpdate(
        uint256 oldVaultRoot,
        uint256 newVaultRoot,
        uint256 oldOrderRoot,
        uint256 newOrderRoot,
        uint256 vaultTreeHeightSent,
        uint256 orderTreeHeightSent
    )
        internal;


    /*
      Transfers funds from the on-chain deposit area to the off-chain area.
      Implemented in the Deposits contracts.
    */
    function acceptDeposit(
        uint256 starkKey,
        uint256 vaultId,
        uint256 tokenId,
        uint256 quantizedAmount
    )
        internal;

    /*
      Transfers funds from the off-chain area to the on-chain withdrawal area.
      Implemented in the Withdrawals contracts.
    */
    function acceptWithdrawal(
        uint256 starkKey,
        uint256 tokenId,
        uint256 quantizedAmount
    )
        internal;

    /*
      Implemented in the FullWithdrawal contracts.
    */
    function clearFullWithdrawalRequest(
        uint256 starkKey,
        uint256 vaultId
    )
        internal;
}
