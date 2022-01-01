// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;

contract SimpleStorage {
  uint storedData;
  mapping (string=>bool) voterID;
  mapping (string=>bool) addressInUse;

  constructor() public {}
  function registerNewVoter(string memory id, string memory add) public returns (string memory ret) {
    
    if(!voterID[id]) {
      voterID[id] = true;
      addressInUse[add] = true;
      return "Success";
    } else {
      return "Voter already registered";
    }
  }

  function isAddressInUse(string calldata add) public view returns (bool) {
    return addressInUse[add] ? true : false;
  }
}
