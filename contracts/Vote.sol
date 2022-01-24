// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;

import "./VoterData.sol";

struct Voter {
    address add;
    bool exists;
}

struct Candidate {
    string candidate;
    int256 count;
    bool exists;
}

contract Vote {
    mapping(string => Candidate) private count;
    string[] public candidateList; // Should be predefined list
    address voterDataAddress;
    mapping(address => Voter) public votesDone;

    constructor() public {
        candidateList = [string("A"), "B"];
        voterDataAddress = 0x94E55451Fba1803FB8D614663D0CC22d6F7c63a8;
    }

    function getCandidates() public view returns (string[] memory) {
        return candidateList;
    }

    function toAsciiString(address x) internal pure returns (string memory) {
        bytes memory s = new bytes(40);
        for (uint256 i = 0; i < 20; i++) {
            bytes1 b = bytes1(uint8(uint256(uint160(x)) / (2**(8 * (19 - i)))));
            bytes1 hi = bytes1(uint8(b) / 16);
            bytes1 lo = bytes1(uint8(b) - 16 * uint8(hi));
            s[2 * i] = char(hi);
            s[2 * i + 1] = char(lo);
        }
        return string(s);
    }

    function char(bytes1 b) internal pure returns (bytes1 c) {
        if (uint8(b) < 10) return bytes1(uint8(b) + 0x30);
        else return bytes1(uint8(b) + 0x57);
    }

    modifier validVoter(string memory add) {
        string memory a = "0x769043945515e7A25e8B9A4DD6a93f637B6b5F6e";
        require(
            keccak256(bytes(add)) == keccak256(bytes(a)),
            "Not a valid Address"
        );
        _;
    }

    function castVote(string calldata candidate)
        public
        returns (string memory)
    {
        address voter = msg.sender;

        if (!votesDone[voter].exists) {
            votesDone[voter] = Voter(voter, true);

            if (!count[candidate].exists) {
                count[candidate] = Candidate(candidate, 0, true);
            }
            count[candidate].count++;
            return ("success");
        }
        return ("vote done");
    }

    function getCount(string calldata candidate) public view returns (int256) {
        int256 cnt = count[candidate].count;
        return cnt;
    }
}
