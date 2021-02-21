// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.11;

contract OnchainDataFactTreeEncoder {
    // The number of additional words appended to the public input when using the
    // OnchainDataFactTreeEncoder format.

    uint256 internal constant ONCHAIN_DATA_FACT_ADDITIONAL_WORDS = 2;

    /*
      Encodes a GPS fact Merkle tree where the root has two children.
      The left child contains the data we care about and the right child contains
      on-chain data for the fact.

      minimalValidLength is the minimal possible length of the data in the left node.
    */
    function encodeFactWithOnchainData(
        uint256[] memory publicInput, uint256 minimalValidLength
    )
        internal pure
        returns (bytes32)
    {
        // The state transition fact is computed as a Merkle tree, as defined in
        // GpsOutputParser.
        //
        // In our case the fact tree looks as follows:
        //   The root has two children.
        //   The left child is a leaf that includes the main part - the information regarding
        //   the state transition required by this contract.
        //   The right child contains the onchain-data which shouldn't be accessed by this
        //   contract, so we are only given its hash and length
        //   (it may be a leaf or an inner node, this has no effect on this contract).

        require(
            publicInput.length >= minimalValidLength + ONCHAIN_DATA_FACT_ADDITIONAL_WORDS,
            "publicInput does not contain all required fields.");

        // Compute the hash without the two additional fields.
        uint256 mainPublicInputLen = publicInput.length - ONCHAIN_DATA_FACT_ADDITIONAL_WORDS;
        bytes32 mainPublicInputHash;
        assembly {
            mainPublicInputHash := keccak256(
                add(publicInput, 0x20), mul(0x20, mainPublicInputLen))
        }

        // Compute the hash of the fact Merkle tree.
        bytes32 hashResult = keccak256(
            abi.encodePacked(
                mainPublicInputHash,
                mainPublicInputLen,
                /*The hash of the onchain-data node*/ publicInput[publicInput.length - 2],
                mainPublicInputLen +
                /*The size of the onchain-data node*/ publicInput[publicInput.length - 1]
            )
        );
        // Add one to the hash to indicate it represents an inner node, rather than a leaf.
        return bytes32(uint256(hashResult) + 1);
    }
}
