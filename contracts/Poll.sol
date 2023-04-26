// SPDX-License-Identifier: MIT

pragma solidity ^0.8;

import "./DecentraVoteListing.sol";

contract Polls is DecentraVoteListing {
    //create poll

    //generating token equivalent to dollar
    function calculateTokenFee(
        uint256 _tokenRate
    ) private view returns (uint256) {
        require(_tokenRate > 0, "The rate cannot be less than 0");
        uint fee = ((1 * 10 ** 18) / _tokenRate) * usdCharge;
        return fee;
    }

    // creating polls
    function createPoll(
        address _address,
        bytes32 _title,
        string memory _description,
        bytes32[] memory _options,
        address _projectAddress
    ) public payable {
        //attempts to collect some fees
        require(
            PaymentToken(_address).transferFrom(
                msg.sender,
                address(this),
                calculateTokenFee(rates[_address])
            ) || msg.value >= calculateTokenFee(rates[wBnb]),
            "Provide fees before creating polls"
        );

        //create poll if fees settled!
        Poll memory newPoll;
        newPoll.options = _options;
        newPoll.description = _description;
        newPoll.title = _title;

        //save poll
        projects[_projectAddress].polls.push(newPoll);
    }
}
