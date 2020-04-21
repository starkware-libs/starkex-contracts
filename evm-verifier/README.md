# STARK Verifiers for StarkEx

StarkEx is a STARK-powered scalability engine for crypto exchanges. StarkEx uses cryptographic
proofs to attest to the validity of a batch of transactions (such as trades and transfers)
and updates a commitment to the state of the exchange onchain.

StarkEx allows exchanges to provide non-custodial trading at scale with high liquidity and lower
costs.

## Contracts

1. DexStatementVerifier - STARK verifier contract for StarkEx state updates. Accepts monolythic
   proofs.
2. DexFrilessStatementVerifier - Same as DexStatementVerifier but accepts partial proofs if the
   complementary Merkle and Fri proofs have been accepted by their appropriate verifiers.
3. MerkleStatementContract - Merkle verifier used by the DexFrilessStatementVerifier.
4. FriStatementContract - Fri verifier used by the DexFrilessStatementVerifier.
5. Auxilliary contracts used by the Dex Verifiers to calculate polynomial evaluations:
   1. DexConstraintPoly
   2. DexHashPointsXColumn
   3. DexHashPointsYColumn
   4. DexEcdsaPointsXColumn
   5. DexEcdsaPointsYColumn
   6. DexOods
