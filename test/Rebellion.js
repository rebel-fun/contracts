// Rebel Treasury: 0xaeA7e85AD73B4e8Fa2c222Bd43F129008fb0C56A
// Rebel Community: 0x1CEb163cc1A57eff22BCF1EE02B38074BE181C07

const { expect } = require("chai");

describe("Simulate a Rebellion", function () {

  let Misfit;
  let Rebel;
  let Trouble;
  let Withdraw;
  let Invest;
  let Metadata;
  let misfitToken;
  let rebelToken;
  let troubleToken;
  let withdrawContract;
  let investContract;
  let metadataContract;
  let owner;
  let rebelTreasury;
  let communityTreasury;
  let member;
  let decimals;
  let troubleMintAward;

  const mintPrice = 500
  const maxMisfitSupply = 25
  const metadataBaseUrl = 'https://rebel.fun/rebel/collectibles/'

  before(async function(){

    [owner, rebelTreasury, communityTreasury, member] = await ethers.getSigners();

    Misfit   = await ethers.getContractFactory("Misfits");
    Rebel    = await ethers.getContractFactory("Rebel");
    Trouble  = await ethers.getContractFactory("Trouble");
    Withdraw = await ethers.getContractFactory("Withdraw");
    Invest   = await ethers.getContractFactory("Invest");
    Metadata = await ethers.getContractFactory("Metadata");
    misfitToken  = await Misfit.deploy()
    rebelToken   = await Rebel.deploy()
    troubleToken = await Trouble.deploy()
    withdrawContract = await Withdraw.deploy()
    investContract   = await Invest.deploy()
    metadataContract = await Metadata.deploy()

    decimals = await rebelToken.decimals();

    troubleMintAward = ethers.BigNumber.from(100).mul(ethers.BigNumber.from(10).pow(decimals))

    await rebelToken.mint(rebelTreasury.address, ethers.BigNumber.from(510000000).mul(ethers.BigNumber.from(10).pow(decimals)));
    await rebelToken.mint(communityTreasury.address, ethers.BigNumber.from(490000000).mul(ethers.BigNumber.from(10).pow(decimals)));
    await rebelToken.connect(rebelTreasury).transfer(investContract.address, ethers.BigNumber.from(20000000).mul(ethers.BigNumber.from(10).pow(decimals)))

    await misfitToken.setRebelAddress(rebelTreasury.address)
    await misfitToken.setTroubleAddress(troubleToken.address)
    await misfitToken.connect(owner).setMintPrice(mintPrice);
    await misfitToken.setTroubleMintReward(troubleMintAward);
    await misfitToken.setMaxSupply(maxMisfitSupply);
    await misfitToken.setMetadataBaseUrl(metadataBaseUrl);
    // UNCOMMENT FOR LIVE DEPLOYMENT
    // await misfitToken.setWithdrawAddress(withdrawContract.address)

    await troubleToken.grantRole(troubleToken.MINTER_ROLE(), misfitToken.address);
    await troubleToken.grantRole(troubleToken.MINTER_ROLE(), investContract.address);
    await troubleToken.grantRole(troubleToken.MINTER_ROLE(), rebelTreasury.address);
    await troubleToken.grantRole(troubleToken.TRANSFER_ROLE(), rebelTreasury.address);
    await troubleToken.grantRole(troubleToken.BURNER_ROLE(), rebelTreasury.address);

    await investContract.setValuation(20000000);
    await investContract.setRebelTokenAddress(rebelToken.address);
    await investContract.setTroubleTokenAddress(troubleToken.address);
  })

  describe("Deployment", function(){
    it("Should set the right Owners and Roles", async function(){
      expect(await misfitToken.owner()).to.equal(owner.address);
    })
  })

  describe("Investors", function(){
    it("Can calculate the correct values", async function(){
      decimals = await rebelToken.decimals();
      result = await investContract.connect(member).rebelTotalForUsd(1);
      expect(result).to.equal(ethers.BigNumber.from(50).mul(ethers.BigNumber.from(10).pow(decimals)));
    })

    it("Can ask for price in ETH and purchase REBEL", async function(){
      minEth = await investContract.connect(member).usdPriceInEth(1);
      decimals = await rebelToken.decimals();
      
      await investContract.connect(member).purchase(member.address, 1, {value: minEth});
      expect(await rebelToken.balanceOf(member.address)).to.equal(ethers.BigNumber.from(50).mul(ethers.BigNumber.from(10).pow(decimals)));
    })
  })

  describe("Misfit mints", function(){
    it("Should mint Misfits to Rebel Treasury", async function(){
      await misfitToken.connect(rebelTreasury).mint(rebelTreasury.address, {value: ethers.utils.parseEther("0.6")});
      await misfitToken.connect(rebelTreasury).mintMultiple(rebelTreasury.address, 19, {value: ethers.utils.parseEther("11")});
      
      await misfitToken.connect(member).mintAndStake(member.address, 1, "wagdie.fun", {value: ethers.utils.parseEther("0.6")});
      await misfitToken.connect(member).mintAndStake(member.address, 2, "pablos.fun", {value: ethers.utils.parseEther("0.6")});

      expect(await misfitToken.balanceOf(rebelTreasury.address)).to.equal(20);
    })

    it("Should revert when trying to stake an already-staked communityId", async function(){
      await expect(
        misfitToken.connect(rebelTreasury).stakeMisfit(1, 1, 'wagdie.fun')
      ).to.be.revertedWith(`CommunityAlreadyStaked`);
    });

    it("Should make Trouble for Misfit mints", async function(){
      expect(await troubleToken.balanceOf(rebelTreasury.address)).to.equal(troubleMintAward);
      expect(await troubleToken.balanceOf(member.address)).to.equal(troubleMintAward);
    })

    it("Should return the correct domains for wagdie", async function(){
      expect(await misfitToken.getDomainFor(21)).to.equal("wagdie.fun");
      await misfitToken.connect(member).setDomainFor(21, "wagdie.xyz");
      expect(await misfitToken.getDomainFor(21)).to.equal("wagdie.xyz");
    })
  })

  describe("Misfit boosts", function(){
    it("Should revert on unstaked misfits", async function(){
      await expect(
        misfitToken.connect(member).boost(1, {value: ethers.utils.parseEther("0.5")})
      ).to.be.revertedWith(`MisfitNotStaked`);
    });

    it("Should allow people to boost staked Misfit communities", async function(){

      // Boosting wagdie.fun
      await misfitToken.connect(member).boost(21, {value: ethers.utils.parseEther("0.5")});

      // Boosting pablos.fun 2x
      await misfitToken.connect(member).boost(21, {value: ethers.utils.parseEther("0.5")});
      await misfitToken.connect(communityTreasury).boost(22, {value: ethers.utils.parseEther("1.5")});

      expect(await misfitToken.totalBoostedForToken(21)).to.equal(ethers.utils.parseEther("1"));
      expect(await misfitToken.totalBoostedForToken(22)).to.equal(ethers.utils.parseEther("1.5"));
      
      // Verify that various boosts getters work
      expect((await misfitToken.boostsFromAddress(member.address)).length).to.equal(2);
      expect((await misfitToken.boostsFromAddressForToken(member.address, 21)).length).to.equal(2);
      expect((await misfitToken.boostsFromAddressForToken(communityTreasury.address, 21)).length).to.equal(0);
      expect((await misfitToken.boostsFromAddressForToken(communityTreasury.address, 22)).length).to.equal(1);
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

      await misfitToken.connect(member).boost(21, {value: ethers.utils.parseEther("1")});

      misfitsBalance  = await provider.getBalance(misfitToken.address);
      treasuryBalance = await provider.getBalance(rebelTreasury.address);

      await misfitToken.setWithdrawAddress(withdrawContract.address);
      await misfitToken.connect(owner).withdraw();

      expect(await provider.getBalance(rebelTreasury.address)).to.equal(treasuryBalance.add(misfitsBalance.div(4)));
    });
  })
});