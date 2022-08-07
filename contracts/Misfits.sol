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

import "./Trouble.sol";

interface IWithdraw {
  function withdraw(address rebelTreasuryAddress) external;
}

interface IBoost {
  function boost(uint256 tokenId) external payable;
}

interface IMintSwap {
  function swap(uint256 amount) external payable;
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
  event MisfitStaked(uint256 tokenId, uint256 communityId);

  /// @notice Emitted when boosting
  event Boosted(Boost boost);

  /// @notice Emitted when withdrawing ETH
  event Withdrew(uint256 rebel);
  
  struct Stake {
    uint256 tokenId;
    uint256 communityId;
    uint256 timestamp;
  }

  struct Boost {
    uint256 tokenId;
    address sender;
    uint256 amount;
    uint256 timestamp;
  }

  Counters.Counter private _tokenIdCounter;

  Boost[] boosts;
  string  metadataBaseUrl;
  address public rebelTreasuryAddress;
  address public troubleAddress;
  address public boostsContract;
  address public withdrawContract;
  address public metadataContract;
  address public mintSwapContract;
  uint256 public ethMintPrice;
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

  function stakeMisfit(uint256 tokenId, uint256 communityId) public {
    if(_tokenIdCounter.current() < tokenId) revert MisfitDoesntExist();
    if(stakedMisfits[tokenId].tokenId != 0) revert MisfitAlreadyStaked();
    if(stakedCommunities[communityId] != 0) revert CommunityAlreadyStaked();
    if(ownerOf(tokenId) != msg.sender && msg.sender != owner()) revert Unauthorized();

    emit MisfitStaked(tokenId, communityId);
    stakedMisfits[tokenId] = Stake(tokenId, communityId, block.timestamp);
    stakedCommunities[communityId] = tokenId;
  }
  
  function unstakeMisfit(uint256 tokenId) public {
    if(_tokenIdCounter.current() < tokenId) revert MisfitDoesntExist();
    if(stakedMisfits[tokenId].tokenId == 0) revert MisfitNotStaked();
    if(ownerOf(tokenId) != msg.sender && msg.sender != owner()) revert Unauthorized();
    uint256 communityId = stakedMisfits[tokenId].communityId;

    emit MisfitStaked(tokenId, 0);

    stakedMisfits[tokenId] = Stake(0,0,0);
    stakedCommunities[communityId] = 0;
  }

  function mintPriceInEth(uint256 quantity) public view returns (uint256) {
  
    uint256 totalMintPrice;

    if(quantity >= 5) {
      // 20% discount for minting 5+
      totalMintPrice = (ethMintPrice * 8 / 10) * quantity;
    } else {
      totalMintPrice = ethMintPrice * quantity;
    }

    return totalMintPrice;
  }

  function mint(address to) public payable returns(uint256) {

    if(mintPriceInEth(1) > msg.value) revert NotEnoughEth();
    if(_tokenIdCounter.current() + 1 > maxSupply) revert NotEnoughSupply();
    _swapEth();

    return _mint(to);
  }

  function mintMultiple(address to, uint8 quantity) public payable returns (uint256[] memory){
    if(mintPriceInEth(quantity) > msg.value) revert NotEnoughEth();
    if(_tokenIdCounter.current() + quantity > maxSupply) revert NotEnoughSupply();
    _swapEth();

    uint256[] memory tokenIds = new uint256[](quantity);

    for(uint256 i = 0; i < quantity; i++) {
      tokenIds[i] = _mint(to);
    }

    return tokenIds;
  }

  function mintAndStake(address to, uint256 communityId) public payable {
    stakeMisfit(mint(to), communityId);
  }

  function boost(uint256 tokenId) public payable {
    if(stakedMisfits[tokenId].communityId == 0) revert MisfitNotStaked();

    if(boostsContract != address(0)) {
      IBoost(boostsContract).boost{value: msg.value}(tokenId);
    } else {
      Boost memory _boost = Boost(tokenId, msg.sender, msg.value, block.timestamp);
      boosts.push(_boost);
      emit Boosted(_boost);
    }
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

  function totalSupply() public view returns (uint256) {
    return maxSupply;
  }

  receive() external payable {}

  // ONLY OWNER //

  function withdraw() public onlyOwner {
    if(withdrawContract != address(0)) {
      payable(withdrawContract).transfer(address(this).balance);
      IWithdraw(withdrawContract).withdraw(rebelTreasuryAddress);
    } else {
      emit Withdrew(address(this).balance);
      payable(rebelTreasuryAddress).transfer(address(this).balance);
    }
  }

  function setMintPrice(uint256 newPrice) public onlyOwner {
    ethMintPrice = newPrice;
  }

  function setMaxSupply(uint256 newSupply) public onlyOwner {
    maxSupply = newSupply;
  }

  function setRebelTreasuryAddress(address newAddress) public onlyOwner {
    rebelTreasuryAddress = newAddress;
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

  function setMintSwapAddress(address newAddress) public onlyOwner {
    mintSwapContract = newAddress;
  }

  function setBoostsAddress(address newAddress) public onlyOwner {
    boostsContract = newAddress;
  }

  function pause() public onlyOwner {
    _pause();
  }

  function unpause() public onlyOwner {
    _unpause();
  }

  // PRIVATE //

  function _mint(address to) private returns(uint256) {

    _tokenIdCounter.increment();

    uint256 tokenId = _tokenIdCounter.current();
    _safeMint(to, tokenId);
    _makeTrouble(to);

    return tokenId;
  }

  function _swapEth() private {
    if(mintSwapContract == address(0)) return;

    payable(mintSwapContract).transfer(msg.value);
    IMintSwap(mintSwapContract).swap(msg.value);
  }

  function _makeTrouble(address to) private {
    if(Trouble(troubleAddress).balanceOf(to) == 0) {
      Trouble(troubleAddress).makeTrouble(to, troubleMintReward);
    }
  }
}