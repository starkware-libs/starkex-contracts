pragma solidity ^0.5.2;


contract IDexStatementVerifier {

    /**
      Verifies that a STARK proof for an exchange state update is valid
      (see :sol:mod:`UpdateState`).

      The state update with respect to a batch of transactions is defined by a transition from a
      previous Merkle root to a new Merkle root as calculated over a series of off-chain vaults.
      It is considered to be valid as long as:

      - The transactions in the batch result in an update of the vault and order Merkle roots as they appear in the `publicInput`.
      - The transactions are valid.
      - For ramping transactions (deposits, withdrawals, full withdrawals), the proof is consistent with the transaction parameters that appear in the `publicInput`
      - The submitted STARK proof is accepted based on a set of valid proof parameters.

      The transactions currently supported include ramping transactions, token transfers (from one
      off-chain vault to another) and exchange settlements pairing two valid orders.

      If a state update is accepted, this is registered under the following claim hash that may
      later be queried for validity:

      `claimHash = keccak256(abi.encodePacked(publicInput))`

      For a high level overview of the system state, see
      this `StarkWare blog post <https://medium.com/starkware/starkdex-deep-dive-contracts-statement-3b500cf143c9>`_.

      @param proofParams In the format as follows (each row represents a 256-bit word):

          +-------------------------------------------------------------------+
          | Blowup factor                                                     |
          +-------------------------------------------------------------------+
          | Number of PoW bits                                                |
          +-------------------------------------------------------------------+
          | Log last FRI layer degree bound                                   |
          +-------------------------------------------------------------------+
          | Number of FRI steps (S)                                           |
          +-------------------------------------------------------------------+
          | FRI step 0 size                                                   |
          +-------------------------------------------------------------------+
          | ...                                                               |
          +-------------------------------------------------------------------+
          | FRI step S-1 size                                                 |
          +-------------------------------------------------------------------+

          - The number of queries to meet the verifier's security parameter will be derived from the blowup factor and number of PoW bits.
          - The sum of the FRI steps and the log of the last layer degree should equal the log of the expected STARK proof trace length.
          - Additional restrictions on the FRI step sizes may also be enforced by the verifier.

      @param publicInput In the format as follows (each row represents a 256-bit word):

          +-------------------------------------------------------------------+
          | Batch size                                                        |
          +-------------------------------------------------------------------+
          | Number of transactions                                            |
          +-------------------------------------------------------------------+
          | Global expiration timestamp                                       |
          +-------------------------------------------------------------------+
          | Intial vault root                                                 |
          +-------------------------------------------------------------------+
          | Final vault root                                                  |
          +-------------------------------------------------------------------+
          | Intial order root                                                 |
          +-------------------------------------------------------------------+
          | Final order root                                                  |
          +-------------------------------------------------------------------+
          | Vault Merkle tree height                                          |
          +-------------------------------------------------------------------+
          | Order Merkle tree height                                          |
          +-------------------------------------------------------------------+
          | Ramping operation 0 Stark Key                                     |
          +-------------------------------------------------------------------+
          | Ramping operation 0 Token ID                                      |
          +-------------------------------------------------------------------+
          | Ramping operation 0 Additional Info                               |
          +-------------------------------------------------------------------+
          | ...                                                               |
          +-------------------------------------------------------------------+
          | Ramping operation N Stark Key                                     |
          +-------------------------------------------------------------------+
          | Ramping operation N Token ID                                      |
          +-------------------------------------------------------------------+
          | Ramping operation N Additional Info                               |
          +-------------------------------------------------------------------+

          Three words per ramping operation should be provided where Additional Info has the
          following format (numbers indicate field sizes in bits):

          +-------------+------------+---------------+----------+---------------+
          | Amount      | Amount     | Vault ID (32) | Row (16) | Reserved (80) |
          |             |            |               |          |               |
          | before (64) | after (64) |               |          |               |
          +-------------+------------+---------------+----------+---------------+

          The Row parameter refers to the index of the ramping operation within the batch.

      @param proof The binary STARK proof. It's exact description is beyond the scope of this
        documentation.
    */
    function verifyProofAndRegister(
        uint256[] calldata proofParams,
        uint256[] calldata proof,
        uint256[] calldata publicInput
    )
        external;

    function isValid(bytes32 fact)
        external view
        returns(bool);
}
