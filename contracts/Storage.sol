// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract Storage {
    struct Poll {
        bytes32 title;
        string description;
        bytes32[] options;
    }

    struct Projects {
        address walletAddress;
        bool listed;
        Poll[] polls;
    }

    //entry point variable for projects
    mapping(address => Projects) public projects;

    mapping(address => bool) hasProject;

    address owner;

    mapping(address => uint256) public rates;
    uint256 public usdCharge = 5;
    address wBnb;
}
