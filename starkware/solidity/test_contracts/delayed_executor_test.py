import logging
from typing import Any, Iterable, List

import pytest
from hexbytes import HexBytes
from web3.exceptions import ContractLogicError

from starkware.eth.eth_test_utils import EthAccount, EthContract, EthTestUtils, eth_reverts
from starkware.solidity.test_contracts.internal_contracts import DelayedExecutor, TestCollect
from starkware.solidity.test_utils2 import ZERO_ADDRESS
from starkware.web3.web3_utils import get_timestamp

logger = logging.getLogger(__name__)

DELAY = 1000
E_VALUE = 27818281828
EXPIRATION = 18000

MAX_DELAY = 28 * 24 * 3600  # 28 days.
MIN_EXPIRATION = 3600  # 1 hour.
MAX_EXPIRATION = 52 * 7 * 24 * 3600  # 1 typical year.


@pytest.fixture(scope="session")
def default_account(deployer: EthAccount) -> EthAccount:
    deployer.w3.eth.default_account = deployer.address  # type: ignore[assignment]
    return deployer


@pytest.fixture
def delayed_exec(deployer: EthAccount, default_account: EthAccount) -> EthContract:
    assert default_account == deployer
    return deployer.deploy(DelayedExecutor, deployer.address, DELAY, EXPIRATION)


@pytest.fixture
def register(delayed_exec: EthContract):
    """
    Returns the `register*` method of the DelayedExecutor contract.
    """
    return lambda method: getattr(delayed_exec, f"register{method}")


@pytest.fixture
def execute(delayed_exec: EthContract):
    """
    Returns the `exec*` method of the DelayedExecutor contract.
    """
    return lambda method: getattr(delayed_exec, f"exec{method}")


@pytest.fixture
def eth_sink(deployer: EthAccount) -> EthContract:
    return deployer.deploy(TestCollect)


@pytest.fixture
def test_facts() -> List[bytes]:
    return [HexBytes(f) for f in [1439, 7059, 5827, 2918]]


@pytest.fixture
def tx_data_sets(mock_fact_registry: EthContract, test_facts: List[bytes]):
    """
    Prepares 4 sets of data for mfr.mockRegisterFact,
    for the 4 flavors of registration/execution.
    0 - register/execTransaction
    1 - register/execPayableTransaction
    2 - register/execMultiTransaction
    3 - register/execMultiPayableTransaction
    """
    target = mock_fact_registry.address
    sets_ = [
        ("Transaction", (target, mfr_set_tx_data(mock_fact_registry, test_facts[0]))),
        ("PayableTransaction", (target, 0, mfr_set_tx_data(mock_fact_registry, test_facts[1]))),
        ("MultiTransaction", ([target], [mfr_set_tx_data(mock_fact_registry, test_facts[2])])),
        (
            "MultiPayableTransaction",
            ([target], [0], [mfr_set_tx_data(mock_fact_registry, test_facts[3])]),
        ),
    ]
    return sets_


@pytest.fixture
def multi_tx_data_sets(mock_fact_registry: EthContract, test_facts: List[bytes]):
    """
    Prepare 2 sets of data for a set of two mfr.mockRegisterFact,
    0 - register/execMultiTransaction
    1 - register/execMultiPayableTransaction
    """
    set0_ = [
        2 * [mock_fact_registry.address],
        [mfr_set_tx_data(mock_fact_registry, fact) for fact in test_facts[:2]],
    ]
    set1_ = [
        2 * [mock_fact_registry.address],
        2 * [0],
        [mfr_set_tx_data(mock_fact_registry, fact) for fact in test_facts[2:]],
    ]
    return [("MultiTransaction", set0_), ("MultiPayableTransaction", set1_)]


def mfr_set_tx_data(mfr: EthContract, set_value: bytes):
    return mfr.w3_contract.functions.mockRegisterFact(set_value).buildTransaction()["data"]


def check_multiple_facts(mfr: EthContract, fact_set: Iterable, test_value: bool = True):
    """
    Tests a set of facts on the MFR (MockFactRegistry) to be all `test_value`.
    """
    assert all(mfr.isValid.call(fact) == test_value for fact in fact_set)


def test_construction_delay_and_expiration(deployer):
    """
    MAX_DELAY = 28 * 24 * 3600  # 28 days.
    MIN_EXPIRATION = 3600  # 1 hour.
    MAX_EXPIRATION = 52 * 7 * 24 * 3600  # 1 typical year.
    """
    with pytest.raises(ContractLogicError, match="ZERO_OWNER_ADDRESS"):
        deployer.deploy(DelayedExecutor, ZERO_ADDRESS, DELAY, EXPIRATION)

    with pytest.raises(ContractLogicError, match="DELAY_TOO_LONG"):
        deployer.deploy(DelayedExecutor, deployer.address, MAX_DELAY + 1, EXPIRATION)
    deployer.deploy(DelayedExecutor, deployer.address, MAX_DELAY, EXPIRATION)

    with pytest.raises(ContractLogicError, match="EXPIRATION_TOO_SHORT"):
        deployer.deploy(DelayedExecutor, deployer.address, DELAY, MIN_EXPIRATION - 1)
    deployer.deploy(DelayedExecutor, deployer.address, DELAY, MIN_EXPIRATION)

    with pytest.raises(ContractLogicError, match="EXPIRATION_TOO_LONG"):
        deployer.deploy(DelayedExecutor, deployer.address, DELAY, MAX_EXPIRATION + 1)
    deployer.deploy(DelayedExecutor, deployer.address, DELAY, MAX_EXPIRATION)


def test_ownership(
    delayed_exec: EthContract,
    admin: EthAccount,
    non_admin: EthAccount,
):
    args = [admin.address, bytes(0)]
    assert admin.address != non_admin.address
    assert delayed_exec.owner.call() == admin.address

    # Start ownership transfer to `non_admin`.
    receipt = delayed_exec.transferOwnership(non_admin)

    # Test ownership nomination event.
    assert receipt.get_events("OwnershipNominated") == [
        {
            "currentOwner": admin.address,
            "newOwner": non_admin.address,
        }
    ]

    # Ownership effectively is still owned by `admin`.
    assert delayed_exec.owner.call() == admin.address
    with eth_reverts("NOT_DESIGNATED_OWNER"):
        delayed_exec.acceptOwnership.call(transact_args={"from": admin.address})
    delayed_exec.registerTransaction.call(*args, transact_args={"from": admin.address})
    with eth_reverts("ONLY_OWNER"):
        delayed_exec.registerTransaction.call(*args, transact_args={"from": non_admin.address})

    # `non_admin` accepts ownership.
    receipt = delayed_exec.acceptOwnership(transact_args={"from": non_admin.address})

    # Test ownership acceptance event.
    assert receipt.get_events("OwnershipAccepted") == [{"newOwner": non_admin.address}]

    # Ownership now owned by `non_admin`.
    assert delayed_exec.owner.call() == non_admin.address
    with eth_reverts("ONLY_OWNER"):
        delayed_exec.registerTransaction.call(*args, transact_args={"from": admin.address})
    delayed_exec.registerTransaction.call(*args, transact_args={"from": non_admin.address})

    with eth_reverts("NOT_DESIGNATED_OWNER"):
        delayed_exec.acceptOwnership(transact_args={"from": non_admin.address})

    # Owner cannot self-nominate.
    with eth_reverts("ALREADY_OWNER"):
        delayed_exec.transferOwnership(non_admin, transact_args={"from": non_admin.address})

    with eth_reverts("ONLY_OWNER"):
        delayed_exec.transferOwnership.call(admin)

    # Test clear nomination.
    # 1. Nominate `admin`.
    delayed_exec.transferOwnership(admin, transact_args={"from": non_admin.address})

    # 2. `admin` can now accept (it doesn't here, just using call to check).
    delayed_exec.acceptOwnership.call()

    # 3. Clear the nomination.
    receipt = delayed_exec.transferOwnership(
        ZERO_ADDRESS, transact_args={"from": non_admin.address}
    )
    # Test ownership nomination clearing event.
    assert len(receipt.get_events("OwnershipNominationCleared")) == 1

    # 4. `admin` is not an owner nominee thus cannot accept anymore.
    with eth_reverts("NOT_DESIGNATED_OWNER"):
        delayed_exec.acceptOwnership.call()


def test_only_owner(
    eth_test_utils: EthTestUtils,
    delayed_exec: EthContract,
    deployer: EthAccount,
    non_admin: EthAccount,
    tx_data_sets: List[Any],
    register,
    execute,
):
    """
    Test that register, exec & remove are allowed only to the owner.
    """
    # Only owner can register a transaction/multi-transaction.
    for method, data in tx_data_sets:
        with eth_reverts("ONLY_OWNER"):
            register(method).call(*data, transact_args={"from": non_admin.address})
        register(method).transact(*data, transact_args={"from": deployer.address})

    reg_hashes = [register(method).call(*data) for method, data in tx_data_sets]
    assert len(set(reg_hashes)) == len(tx_data_sets)

    # Only owner can remove a transaction/multi-transaction.
    for rh in reg_hashes:
        with eth_reverts("ONLY_OWNER"):
            delayed_exec.removeTxSet.call(rh, transact_args={"from": non_admin})
        delayed_exec.removeTxSet.call(rh, transact_args={"from": deployer})

    # Only owner can execute a transaction/multi-transaction.
    # Advance the time, so that the delay will not fail the execution.
    eth_test_utils.advance_time(DELAY)

    for method, data in tx_data_sets:
        with eth_reverts("ONLY_OWNER"):
            execute(method).call(*data, transact_args={"from": non_admin.address})
        execute(method).call(*data, transact_args={"from": deployer.address})


def test_progress_and_effect(
    eth_test_utils: EthTestUtils,
    delayed_exec: EthContract,
    mock_fact_registry: EthContract,
    tx_data_sets: List[Any],
    test_facts: List[bytes],
    register,
    execute,
):
    """
    Test that register, exec work as expected.
    """
    reg_hashes = [register(method).call(*data) for method, data in tx_data_sets]
    assert len(set(reg_hashes)) == len(tx_data_sets)

    # Facts are not registered.
    check_multiple_facts(mock_fact_registry, test_facts, test_value=False)

    for method, data in tx_data_sets:
        with eth_reverts("TX_UNKNOWN"):
            execute(method).call(*data)

    # TxSets are not registered.
    assert all(delayed_exec.txSetAllowedTime.call(rh) == 0 for rh in reg_hashes)

    for method, data in tx_data_sets:
        register(method).transact(*data)

    # TxSets are all registered.
    assert all(delayed_exec.txSetAllowedTime.call(rh) > 1 for rh in reg_hashes)

    for method, data in tx_data_sets:
        with eth_reverts("TX_NOT_ENABLED_YET"):
            execute(method).call(*data)

    # Check removal and re-reg.
    delayed_exec.removeTxSet(reg_hashes[0])
    with eth_reverts("TX_UNKNOWN"):
        delayed_exec.execTransaction.call(*tx_data_sets[0][1])
    delayed_exec.registerTransaction(*tx_data_sets[0][1])

    eth_test_utils.advance_time(DELAY)

    for method, data in tx_data_sets:
        execute(method).transact(*data)

    assert all(delayed_exec.txSetAllowedTime.call(rh) == 1 for rh in reg_hashes)

    for method, data in tx_data_sets:
        with eth_reverts("TX_ALREADY_EXECUTED"):
            execute(method).call(*data)

    # Test that facts were registered (side effect of the executed transactions).
    check_multiple_facts(mock_fact_registry, test_facts, test_value=True)

    delayed_exec.removeTxSet(reg_hashes[0])
    with eth_reverts("TX_UNKNOWN"):
        delayed_exec.execTransaction.call(*tx_data_sets[0][1])


def test_expired_txs(eth_test_utils: EthTestUtils, tx_data_sets: List[Any], register, execute):
    """
    Test that register tx cannot be executed after it expired.
    """
    for method, data in tx_data_sets:
        register(method).transact(*data)

    eth_test_utils.advance_time(DELAY + EXPIRATION + 1)

    for method, data in tx_data_sets:
        with eth_reverts("TX_EXPIRED"):
            execute(method).call(*data)


def test_events(
    eth_test_utils: EthTestUtils,
    deployer: EthContract,
    tx_data_sets: List[Any],
    multi_tx_data_sets: List[Any],
    register,
    execute,
):
    """
    Test generated events.

    1. event TransactionRegistered(
        address target,
        bytes data,
        bytes32 txSetHash,
        uint256 enableTime
    );

    2. event PayableTransactionRegistered(
        address target,
        uint256 eth_value,
        bytes data,
        bytes32 txSetHash,
        uint256 enableTime
    );

    3. event MultiTransactionRegistered(
        address[] targets,
        bytes[] datas,
        bytes32 txSetHash,
        uint256 enableTime
    );

    4. event MultiPayableTransactionRegistered(
        address[] targets,
        uint256[] eth_values,
        bytes[] datas,
        bytes32 txSetHash,
        uint256 enableTime
    );

    5. event TxExecuted(address caller, address indexed target, uint256 eth_value, bytes data);
    """
    tx_data = tx_data_sets[:2] + multi_tx_data_sets

    reg_hashes = [HexBytes(register(method).call(*data)).hex() for method, data in tx_data]

    t0 = get_timestamp(eth_test_utils.w3) + DELAY  # Lower bound for `activationTime`.
    reg_receipts = [register(method).transact(*data) for (method, data) in tx_data]
    t1 = get_timestamp(eth_test_utils.w3) + DELAY  # Upper bound for `activationTime`.

    event_lists = [
        reg_receipt.get_events(f"{method}Registered")
        for (reg_receipt, (method, _data)) in zip(reg_receipts, tx_data)
    ]
    assert all(len(e) for e in event_lists)
    events = [e[0] for e in event_lists]

    # Test target in event data equals to `target`.
    assert all(e["target"] == tx_data[0][1][0] for e in events[:2])
    assert all(e["targets"] == 2 * [tx_data[0][1][0]] for e in events[2:])

    # Test eth_value in event data is 0 as expected.
    assert events[1]["eth_value"] == 0
    assert events[3]["eth_values"] == 2 * [0]

    # Check data field in event to match `data` in registration.
    assert all(events[i]["data"] == tx_data[i][1][-1] for i in (0, 1))
    assert all([HexBytes(d).hex() for d in events[i]["datas"]] == tx_data[i][1][-1] for i in (2, 3))

    # Test hash field in event data against registration hash.
    assert all(ev_reg[0]["txSetHash"] == ev_reg[1] for ev_reg in zip(events, reg_hashes))

    # Check that enableTime in event data is in bounds.
    assert all(t0 <= ev["enableTime"] <= t1 for ev in events)

    eth_test_utils.advance_time(DELAY)

    # Execution events.
    exec_evs = [
        execute(method).transact(*data).get_events(f"TxExecuted") for (method, data) in tx_data
    ]

    # In the single we have only 1 execution, hence 1 exec event.
    assert all(len(e) == 1 for e in exec_evs[:2])

    # In the multi we have 2 tx a batch, so we expect 2 exec events.
    assert all(len(e) == 2 for e in exec_evs[2:])

    # Check caller field in the event to match actual caller.
    assert all(e[0]["caller"] == deployer.address for e in exec_evs)

    # Check `target` field in event.
    assert all(e[0]["target"] == tx_data_sets[0][1][0] for e in exec_evs[:2])

    # Check `data` field in event.
    assert all(exec_evs[i][0]["data"] == tx_data_sets[i][1][-1] for i in (0, 1))

    # Check `eth_value` field in event.
    assert all(e[-1]["eth_value"] == 0 for e in exec_evs)


def test_eth_sink(eth_sink: EthContract):
    """
    Test the eth collect test contract.
    """
    with eth_reverts("ETH_VALUE_ZERO"):
        eth_sink.collect.call(0)
    with eth_reverts("MSG_VALUE_ZERO"):
        eth_sink.collect.call(E_VALUE)
    with eth_reverts("INACCURATE_SUM"):
        eth_sink.collect.call(E_VALUE, transact_args={"value": E_VALUE - 1})
    with eth_reverts("INACCURATE_SUM"):
        eth_sink.collect.call(E_VALUE, transact_args={"value": E_VALUE + 1})
    eth_sink.collect.call(E_VALUE, transact_args={"value": E_VALUE})


def test_payable_as_value(
    eth_test_utils: EthTestUtils, delayed_exec: EthContract, eth_sink: EthContract
):
    """
    Test that value passes correctly, when sent as value in the calling tx.
    """
    assert eth_test_utils.get_balance(eth_sink.address) == 0
    tx1_data = eth_sink.w3_contract.functions.collect(E_VALUE).buildTransaction({"gas": 1})["data"]
    tx2_data = eth_sink.w3_contract.functions.collect(2 * E_VALUE).buildTransaction({"gas": 1})[
        "data"
    ]
    target = eth_sink.address

    # A registration MUST not accept value.
    with eth_reverts(""):
        delayed_exec.registerPayableTransaction.call(
            target, E_VALUE, tx1_data, transact_args={"value": E_VALUE}
        )

    # Register 4 txs - 2 single payable, 1 single as multi, 1 real multi.
    delayed_exec.registerPayableTransaction(target, E_VALUE, tx1_data)
    delayed_exec.registerPayableTransaction(target, 2 * E_VALUE, tx2_data)
    delayed_exec.registerMultiPayableTransaction([target], [E_VALUE], [tx1_data])
    delayed_exec.registerMultiPayableTransaction(3 * [target], 3 * [E_VALUE], 3 * [tx1_data])

    eth_test_utils.advance_time(DELAY)

    # Execute the registered txs.
    delayed_exec.execPayableTransaction(target, E_VALUE, tx1_data, transact_args={"value": E_VALUE})

    # When there is no balance in the executor, insufficient msg.value causes the tx to revert.
    with eth_reverts(""):
        delayed_exec.execPayableTransaction(
            target, 2 * E_VALUE, tx2_data, transact_args={"value": E_VALUE}  # Should be 2x.
        )
    delayed_exec.execPayableTransaction(
        target, 2 * E_VALUE, tx2_data, transact_args={"value": 2 * E_VALUE}  # Correct value.
    )
    delayed_exec.execMultiPayableTransaction(
        [target], [E_VALUE], [tx1_data], transact_args={"value": E_VALUE}
    )
    delayed_exec.execMultiPayableTransaction(
        3 * [target], 3 * [E_VALUE], 3 * [tx1_data], transact_args={"value": 3 * E_VALUE}
    )

    # All 4 registered txs were executed successfully. Check proper balance.
    assert eth_test_utils.get_balance(eth_sink.address) == 7 * E_VALUE  # 1 + 2 + 1 + 3.


def test_payable_from_balance(
    eth_test_utils: EthTestUtils,
    delayed_exec: EthContract,
    eth_sink: EthContract,
    deployer: EthAccount,
):
    """
    Test that value passes correctly,
    when using the executor own balance (i.e. 0/less than needed in msg.value).
    """
    data = eth_sink.w3_contract.functions.collect(E_VALUE).buildTransaction({"gas": 1})["data"]
    target = eth_sink.address

    # We fund the Executor with eth, so the payable txs will be payed from that balance.
    deployer.transfer(to=delayed_exec, value=10 * E_VALUE)  # type: ignore[arg-type]
    assert eth_test_utils.get_balance(eth_sink.address) == 0
    assert eth_test_utils.get_balance(delayed_exec.address) == 10 * E_VALUE

    # Register 3 txs - 1 single payable, 1 single as multi, 1 real multi.
    delayed_exec.registerPayableTransaction(target, E_VALUE, data)
    delayed_exec.registerMultiPayableTransaction([target], [E_VALUE], [data])
    delayed_exec.registerMultiPayableTransaction(3 * [target], 3 * [E_VALUE], 3 * [data])

    eth_test_utils.advance_time(DELAY)

    # Execute the registered txs.
    # First two txs are passing value=0, i.e. all is covered from executor balance.
    delayed_exec.execPayableTransaction(target, E_VALUE, data, transact_args={"value": 0})
    delayed_exec.execMultiPayableTransaction(
        [target], [E_VALUE], [data], transact_args={"value": 0}
    )

    # Some eth_value is passed, and the rest is covered by the balance.
    delayed_exec.execMultiPayableTransaction(
        3 * [target], 3 * [E_VALUE], 3 * [data], transact_args={"value": E_VALUE}
    )

    # All expected eth_value was sent to the eth sink contract.
    assert eth_test_utils.get_balance(eth_sink.address) == 5 * E_VALUE  # 1 + 1 + 3.

    # Only 4x amount was reduced from the executor balance (as 1 more payed by caller).
    assert eth_test_utils.get_balance(delayed_exec.address) == 6 * E_VALUE
