// SPDX-License-Identifier: MIT
pragma solidity ^0.8;
import "./Storage.sol";

abstract contract ProjectContract {
    address public owner;

    function name() public view virtual returns (string memory);

    function symbol() public view virtual returns (string memory);
}

contract DecentraVoteListing is Storage {
    function isClaimed(address _address) public view returns (bool) {
        bool claimed = projects[_address].walletAddress != address(0);
        return claimed;
    }

    function getProjectPolls(
        address _address
    ) public view returns (Poll[] memory) {
        return projects[_address].polls;
    }

    modifier isProjectAddressDeployer(address _projectAddress) {
        require(
            msg.sender == ProjectContract(_projectAddress).owner(),
            "contract address does not belong to this address"
        );
        _;
    }

    function claimProject(
        address _registeredAddress,
        address _projectAddress
    ) public isProjectAddressDeployer(_projectAddress) {
        require(
            !hasProject[_registeredAddress],
            "This address has already been linked to a project"
        );
        projects[_projectAddress].walletAddress = _registeredAddress;
        hasProject[_registeredAddress] = true;
        //emit an event
    }

    modifier isNotListedAndHasName(address _projectAddress) {
        require(
            !projects[_projectAddress].listed,
            "This project has already been listed"
        );
        require(
            bytes(ProjectContract(_projectAddress).name()).length != 0,
            "Contract does not have a name"
        );
        _;
    }

    function listAndClaimProject(
        address _registeredAddress,
        address _projectAddress
    ) public isProjectAddressDeployer(_projectAddress) {
        require(
            !hasProject[_registeredAddress],
            "This address has already been linked to a project"
        );
        hasProject[_registeredAddress] = true;
        // projects[_projectAddress].listed = true;
        listProject(_projectAddress);
        projects[_projectAddress].walletAddress = _registeredAddress;
    }

    function listProject(
        address _projectAddress
    ) public isNotListedAndHasName(_projectAddress) {
        projects[_projectAddress].listed = true;
    }

    function checkProjectListing(address _address) public view returns (bool) {
        return projects[_address].listed;
    }
}
