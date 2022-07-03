// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
pragma abicoder v2;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import '@uniswap/v3-periphery/contracts/libraries/TransferHelper.sol';
import '@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol';

interface WethLike {
  function deposit() external payable;
  function withdraw(uint256) external;
}

contract Withdraw {

  /// @notice Emitted when swapping ETH to other stuff
  event GotPaid(uint256 eth, uint256 dai, uint256 op);

  address constant DAI  = 0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1;
  address constant WETH = 0x4200000000000000000000000000000000000006;
  address constant OP   = 0x4200000000000000000000000000000000000042;
  address constant SWAP = 0xE592427A0AEce92De3Edee1F18E0157C05861564;

  ISwapRouter private swapRouter;
  uint24 public poolFee = 3000;

  receive() external payable { }

  function withdraw(address rebelAddress) public {

    // Transfers balance to:
    //   50% - DAI
    //   25% - OP
    //   25% - ETH 

    swapEth(rebelAddress);
    payable(rebelAddress).transfer(address(this).balance);

    TransferHelper.safeApprove(DAI, rebelAddress, ERC20(DAI).balanceOf(address(this)));
    TransferHelper.safeApprove(OP, rebelAddress, ERC20(OP).balanceOf(address(this)));
    TransferHelper.safeApprove(WETH, rebelAddress, ERC20(WETH).balanceOf(address(this)));

    ERC20(DAI).transferFrom(address(this), rebelAddress, ERC20(DAI).balanceOf(address(this)));
    ERC20(OP).transferFrom(address(this), rebelAddress, ERC20(OP).balanceOf(address(this)));
    ERC20(WETH).transferFrom(address(this), rebelAddress, ERC20(WETH).balanceOf(address(this)));
  }

  // PRIVATE //

  function swapEth(address rebelAddress) private {

    WethLike weth = WethLike(WETH);
    swapRouter = ISwapRouter(SWAP);
    
    uint256 balance = address(this).balance;
    uint256 ethTotal = balance;
    uint256 daiTotal;
    uint256 opTotal;

    // Convert sent ETH into WETH for swaps
    weth.deposit{value: (balance / 4) * 3}();

    // Swap to DAI
    TransferHelper.safeApprove(WETH, address(swapRouter), balance);
    ethTotal -= balance / 2;

    ISwapRouter.ExactInputSingleParams memory params =
      ISwapRouter.ExactInputSingleParams({
        tokenIn: WETH,
        tokenOut: DAI,
        fee: poolFee,
        recipient: rebelAddress,
        deadline: block.timestamp,
        amountIn: balance / 2,
        amountOutMinimum: 0, // This should probably be set using a DAI oracle
        sqrtPriceLimitX96: 0
      });

    daiTotal = swapRouter.exactInputSingle(params);

    // Swap to OP
    ethTotal -= balance / 4;

    params = ISwapRouter.ExactInputSingleParams({
      tokenIn: WETH,
      tokenOut: OP,
      fee: poolFee,
      recipient: rebelAddress,
      deadline: block.timestamp,
      amountIn: balance / 4,
      amountOutMinimum: 0,  // This should probably be set using an OP oracle
      sqrtPriceLimitX96: 0
    });

    opTotal = swapRouter.exactInputSingle(params);

    emit GotPaid(ethTotal, daiTotal, opTotal);
  }
}