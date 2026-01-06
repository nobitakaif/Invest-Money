// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { InvestMoney } from "./invest.sol";

contract AllFunded{ 
    address public owner;
    bool public paused;

    struct Campaign{
        address campaingAddress;
        address owner;
        string name;
        uint256 creationTime;
    }

    Campaign[] public campaigns;
    mapping(address => Campaign[]) public userCampaigns;

    modifier onlyOwner(){
        require(!paused, "Factory is puased");
        _;
    }
    modifier notPauesed(){
        require(!paused, "Factory is paused");
        _;
    }
    constructor (){
        owner = msg.sender;
    }

    function createCampaign(string memory _name, string memory _description, uint256 _goal, uint256 _durationInDays) external notPauesed{
        InvestMoney newInvest = new InvestMoney(
            msg.sender,
            _name,
            _description,
            _goal,
            _durationInDays
        );
        address campaignAddress = address(newInvest);
        
        Campaign memory campaign = Campaign({
            campaingAddress : campaignAddress,
            owner : msg.sender,
            name : _name,
            creationTime : block.timestamp
        });
        
        campaigns.push(campaign);
        userCampaigns[msg.sender].push(campaign);
    }

    function getUserCampaigns(address _user) external view returns(Campaign[] memory){
        return userCampaigns[_user];
    }

    function getAllCampaings()external view returns(Campaign[] memory){
        return campaigns;
    }
    
    function togglePuase() external onlyOwner{ 
        paused = !paused;
    }

}