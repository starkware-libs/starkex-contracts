// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

contract PoseidonPoseidonFullRoundKey2Column {
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
                add(0x646004831088eedddafcec3518108e2033e3e613eb2b2b0ca972f75946901ba, mulmod(
                add(0x71a637fccbfdcc8da4828cb4734b6887fe9ebd78725ceb92d2756ea4e4c86fb, mulmod(
                add(0x2fa9daffc6ffa8c6dd8cf633aa7c2d2a113a885f4ba935ff7f0198a4ea056cf, mulmod(
                add(0x71273291cc9fb7c500b008872a8890e1e3917ea2b954d1f4a9af67427323126, mulmod(
                add(0x27a6021b1b06d9adf868d5ba9b068ecdee5e65fe62163095b96f7f4c2fa6c3e, mulmod(
                add(0x6217cc4bd0f62fec8a25f305b3914f3c6c2df7701aee105c60cd37ef815239a, mulmod(
                add(0x565a88ff293c0a9c48cb67be157ad800604990d390e1b173e9bdc09abf9f788, mulmod(
                    result,
                x, PRIME)),
                x, PRIME)),
                x, PRIME)),
                x, PRIME)),
                x, PRIME)),
                x, PRIME)),
                x, PRIME))

            result :=
                add(0x7d384f90e1f21f53dbafb1648ecdb97d8c020dbad501b0d79a491587484fefa, mulmod(
                    result,
                x, PRIME))


        }
        return result % PRIME;
    }
}
