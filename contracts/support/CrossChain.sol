// Dummy contract for testing cross domain minting

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
pragma abicoder v2;

import "../Misfits.sol";

contract CrossChain {

  address payable misfitsAddress;
  address l1MintContractAddress;

  function mint(address to) payable public returns(uint256) {
    return Misfits(misfitsAddress).mint{value: 0}(to);
  }

  function xDomainMessageSender() public view returns(address) {
    return address(l1MintContractAddress);
  }

  function setMisfitsAddress(address newAddress) public {
    misfitsAddress = payable(newAddress);
  }

  function setL1MintContractAddress(address newAddress) public {
    l1MintContractAddress = newAddress;
  }
}