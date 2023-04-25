// SPDX-License-Identifier: MIT

pragma solidity ^0.8;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DVT is ERC20 {
    constructor(uint256 _initialSupply) ERC20("Decentravote", "DVT") {
        _mint(msg.sender, _initialSupply * 10 ** decimals());
        owner = msg.sender;
    }

    address public owner;
}
