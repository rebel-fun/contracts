// Dummy metadata contract for testing

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
pragma abicoder v2;

import "@openzeppelin/contracts/utils/Strings.sol";

contract Boosts {
  
  /// @notice Emitted when boosting
  event Boosted(Boost boost);

  struct Boost {
    uint256 tokenId;
    address sender;
    uint256 amount;
    uint256 timestamp;
  }

  Boost[] boosts;

  receive() external payable { }

  function boost(uint256 tokenId, uint256 amount) public payable {
    Boost memory _boost = Boost(tokenId, msg.sender, amount, block.timestamp);
    boosts.push(_boost);
    emit Boosted(_boost);
  }

  function getBoosts() public view returns(Boost[] memory) {
    return boosts;
  }
}