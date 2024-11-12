// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract L1Contract {
    /////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////// GLOBAL VARIABLES //////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////

    // uint256
    uint256 l1Number; //storage slot 0
    // bytes 
    string l1Text; //storage slot 1
    // string
    bytes32 l1Bytes; //storage slot 2
    // fixed or dynamic array
    uint256[3] public l1FixedArray;
    uint64[4] public l1FixedArray2;
    uint256[] public l1DynamicArray;
    // dynamic mapping
    mapping(address => uint256) l1AddressToNumberMapping;
    mapping(address => mapping(string => uint256)) l1NestedMapping;
    // struct

    struct L1ProfileStruct {
        string name;
        uint256 age;
    }

    L1ProfileStruct[] public playerProfile;

    /////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////// WRITE FUNCTIONS //////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////

    constructor() {
        l1FixedArray = [3, 6, 9];
        l1FixedArray2 = [10, 20, 0, 30];
        l1DynamicArray = [100, 200, 300, 400];

        l1AddressToNumberMapping[address(this)] = 100;
        l1NestedMapping[address(this)]["ABC"] = 1000;
    }

    function storeNumber(uint256 number) public {
        l1Number = number;
    }

    function storeText(string memory _stringText) public {
        l1Text = _stringText;
    }

    function storeBytes(bytes32 _bytes) public {
        l1Bytes = _bytes;
    }

    function pushFixedArray(uint256 _index, uint256 value) public {
        l1FixedArray[_index] = value;
    }

    function pushDynamicArray(uint256 value) public {
        l1DynamicArray.push(value);
    }

    function setl1AddressToNumberMapping(address _someAddress, uint256 _someValue) public {
        l1AddressToNumberMapping[_someAddress] = _someValue;
    }

    function setNestedMapping(address _nestedAddress, string memory _nestedString, uint256 _nestedValue) public {
        l1NestedMapping[_nestedAddress][_nestedString] = _nestedValue;
    }

    function setPlayerProfile(string memory _name, uint256 _age) public {
        L1ProfileStruct memory newProfile = L1ProfileStruct({name: _name, age: _age});
        playerProfile.push(newProfile);
    }

    /////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////// READ FUNCTIONS ///////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////

    function retrieveNumber() public view returns (uint256) {
        return l1Number;
    }

    function retrieveString() public view returns (string memory) {
        return l1Text;
    }

    function retrieveBytes() public view returns (bytes32) {
        return l1Bytes;
    }

    function retrieveFixedArray() public view returns (uint256[3] memory) {
        return l1FixedArray;
    }

    function retrieveFixedArray2() public view returns (uint64[4] memory) {
        return l1FixedArray2;
    }

    function retrieveDynamicArray() public view returns (uint256[] memory) {
        return l1DynamicArray;
    }

    function retrieveL1AddressToNumberMapping(address _someAddress) public view returns (uint256) {
        return l1AddressToNumberMapping[_someAddress];
    }

    function retrieveL1NestedMapping(address _someAddress, string memory _someKey) public view returns (uint256) {
        return l1NestedMapping[_someAddress][_someKey];
    }

    function retrieveStructArray() public view returns (L1ProfileStruct[] memory) {
        return playerProfile;
    }
}
