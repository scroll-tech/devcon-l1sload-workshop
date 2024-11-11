// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {L1SLOAD} from "./l1sload/L1SLOAD.sol";

/// @title A simple wallet that allows initiating transactions from one or more signers.
abstract contract Wallet {
    error Unauthorized();
    error CallFailed();

    /// @notice Returns true if `signer` is authorized to use this wallet
    function isAuthorized(address signer) public virtual returns (bool);

    function executeTransaction(address to, uint256 value, bytes memory data, uint256 txGas) external {
        if (!isAuthorized(msg.sender)) {
            revert Unauthorized();
        }

        bool success;

        assembly {
            success := call(txGas, to, value, add(data, 0x20), mload(data), 0, 0)
        }

        if (!success) {
            revert CallFailed();
        }
    }
}

contract L1Wallet is Wallet {
    /// @dev A mapping to store authorized signers in contract storage
    mapping(address => bool) public isAuthorizedSigner;

    constructor() {
        // creator is always authorized
        isAuthorizedSigner[msg.sender] = true;
    }

    /// @notice Adds a new signer to the authorized signer list
    function addSigner(address signer) external {
        if (!isAuthorized(msg.sender)) revert Unauthorized();
        isAuthorizedSigner[signer] = true;
    }

    /// @inheritdoc Wallet
    function isAuthorized(address signer) public view override returns (bool) {
        return isAuthorizedSigner[signer];
    }
}

contract L2Wallet is Wallet {
    /// @dev The L1 wallet contract address
    address public l1Wallet;

    constructor(address _l1Wallet) {
        l1Wallet = _l1Wallet;
    }

    /// @inheritdoc Wallet
    /// @dev This function reads the signer value from L1
    function isAuthorized(address signer) public view override returns (bool) {
        bytes32 mappingSlot = keccak256(abi.encode( /* mapping key: */ signer, /* mapping slot: */ 0));
        bool authorized = L1SLOAD.readBool(l1Wallet, mappingSlot);
        return authorized;
    }
}
