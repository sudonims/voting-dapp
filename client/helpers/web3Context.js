import React from "react";

const Web3Context = React.createContext({
  web3: null,
  address: null,
  updateWeb3: () => {},
  updateAddress: () => {},
});

export default Web3Context;
