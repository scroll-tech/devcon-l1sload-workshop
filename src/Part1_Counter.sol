// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {L1SLOAD} from "./l1sload/L1SLOAD.sol";

/// @title A simple counter contract
/// @dev This contract should be deployed on L1
contract Counter {
    uint256 public number;
    mapping(uint256 => uint256) public map;

    function increment() public {
        number++;
        map[123] = 2 * number;
    }
}

/// @title A simple contract that reads the counter through L1SLOAD
/// @dev This contract should be deployed on L2
contract CounterReader {
    /// @dev The L1 counter contract address
    address public immutable counter;

    constructor(address _counter) {
        counter = _counter;
    }

    /// @notice Reads `number` and `map[123]` from L1 using L1SLOAD
    /// @dev This function reads values from L1
    function readCounter() external view returns (uint256, uint256) {
        // TODO: complete this function
    }
}
