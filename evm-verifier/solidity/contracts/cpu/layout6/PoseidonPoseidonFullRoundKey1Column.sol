// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

contract PoseidonPoseidonFullRoundKey1Column {
    function compute(uint256 x) external pure returns(uint256 result) {
        uint256 PRIME = 0x800000000000011000000000000000000000000000000000000000000000001;

        assembly {
            // Use Horner's method to compute f(x).
            // The idea is that
            //   a_0 + a_1 * x + a_2 * x^2 + ... + a_n * x^n =
            //   (...(((a_n * x) + a_{n-1}) * x + a_{n-2}) * x + ...) + a_0.
            // Consequently we need to do deg(f) horner iterations that consist of:
            //   1. Multiply the last result by x
            //   2. Add the next coefficient (starting from the highest coefficient)
            //
            //  We slightly diverge from the algorithm above by updating the result only once
            //  every 7 horner iterations.
            //  We do this because variable assignment in solidity's functional-style assembly results in
            //  a swap followed by a pop.
            //  7 is the highest batch we can do due to the 16 slots limit in evm.
            result :=
                add(0x17190a2c4fe2fb2a1c4061a3aaa8d89e8a363f653a905e43ab819ff47516c67, mulmod(
                add(0x67fa64d83009acfaae5a7a0e910d322b5d4dbc825090c1239dc68cd18338ed4, mulmod(
                add(0x21052369229137423604dbda64cdab20290c4da86882c0444750eaf0687d1c8, mulmod(
                add(0x26315e8a17d10270d98790f94772ab99b185baeab1e0ec64e783de5c5b35859, mulmod(
                add(0x16ba64f5ffc9bcb3a71b49f79a1c26ce608e33f1b6ce5fdfeae1c732b5d0b5, mulmod(
                add(0x4430620ab3eb75b8b2c3ee9c8bafd3408efbe93661f670002b3f96d354c2bc0, mulmod(
                add(0x143ce163d9e857b549efa236512d839954411bc04e888aa114215f991ee8a57, mulmod(
                    result,
                x, PRIME)),
                x, PRIME)),
                x, PRIME)),
                x, PRIME)),
                x, PRIME)),
                x, PRIME)),
                x, PRIME))

            result :=
                add(0x587584d86e310744ac2167594e87c72847cc1018d766c61b29b572ba4552a80, mulmod(
                    result,
                x, PRIME))


        }
        return result % PRIME;
    }
}
