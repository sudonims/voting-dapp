import Web3Context from "./web3Context";
import voterData from "../src/contracts/VoterData.json";
import vote from "../src/contracts/Vote.json";
import voteToken from "../src/contracts/VoteToken.json";
import {
  VOTER_DATA_ADDRESS,
  VOTER_TOKEN_ADDRESS,
  VOTE_CONTRACT_ADDRESS,
} from "./constants";
import React from "react";

function useContract() {
  const [contracts, setContracts] = React.useState({
    tokenContract: null,
    voteContract: null,
    dataContract: null,
  });
  const { web3 } = React.useContext(Web3Context);

  React.useEffect(() => {
    async function init() {
      const tokenContract = new web3.eth.Contract(
        voteToken.abi,
        VOTER_TOKEN_ADDRESS
      );
      const voteContract = new web3.eth.Contract(
        vote.abi,
        VOTE_CONTRACT_ADDRESS
      );
      const dataContract = new web3.eth.Contract(
        voterData.abi,
        VOTER_DATA_ADDRESS
      );

      setContracts({
        tokenContract,
        voteContract,
        dataContract,
      });
    }

    init();
  }, []);

  return contracts;
}

export default useContract;
