async function main() {
  const [owner] = await ethers.getSigners();

  let rebelTreasuryAddress = '0xaeA7e85AD73B4e8Fa2c222Bd43F129008fb0C56A'
  let michaelAddress = '0x440DAA861400Bf754B83121479Bf26895F1Df7C4'

  // Rebel has been deployed to Optimism Mainnet
  let rebelTokenAddress = '0x328345ab56a490383B515c17ea6788bAB205BCA4'

  let Misfit;
  let Rebel;
  let Trouble;
  let Withdraw;
  let Vend;
  let Metadata;
  let misfitToken;
  let rebelToken;
  let troubleToken;
  let withdrawContract;
  let vendContract;
  let metadataContract;
  let rebelTreasury;
  let communityTreasury;
  let member;
  let decimals;
  let troubleMintAward;

  const mintPrice = 0.05
  const maxMisfitSupply = 1000
  const metadataBaseUrl = 'https://rebel.fun/rebel/collectibles/'

  console.log("Deploying contracts...")

  Misfit   = await ethers.getContractFactory("Misfits");
  Rebel    = await ethers.getContractFactory("Rebel");
  Trouble  = await ethers.getContractFactory("Trouble");
  Withdraw = await ethers.getContractFactory("Withdraw");
  Vend   = await ethers.getContractFactory("Vend");

  misfitToken  = await Misfit.deploy()
  rebelToken   = await Rebel.deploy()
  troubleToken = await Trouble.deploy()
  withdrawContract = await Withdraw.deploy()
  vendContract   = await Vend.deploy()

  console.log("Deployed contracts...")
  console.log("  Misfit address:", misfitToken.address);
  console.log("  Rebel address:", rebelToken.address);
  console.log("  Trouble address:", troubleToken.address);
  console.log("  Withdraw address:", withdrawContract.address);
  console.log("  Vend address:", vendContract.address);

  decimals = await rebelToken.decimals();

  troubleMintAward = ethers.BigNumber.from(100).mul(ethers.BigNumber.from(10).pow(decimals))

  console.log("Minting REBEL...")
  await rebelToken.mint(rebelTreasuryAddress, ethers.BigNumber.from(999999000).mul(ethers.BigNumber.from(10).pow(decimals)));
  await rebelToken.mint(michaelAddress, ethers.BigNumber.from(1000).mul(ethers.BigNumber.from(10).pow(decimals)));

  console.log("Setting MISFIT values...")
  await misfitToken.setRebelAddress(rebelTreasuryAddress)
  await misfitToken.setTroubleAddress(troubleToken.address)
  await misfitToken.setMintPrice(mintPrice);
  await misfitToken.setTroubleMintReward(troubleMintAward);
  await misfitToken.setMaxSupply(maxMisfitSupply);
  await misfitToken.setMetadataBaseUrl(metadataBaseUrl);
  await misfitToken.setWithdrawAddress(withdrawContract.address)

  console.log("Setting TROUBLE roles...")
  await troubleToken.grantRole(troubleToken.MINTER_ROLE(), misfitToken.address);
  await troubleToken.grantRole(troubleToken.MINTER_ROLE(), vendContract.address);
  await troubleToken.grantRole(troubleToken.MINTER_ROLE(), rebelTreasuryAddress);
  await troubleToken.grantRole(troubleToken.TRANSFER_ROLE(), rebelTreasuryAddress);
  await troubleToken.grantRole(troubleToken.BURNER_ROLE(), rebelTreasuryAddress);

  console.log("Setting Vend values...")
  await vendContract.setValuation(20000000);
  await vendContract.setRebelTokenAddress(rebelToken.address);
  await vendContract.setTroubleTokenAddress(troubleToken.address);

  await rebelToken.transferOwnership(rebelTreasury);

  console.log("Deployment complete.")
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });