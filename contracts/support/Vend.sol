// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
pragma abicoder v2;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "../Trouble.sol";
import "../Rebel.sol";

import "hardhat/console.sol";

interface IWithdraw {
  function withdraw(address rebelAddress) external;
}

contract Vend is Ownable {

  /// @notice Thrown when trying to mint with less than mint price in ETH
  error NotEnoughEth();

  /// @notice Thrown when trying to mint more than there is supply for
  error NotEnoughSupply();

  /// @notice Emitted when someone purchases REBEL
  event PurchasedRebel(address investor, uint256 amount);

  address withdrawContract;
  address rebelTokenAddress;
  address rebelTreasuryAddress;
  address troubleTokenAddress;
  uint256 valuation;

  address constant ETH_USD_ORACLE = 0x13e3Ee699D1909E989722E753853AE30b17e08c5;

  AggregatorV3Interface internal priceFeed = AggregatorV3Interface(ETH_USD_ORACLE);

  receive() external payable { }

  function purchase(address to, uint256 amount) public payable {
    if(usdPriceInEth(amount) > msg.value) revert NotEnoughEth();
    if(rebelTotalForUsd(amount) > Rebel(rebelTokenAddress).balanceOf(address(this))) revert NotEnoughSupply();

    Rebel(rebelTokenAddress).transfer(address(msg.sender), rebelTotalForUsd(amount));

    emit PurchasedRebel(to, amount);
    _makeTrouble(to, amount);
  }

  function rebelTotalForUsd(uint256 amount) public view returns (uint256) {
    uint256 rebelSupply = ERC20(rebelTokenAddress).totalSupply();
    uint256 rebelToUSD = rebelSupply / valuation; // eg 1B / 20MM = 50
    uint256 rebelTotal = rebelToUSD * amount;

    return rebelTotal;
  }

  function usdPriceInEth(uint256 amount) public view returns (uint256) {
  
    uint256 minRequiredUSD;
    uint256 etherPriceUSD;

    (,int price,,,) = priceFeed.latestRoundData();

    minRequiredUSD = amount * 10**18;
    etherPriceUSD = (uint256(price) / 10**8) * 10**18;

    return (minRequiredUSD * 10**18) / etherPriceUSD;
  }

  function _makeTrouble(address to, uint256 amount) private {

    uint256 troubleMade;
    uint24 decimals = Trouble(troubleTokenAddress).decimals();

    if(amount < 500) {
      return;
    } else if(amount <= 1000) {
      troubleMade = 100;
    } else if(amount <= 10000) {
      troubleMade = 500;
    } else if(amount <= 25000) {
      troubleMade = 500;
    } else {
      troubleMade = 1000;
    }

    if(Trouble(troubleTokenAddress).balanceOf(to) < 1000 ** decimals)
    Trouble(troubleTokenAddress).makeTrouble(to, troubleMade * 10 ** decimals);
  }

  function setValuation(uint256 _valuation) public onlyOwner {
    valuation = _valuation;
  }

  function setRebelTokenAddress(address _address) public onlyOwner {
    rebelTokenAddress = _address;
  }

  function setTroubleTokenAddress(address _address) public onlyOwner {
    troubleTokenAddress = _address;
  }

  function setWithdrawAddress(address _address) public onlyOwner {
    withdrawContract = _address;
  }

  function withdraw() public onlyOwner {
    if(withdrawContract != address(0)) {
      payable(withdrawContract).transfer(address(this).balance);
      IWithdraw(withdrawContract).withdraw(rebelTreasuryAddress);
    } else {
      // emit PurchasedRebel(address(this).balance);
      payable(rebelTreasuryAddress).transfer(address(this).balance);
    }
  }
}