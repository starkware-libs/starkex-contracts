pragma solidity ^0.5.2;

/*
  Interface containing actions a verifier can invoke on the state.
  The contract containing the state should implement these and verify correctness.
*/
contract MAcceptModifications {

    function acceptDeposit(
        uint256 starkKey,
        uint256 vaultId,
        uint256 assetId,
        uint256 quantizedAmount
    )
        internal;

    function allowWithdrawal(
        uint256 starkKey,
        uint256 assetId,
        uint256 quantizedAmount
    )
        internal;

    function acceptWithdrawal(
        uint256 starkKey,
        uint256 assetId,
        uint256 quantizedAmount
    )
        internal;

    function clearFullWithdrawalRequest(
        uint256 starkKey,
        uint256 vaultId
    )
        internal;
}
