// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;

interface IERC20 {
    function totalSupply() external view returns (uint256);

    function balanceOf(address acc) external view returns (uint256);

    function allowance(address owner, address spender)
        external
        view
        returns (uint256);

    function transfer(address receiver, uint256 amount) external returns (bool);

    function approve(address spender, uint256 amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}

struct Voter {
    address add;
    bool exists;
}

struct Candidate {
    string candidate;
    uint256 count;
    bool exists;
}

contract Vote {
    mapping(string => Candidate) private count;
    string[] public candidateList; // Should be predefined list
    address tokenAddress;
    mapping(address => Voter) public votesDone;

    constructor() public {
        candidateList = [string("A"), "B"];
        tokenAddress = 0x6FcD2a260dbc4E49A935098d8CA15306aF6EC841;
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
            require(count[candidate].count != 1, "Next Step");
            IERC20(tokenAddress).transfer(voter, 1);
            // require(1, "Sent");
            return ("success");
        }
        return ("vote done");
    }

    function getCount(string calldata candidate) public view returns (uint256) {
        uint256 cnt = count[candidate].count;
        return cnt;
    }
}
