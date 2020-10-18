# StarkEx

StarkEx is a STARK-powered scalability engine for crypto exchanges. StarkEx uses cryptographic
proofs to attest to the validity of a batch of transactions (such as trades and transfers)
and updates a commitment to the state of the exchange onchain.

StarkEx allows exchanges to provide non-custodial trading at scale with high liquidity and lower
costs.

## Contracts

1. StarkExchange - The main exchange contract holding the exchage state and funds.
2. GpsFactRegistryAdapter - An adapter to the STARK verifier fact registry.
3. Committee - Verifies signatures attesting to off-chain data availability.
4. EscapeVerifier - Verifies that the contents of a vault belong to a certain Merkle commitment.
5. Proxy - Implements delegation of calls to other contracts. Used to allow time-locked
   StarkExchange updates.
6. ChangeVerifiersExternalInitializer - Implements an initialization procedure to be used for
   contract updates where the only state updates are the verifier contracts to be used.
