// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract L2ContractAdvanceType {
    address immutable L1SLOAD_PRECOMPILE = 0x0000000000000000000000000000000000000101;
    address immutable l1sloadContractAddress;

    struct L1ProfileStruct {
        string name;
        uint256 age;
    }

    constructor(address _l1sloadContractAddress) {
        l1sloadContractAddress = _l1sloadContractAddress;
    }

    // Retrieve fixed L1 Array
    function retrieveFixedArrayElement(uint256 variableStorageSlot, uint256 arraySlot) public view returns (uint256) {
        (bool success, bytes memory data) =
            L1SLOAD_PRECOMPILE.staticcall(abi.encodePacked(l1sloadContractAddress, variableStorageSlot + arraySlot));
        if (!success) {
            revert("Error retrieving fixed array elements");
        }
        return abi.decode(data, (uint256));
    }

    // Retrieve Dynamic Array
    function retrieveDynamicArrayNumber(uint256 variableStorageSlot, uint256 arrayIndex)
        public
        view
        returns (uint256)
    {
        (bool success, bytes memory data) = L1SLOAD_PRECOMPILE.staticcall(
            abi.encodePacked(
                l1sloadContractAddress, uint256(keccak256(abi.encodePacked(variableStorageSlot))) + arrayIndex
            )
        );
        if (!success) {
            revert("Error retrieving L1 array");
        }
        return abi.decode(data, (uint256));
    }

    // Retrieve mapping
    function retrieveL1AddressToMapping(uint256 variableStorageSlot, address _mappingAddress)
        public
        view
        returns (uint256)
    {
        (bool success, bytes memory data) = L1SLOAD_PRECOMPILE.staticcall(
            abi.encodePacked(
                l1sloadContractAddress,
                uint256(keccak256(abi.encodePacked(uint256(uint160(_mappingAddress)), variableStorageSlot)))
            )
        );
        if (!success) {
            revert("Error extracting mapping data");
        }
        return abi.decode(data, (uint256));
    }

    // Retrieve nested mapping
    function retrieveL1NestedMapping(uint256 variableStorageSlot, address _mappingAddress, string memory _mappingString)
        public
        view
        returns (uint256)
    {
        bytes32 initialSlot = keccak256(abi.encodePacked(uint256(uint160(_mappingAddress)), variableStorageSlot));
        bytes32 finalSlot = keccak256(abi.encodePacked(_mappingString, initialSlot));

        (bool success, bytes memory data) =
            L1SLOAD_PRECOMPILE.staticcall(abi.encodePacked(l1sloadContractAddress, finalSlot));
        if (!success) {
            revert("Error extracting nested mapping data");
        }
        return abi.decode(data, (uint256));
    }

    // Retrieve struct
    function retrieveStruct(uint256 variableStorageSlot, uint256 arrayIndex) public view returns (bytes memory) {
        (bool success, bytes memory data) = L1SLOAD_PRECOMPILE.staticcall(
            abi.encodePacked(
                l1sloadContractAddress, uint256(keccak256(abi.encodePacked(variableStorageSlot))) + arrayIndex
            )
        );
        if (!success) {
            revert("Error retrieving L1 array");
        }
        return data;
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////// UTILS ////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    function convertBytesToString(bytes memory _bytes) public pure returns (string memory) {
        return string(_bytes);
    }

    function convertBytesToUint(bytes memory _bytes) public pure returns (uint256) {
        return abi.decode(_bytes, (uint256));
    }
}
