// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

library L1SLOAD {
    address public constant ADDRESS = 0x5300000000000000000000000000000000000001;

    function readAddress(address addr, bytes32 slot0) public view returns (address) {
        bytes memory call = abi.encodePacked(addr, slot0);
        (bool success, bytes memory ret) = ADDRESS.staticcall(call);
        if (!success) revert("failed to call l1sload");
        return abi.decode(ret, (address));
    }

    function readBool(address addr, bytes32 slot0) public view returns (bool) {
        bytes memory call = abi.encodePacked(addr, slot0);
        (bool success, bytes memory ret) = ADDRESS.staticcall(call);
        if (!success) revert("failed to call l1sload");
        return abi.decode(ret, (bool));
    }

    function readUint256(address addr, bytes32 slot0) public view returns (uint256) {
        bytes memory call = abi.encodePacked(addr, slot0);
        (bool success, bytes memory ret) = ADDRESS.staticcall(call);
        if (!success) revert("failed to call l1sload");
        return abi.decode(ret, (uint256));
    }

    function readUint256(address addr, bytes32 slot0, bytes32 slot1) public view returns (uint256, uint256) {
        bytes memory call = abi.encodePacked(addr, slot0, slot1);
        (bool success, bytes memory ret) = ADDRESS.staticcall(call);
        if (!success) revert("failed to call l1sload");
        return abi.decode(ret, (uint256, uint256));
    }

    function readUint256(address addr, bytes32 slot0, bytes32 slot1, bytes32 slot2)
        public
        view
        returns (uint256, uint256, uint256)
    {
        bytes memory call = abi.encodePacked(addr, slot0, slot1, slot2);
        (bool success, bytes memory ret) = ADDRESS.staticcall(call);
        if (!success) revert("failed to call l1sload");
        return abi.decode(ret, (uint256, uint256, uint256));
    }

    function readUint256(address addr, bytes32 slot0, bytes32 slot1, bytes32 slot2, bytes32 slot3)
        public
        view
        returns (uint256, uint256, uint256, uint256)
    {
        bytes memory call = abi.encodePacked(addr, slot0, slot1, slot2, slot3);
        (bool success, bytes memory ret) = ADDRESS.staticcall(call);
        if (!success) revert("failed to call l1sload");
        return abi.decode(ret, (uint256, uint256, uint256, uint256));
    }

    function readUint256(address addr, bytes32 slot0, bytes32 slot1, bytes32 slot2, bytes32 slot3, bytes32 slot4)
        public
        view
        returns (uint256, uint256, uint256, uint256, uint256)
    {
        bytes memory call = abi.encodePacked(addr, slot0, slot1, slot2, slot3, slot4);
        (bool success, bytes memory ret) = ADDRESS.staticcall(call);
        if (!success) revert("failed to call l1sload");
        return abi.decode(ret, (uint256, uint256, uint256, uint256, uint256));
    }

    function readBytes32(address addr, bytes32 slot0) public view returns (bytes32) {
        bytes memory call = abi.encodePacked(addr, slot0);
        (bool success, bytes memory ret) = ADDRESS.staticcall(call);
        if (!success) revert("failed to call l1sload");
        return abi.decode(ret, (bytes32));
    }

    function readBytes32(address addr, bytes32 slot0, bytes32 slot1) public view returns (bytes32, bytes32) {
        bytes memory call = abi.encodePacked(addr, slot0, slot1);
        (bool success, bytes memory ret) = ADDRESS.staticcall(call);
        if (!success) revert("failed to call l1sload");
        return abi.decode(ret, (bytes32, bytes32));
    }

    function readBytes32(address addr, bytes32 slot0, bytes32 slot1, bytes32 slot2)
        public
        view
        returns (bytes32, bytes32, bytes32)
    {
        bytes memory call = abi.encodePacked(addr, slot0, slot1, slot2);
        (bool success, bytes memory ret) = ADDRESS.staticcall(call);
        if (!success) revert("failed to call l1sload");
        return abi.decode(ret, (bytes32, bytes32, bytes32));
    }

    function readBytes32(address addr, bytes32 slot0, bytes32 slot1, bytes32 slot2, bytes32 slot3)
        public
        view
        returns (bytes32, bytes32, bytes32, bytes32)
    {
        bytes memory call = abi.encodePacked(addr, slot0, slot1, slot2, slot3);
        (bool success, bytes memory ret) = ADDRESS.staticcall(call);
        if (!success) revert("failed to call l1sload");
        return abi.decode(ret, (bytes32, bytes32, bytes32, bytes32));
    }

    function readBytes32(address addr, bytes32 slot0, bytes32 slot1, bytes32 slot2, bytes32 slot3, bytes32 slot4)
        public
        view
        returns (bytes32, bytes32, bytes32, bytes32, bytes32)
    {
        bytes memory call = abi.encodePacked(addr, slot0, slot1, slot2, slot3, slot4);
        (bool success, bytes memory ret) = ADDRESS.staticcall(call);
        if (!success) revert("failed to call l1sload");
        return abi.decode(ret, (bytes32, bytes32, bytes32, bytes32, bytes32));
    }
}
