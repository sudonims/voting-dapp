const path = require("path");

module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!
  contracts_build_directory: path.join(__dirname, "client/src/contracts"),
  networks: {
    ganache: {
      network_id: 5777,
      port: 7545,
      host: "127.0.0.1",
    },
  },
  compilers: {
    solc: {
      version: "0.8.11",
      parser: "solcjs", // Leverages solc-js purely for speedy parsing
      settings: {
        optimizer: {
          enabled: true,
        },
      },
    },
  },
};
