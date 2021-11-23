require("@nomiclabs/hardhat-waffle");

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.4",
  networks : {
    rinkeby : {
      url : 'https://eth-rinkeby.alchemyapi.io/v2/nBgHza1pur1mCNocxhV38BdFdmGChox6',
      accounts : ['4dde36913557a191ce86f2c0131359228b2b50cacca1dded152927731b653065']
    }
  }
};
