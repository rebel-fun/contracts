// MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
// MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
// MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMW0lcccccoKMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM0lcccccoKMMMMMMM
// MMMMMMMMMMMWXK0KKKKKKKKKKKXNWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNXl      '0MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWl      '0MMMMMMM
// MMMMMMMMMMMO,..............';lkXMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMKx,      cNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMK,      cNMMMMMMM
// MMMMMMMMMMWo                   ,kWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMk:.     .dWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMk.     .xWMMMMMMM
// MMMMMMMMMMX:       ...          .OMMMMMMMMMMMMMMMMMMMMMMMMMMMMWo.      '0MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWl      '0MMMMMMMM
// MMMMMMMMMMO.      .xKKOd,        oWMMMMMMMMMMMMMMMMMMMMMMMMMMMX;       :XMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMK;      :NMMMMMMMM
// MMMMMMMMMWd.      :XMMMMk.      .dWMMMMMMWX0kdolllodOXWMMMMMMMO.      .dNKkdolloxOXWMMMMMMMMMMMWXOxdollooxOXWMMMMMMMk.     .dWMMMMMMMM
// MMMMMMMMMN:       oWMMMXc       ,KMMMMWKd:..         .;xXMMMMWo       .;;.        .c0WMMMMMMWOo,.          .:kNMMMMWo      .OMMMMMMMMM
// MMMMMMMMM0'      .lOkdl'       'OWMMW0c.      ....      ;0MMMX:                     .dNMMMWO:.      ...      .lXMMMX;      :XMMMMMMMMM
// MMMMMMMMMx.                  .cKMMMWk.     .lOKXX0o.     :XMMO.         .';,'.       .xWMNo.     'oOXXXOc.     oWMMO.      oWMMMMMMMMM
// MMMMMMMMNc               .':dKWMMMWk.      ,loooool.     .OMWd        ,xKNWWNO;       :NNo.      ;ooooooc.     ,KMWd      .OMMMMMMMMMM
// MMMMMMMM0'      ..       'OWMMMMMMK;                     .OMX:       ;KMMMMMMMk.      :XO.                     ,KMX:      ;XMMMMMMMMMM
// MMMMMMMMx.      ;k:       'OWMMMMMk.      ';;;;;;;;;;;;;;oXM0'       dWMMMMMMWo.      oNo      .,;;;;;;;;;;;;;;dNMO'      oWMMMMMMMMMM
// MMMMMMMNc       lWK;       .xNMMMMk.     .xWWWWWWNXXXXXXXWMWd.       ,OWMMMN0l.      ;KWo      '0WWWWWWNXXXXXXNWMWd.     .kMMMMMMMMMMM
// MMMMMMMK,      .kMMK;       .lXMMMK;      'd0KK0x:.....'dNMNc         .,:c:,.       :KMMO.      ;k0KKOo,.....;OWMNc      ;KMMMMMMMMMMM
// MMMMMMMk.      ,KMMM0;        :KMMWO,       ....      .oXMM0'                     .dXMMMWx.       ...       ,kNMM0'      lWMMMMMMMMMMM
// MMMMMMWl       lNMMMM0,        ;0WMMXd,.           .;dKWMMMx.      .;'         .;dXWMMMMMW0l'.           .:kXMMMMx.     .kMMMMMMMMMMMM
// MMMMMMW0xxxxxxkXMMMMMMKkxxxxxxxkKWMMMMNKkolc::ccldOXWMMMMMMKkxxxxxxONXOoc::cldkKWMMMMMMMMMMMN0xocc::clox0XWMMMMMMKkxxxxxONMMMMMMMMMMMM
// MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
// MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
// MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM

// by @mboyle for Rebel (https://rebel.fun)

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Snapshot.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";

contract Rebel is ERC20, ERC20Snapshot, Ownable, Pausable, ERC20Permit, ERC20Votes {
  constructor() ERC20("Rebel", "REBEL") ERC20Permit("Rebel") {}

  function snapshot() public onlyOwner {
    _snapshot();
  }

  function pause() public onlyOwner {
    _pause();
  }

  function unpause() public onlyOwner {
    _unpause();
  }

  function mint(address to, uint256 amount) public onlyOwner {
    _mint(to, amount);
  }

  function _beforeTokenTransfer(address from, address to, uint256 amount)
    internal
    whenNotPaused
    override(ERC20, ERC20Snapshot)
  {
    super._beforeTokenTransfer(from, to, amount);
  }

  // The following functions are overrides required by Solidity.

  function _afterTokenTransfer(address from, address to, uint256 amount)
    internal
    override(ERC20, ERC20Votes)
  {
    super._afterTokenTransfer(from, to, amount);
  }

  function _mint(address to, uint256 amount)
    internal
    override(ERC20, ERC20Votes)
  {
    super._mint(to, amount);
  }

  function _burn(address account, uint256 amount)
    internal
    override(ERC20, ERC20Votes)
  {
    super._burn(account, amount);
  }
}