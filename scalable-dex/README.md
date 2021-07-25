# StarkEx

StarkEx is a STARK-powered scalability engine for crypto exchanges. StarkEx uses cryptographic
proofs to attest to the validity of a batch of transactions (such as trades and transfers)
and updates a commitment to the state of the exchange onchain.

StarkEx allows exchanges to provide non-custodial trading at scale with high liquidity and lower
costs.

Two versions of the StarkEx are implemented: One for spot trading (StarkExchange) and one for
derivates trading (StarkPerpetual).

## Contracts

1. StarkExchange - The main exchange contract holding the StarkEx spot trading exchage state and
   funds.
2. StarkPerpetual - The main exchange contract holding the StarkEx derivatives exchage state and
   funds.
3. GpsFactRegistryAdapter - An adapter to the STARK verifier fact registry.
4. Committee - Verifies signatures attesting to off-chain data availability (where applicable).
5. EscapeVerifier - Verifies that the contents of a StarkEx spot trading vault belong to a certain
   Merkle commitment.
6. PerpetualEscapeVerifier - Verifies that the contents of a StarkEx derivatives position belong to
   a certain Merkle commitment and calculates the amount allowed for escape.
7. Proxy - Implements delegation of calls to other contracts. Used to allow time-locked
   StarkExchange/StarkPerpetual updates.
8. ChangeVerifiersExternalInitializer - Implements an initialization procedure to be used for
   contract updates where the only state updates are the verifier contracts to be used.
9. ModifyUpgradeDelayExternalInitializer - Implements an initialization procedure to be used for
   contract updates where the only state update is the Proxy upgrade activation timelock.
10. UpdatePerpetualConfigExternalInitializer - Implements an initialization procedure to be used for
    contract updates where the only state update is the StarkPerpetual configuration hash.
11. V2toV3ChangesExternalInitializer - Implements an initialization procedure to be used for
    StarkEx contract updates from v2 contracts to v3 contracts which requires setting some default
    values.
