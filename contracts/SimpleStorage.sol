// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;

contract SimpleStorage {
    uint256 storedData;
    mapping(string => bool) public voterID;
    mapping(string => bool) public addressInUse;
    string[] public arr;

    constructor() public {}

    function registerNewVoter(string memory id, string memory add)
        public
        returns (string memory)
    {
        if (!voterID[id]) {
            arr.push(id);
            voterID[id] = true;
            addressInUse[add] = true;
            return ("success");
        } else {
            return ("Voter already registered");
        }
    }

    function getAdd() public view returns (string memory) {
        return arr[0];
    }

    function isAddressInUse(string calldata add) public view returns (bool) {
        return addressInUse[add] ? true : false;
    }
}
