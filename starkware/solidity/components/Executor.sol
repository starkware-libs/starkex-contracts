// SPDX-License-Identifier: Apache-2.0.
pragma solidity ^0.8.0;

enum TxSetType {
    Transaction,
    PayableTransaction,
    MultiTransaction,
    MultiPayableTransaction
}

/**
  Executor is a contract that executes a transaction or a batch of transactions,
  on behalf of the caller.
  This implementation is a simple one: it only supports `call`, and doesn't support `delegatecall`.
*/
abstract contract Executor {
    // The caller is the user that called the execTransaction on the Executor.
    event TxExecuted(address indexed caller, address indexed target, uint256 eth_value, bytes data);

    /**
      Modifier to all execute entries, allows extending contract to add pre-check and pre-process.
    */
    modifier allowedTx(TxSetType setType) {
        (bool allowed, string memory allowed_err) = isAllowed(setType);
        require(allowed, allowed_err);
        preExec(setType);
        _;
    }

    function preExec(TxSetType setType) internal virtual {}

    /**
      The allowedTx modifier reverts with the error message returned by this function.
      It's implemented by the extending contract.
    */
    function isAllowed(TxSetType setType) internal virtual returns (bool, string memory);

    function execTransaction(address target, bytes calldata data)
        external
        allowedTx(TxSetType.Transaction)
    {
        _exec(target, 0, data);
    }

    function execPayableTransaction(
        address target,
        uint256 eth_value,
        bytes calldata data
    ) external payable allowedTx(TxSetType.PayableTransaction) {
        _exec(target, eth_value, data);
    }

    function execMultiTransaction(address[] calldata targets, bytes[] calldata datas)
        external
        allowedTx(TxSetType.MultiTransaction)
    {
        require(targets.length == datas.length, "INPUT_LENGTH_MISMATCH");
        for (uint256 i = 0; i < datas.length; i++) {
            _exec(targets[i], 0, datas[i]);
        }
    }

    function execMultiPayableTransaction(
        address[] calldata targets,
        uint256[] calldata eth_values,
        bytes[] calldata datas
    ) external payable allowedTx(TxSetType.MultiPayableTransaction) {
        require(
            targets.length == eth_values.length && eth_values.length == datas.length,
            "INPUT_LENGTH_MISMATCH"
        );
        for (uint256 i = 0; i < datas.length; i++) {
            _exec(targets[i], eth_values[i], datas[i]);
        }
    }

    /**
      Internal common execution function.
      Note - eth_value can be used either from the msg.value or from pre-existing balance.
    */
    function _exec(
        address target,
        uint256 eth_value,
        bytes calldata data
    ) internal {
        // solium-disable-next-line security/no-call-value
        (bool success, bytes memory returnData) = target.call{value: eth_value}(data);
        require(success, string(returnData));
        emit TxExecuted(msg.sender, target, eth_value, data);
    }
}
