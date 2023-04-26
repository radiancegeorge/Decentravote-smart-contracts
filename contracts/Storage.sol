// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

abstract contract PaymentToken {
    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public virtual returns (bool success);

    function decimals() public view virtual returns (uint8);
}

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

    mapping(address => uint256) public rates; // just contains the current dollar equivalent of supported tokens
    uint256 public usdCharge;
    address wBnb;
}
