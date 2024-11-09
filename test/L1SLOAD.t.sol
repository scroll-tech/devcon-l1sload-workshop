// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";

import {TestWithL1SLOAD} from "../src/l1sload/MockL1SLOAD.sol";
import {L1SLOAD} from "../src/l1sload/L1SLOAD.sol";

contract Storage {
    function write(bytes32 slot, bytes32 val) public {
        assembly {
            sstore(slot, val)
        }
    }
}

contract L1SLOADTest is Test, TestWithL1SLOAD {
    Storage public st;

    function setUp() public virtual override {
        super.setUp();

        st = new Storage();
    }

    function test_readUint256_1(bytes32 slot0, uint256 val0) public {
        st.write(slot0, bytes32(val0));

        uint256 read0 = L1SLOAD.readUint256(address(st), slot0);
        assertEq(read0, val0);
    }

    function test_readUint256_2(bytes32 slot0, uint256 val0, bytes32 slot1, uint256 val1) public {
        vm.assume(slot0 != slot1);

        st.write(slot0, bytes32(val0));
        st.write(slot1, bytes32(val1));

        // read one-by-one
        uint256 read0 = L1SLOAD.readUint256(address(st), slot0);
        uint256 read1 = L1SLOAD.readUint256(address(st), slot1);
        assertEq(read0, val0);
        assertEq(read1, val1);

        // read together
        (read0, read1) = L1SLOAD.readUint256(address(st), slot0, slot1);
        assertEq(read0, val0);
        assertEq(read1, val1);

        // read in different order
        (read1, read0) = L1SLOAD.readUint256(address(st), slot1, slot0);
        assertEq(read0, val0);
        assertEq(read1, val1);

        // read the same twice
        (read0, read1) = L1SLOAD.readUint256(address(st), slot0, slot0);
        assertEq(read0, val0);
        assertEq(read1, val0);
    }
}
