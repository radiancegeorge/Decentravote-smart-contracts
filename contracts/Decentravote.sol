// SPDX-License-Identifier: MIT

pragma solidity ^0.8;

import "./Poll.sol";

contract DecentraVote is Polls {
    constructor() {
        owner = msg.sender;
    }

    address owner;

    function addTokenCharges(address _address, uint256 _charge) public {
        require(
            msg.sender == owner,
            "you are not permitted to call this function!"
        );
        charges[_address] = _charge * 10 ** PaymentToken(_address).decimals();
    }

    function setBnbCharge(uint256 _charge) public {
        require(
            msg.sender == owner,
            "you are not permitted to call this function!"
        );
        bnbCharge = _charge * 10 ** 18;
    }
}

contract Test {
    constructor() {
        owner = msg.sender;
    }

    string public name = "radiance";
    address public owner;
}
