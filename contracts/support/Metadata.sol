// Dummy metadata contract for testing

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
pragma abicoder v2;

import "@openzeppelin/contracts/utils/Strings.sol";

contract Metadata {
  function tokenURI(uint256 tokenId) public pure returns (string memory) {
    return string(abi.encodePacked("data://ALT-METADATA/", Strings.toString(tokenId), '/metadata.json'));
  }
}