pragma solidity ^0.5.2;

import "../libraries/LibErrors.sol";
import "../libraries/LibConstants.sol";
import "../interfaces/MTokens.sol";
import "../interfaces/MGovernance.sol";
import "../ERC20/IERC20.sol";
import "./MainStorage.sol";

/**
  Registration of a new token (:sol:func:`registerToken`) entails defining a new token ID
  identifying the token within the system, and associating it with an `assetData` array of bytes and
  a quantization factor (`quantum`).

  The `assetData` array defines the token type (ERC20 or Eth) encoded as a 4-byte `selector` and in
  the case of ERC20, followed by the 32-byte address of the ERC20 contract.

  The `selector` arrays are defined as follows:

  `ERC20_SELECTOR = bytes4(keccak256("ERC20Token(address)"));`

  `ETH_SELECTOR = bytes4(keccak256("ETH()"));`

  The `quantum` quantization factor defines the multiplicative transformation from the native token
  denomination as a 256b unsigned integer to a 63b unsigned integer representation as used by the
  Stark exchange. Only amounts in the native representation that represent an integer number of
  quanta are allowed in the system.

  Once registered, tokens cannot be removed from the system, as their IDs may be used by off-chain
  accounts.

  New tokens may only be registered by a Token Administrator. A Token Administrator may be instantly
  appointed or removed by the contract Governor (see :sol:mod:`MainGovernance`). Typically, the
  Token Administrator's private key should be kept in a cold wallet.
*/
/*
  Implements MTokens.
  Uses MGovernance.
*/
contract Tokens is MainStorage, LibErrors, LibConstants, MGovernance, MTokens {
    bytes4 constant internal ERC20_SELECTOR = bytes4(keccak256("ERC20Token(address)"));
    bytes4 constant internal ETH_SELECTOR = bytes4(keccak256("ETH()"));

    // The selector follows the 0x20 bytes assetData.length field.
    uint256 constant internal SELECTOR_OFFSET = 0x20;
    uint256 constant internal SELECTOR_SIZE = 4;
    uint256 constant internal ERC20_ADDRESS_OFFSET = SELECTOR_OFFSET + SELECTOR_SIZE;


    event LogTokenRegistered(uint256 tokenId, bytes assetData);

    modifier onlyTokensAdmin()
    {
        require(tokenAdmins[msg.sender], "ONLY_TOKENS_ADMIN");
        _;
    }

    function registerTokenAdmin(address newAdmin)
        external
        onlyGovernance()
    {
        tokenAdmins[newAdmin] = true;
    }

    function unregisterTokenAdmin(address oldAdmin)
        external
        onlyGovernance()
    {
        tokenAdmins[oldAdmin] = false;
    }

    /*
      Safe wrapper around ERC20 calls.
      This is required because many deployed ERC20 contracts don't return a value.
      See https://github.com/ethereum/solidity/issues/4116.
    */
    function safeERC20Call(address tokenAddress, bytes memory callData) internal {
        // solium-disable-next-line security/no-low-level-calls
        (bool success, bytes memory returndata) = address(tokenAddress).call(callData);
        require(success, string(returndata));

        if (returndata.length > 0) {
            require(abi.decode(returndata, (bool)), "ERC20_OPERATION_FAILED");
        }
    }


    function extractUint256(bytes memory assetData, uint256 offset)
        internal pure returns (uint256 res)
    {
        // solium-disable-next-line security/no-inline-assembly
        assembly {
           res := mload(add(assetData, offset))
        }
    }

    /*
      Extract the tokenSelector from assetData.

      Works like bytes4 tokenSelector = abi.decode(assetData, (bytes4))
      but does not revert when assetData.length < 0x20.
    */
    function extractSelector(bytes memory assetData)
        internal pure returns (bytes4 selector)
    {
        // solium-disable-next-line security/no-inline-assembly
        assembly {
           selector := and(0xffffffff00000000000000000000000000000000000000000000000000000000,
                           mload(add(assetData, 0x20)))
        }
    }

    /*
      Registers a new asset to the system.
      Once added, it can not be removed and there is a limited number
      of slots available.
    */
    function registerToken(
        uint256 tokenId,
        bytes calldata assetData,
        uint256 quantum
    )
        external
        onlyTokensAdmin()
    {
        // Make sure it is not invalid or already registered.
        require(registeredTokenId[tokenId] == false, "TOKEN_REGISTERED");
        require(tokenId < K_MODULUS, "INVALID_TOKEN_ID");
        require(quantum > 0, "INVALID_QUANTUM");
        require(quantum <= MAX_QUANTUM, "INVALID_QUANTUM");
        require(assetData.length >= SELECTOR_SIZE, "INVALID_ASSET_STRING");

        // Require that the tokenId is the hash of the assetData and quantum truncated to 250 bits.
        uint256 enforcedId = uint256(keccak256(abi.encodePacked(assetData, quantum))) &
            0x03FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
        require(tokenId == enforcedId, "INVALID_TOKEN_ID");

        // Add token to the in-storage structures.
        registeredTokenId[tokenId] = true;
        tokenIdToAssetData[tokenId] = assetData;
        tokenIdToQuantum[tokenId] = quantum;

        bytes4 tokenSelector = extractSelector(assetData);
        if (tokenSelector == ERC20_SELECTOR) {
            require(assetData.length == 0x24, "INVALID_ASSET_STRING");
            uint256 tokenAddress = extractUint256(assetData, ERC20_ADDRESS_OFFSET);

            uint256 erc20ConstractSize;
            // solium-disable-next-line security/no-inline-assembly
            assembly {
                erc20ConstractSize := extcodesize(tokenAddress)
            }
            // Check erc20ConstractSize before the approve call to get a meaningful error
            // message if the address is invalid.
            require(erc20ConstractSize > 0, "BAD_ERC20_ADDRESS");
        } else if (tokenSelector == ETH_SELECTOR) {
            require(assetData.length == 4, "INVALID_ASSET_STRING");
        } else {
            revert("UNSUPPORTED_TOKEN_TYPE");
        }

        // Log the registration of a new token.
        emit LogTokenRegistered(tokenId, assetData);
    }

    function getQuantum(uint256 tokenId)
        public view
        returns (uint256 quantum)
    {
        // Verify that the registration is set and valid.
        require(registeredTokenId[tokenId], "TOKEN_UNREGISTERED");

        // Retrieve registration.
        quantum = tokenIdToQuantum[tokenId];
    }

    function getAssetData(uint256 tokenId)
        public view
        returns (bytes memory assetData)
    {
        // Verify that the registration is set and valid.
        require(registeredTokenId[tokenId], "TOKEN_UNREGISTERED");

        // Retrieve registration.
        assetData = tokenIdToAssetData[tokenId];
    }

    function toQuantized(
        uint256 tokenId,
        uint256 amount
    )
        internal view
        returns (uint256 quantizedAmount)
    {
        uint256 quantum = getQuantum(tokenId);
        require(amount % quantum == 0, "INVALID_AMOUNT");
        quantizedAmount = amount / quantum;
    }

    function fromQuantized(
        uint256 tokenId,
        uint256 quantizedAmount
    )
        internal view
        returns (uint256 amount)
    {
        uint256 quantum = getQuantum(tokenId);
        amount = quantizedAmount * quantum;
        require(amount / quantum == quantizedAmount, "DEQUANTIZATION_OVERFLOW");
    }

    function isEther(
        uint256 tokenId)
        internal view returns (bool)
    {
        bytes memory assetData = getAssetData(tokenId);
        bytes4 tokenSelector = extractSelector(assetData);

        return tokenSelector == ETH_SELECTOR;
    }

    /*
      Transfers funds from msg.sender to the exchange.
    */
    function transferIn(
        uint256 tokenId,
        uint256 quantizedAmount
    )
        internal
    {
        bytes memory assetData = getAssetData(tokenId);
        uint256 amount = fromQuantized(tokenId, quantizedAmount);

        bytes4 tokenSelector = extractSelector(assetData);
        if (tokenSelector == ERC20_SELECTOR) {
            uint256 tokenAddress = extractUint256(assetData, ERC20_ADDRESS_OFFSET);
            safeERC20Call(
                address(tokenAddress),
                abi.encodeWithSelector(
                IERC20(0).transferFrom.selector, msg.sender, address(this), amount));
        } else if (tokenSelector == ETH_SELECTOR) {
            require(msg.value == amount, "INCORRECT_DEPOSIT_AMOUNT");
        } else {
            revert("UNSUPPORTED_TOKEN_TYPE");
        }
    }

    /*
      Transfers funds from the exchange to msg.sender.
    */
    function transferOut(
        uint256 tokenId,
        uint256 quantizedAmount
    )
        internal
    {
        bytes memory assetData = getAssetData(tokenId);
        uint256 amount = fromQuantized(tokenId, quantizedAmount);

        bytes4 tokenSelector = extractSelector(assetData);
        if (tokenSelector == ERC20_SELECTOR) {
            uint256 tokenAddress = extractUint256(assetData, ERC20_ADDRESS_OFFSET);
            safeERC20Call(
                address(tokenAddress),
                abi.encodeWithSelector(IERC20(0).transfer.selector, msg.sender, amount));
        } else if (tokenSelector == ETH_SELECTOR) {
            msg.sender.transfer(amount);
        } else {
            revert("UNSUPPORTED_TOKEN_TYPE");
        }
    }
}
