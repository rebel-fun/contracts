// MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
// MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWWWWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
// MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWXOkOKWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWXkoc;,,,l0MMWKOk0XMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
// MMMMMMMMMMMMMMMWKK000K0XWMMMMMMMMMMMNK0K000KXWMMMMMW0c.   .lXMMMMMMMMMMMMMMMMMMMMMMMMMMMWOc.       .ONk;.   'xWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
// MMMMMMMMMMMMMMWd.......'OMMMMMMMMMM0;.......lNMMMMM0,      .kMMMMMMMMMMMMMMMMMMMMMMMMMMKc.         ;Kx.      ;XMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
// MMMMMMMMMMMMMMO.        cNMMMMMMMWO'        :NMMMMMO.      :XMMMMMMMMMMMMMMMMMMMMMMMMMK;      .:oolkNo      .dWMMMKkxxxxxONMMMMMMMMMMMMMMMMMMMMMMMMMMMM
// MMMMMMMMMMMMMX:         .OMMMMMMWk.         :NMMMMMWO:'.':xNMMMMMMMMMMMMMMMMMMMMMMMMMWo      .kWMMMMMXd;'.,lOWMMMNl      ,KMMMMMMMMMMMMMMMMMMMMMMMMMMMM
// MMMMMMMMMMMMWd.          lWMMMMNd.          :NMMMMMMMWNNNWMMMMMMMMMMMMMMMMMMMMMMMMMMMX;      cNMMMMMMMMWNNWMMMMMMK,      cNMMMMMMMMMMMMMMMMMMMMMMMMMMMM
// MMMMMMMMMMMMO'           '0MMMNo.           cNMMMMNKOOOOO0XMMMMMMMWXOxdollloodkKNMWKOo.      :OOO0NMX0OOOOO0NMWKOl.      cOO0NMMMMMN0kdolllodk0XWMMMMMM
// MMMMMMMMMMMX:            .dWMXl.            cNMMMMk.     .kWMMMMXx:.           ;KMO'             'kNl.     ;KM0,            'OMMNOc'.         'kWMMMMMM
// MMMMMMMMMMWd.      .      ;KXc      .       cNMMMWl      '0MMMWk'       ..    :0WWd              ,KK,      cNMx.            ;KMK:.      ..   'kWMMMMMMM
// MMMMMMMMMM0'      :o.     .c;      ;o.      cNMMMK,      cNMMMk.     .lOK00OdkXMMNo..       ....'dNk.     .xMWd'.       ...'dWK;      ;k00OxxKWMMMMMMMM
// MMMMMMMMMXc      'OX:             cXO.      cNMMMk.     .dWMMWl       ,ldxkOXWMMMWNXl      .kNNNNWWl      '0MMWKc      'kNNNWMk.      .coxOKNMMMMMMMMMM
// MMMMMMMMWd.      oWMx.          .lNMk.      cNMMWo      '0MMMWd.            .cOWMMMX:      ;XMMMMMK,      cNMMMK;      cNMMMMM0'           .;xNMMMMMMMM
// MMMMMMMM0'      ;KMMX:         .dNMMx.      cNMMX;      :XMMMMNkc'.           '0MMMO.      oWMMMMMk.     .dWMMMk.     .dWMMMMMW0l,..         .dWMMMMMMM
// MMMMMMMXc      .xWMMWx.       .xWMMMx.      lNMMO.      dWMMMWXNWNK0ko'       .kMMWd.     .OMMMMMWo      '0MMMWo      '0MMMMMWNNWWX0Od;       lWMMMMMMM
// MMMMMMWx.      cNMMMMX;      'OWMMMWd       lNMWo      .OMMMXo',cdk0Od'       :XMMX:      ;XMMMMMX;      :XMMMX;      :XMMMMWk,':okO0k:      .OMMMMMMMM
// MMMMMM0,      '0MMMMMWd.    ;0WMMMMWo       lWMX:      :XMW0;               .cKMMM0'      oWMMMMMO.      dWMMMO.      dWMMMXo.              ,kWMMMMMMMM
// MMMMMNl      .dWMMMMMMK;   :KMMMMMMWo       lWMO'     .oWMNx'           .';cONMMMWx.     .kMMMMMWd.     .OMMMWd.     'OMMMWO;.           .;xXMMMMMMMMMM
// MMMMMNOxxxxxxONMMMMMMMWKxxOXMMMMMMMWKxxxxxxxKMMXkxxxxxkXMMMWX0xolc::clox0NWWMMMMMMKkxxxxxONMMMMMWKxxxxxxONMMMWKxxxxxxONMMMMMNKkdlc::ccldOXWMMMMMMMMMMMM
// MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
// MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
// MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM

// by @mboyle for Rebel (https://rebel.fun)

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
pragma abicoder v2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

import "@openzeppelin/contracts/utils/Strings.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

import "./Trouble.sol";

import "hardhat/console.sol";

interface IWithdraw {
  function withdraw(address rebelAddress) external;
}

contract Misfits is ERC721, Pausable, Ownable {

  using Counters for Counters.Counter;
  
  /// ERRORS ///

  /// @notice Thrown when trying to stake/unstake a Misfit without owning it
  error Unauthorized();

  /// @notice Thrown when trying to stake a staked Misfit
  error MisfitAlreadyStaked();

  /// @notice Thrown when trying to unstake an unstaked Misfit
  error MisfitNotStaked();

  /// @notice Thrown when trying to unstake an unstaked Misfit
  error MisfitDoesntExist();

  /// @notice Thrown when trying to stake a staked community
  error CommunityAlreadyStaked();

  /// @notice Thrown when trying to mint with less than mint price in ETH
  error NotEnoughEth();

  /// @notice Thrown when trying to mint more than there is supply for
  error NotEnoughSupply();

  /// EVENTS ///

  /// @notice Emitted when staking and unstaking Misfits
  event MisfitStaked(uint256 tokenId, uint256 communityId, string domain);

  /// @notice Emitted when boosting
  event Boosted(Boost boost);

  /// @notice Emitted when withdrawing ETH
  event GotPaid(uint256 eth);

  struct Boost {
    uint256 tokenId;
    address sender;
    uint256 amount;
    uint256 timestamp;
  }
  
  struct Stake {
    uint256 tokenId;
    uint256 communityId;
    string domain;
    uint256 timestamp;
  }
  
  // Optimism Mainnet
  // address constant ETH_USD_ORACLE = 0x13e3Ee699D1909E989722E753853AE30b17e08c5;
  
  // Optimism Kovan
  address constant ETH_USD_ORACLE = 0x7f8847242a530E809E17bF2DA5D2f9d2c4A43261;

  Counters.Counter private _tokenIdCounter;

  AggregatorV3Interface internal priceFeed = AggregatorV3Interface(ETH_USD_ORACLE);

  Boost[] boosts;
  string  metadataBaseUrl;
  address public rebelAddress;
  address public troubleAddress;
  address public withdrawContract;
  address public metadataContract;
  uint256 public daiMintPrice;
  uint256 public maxSupply;
  uint256 public troubleMintReward;
  mapping(uint256 => uint256) stakedCommunities;
  mapping(uint256 => Stake) stakedMisfits;

  constructor() ERC721("Misfits", "MISFIT") {}

  function tokenIdForCommunity(uint256 communityId) public view returns(uint256) {
    return(stakedCommunities[communityId]);
  }

  function communityIdForToken(uint256 tokenId) public view returns(uint256) {
    if(stakedMisfits[tokenId].tokenId == 0) revert MisfitNotStaked();
    return(stakedMisfits[tokenId].communityId);
  }

  function stakeMisfit(uint256 tokenId, uint256 communityId, string memory domain) public {
    if(_tokenIdCounter.current() < tokenId) revert MisfitDoesntExist();
    if(stakedMisfits[tokenId].tokenId != 0) revert MisfitAlreadyStaked();
    if(stakedCommunities[communityId] != 0) revert CommunityAlreadyStaked();
    if(ownerOf(tokenId) != msg.sender && msg.sender != owner()) revert Unauthorized();

    emit MisfitStaked(tokenId, communityId, domain);
    stakedMisfits[tokenId] = Stake(tokenId, communityId, domain, block.timestamp);
    stakedCommunities[communityId] = tokenId;
  }
  
  function unstakeMisfit(uint256 tokenId) public {
    if(_tokenIdCounter.current() < tokenId) revert MisfitDoesntExist();
    if(stakedMisfits[tokenId].tokenId == 0) revert MisfitNotStaked();
    if(ownerOf(tokenId) != msg.sender && msg.sender != owner()) revert Unauthorized();
    uint256 communityId = stakedMisfits[tokenId].communityId;

    emit MisfitStaked(tokenId, 0, '');

    stakedMisfits[tokenId] = Stake(0,0,'',0);
    stakedCommunities[communityId] = 0;
  }

  function mintPriceInEth() public view returns (uint256) {
  
    uint256 minRequiredUSD;
    uint256 etherPriceUSD;

    (,int price,,,) = priceFeed.latestRoundData();

    minRequiredUSD = daiMintPrice * 10**18;
    etherPriceUSD = (uint256(price) / 10**8) * 10**18;

    return (minRequiredUSD * 10**18) / etherPriceUSD;
  }

  function mint(address to) public payable returns(uint256) {

    if(mintPriceInEth() > msg.value) revert NotEnoughEth();
    if(_tokenIdCounter.current() + 1 > maxSupply) revert NotEnoughSupply();

    _tokenIdCounter.increment();

    uint256 tokenId = _tokenIdCounter.current();
    _safeMint(to, tokenId);
    _makeTrouble(to);

    return tokenId;
  }

  function mintMultiple(address to, uint8 count) public payable returns (uint256[] memory){
    if(mintPriceInEth() * count > msg.value) revert NotEnoughEth();
    if(_tokenIdCounter.current() + count > maxSupply) revert NotEnoughSupply();

    uint256[] memory tokenIds = new uint256[](count);

    for(uint256 i = 0; i < count; i++) {
      tokenIds[i] = mint(to);
    }

    return tokenIds;
  }

  function mintAndStake(address to, uint256 communityId, string memory domain) public payable {
    stakeMisfit(mint(to), communityId, domain);
  }

  function setDomainFor(uint256 tokenId, string memory domain) public {
    if(_tokenIdCounter.current() < tokenId) revert MisfitDoesntExist();
    if(ownerOf(tokenId) != msg.sender && msg.sender != owner()) revert Unauthorized();
    if(stakedMisfits[tokenId].communityId == 0) revert MisfitNotStaked();
    stakedMisfits[tokenId].domain = domain;
  }

  function getDomainFor(uint256 tokenId) public view returns(string memory) {
    if(stakedMisfits[tokenId].communityId == 0) revert MisfitNotStaked();
    return stakedMisfits[tokenId].domain;
  }

  function boost(uint256 tokenId) public payable {
    if(stakedMisfits[tokenId].communityId == 0) revert MisfitNotStaked();
    Boost memory _boost = Boost(tokenId, msg.sender, msg.value, block.timestamp);
    boosts.push(_boost);
    emit Boosted(_boost);
  }

  function totalBoostedForToken(uint256 tokenId) public view returns(uint256) {
    
    uint256 total = 0;

    for(uint256 i = 0; i < boosts.length; i++) {
      if(boosts[i].tokenId == tokenId) {
        total += boosts[i].amount;
      }
    }

    return total;
  }

  function boostsFromAddress(address sender) public view returns(Boost[] memory) {

    uint256 y = 0;
    uint256 boostsCount = 0;

    for(uint256 i = 0; i < boosts.length; i++) {
      if(address(boosts[i].sender) == sender) {
        boostsCount++;
      }
    }

    Boost[] memory _boosts = new Boost[](boostsCount);

    for(uint256 i = 0; i < boosts.length; i++) {
      if(address(boosts[i].sender) == sender) {
        _boosts[y] = boosts[i];
        y++;
      }
    }

    return _boosts;
  }

  function boostsFromAddressForToken(address sender, uint256 tokenId) public view returns(Boost[] memory) {

    uint256 y = 0;
    uint256 boostsCount = 0;

    for(uint256 i = 0; i < boosts.length; i++) {
      if(boosts[i].sender == sender && boosts[i].tokenId == tokenId) boostsCount++;
    }

    Boost[] memory _boosts = new Boost[](boostsCount);

    for(uint256 i = 0; i < boosts.length; i++) {
      if(boosts[i].sender == sender && boosts[i].tokenId == tokenId) {
        _boosts[y] = boosts[i];
        y++;
      }
    }

    return _boosts;
  }

  function _beforeTokenTransfer(address from, address to, uint256 tokenId) internal whenNotPaused override {
    super._beforeTokenTransfer(from, to, tokenId);
  }

  function tokenURI(uint256 tokenId) override(ERC721) public view returns (string memory) {
    if(metadataContract != address(0)) {
      return ERC721(metadataContract).tokenURI(tokenId);
    } else {
      return string(abi.encodePacked(metadataBaseUrl, Strings.toString(tokenId), '/metadata.json'));
    }
  }

  receive() external payable {}

  // ONLY OWNER //

  function withdraw() public onlyOwner {
    if(withdrawContract != address(0)) {
      payable(withdrawContract).transfer(address(this).balance);
      IWithdraw(withdrawContract).withdraw(rebelAddress);
    } else {
      emit GotPaid(address(this).balance);
      payable(rebelAddress).transfer(address(this).balance);
    }
  }

  function setMintPrice(uint256 newPrice) public onlyOwner {
    daiMintPrice = newPrice;
  }

  function setMaxSupply(uint256 newSupply) public onlyOwner {
    maxSupply = newSupply;
  }

  function setRebelAddress(address newAddress) public onlyOwner {
    rebelAddress = newAddress;
  }

  function setTroubleAddress(address newAddress) public onlyOwner {
    troubleAddress = newAddress;
  }

  function setTroubleMintReward(uint256 amount) public onlyOwner {
    troubleMintReward = amount;
  }

  function setWithdrawAddress(address newAddress) public onlyOwner {
    withdrawContract = newAddress;
  }

  function setMetadataBaseUrl(string calldata newUrl) public onlyOwner {
    metadataBaseUrl = newUrl;
  }

  function setMetadataAddress(address newAddress) public onlyOwner {
    metadataContract = newAddress;
  }

  function pause() public onlyOwner {
    _pause();
  }

  function unpause() public onlyOwner {
    _unpause();
  }

  // PRIVATE //

  function _makeTrouble(address to) private {
    if(Trouble(troubleAddress).balanceOf(to) == 0) {
      Trouble(troubleAddress).makeTrouble(to, troubleMintReward);
    }
  }
}