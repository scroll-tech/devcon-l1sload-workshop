// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";

import {TestWithL1SLOAD} from "../src/l1sload/MockL1SLOAD.sol";
import {Counter, CounterReader} from "../src/Counter.sol";

contract CounterTest is Test, TestWithL1SLOAD {
    Counter public counter;

    function setUp() public virtual override {
        super.setUp();

        // simulate L1 contract deployment
        counter = new Counter();
    }

    function testReadCounter() public {
        // simulate L2 contract deployment
        CounterReader reader = new CounterReader(address(counter));

        uint256 val0 = reader.readCounter();
        assertEq(val0, 0);

        counter.increment();

        val0 = reader.readCounter();
        assertEq(val0, 1);
    }
}
