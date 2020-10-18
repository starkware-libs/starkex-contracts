pragma solidity ^0.5.2;

import "../libraries/LibConstants.sol";
import "../interfaces/MAcceptModifications.sol";
import "../interfaces/MFreezable.sol";
import "../interfaces/IFactRegistry.sol";
import "../interfaces/MStateRoot.sol";
import "../components/MainStorage.sol";

/**
  Escaping the exchange is the last resort for users that wish to withdraw their funds without
  relying on off-chain exchange services. The Escape functionality may only be invoked once the
  contract has become frozen. This will be as the result of an unserviced full withdraw request
  (see :sol:mod:`FullWithdrawals`). At that point, any escaper entity may perform an escape
  operation as follows:

  1. Escapers must obtain a Merkle path of a vault to be evicted with respect to the frozen vault tree root. Typically, once the exchange is frozen, such data will be made public or would be obtainable from an exchange API, depending on the data availability approach used by the exchange.
  2. Escapers call the :sol:mod:`EscapeVerifier` contract with the Merkle proof for the vault to be evicted. If the proof is valid, this results in the registration of such proof.
  3. Escapers call :sol:func:`escape` function with the same parameters as submitted to the :sol:mod:`EscapeVerifier` (i.e. the vault ID, Stark Key of the vault owner, the asset ID and the vault balance), sans the Merkle proof. If a proof was accepted for the same parameters by the :sol:mod:`EscapeVerifier`, and no prior escape call was made for the vault, the contract adds the vault balance to an on-chain pending withdrawals account under the Stark Key of the vault owner and the appropriate asset ID.
  4. The owner of the vault may then withdraw this amount from the pending withdrawals account by calling the normal withdraw function (see :sol:mod:`Withdrawals`) to transfer the funds to the users Eth or ERC20 account (depending on the token type).

  Note that while anyone can perform the initial steps of the escape operation (including the
  exchange operator, for example), only the owner of the vault may perform the final step of
  transferring the funds.
*/
contract Escapes is MainStorage, MAcceptModifications, MFreezable, MStateRoot {
    function initialize (
        IFactRegistry escapeVerifier
    ) internal
    {
        escapeVerifier_ = escapeVerifier;
    }
    /*
      Escape when the contract is frozen.
    */
    function escape(
        uint256 starkKey,
        uint256 vaultId,
        uint256 assetId,
        uint256 quantizedAmount
    )
        external
        onlyFrozen()
    {
        require(!escapesUsed[vaultId], "ESCAPE_ALREADY_USED");

        // Escape can be used only once.
        escapesUsed[vaultId] = true;
        escapesUsedCount += 1;

        bytes32 claimHash = keccak256(
            abi.encode(
        starkKey, assetId, quantizedAmount, getVaultRoot(), getVaultTreeHeight(), vaultId));
        require(escapeVerifier_.isValid(claimHash), "ESCAPE_LACKS_PROOF");

        allowWithdrawal(starkKey, assetId, quantizedAmount);
    }
}
