// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.6.12;

import "../components/FactRegistry.sol";
import "../cpu/CpuPublicInputOffsetsBase.sol";

/*
  A utility contract to parse the GPS output.
  See registerGpsFacts for more details.
*/
contract GpsOutputParser is CpuPublicInputOffsetsBase, FactRegistry {
    uint256 internal constant METADATA_TASKS_OFFSET = 1;
    uint256 internal constant METADATA_OFFSET_TASK_OUTPUT_SIZE = 0;
    uint256 internal constant METADATA_OFFSET_TASK_PROGRAM_HASH = 1;
    uint256 internal constant METADATA_OFFSET_TASK_N_TREE_PAIRS = 2;
    uint256 internal constant METADATA_TASK_HEADER_SIZE = 3;

    uint256 internal constant METADATA_OFFSET_TREE_PAIR_N_PAGES = 0;
    uint256 internal constant METADATA_OFFSET_TREE_PAIR_N_NODES = 1;

    uint256 internal constant NODE_STACK_OFFSET_HASH = 0;
    uint256 internal constant NODE_STACK_OFFSET_END = 1;
    // The size of each node in the node stack.
    uint256 internal constant NODE_STACK_ITEM_SIZE = 2;

    uint256 internal constant FIRST_CONTINUOUS_PAGE_INDEX = 1;

    /*
      Logs the program output fact together with the relevant continuous memory pages' hashes.
      The event is emitted for each registered fact.
    */
    event LogMemoryPagesHashes(bytes32 programOutputFact, bytes32[] pagesHashes);

    /*
      Parses the GPS program output (using taskMetadata, which should be verified by the caller),
      and registers the facts of the tasks which were executed.

      The first entry in taskMetadata is the number of tasks.

      For each task, the structure is as follows:
        1. Size (including the size and hash fields).
        2. Program hash.
        3. The number of pairs in the Merkle tree structure (see below).
        4. The Merkle tree structure (see below).

      The fact of each task is stored as a (non-binary) Merkle tree.
      Leaf nodes are labeled with the hash of their data.
      Each non-leaf node is labeled as 1 + the hash of (node0, end0, node1, end1, ...)
      where node* is a label of a child children and end* is the total number of data words up to
      and including that node and its children (including the previous sibling nodes).
      We add 1 to the result of the hash to prevent an attacker from using a preimage of a leaf node
      as a preimage of a non-leaf hash and vice versa.

      The structure of the tree is passed as a list of pairs (n_pages, n_nodes), and the tree is
      constructed using a stack of nodes (initialized to an empty stack) by repeating for each pair:
      1. Add n_pages to the stack of nodes.
      2. Pop the top n_nodes, construct a parent node for them, and push it back to the stack.
      After applying the steps above, the stack much contain exactly one node, which will
      constitute the root of the Merkle tree.
      For example, [(2, 2)] will create a Merkle tree with a root and two direct children, while
      [(3, 2), (0, 2)] will create a Merkle tree with a root whose left child is a leaf and
      right child has two leaf children.

      Assumptions: taskMetadata and cairoAuxInput are verified externally.
    */
    function registerGpsFacts(
        uint256[] calldata taskMetadata,
        uint256[] memory publicMemoryPages,
        uint256 outputStartAddress
    ) internal {
        uint256 totalNumPages = publicMemoryPages[0];

        // Allocate some of the loop variables here to avoid the stack-too-deep error.
        uint256 task;
        uint256 nTreePairs;
        uint256 nTasks = taskMetadata[0];

        // Contains fact hash with the relevant memory pages' hashes.
        // Size is bounded from above with the total number of pages. Three extra places are
        // dedicated for the fact hash and the array address and length.
        uint256[] memory pageHashesLogData = new uint256[](totalNumPages + 3);
        // Relative address to the beginning of the memory pages' hashes in the array.
        pageHashesLogData[1] = 0x40;

        uint256 taskMetadataOffset = METADATA_TASKS_OFFSET;

        // Skip the 5 first output cells which contain the bootloader config, the number of tasks
        // and the size and program hash of the first task. curAddr points to the output of the
        // first task.
        uint256 curAddr = outputStartAddress + 5;

        // Skip the main page.
        uint256 curPage = FIRST_CONTINUOUS_PAGE_INDEX;

        // Bound the size of the stack by the total number of pages.
        uint256[] memory nodeStack = new uint256[](NODE_STACK_ITEM_SIZE * totalNumPages);

        // Copy to memory to workaround the "stack too deep" error.
        uint256[] memory taskMetadataCopy = taskMetadata;

        uint256[PAGE_INFO_SIZE] memory pageInfoPtr;
        assembly {
            // Skip the array length and the first page.
            pageInfoPtr := add(add(publicMemoryPages, 0x20), PAGE_INFO_SIZE_IN_BYTES)
        }

        // Register the fact for each task.
        for (task = 0; task < nTasks; task++) {
            uint256 curOffset = 0;
            uint256 firstPageOfTask = curPage;
            nTreePairs = taskMetadataCopy[taskMetadataOffset + METADATA_OFFSET_TASK_N_TREE_PAIRS];

            // Build the Merkle tree using a stack (see the function documentation) to compute
            // the fact.
            uint256 nodeStackLen = 0;
            for (uint256 treePair = 0; treePair < nTreePairs; treePair++) {
                // Add nPages to the stack of nodes.
                uint256 nPages = taskMetadataCopy[
                    taskMetadataOffset +
                        METADATA_TASK_HEADER_SIZE +
                        2 *
                        treePair +
                        METADATA_OFFSET_TREE_PAIR_N_PAGES
                ];

                // Ensure 'nPages' is bounded from above as a sanity check
                // (the bound is somewhat arbitrary).
                require(nPages < 2**20, "Invalid value of n_pages in tree structure.");

                for (uint256 i = 0; i < nPages; i++) {
                    (uint256 pageSize, uint256 pageHash) = pushPageToStack(
                        pageInfoPtr,
                        curAddr,
                        curOffset,
                        nodeStack,
                        nodeStackLen
                    );
                    pageHashesLogData[curPage - firstPageOfTask + 3] = pageHash;
                    curPage += 1;
                    nodeStackLen += 1;
                    curAddr += pageSize;
                    curOffset += pageSize;

                    assembly {
                        pageInfoPtr := add(pageInfoPtr, PAGE_INFO_SIZE_IN_BYTES)
                    }
                }

                // Pop the top n_nodes, construct a parent node for them, and push it back to the
                // stack.
                uint256 nNodes = taskMetadataCopy[
                    taskMetadataOffset +
                        METADATA_TASK_HEADER_SIZE +
                        2 *
                        treePair +
                        METADATA_OFFSET_TREE_PAIR_N_NODES
                ];
                if (nNodes != 0) {
                    nodeStackLen = constructNode(nodeStack, nodeStackLen, nNodes);
                }
            }
            require(nodeStackLen == 1, "Node stack must contain exactly one item.");

            uint256 programHash = taskMetadataCopy[
                taskMetadataOffset + METADATA_OFFSET_TASK_PROGRAM_HASH
            ];

            // Verify that the sizes of the pages correspond to the task output, to make
            // sure that the computed hash is indeed the hash of the entire output of the task.
            {
                uint256 outputSize = taskMetadataCopy[
                    taskMetadataOffset + METADATA_OFFSET_TASK_OUTPUT_SIZE
                ];

                require(
                    nodeStack[NODE_STACK_OFFSET_END] + 2 == outputSize,
                    "The sum of the page sizes does not match output size."
                );
            }

            uint256 programOutputFact = nodeStack[NODE_STACK_OFFSET_HASH];
            bytes32 fact = keccak256(abi.encode(programHash, programOutputFact));

            // Update taskMetadataOffset.
            taskMetadataOffset += METADATA_TASK_HEADER_SIZE + 2 * nTreePairs;

            {
                // Log the output Merkle root with the hashes of the relevant memory pages.
                // Instead of emit, we use log1 https://docs.soliditylang.org/en/v0.4.24/assembly.html,
                // https://docs.soliditylang.org/en/v0.6.2/abi-spec.html#use-of-dynamic-types.

                bytes32 logHash = keccak256("LogMemoryPagesHashes(bytes32,bytes32[])");
                assembly {
                    let buf := add(pageHashesLogData, 0x20)
                    // Number of memory pages that are relevant for this fact.
                    let length := sub(curPage, firstPageOfTask)
                    mstore(buf, programOutputFact)
                    mstore(add(buf, 0x40), length)
                    log1(buf, mul(add(length, 3), 0x20), logHash)
                }
            }
            registerFact(fact);

            // Move curAddr to the output of the next task (skipping the size and hash fields).
            curAddr += 2;
        }

        require(totalNumPages == curPage, "Not all memory pages were processed.");
    }

    /*
      Push one page (curPage) to the top of the node stack.
      curAddr is the memory address, curOffset is the offset from the beginning of the task output.
      Verifies that the page has the right start address and returns the page size and the page
      hash.
    */
    function pushPageToStack(
        uint256[PAGE_INFO_SIZE] memory pageInfoPtr,
        uint256 curAddr,
        uint256 curOffset,
        uint256[] memory nodeStack,
        uint256 nodeStackLen
    ) private pure returns (uint256 pageSize, uint256 pageHash) {
        // Read the first address, page size and hash.
        uint256 pageAddr = pageInfoPtr[PAGE_INFO_ADDRESS_OFFSET];
        pageSize = pageInfoPtr[PAGE_INFO_SIZE_OFFSET];
        pageHash = pageInfoPtr[PAGE_INFO_HASH_OFFSET];

        // Ensure 'pageSize' is bounded as a sanity check (the bound is somewhat arbitrary).
        require(pageSize < 2**30, "Invalid page size.");
        require(pageAddr == curAddr, "Invalid page address.");

        nodeStack[NODE_STACK_ITEM_SIZE * nodeStackLen + NODE_STACK_OFFSET_END] =
            curOffset +
            pageSize;
        nodeStack[NODE_STACK_ITEM_SIZE * nodeStackLen + NODE_STACK_OFFSET_HASH] = pageHash;
    }

    /*
      Pops the top nNodes nodes from the stack and pushes one parent node instead.
      Returns the new value of nodeStackLen.
    */
    function constructNode(
        uint256[] memory nodeStack,
        uint256 nodeStackLen,
        uint256 nNodes
    ) private pure returns (uint256) {
        require(nNodes <= nodeStackLen, "Invalid value of n_nodes in tree structure.");
        // The end of the node is the end of the last child.
        uint256 newNodeEnd = nodeStack[
            NODE_STACK_ITEM_SIZE * (nodeStackLen - 1) + NODE_STACK_OFFSET_END
        ];
        uint256 newStackLen = nodeStackLen - nNodes;
        // Compute node hash.
        uint256 nodeStart = 0x20 + newStackLen * NODE_STACK_ITEM_SIZE * 0x20;
        uint256 newNodeHash;
        assembly {
            newNodeHash := keccak256(
                add(nodeStack, nodeStart),
                mul(
                    nNodes,
                    // NODE_STACK_ITEM_SIZE * 0x20 =
                    0x40
                )
            )
        }

        nodeStack[NODE_STACK_ITEM_SIZE * newStackLen + NODE_STACK_OFFSET_END] = newNodeEnd;
        // Add one to the new node hash to distinguish it from the hash of a leaf (a page).
        nodeStack[NODE_STACK_ITEM_SIZE * newStackLen + NODE_STACK_OFFSET_HASH] = newNodeHash + 1;
        return newStackLen + 1;
    }
}
