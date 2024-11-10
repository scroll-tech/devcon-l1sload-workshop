// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract L2Contract {
    address immutable L1SLOAD_PRECOMPILE = 0x0000000000000000000000000000000000000101;
    address immutable l1sloadContractAddress;

    constructor(address _l1sloadContractAddress) {
        l1sloadContractAddress = _l1sloadContractAddress;
    }

    function retrieveL1Number() public view returns (uint256) {
        uint256 l1SlotNumber = 0;
        (bool success, bytes memory data) =
            L1SLOAD_PRECOMPILE.staticcall(abi.encodePacked(l1sloadContractAddress, l1SlotNumber));
        if (!success) {
            revert("Error retrieving L1 Number");
        }
        return abi.decode(data, (uint256));
    }

    function retrieveL1String() public view returns (string memory) {
        uint256 l1SlotNumber = 1; // string storage slot
        uint256 slotSequence = 0; // string slot ++
        string memory stringResult = "";

        while (true) {
            (bool success, bytes memory data) = L1SLOAD_PRECOMPILE.staticcall(
                abi.encodePacked(
                    l1sloadContractAddress, uint256(keccak256(abi.encodePacked(l1SlotNumber))) + slotSequence
                )
            );
            if (!success) {
                revert("Error retrieving L1 String");
            }

            string memory retrievedString = string(data);

            // Check if the retrieved string is empty
            if (keccak256(data) == keccak256(abi.encodePacked(uint256(0)))) {
                break;
            }

            stringResult = string(abi.encodePacked(stringResult, retrievedString));
            slotSequence++;
        }
        return stringResult;
    }

    // variable tester
    function retrieveL1StringSlotBySequence(uint256 testSlots) public view returns (string memory) {
        uint256 l1SlotNumber = 1; // string storage slot
        (bool success, bytes memory data) = L1SLOAD_PRECOMPILE.staticcall(
            abi.encodePacked(l1sloadContractAddress, uint256(keccak256(abi.encodePacked(l1SlotNumber))) + testSlots)
        );
        if (!success) {
            revert("Error retrieving L1 String");
        }
        return string(data);
    }

    function retrieveL1Bytes() public view returns (bytes memory) {
        uint256 l1SlotNumber = 2; //storage of l1Bytes
        (bool success, bytes memory data) =
            L1SLOAD_PRECOMPILE.staticcall(abi.encodePacked(l1sloadContractAddress, l1SlotNumber));
        if (!success) {
            revert("Error retrieving L1 Bytes");
        }
        return bytes(data);
    }
}
