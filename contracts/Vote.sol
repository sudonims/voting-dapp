// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;

import "./VoteToken.sol";

interface VoterData {
    function isAddressInUse(string memory add) external view returns (bool);
}

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
    address voterTokenAddress;
    mapping(address => Voter) public votesDone;

    constructor() public {
        candidateList = [string("A"), "B"];
        voterDataAddress = 0x6b25Ac500EBBf158A02f6544f8fC3f1330D4F5aa;
        voterTokenAddress = 0x56C9F47BF43DCddc1CfA8f1e157f0f66E01c79E5;
    }

    function getCandidates() public view returns (string[] memory) {
        return candidateList;
    }

    function toAsciiString(address x) public view returns (string memory) {
        x = msg.sender;
        bytes memory s = new bytes(42);
        s[0] = "0";
        s[1] = "x";
        for (uint256 i = 0; i < 20; i++) {
            bytes1 b = bytes1(uint8(uint256(uint160(x)) / (2**(8 * (19 - i)))));
            bytes1 hi = bytes1(uint8(b) / 16);
            bytes1 lo = bytes1(uint8(b) - 16 * uint8(hi));
            s[2 * i + 2] = char(hi);
            s[2 * i + 3] = char(lo);
        }
        return string(s);
    }

    function char(bytes1 b) internal pure returns (bytes1 c) {
        if (uint8(b) < 10) return bytes1(uint8(b) + 0x30);
        else return bytes1(uint8(b) + 0x57);
    }

    // modifier validVoter(string memory add) {
    //     require( // string memory a = "0x769043945515e7A25e8B9A4DD6a93f637B6b5F6e";
    //         keccak256(bytes(add)) == keccak256(bytes(a)),
    //         "Not a valid Address"
    //     );
    //     _;
    // }

    function castVote(string calldata candidate)
        public
        returns (string memory)
    {
        address voter = msg.sender;

        bool isValid = VoterData(voterDataAddress).isAddressInUse(
            toAsciiString(voter)
        );

        require(isValid == true, "Voter Not Valid");

        if (!votesDone[voter].exists) {
            votesDone[voter] = Voter(voter, true);

            if (!count[candidate].exists) {
                count[candidate] = Candidate(candidate, 0, true);
            }
            count[candidate].count++;
            IERC20(voterTokenAddress).transfer(voter, 1);
            return ("success");
        }
        return ("vote done");
    }

    function getCount(string calldata candidate)
        external
        view
        returns (int256)
    {
        int256 cnt = count[candidate].count;
        return cnt;
    }
}
