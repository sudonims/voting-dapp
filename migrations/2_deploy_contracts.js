var VoterData = artifacts.require("./VoterData.sol");
var Vote = artifacts.require("./Vote.sol");
var VoteToken = artifacts.require("./VoteToken.sol");

module.exports = function (deployer) {
  deployer.deploy(VoterData);
  deployer.deploy(Vote);
  // deployer.deploy(VoteToken);
};
