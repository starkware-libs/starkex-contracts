// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.8.24;

import "starkware/solidity/components/Executor.sol";
import "starkware/solidity/components/Owned.sol";

uint256 constant TX_EXECUTED = 1;
uint256 constant MAX_DELAY = 28 days;
uint256 constant MIN_EXPIRATION = 1 hours;
uint256 constant MAX_EXPIRATION = 52 weeks;

/**
  Delayed executor execute transactions (or batches of txs), only for the owner,
  and only after a certain delay since its registration.

  A transaction has to be registered by the owner, and after the delay has passed,
  the owner can call its execution.

  If a batch transaction is registered then that batch exactly has to be executed.
  I.e. the registered entity is the batch itself, and it has to be executed exactly as registered.
*/
contract DelayedExecutor is Executor, Owned {
    event TransactionRegistered(address target, bytes data, bytes32 txSetHash, uint256 enableTime);
    event PayableTransactionRegistered(
        address target,
        uint256 eth_value,
        bytes data,
        bytes32 txSetHash,
        uint256 enableTime
    );
    event MultiTransactionRegistered(
        address[] targets,
        bytes[] datas,
        bytes32 txSetHash,
        uint256 enableTime
    );
    event MultiPayableTransactionRegistered(
        address[] targets,
        uint256[] eth_values,
        bytes[] datas,
        bytes32 txSetHash,
        uint256 enableTime
    );

    // The delay (seconds) required between registration and execution.
    uint256 public immutable executionDelay;

    // Execution can be done only within `executionExpiration` seconds since active.
    uint256 public immutable executionExpiration;

    // A map from registered tx/multi-tx hash to eligible activation time.
    mapping(bytes32 => uint256) public txSetAllowedTime;

    constructor(
        address _owner,
        uint256 delay,
        uint256 expiration
    ) Owned(_owner) {
        require(delay <= MAX_DELAY, "DELAY_TOO_LONG");
        require(expiration >= MIN_EXPIRATION, "EXPIRATION_TOO_SHORT");
        require(expiration <= MAX_EXPIRATION, "EXPIRATION_TOO_LONG");
        executionDelay = delay;
        executionExpiration = expiration;
    }

    // Allowing contract to receive eth, to allow adding balance to it.
    // Useful to allow txs that need eth to use existing balance.
    receive() external payable {}

    // As a key we use the entire tx data, excluding the selector,
    // so that txKey(registerTransaction(...)) == txKey(execTransaction(...)).
    function txKey(TxSetType setType) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked(setType, msg.data[4:]));
    }

    /**
      Reset the executed entry.
      This function is called by the executing functions in Executor.
    */
    function preExec(TxSetType setType) internal virtual override {
        txSetAllowedTime[txKey(setType)] = TX_EXECUTED;
    }

    function isAllowed(TxSetType setType) internal virtual override returns (bool, string memory) {
        uint256 _txtime = txSetAllowedTime[txKey(setType)];
        if (_txtime == 0) {
            return (false, "TX_UNKNOWN");
        }
        if (_txtime == TX_EXECUTED) {
            return (false, "TX_ALREADY_EXECUTED");
        }
        if (block.timestamp < _txtime) {
            return (false, "TX_NOT_ENABLED_YET");
        }
        if (block.timestamp > _txtime + executionExpiration) {
            return (false, "TX_EXPIRED");
        }
        if (msg.sender != owner) {
            return (false, "ONLY_OWNER");
        }
        return (true, "");
    }

    function registerTransaction(address target, bytes calldata data)
        external
        onlyOwner
        returns (bytes32)
    {
        bytes32 txSetHash = registerTxSet(TxSetType.Transaction);
        emit TransactionRegistered(target, data, txSetHash, txSetAllowedTime[txSetHash]);
        return txSetHash;
    }

    function registerPayableTransaction(
        address target,
        uint256 eth_value,
        bytes calldata data
    ) external onlyOwner returns (bytes32) {
        bytes32 txSetHash = registerTxSet(TxSetType.PayableTransaction);
        emit PayableTransactionRegistered(
            target,
            eth_value,
            data,
            txSetHash,
            txSetAllowedTime[txSetHash]
        );
        return txSetHash;
    }

    function registerMultiTransaction(address[] calldata targets, bytes[] calldata datas)
        external
        onlyOwner
        returns (bytes32)
    {
        bytes32 txSetHash = registerTxSet(TxSetType.MultiTransaction);
        emit MultiTransactionRegistered(targets, datas, txSetHash, txSetAllowedTime[txSetHash]);
        return txSetHash;
    }

    function registerMultiPayableTransaction(
        address[] calldata targets,
        uint256[] calldata eth_values,
        bytes[] calldata datas
    ) external onlyOwner returns (bytes32) {
        bytes32 txSetHash = registerTxSet(TxSetType.MultiPayableTransaction);
        emit MultiPayableTransactionRegistered(
            targets,
            eth_values,
            datas,
            txSetHash,
            txSetAllowedTime[txSetHash]
        );
        return txSetHash;
    }

    function registerTxSet(TxSetType setType) internal returns (bytes32) {
        bytes32 _key = txKey(setType);
        txSetAllowedTime[_key] = block.timestamp + executionDelay;
        return _key;
    }

    function removeTxSet(bytes32 txSetHash) external onlyOwner {
        txSetAllowedTime[txSetHash] = 0;
    }
}
