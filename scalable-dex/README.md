# StarkEx

StarkEx is a STARK-powered scalability engine for crypto exchanges. StarkEx uses cryptographic
proofs to attest to the validity of a batch of transactions (such as trades and transfers)
and updates a commitment to the state of the exchange onchain.

StarkEx allows exchanges to provide non-custodial trading at scale with high liquidity and lower
costs.

## Contracts

1. StarkExchange - The main exchange contract holding the exchage state and funds.
2. Committee - Verifies signatures attesting to off-chain data availability.
3. EscapeVerifier - Verifies that the contents of a vault belong to a certain Merkle commitment.
4. Proxy - Implements delegation of calls to other contracts. Used to allow time-locked StarkExchange updates.

