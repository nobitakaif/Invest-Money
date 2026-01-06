// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { InvestMoney } from "./invest.sol";

contract AllFunded is InvestMoney{ 
    address public owner;
    bool public paused;

    struct Campaign{
        address campaingAddress;
        address owner;
        string name;
        uint256 creationTime;
    }

    Campaign[] public campaigns;
    mapping(address => Campaign[]) public userCampaings;

    modifier onlyOwner(){
        require(!paused, "Factory is puased");
        _;
    }
    constructor (){
        owner = msg.sender;
    }

    function createCampaign(string memory _name, string memory _description, uint256 _goal, uint256 _durationInDays) external notPaused{
        InvestMoney newInvest = new InvestMoney(
            msg.sender,
            _name,
            _descriptin,
            _goal,
            _durationInDays
        );
        address campaignAddress = address(newInvest);
        
        Campaing memory campaign = Campaign({
            campainAddress : campaignAddress,
            owner : msg.sender,
            name : _name,
            creationTime : block.timestamp
        });
        
        campaings.push(campaign);
        userCampaigns[msg.sender].push(campaign);
    }

}