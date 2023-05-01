// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

contract PoseidonPoseidonPartialRoundKey0Column {
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
                add(0x52208d8264d42061c7107f7945857541692a87bb1b4b4307c17d43193be3ad, mulmod(
                add(0x641cd514114aa297433e1ebb6f6fe8cf4c5b3816df09b39b38bf3851328781b, mulmod(
                add(0x6fba7ab30e117b743f154c4c1ef96007fbbff3b8cddbffbaa3cf1620dad0df2, mulmod(
                add(0x18e5bd14d527406ed33ef180f4351d66ba350fd42a210f14b13774666960edd, mulmod(
                add(0xaba2f20ea6ee9cae2a9a5ffab6bb531cae756025a2039dbb3fdc7f6a7ea66a, mulmod(
                add(0x624b1ba9e7d45d86f0a2ef7896a159e8e3d418234f3950ae2c1a1106b4d8e64, mulmod(
                add(0x3413bee8966e47edad4d25455e74664d547713650ae8ef6f7f4bd1d56077b55, mulmod(
                    result,
                x, PRIME)),
                x, PRIME)),
                x, PRIME)),
                x, PRIME)),
                x, PRIME)),
                x, PRIME)),
                x, PRIME))

            result :=
                add(0x7fdffd1f06d45f58c50609eddb9e4dcdf9845c3e13ae29fa3e6a4134615463a, mulmod(
                add(0x1125b5ff47f1e0c4105a6b62e2a6dcf3d71812409c77b4c708825299e70bcfd, mulmod(
                add(0x1e8db0feaf54299f9e0daa802e5a00c5b43dc189f622dc9d0d8039fc8f4eb16, mulmod(
                add(0xaa7db6d9cd63141d64bc671099b444013d3ac056afb7223fdf97319f7bd76f, mulmod(
                add(0x592bcd7384ba517197075eca669701a6d8eac3bdf21af499e3defd891fc8787, mulmod(
                add(0x58372f1bada3f7d38dee566363d48fc45a542d57a2357a00006f8c4508f3858, mulmod(
                add(0x44e2813694e35f41733099371352f930e87366ded64841028c54de5ae0cf86e, mulmod(
                    result,
                x, PRIME)),
                x, PRIME)),
                x, PRIME)),
                x, PRIME)),
                x, PRIME)),
                x, PRIME)),
                x, PRIME))

            result :=
                add(0x42240cb9baca23c27a0eb13e654a5af7a490b95b51a152b8a2da5f0752226, mulmod(
                add(0x6429e4ca7107ea29d85b4c45f4926f82d9d72206fdf33d7e499243b6a9ca81f, mulmod(
                add(0x4d2b779ec13ff444eafa96e2e505999c3f79b06939f6ec492378d2ccb49c3dc, mulmod(
                add(0x24c477665b5e4b3843749877bcce106ac76c085f15b0759fe9d8f1d04b723be, mulmod(
                add(0xc1e6049a1a088b613f8cb972734a8c4ee6d4bc5a359d5ebf272eff71312c01, mulmod(
                add(0x54beab500732d6102d1d501adac8f41fd04cf465e580d8664009c12e28fc5ed, mulmod(
                add(0x770f2c3dcb1befd2dbdd3e874a40ec38860828877139317823bc60ed3b69be4, mulmod(
                    result,
                x, PRIME)),
                x, PRIME)),
                x, PRIME)),
                x, PRIME)),
                x, PRIME)),
                x, PRIME)),
                x, PRIME))

            result :=
                add(0x4d5422ca4881cbaf9e99fe864068190670a6a1074e21de1382759182177eaf1, mulmod(
                add(0x324ea07796ce3412e6f938ef1a2974abcb3f8ff7114fef8e0fef438b6e69b89, mulmod(
                add(0x3a8053abe10aed5567dd7d40517596eb747cb829760fbc06f5bc322a0911c84, mulmod(
                add(0x398c6094de25847f31d6458f8bb9c6952ba9092ba7abc54d08050017ae2db64, mulmod(
                add(0x2b23cce09410c815c33da25e53f0204d5d6f474f5f784647a19e9114e4cf753, mulmod(
                add(0x5cd8a4ce2b3274c77469ce2c328d9f56ed2bafe7992707f64ce99d42968f648, mulmod(
                add(0x3c53eb4b33fc6cd4e86c4f3fbe866d358233a54b0f7c626f0ef3164ac48b189, mulmod(
                    result,
                x, PRIME)),
                x, PRIME)),
                x, PRIME)),
                x, PRIME)),
                x, PRIME)),
                x, PRIME)),
                x, PRIME))

            result :=
                add(0x163df55208e1561da127d03f6b63d46e0aa05a1ef3321cfd5711eb4d3fb3ff1, mulmod(
                add(0x489dffafde7fd6ef39e1542159c9d49bfdefe802fe6b358d6ddd1f28942ba69, mulmod(
                add(0x6f2eda70c3c0c744df7d7bdc1ded3d80f290f951649456874904374564edf90, mulmod(
                add(0x4291c5f5cb048e49b20c5b3caa1fa12b99ef81488aa83663110b12abfe704d8, mulmod(
                add(0x2a584b677c86b2a15d48c57df9dad7188545a3a994fef603e86ac16ce1facfa, mulmod(
                add(0xb375c79888613ea49838515cb5f6842dea48d273b9699855c67d0978f13925, mulmod(
                add(0x6db31dad71bfece85b88afc622cfdeaa557d4bfb3d3a313eaa4235dc7ec4ac9, mulmod(
                    result,
                x, PRIME)),
                x, PRIME)),
                x, PRIME)),
                x, PRIME)),
                x, PRIME)),
                x, PRIME)),
                x, PRIME))

            result :=
                add(0x6ec11adaf8da159cac400a273fdd7765371056001451e6441a6cc9da18beb31, mulmod(
                add(0x90916a638846883fc6bbc6c241dd630e4346567e5520bffeb17d0b05a17cbc, mulmod(
                add(0x5add69d3f68df10a5d626eed04e8c34e83780c2c3eb9e07bc49ce7f1fe9f618, mulmod(
                add(0x8bce38b2895c04a0c7620adef3a51a8319fc4e151359a52809b1509f48f662, mulmod(
                add(0x18e0bd645ba4fec89f9991a934891217ba872651494fc08589186d6e6dda88d, mulmod(
                add(0x50c9a8d62edbd150d6090cf1f0831c066282b324ca794df5aca0fbc9e71714d, mulmod(
                add(0x293681f3dfad87cd19bd1cdf5c6244a5f943e411d7a035121621f8692fa77f9, mulmod(
                    result,
                x, PRIME)),
                x, PRIME)),
                x, PRIME)),
                x, PRIME)),
                x, PRIME)),
                x, PRIME)),
                x, PRIME))

            result :=
                add(0x41b07a5f9241075a4ff1b76a9a529c9315f2435f79bab965fce61c8f616badd, mulmod(
                add(0x7f610dcb987484937a18dbae85c5b46f0bbc5f2cd845487501b2f1f7bf9357c, mulmod(
                add(0x4a2ae027e432c0863e1749b62e8533e649ed78091e11155d341cfe47168bb0, mulmod(
                add(0x7e9c35a05ef0ccb7cfe93272e0b46324e97e1512fa4c6e1d30ca2c00dc207b8, mulmod(
                add(0x2a05aa150252d7f810276589f79dbd0aa619289cd283f72ae0d34f141635a13, mulmod(
                add(0x3b09364e6fc149b3063a5442b78165712343e075297108206e246e0de596874, mulmod(
                add(0x58e3b2dc12d9ffe27bf5dc6c28a216e5612a7a0775f902c537806d2f60f4226, mulmod(
                    result,
                x, PRIME)),
                x, PRIME)),
                x, PRIME)),
                x, PRIME)),
                x, PRIME)),
                x, PRIME)),
                x, PRIME))

            result :=
                add(0x4dda9dce889ee4e52e93f3ccd9f32bbfbad5a8e1768aecab88170f78d5f0de1, mulmod(
                add(0x7523eb70ea4b345b7be4f151bfff9cdbfd589120b63d0b7a21a5cdc3d36aed9, mulmod(
                add(0x74155a89a923ea1e2a23985156091d435b5b815ae1e9fa573330f01d880e52f, mulmod(
                add(0x5bd0655433a76820184b6dd6fa4f3a67ebc321c75d1f9bc7422fac69074e2ff, mulmod(
                add(0x583d1f426394c7610a252cae8485a3e6fe2f5fcadc19fb5097a5c55c0787fd4, mulmod(
                add(0x410d9eaa6c615c482f890e4c738e555ac3e4892272617bc7a0ca80613e27fc9, mulmod(
                add(0x301f8e1e5f31d9f0546da692c88e007789002e56c4ccf68f3bd5fba12db838f, mulmod(
                    result,
                x, PRIME)),
                x, PRIME)),
                x, PRIME)),
                x, PRIME)),
                x, PRIME)),
                x, PRIME)),
                x, PRIME))

            result :=
                add(0x4ddf2d7e380560d571e765deec379fec8ae4d909848b18b5389ec295140687d, mulmod(
                add(0x3bd2aeed72b102694fc4a99c25a5250c234c91b03680ef4212885989ba9267f, mulmod(
                add(0x1da26a447725d6a61f31012a81300349baf580ddfaada24630d03ed293da28a, mulmod(
                add(0x5432e64cc316b7f386cf5467af442acb9d986873c5c513bdbdd133259ad54e3, mulmod(
                add(0x4eecc6622ccb897afcd651f5bb655b47101430a53a29bf743f5b1041ac8ff13, mulmod(
                add(0x1871b013899aedb3e2551a73c9f7f4189e86dddd5dfb8db56965e67812ace0a, mulmod(
                add(0x1cdad5777ab21cdea2c8f5994456ce2253e8b020ef32d4d12714106b7d2f632, mulmod(
                    result,
                x, PRIME)),
                x, PRIME)),
                x, PRIME)),
                x, PRIME)),
                x, PRIME)),
                x, PRIME)),
                x, PRIME))

            result :=
                add(0x47237ffdabc0cba010385bf48714bb06a6a2b9316394603c450330e743124ce, mulmod(
                    result,
                x, PRIME))


        }
        return result % PRIME;
    }
}
