import React from "react";
import Nav from "../components/Navbar";
import Web3Context from "../helpers/web3Context";
import Web3 from "web3";

export default function Home() {
  const [web3, setWeb3] = React.useState(null);
  const [address, setAddress] = React.useState(null);

  const updateAddress = (add) => setAddress(add);
  const updateWeb3 = (web) => setWeb3(web);

  console.log(web3, address);
  return (
    <Web3Context.Provider
      value={{
        web3,
        address,
        updateWeb3,
        updateAddress,
      }}
    >
      <div>
        <Nav />
      </div>
    </Web3Context.Provider>
  );
}
