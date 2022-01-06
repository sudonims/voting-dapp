// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;

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

    mapping(address => Voter) public votesDone;

    constructor() public {
        candidateList = [string("A"), "B"];
    }

    function getCandidates() public view returns (string[] memory) {
        return candidateList;
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
            return ("succss");
        }
        return ("vote done");
    }

    function getCount(string calldata candidate) public view returns (int256) {
        int256 cnt = count[candidate].count;
        return cnt;
    }
}
