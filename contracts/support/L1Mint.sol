// Dummy contract for testing cross domain minting

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
pragma abicoder v2;

import "../Misfits.sol";

contract L1Mint {

  address payable crossDomainContract;

  function mint(address to) public payable returns(uint256) {
    // should collect the correct amount of ETH in this contract
    return Misfits(crossDomainContract).mint{value: 0}(to);
  }

  function setCrossDomainContractAddress(address newAddress) public {
    crossDomainContract = payable(newAddress);
  }
}