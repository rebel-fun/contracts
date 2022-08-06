// Rebel Treasury: 0xaeA7e85AD73B4e8Fa2c222Bd43F129008fb0C56A
// Rebel Community: 0x1CEb163cc1A57eff22BCF1EE02B38074BE181C07

const { expect } = require("chai");

describe("Simulate a Rebellion", function () {

  let Misfit;
  let Rebel;
  let Trouble;
  let Withdraw;
  let MintSwap;
  let Boosts;
  let Vend;
  let Metadata;
  let misfitToken;
  let rebelToken;
  let troubleToken;
  let boostsContract;
  let withdrawContract;
  let vendContract;
  let metadataContract;
  let owner;
  let rebelTreasury;
  let communityTreasury;
  let member;
  let decimals;
  let troubleMintAward;

  const mintPrice = "0.05"
  const maxMisfitSupply = 30
  const metadataBaseUrl = 'https://rebel.fun/rebel/collectibles/'

  before(async function(){

    [owner, rebelTreasury, communityTreasury, member] = await ethers.getSigners();

    Misfit   = await ethers.getContractFactory("Misfits");
    Rebel    = await ethers.getContractFactory("Rebel");
    Trouble  = await ethers.getContractFactory("Trouble");
    Withdraw = await ethers.getContractFactory("Withdraw");
    MintSwap = await ethers.getContractFactory("MintSwap");
    Boosts   = await ethers.getContractFactory("Boosts");
    Vend     = await ethers.getContractFactory("Vend");
    Metadata = await ethers.getContractFactory("Metadata");
    misfitToken  = await Misfit.deploy()
    rebelToken   = await Rebel.deploy()
    troubleToken = await Trouble.deploy()
    withdrawContract = await Withdraw.deploy()
    mintSwapContract = await MintSwap.deploy()
    boostsContract = await Boosts.deploy()
    vendContract   = await Vend.deploy()
    metadataContract = await Metadata.deploy()

    decimals = await rebelToken.decimals();

    troubleMintAward = ethers.BigNumber.from(100).mul(ethers.BigNumber.from(10).pow(decimals))

    await rebelToken.mint(rebelTreasury.address, ethers.BigNumber.from(510000000).mul(ethers.BigNumber.from(10).pow(decimals)));
    await rebelToken.mint(communityTreasury.address, ethers.BigNumber.from(490000000).mul(ethers.BigNumber.from(10).pow(decimals)));
    await rebelToken.connect(rebelTreasury).transfer(vendContract.address, ethers.BigNumber.from(20000000).mul(ethers.BigNumber.from(10).pow(decimals)))

    await misfitToken.setRebelTreasuryAddress(rebelTreasury.address)
    await misfitToken.setTroubleAddress(troubleToken.address)
    await misfitToken.setMintPrice(ethers.utils.parseEther(mintPrice));
    await misfitToken.setTroubleMintReward(troubleMintAward);
    await misfitToken.setMaxSupply(maxMisfitSupply);
    await misfitToken.setMetadataBaseUrl(metadataBaseUrl);
    // UNCOMMENT FOR LIVE DEPLOYMENT
    // await misfitToken.setWithdrawAddress(withdrawContract.address)

    await troubleToken.grantRole(troubleToken.MINTER_ROLE(), misfitToken.address);
    await troubleToken.grantRole(troubleToken.MINTER_ROLE(), vendContract.address);
    await troubleToken.grantRole(troubleToken.MINTER_ROLE(), rebelTreasury.address);
    await troubleToken.grantRole(troubleToken.TRANSFER_ROLE(), rebelTreasury.address);
    await troubleToken.grantRole(troubleToken.BURNER_ROLE(), rebelTreasury.address);

    await vendContract.setValuation(20000000);
    await vendContract.setRebelTokenAddress(rebelToken.address);
    await vendContract.setTroubleTokenAddress(troubleToken.address);
  })

  describe("Deployment", function(){
    it("Should set the right Owners and Roles", async function(){
      expect(await misfitToken.owner()).to.equal(owner.address);
    })
  })

  describe("Misfit mints", function(){
    it("Should mint Misfits to Rebel Treasury", async function(){
      await misfitToken.connect(rebelTreasury).mint(rebelTreasury.address, {value: ethers.utils.parseEther("0.05")});
      await misfitToken.connect(rebelTreasury).mintMultiple(rebelTreasury.address, 4, {value: ethers.utils.parseEther("0.2")});

      await misfitToken.connect(member).mintAndStake(member.address, 1, {value: ethers.utils.parseEther("0.05")});
      await misfitToken.connect(member).mintAndStake(member.address, 2, {value: ethers.utils.parseEther("0.05")});
      await misfitToken.connect(member).mint(member.address, {value: ethers.utils.parseEther("0.05")});

      it("Should revert when trying to mint & stake an already-staked communityId", async function(){
        await expect(
          misfitToken.connect(member).mintAndStake(member.address, 1)
        ).to.be.revertedWith(`CommunityAlreadyStaked`);
      });

      expect(await misfitToken.totalSupply()).to.equal(30);
      expect(await misfitToken.balanceOf(rebelTreasury.address)).to.equal(5);
    })

    it("Should proxy ETH to a mint swap contract when set", async function(){
      // let rebelTreasuryRebelBalance = ethers.BigNumber.from((await rebelToken.balanceOf(rebelTreasury.address)));

      // console.log("rebelTreasuryRebelBalance1", rebelTreasuryRebelBalance);

      await misfitToken.setMintSwapAddress(mintSwapContract.address);

      // Use actual REBEL token's address to test uniswap pool
      await mintSwapContract.setRebelTreasuryAddress('0xaea7e85ad73b4e8fa2c222bd43f129008fb0c56a');
      await misfitToken.connect(member).mint(member.address, {value: ethers.utils.parseEther("0.05")});

      // console.log("rebelTreasuryRebelBalance2", await rebelToken.balanceOf(rebelTreasury.address));

      // Check that the treasury's rebel balance has increased
      // expect(ethers.BigNumber.from((await rebelToken.balanceOf(rebelTreasury.address)))).to.be.greaterThan(rebelTreasuryRebelBalance);

      // Remove the mint swap proxy
      await misfitToken.setMintSwapAddress(ethers.constants.AddressZero);
    })

    it("Should revert when not sending enough ETH", async function(){
      await expect(
        misfitToken.connect(member).mint(member.address, {value: ethers.utils.parseEther("0.04")})
      ).to.be.revertedWith(`NotEnoughEth`);
    });

    it("Should discount bulk purchases", async function(){
      let quantity = 10;
      let mintPriceInEth = parseInt(await misfitToken.mintPriceInEth(1));
      let bulkOrderPrice = parseInt(await misfitToken.mintPriceInEth(quantity));

      expect(bulkOrderPrice).to.equal((mintPriceInEth * 8 / 10) * quantity);
    })

    it("Should make Trouble for Misfit mints", async function(){
      expect(await troubleToken.balanceOf(rebelTreasury.address)).to.equal(troubleMintAward);
      expect(await troubleToken.balanceOf(member.address)).to.equal(troubleMintAward);
    })
  })

  describe("Misfit staking", function(){

    if("Should provide access to staked community and misfit info", async function(){
      expect(await misfitToken.tokenIdForCommunity(2)).to.equal(7);
      expect(await misfitToken.communityIdForToken(6)).to.equal(1);
    })

    it("Should revert when trying to stake an unowned Misfit", async function(){
      await expect(
        misfitToken.connect(member).stakeMisfit(5, 50)
      ).to.be.revertedWith(`Unauthorized`);
    });

    it("Owner should be able to stake and unstake any Misfit", async function(){
      await misfitToken.connect(owner).stakeMisfit(5, 50);
      await misfitToken.connect(owner).unstakeMisfit(5);
    });

    it("Should prevent staking and unstaking setting for non-existent Misfits", async function(){
      await expect(
        misfitToken.connect(owner).stakeMisfit(500, 51)
      ).to.be.revertedWith(`MisfitDoesntExist`);

      await expect(
        misfitToken.connect(owner).unstakeMisfit(500)
      ).to.be.revertedWith(`MisfitDoesntExist`);
    });

    it("Should revert when trying to stake an already-staked communityId", async function(){
      await expect(
        misfitToken.connect(rebelTreasury).stakeMisfit(1, 1)
      ).to.be.revertedWith(`CommunityAlreadyStaked`);
    });
  })

  describe("Misfit boosts", function(){
    it("Should revert on unstaked misfits", async function(){
      await expect(
        misfitToken.connect(member).boost(1, {value: ethers.utils.parseEther("0.05")})
      ).to.be.revertedWith(`MisfitNotStaked`);
    });

    it("Should allow people to boost staked Misfit communities", async function(){

      // Boosting token #6
      await misfitToken.connect(member).boost(6, {value: ethers.utils.parseEther("0.5")});

      // Boosting token #6 and token #7
      await misfitToken.connect(member).boost(6, {value: ethers.utils.parseEther("0.5")});
      await misfitToken.connect(communityTreasury).boost(7, {value: ethers.utils.parseEther("1.5")});

      expect(await misfitToken.totalBoostedForToken(6)).to.equal(ethers.utils.parseEther("1"));
      expect(await misfitToken.totalBoostedForToken(7)).to.equal(ethers.utils.parseEther("1.5"));
      
      // Verify that various boosts getters work
      expect((await misfitToken.boostsFromAddress(member.address)).length).to.equal(2);
      expect((await misfitToken.boostsFromAddressForToken(member.address, 6)).length).to.equal(2);
      expect((await misfitToken.boostsFromAddressForToken(communityTreasury.address, 6)).length).to.equal(0);
      expect((await misfitToken.boostsFromAddressForToken(communityTreasury.address, 7)).length).to.equal(1);
    })

    it("Should use a proxy Boosts contract when set", async function(){
      
      // Set a proxy Boosts contract and call its boost()
      await misfitToken.setBoostsAddress(boostsContract.address);
      await misfitToken.connect(member).boost(6, {value: ethers.utils.parseEther("0.5")});

      // Check that the proxy contract has the new boost value
      expect(await provider.getBalance(boostsContract.address)).to.equal(ethers.utils.parseEther("0.5"));
      expect((await boostsContract.getBoosts()).length).to.equal(1);

      // Remove the custom boost proxy so the rest of the tests work
      await misfitToken.setBoostsAddress(ethers.constants.AddressZero);
    })
  })

  describe("Misfit metadata", function(){
    it("It should return the correct metadata", async function(){
      expect(await misfitToken.tokenURI(1)).to.equal(metadataBaseUrl + "1/metadata.json");
    });

    it("It should use an alternate metadata contract", async function(){
      await misfitToken.setMetadataAddress(metadataContract.address);
      expect(await misfitToken.tokenURI(1)).to.equal('data://ALT-METADATA/1/metadata.json');
    })
  })

  describe("Trouble", function(){

    it("Members cannot mint or transfer", async function(){
      await expect(troubleToken.connect(member).makeTrouble(member.address, 1000)).to.be.revertedWith(`AccessControl`)
      await expect(troubleToken.connect(member).transfer(owner.address, 1000)).to.be.revertedWith(`AccessControl`)
      await expect(troubleToken.connect(member).transferFrom(owner.address, member.address, 1000)).to.be.revertedWith(`AccessControl`)
    })

    it("Minters can mint", async function(){
      currentBalance = await troubleToken.balanceOf(member.address);
      await troubleToken.connect(rebelTreasury).makeTrouble(member.address, 1000)
      expect(await troubleToken.balanceOf(member.address)).to.equal(currentBalance.add(1000));
    })

    it("Members can burn their own Trouble", async function(){
      await troubleToken.connect(rebelTreasury).makeTrouble(member.address, 1000)
      currentBalance = await troubleToken.balanceOf(member.address);
      await troubleToken.connect(member).burn(1000)
      expect(await troubleToken.balanceOf(member.address)).to.equal(currentBalance.sub(1000));
    })

    it("Burners can burn", async function(){
      currentBalance = await troubleToken.balanceOf(member.address);
      
      await troubleToken.connect(rebelTreasury).makeTrouble(member.address, 1000)
      expect(await troubleToken.balanceOf(member.address)).to.equal(currentBalance.add(1000));

      await troubleToken.connect(rebelTreasury).burnFor(member.address, 1000)
      expect(await troubleToken.balanceOf(member.address)).to.equal(currentBalance);
    })
    
    it("Transfer roles can transfer", async function(){
      await troubleToken.connect(rebelTreasury).makeTrouble(member.address, 1000)
      memberBalance = await troubleToken.balanceOf(member.address);
      treasuryBalance = await troubleToken.balanceOf(rebelTreasury.address);

      await troubleToken.connect(rebelTreasury).transferFrom(member.address, rebelTreasury.address, 1000)
      
      expect(await troubleToken.balanceOf(member.address)).to.equal(memberBalance.sub(1000));
      expect(await troubleToken.balanceOf(rebelTreasury.address)).to.equal(treasuryBalance.add(1000));
    })
  })

  describe("Misfit withdraws", function(){
    provider = ethers.provider;

    it("Owner can do a basic withdraw", async function(){
      misfitsBalance  = await provider.getBalance(misfitToken.address);
      treasuryBalance = await provider.getBalance(rebelTreasury.address);
      
      await expect(misfitToken.connect(member).withdraw()).to.be.revertedWith(`Ownable: caller is not the owner`);
      
      await misfitToken.connect(owner).withdraw();
      expect(await provider.getBalance(rebelTreasury.address)).to.equal(treasuryBalance.add(misfitsBalance));
    });

    it("Owner can withdraw with custom contract", async function(){

      await misfitToken.connect(member).boost(6, {value: ethers.utils.parseEther("1")});

      misfitsBalance  = await provider.getBalance(misfitToken.address);
      treasuryBalance = await provider.getBalance(rebelTreasury.address);

      await misfitToken.setWithdrawAddress(withdrawContract.address);
      await misfitToken.connect(owner).withdraw();

      expect(await provider.getBalance(rebelTreasury.address)).to.equal(treasuryBalance.add(misfitsBalance.div(4)));
    });
  })

  describe("Vending", function(){
    it("Can calculate the correct values", async function(){
      decimals = await rebelToken.decimals();
      result = await vendContract.connect(member).rebelTotalForUsd(1);
      expect(result).to.equal(ethers.BigNumber.from(50).mul(ethers.BigNumber.from(10).pow(decimals)));
    })

    it("Can ask for price in ETH and purchase REBEL", async function(){
      minEth = await vendContract.connect(member).usdPriceInEth(1);
      decimals = await rebelToken.decimals();
      
      await vendContract.connect(member).purchase(member.address, 1, {value: minEth});
      expect(await rebelToken.balanceOf(member.address)).to.equal(ethers.BigNumber.from(50).mul(ethers.BigNumber.from(10).pow(decimals)));
    })
  })
});