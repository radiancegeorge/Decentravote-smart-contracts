// SPDX-License-Identifier: MIT

pragma solidity ^0.8;

import "./Poll.sol";

contract DecentraVote is Polls {
    constructor() {
        owner = msg.sender;
    }

    address owner;
    modifier isOwner() {
        require(
            msg.sender == owner,
            "you are not permitted to call this function!"
        );
        _;
    }

    function setTokenRates(address _address, uint256 _value) public isOwner {
        rates[_address] = _value;
    }

    function setUsdCharge(uint256 _value) public isOwner {
        usdCharge = _value;
    }

    function setWbnb(address _address) public isOwner {
        wBnb = _address;
    }
}

contract Test {
    constructor() {
        owner = msg.sender;
    }

    string public name = "radiance";
    address public owner;
}
