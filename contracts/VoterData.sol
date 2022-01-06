// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;

contract VoterData {
    mapping(string => bool) public voterID;
    mapping(string => bool) public addressInUse;

    constructor() public {}

    function registerNewVoter(string memory id, string memory add)
        public
        returns (string memory)
    {
        if (!voterID[id]) {
            voterID[id] = true;
            addressInUse[add] = true;
            return ("success");
        } else {
            return ("Voter already registered");
        }
    }

    function isAddressInUse(string calldata add) public view returns (bool) {
        return addressInUse[add] ? true : false;
    }
}
