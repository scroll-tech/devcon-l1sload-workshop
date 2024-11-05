// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";

import {L1SLOAD} from "./L1SLOAD.sol";

contract MockL1SLOAD is Test {
    fallback(bytes calldata data) external returns (bytes memory res) {
        // check data length
        if (data.length < 20 + 32) {
            revert("invalid payload passed to l1sload");
        }

        if ((data.length - 20) % 32 != 0) {
            revert("invalid payload passed to l1sload");
        }

        // decode address
        address addr;

        assembly {
            addr := shr(96, calldataload(data.offset))
        }

        // decode and read storage slots
        for (uint256 index = 0; index < 5; index++) {
            if (data.length < 20 + (index + 1) * 32) break;

            bytes32 slot;
            uint256 dataindex = 20 + index * 32;

            assembly {
                slot := calldataload(add(data.offset, dataindex))
            }

            // execute l1sload
            // note: here we are simulating l1sload with a local sload,
            // in reality this would be an rpc call executed by the sequencer.
            bytes32 val = vm.load(address(addr), slot);

            res = abi.encodePacked(res, val);
        }
    }
}

contract TestWithL1SLOAD is Test {
    function setUp() public virtual {
        MockL1SLOAD l1sload = new MockL1SLOAD();
        bytes memory code = address(l1sload).code;
        vm.etch(L1SLOAD.ADDRESS, code);
    }
}
