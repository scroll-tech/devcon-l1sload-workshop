// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {TestWithL1SLOAD} from "../src/l1sload/MockL1SLOAD.sol";

import {L1Wallet, L2Wallet} from "../src/Part3_Keystore.sol";

contract WalletTest is Test, TestWithL1SLOAD {
    L1Wallet public l1Wallet;
    L2Wallet public l2Wallet;

    function setUp() public virtual override {
        super.setUp();

        l1Wallet = new L1Wallet();
        l2Wallet = new L2Wallet(address(l1Wallet));
    }

    function testDeployedAuthorized() public view {
        assertTrue(l1Wallet.isAuthorized(address(this)));
        assertTrue(l2Wallet.isAuthorized(address(this)));
    }

    function testAddSigner(address signer) public {
        vm.assume(signer != address(this));

        assertFalse(l1Wallet.isAuthorized(signer));
        assertFalse(l2Wallet.isAuthorized(signer));

        l1Wallet.addSigner(signer);

        assertTrue(l1Wallet.isAuthorized(signer));
        assertTrue(l2Wallet.isAuthorized(signer));
    }
}
