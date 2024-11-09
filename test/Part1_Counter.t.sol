// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {TestWithL1SLOAD} from "../src/l1sload/MockL1SLOAD.sol";

import {Counter, CounterReader} from "../src/Part1_Counter.sol";

contract CounterTest is Test, TestWithL1SLOAD {
    Counter public l1Counter;

    function setUp() public virtual override {
        super.setUp();

        l1Counter = new Counter();
    }

    function test_Increment() public {
        l1Counter.increment();
        assertEq(l1Counter.number(), 1);
    }

    function testReadCounter() public {
        CounterReader l2Reader = new CounterReader(address(l1Counter));

        (uint256 val0, uint256 val1) = l2Reader.readCounter();
        assertEq(val0, 0);
        assertEq(val1, 0);

        l1Counter.increment();

        (val0, val1) = l2Reader.readCounter();
        assertEq(val0, 1);
        assertEq(val1, 2);
    }
}
