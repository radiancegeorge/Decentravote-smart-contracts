// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract Test {
    constructor() {
        owner = msg.sender;
    }

    string public name = "test";
    address owner;
}
