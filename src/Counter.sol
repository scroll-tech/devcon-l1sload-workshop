// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {L1SLOAD} from "./l1sload/L1SLOAD.sol";

contract Counter {
    uint256 public number;

    function increment() public {
        number++;
    }
}

contract CounterReader {
    address public immutable counter;

    constructor(address _counter) {
        counter = _counter;
    }

    function readCounter() external view returns (uint256) {
        uint256 val0 = L1SLOAD.readUint256(counter, bytes32(uint256(0)));
        return val0;
    }
}
