// Mint swap demo that converts ETH to OP
// in the future we want to convert this to REBEL

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
pragma abicoder v2;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import '@uniswap/v3-periphery/contracts/libraries/TransferHelper.sol';
import '@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol';
import "@openzeppelin/contracts/access/Ownable.sol";

import "hardhat/console.sol";

interface WethLike {
  function deposit() external payable;
  function withdraw(uint256) external;
}

contract MintSwap is Ownable {

  address constant WETH  = 0x4200000000000000000000000000000000000006;
  address constant REBEL = 0x328345ab56a490383B515c17ea6788bAB205BCA4;
  address constant OP    = 0x4200000000000000000000000000000000000042;
  address constant SWAP  = 0xE592427A0AEce92De3Edee1F18E0157C05861564;

  address public rebelTreasuryAddress;

  ISwapRouter private swapRouter;
  // uint24 public poolFee = 3000;
  uint24 public poolFee = 10000;
  
  receive() external payable { }

  function swap(uint256 amount) public {

    WethLike weth = WethLike(WETH);
    swapRouter = ISwapRouter(SWAP);
    uint256 rebelTotal;

    // console.log("OP balance treasury 1: ", ERC20(OP).balanceOf(address(rebelTreasuryAddress)));

    // Convert sent ETH into WETH to swaps
    weth.deposit{value: amount}();

    // console.log("Weth balance this: ", ERC20(WETH).balanceOf(address(this)));

    // Swap to REBEL
    TransferHelper.safeApprove(WETH, address(swapRouter), amount);

    ISwapRouter.ExactInputSingleParams memory params =
      ISwapRouter.ExactInputSingleParams({
        tokenIn: WETH,
        tokenOut: OP,
        fee: poolFee,
        recipient: address(this),
        deadline: block.timestamp,
        amountIn: amount,
        amountOutMinimum: 0,
        sqrtPriceLimitX96: 0
      });

    rebelTotal = swapRouter.exactInputSingle(params);
    
    // console.log("OP total swapped: ", rebelTotal);
    // console.log("OP balance this: ", ERC20(OP).balanceOf(address(this)));
    // console.log("OP balance treasury 2: ", ERC20(OP).balanceOf(address(rebelTreasuryAddress)));

    ERC20(OP).transfer(rebelTreasuryAddress, ERC20(OP).balanceOf(address(this)));

    // console.log("OP balance treasury 3: ", ERC20(OP).balanceOf(address(rebelTreasuryAddress)));
  }

  function setRebelTreasuryAddress(address newAddress) public onlyOwner {
    rebelTreasuryAddress = newAddress;
  }
}