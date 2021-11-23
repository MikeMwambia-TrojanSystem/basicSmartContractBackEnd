const main = async () => {
  const waveContractFactory = await hre.ethers.getContractFactory('WavePortal');

  const waveContract = await waveContractFactory.deploy({
    //This means move ethers from my account to the contract upon deploying
    value: hre.ethers.utils.parseEther('5'),
  });

  await waveContract.deployed();
  console.log('Contract addy:', waveContract.address);

  /*
   * Get Contract balance
   */
  let contractBalance = await hre.ethers.provider.getBalance(
    waveContract.address
  );
  console.log(
    'Contract balance before two waves:',
    hre.ethers.utils.formatEther(contractBalance)
  );

  /*
   * Send Wave
   */
  let waveTxn = await waveContract.wave('A message!');
  await waveTxn.wait();

  let waveTxn2 = await waveContract.wave('This is wave #2');
  await waveTxn2.wait();

  /*
   * Get Contract balance to see what happened!
   */
  contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
  console.log(
    'Contract balance after two waves:',
    hre.ethers.utils.formatEther(contractBalance)
  );

  let allWaves = await waveContract.getAllWaves();
  console.log(allWaves);
};

  
  const runMain = async () => {
    try {
      await main();
      process.exit(0);
    } catch (error) {
      console.log(error);
      process.exit(1);
    }
  };
  
  runMain();