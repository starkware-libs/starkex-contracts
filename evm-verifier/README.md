# STARK Verifier for Cairo Programs

Cairo is the first production-grade platform for generating STARK proofs for general computation.
It is Turing Complete, and highly efficient. The following set of contracts implements the
verifier of programs written in Cairo, verifying the computational integrity of executing Cairo
program P on input data D, and the correctness of the post-execution state of the system.

The verifier is composed of multiple contracts as described below.

## Contracts

1. GpsStatementVerifier - Main verifier contract entry point for verifying Cairo programs wrapped in
   the context of a general bootloader.
2. CpuVerifier - STARK verifier for verifying Cairo statements
3. MerkleStatementContract - Merkle verifier used by the CpuVerifier.
4. FriStatementContract - Fri verifier used by the CpuVerifier.
5. MemoryPageFactRegistry - Fact registry for memory claims used by the CpuVerifier.
6. Auxilliary contracts used by the above verifiers to calculate polynomial evaluations:
   1. CpuConstraintPoly
   2. EcdsaPointsXColumn
   3. EcdsaPointsYColumn
   4. PedersenHashPointsXColumn
   5. PedersenHashPointsYColumn
   6. CpuOods
