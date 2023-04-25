// SPDX-License-Identifier: MIT

pragma solidity ^0.8;

import "./DecentraVoteListing.sol";

abstract contract PaymentToken {
    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public virtual returns (bool success);

    function decimals() public view virtual returns (uint8);
}

contract Polls is DecentraVoteListing {
    //create poll
    mapping(address => uint256) public charges;
    uint256 public bnbCharge;

    function createPoll(
        address _address,
        bytes32 _title,
        string memory _description,
        bytes32[] memory _options,
        address _projectAddress
    ) public payable {
        require(
            (_address != address(0) && charges[_address] != 0) ||
                msg.value == bnbCharge,
            "Provide fees before creating polls"
        );
        PaymentToken token = PaymentToken(_address);
        require(
            token.transferFrom(msg.sender, address(this), charges[_address]),
            "Error Paying fees"
        );
        //create poll
        Poll memory newPoll;
        newPoll.options = _options;
        newPoll.description = _description;
        newPoll.title = _title;

        //save poll
        projects[_projectAddress].polls.push(newPoll);
    }
}
