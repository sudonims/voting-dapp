var VoterData = artifacts.require("./VoterData.sol");
var Vote = artifacts.require("./Vote.sol");

module.exports = function (deployer) {
  deployer.deploy(VoterData);
  deployer.deploy(Vote);
};
