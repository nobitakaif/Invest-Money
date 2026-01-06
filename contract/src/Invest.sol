

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract InvestMoney{
    string public name;
    string public description;
    uint256 public goal;
    uint256 public deadline;
    address public owner;

    struct Tier{
        string name; 
        uint256 amount;
        uint256 backers;
    }

    Tier[] public tiers;

    modifier onlyOwner(){
        require(msg.sender == owner, "only owner can call");
        _;
    }

    constructor(string memory _name, 
    string memory _description, uint256 _goal, uint256 _durationInDays){
        name = _name;
        description = _description;
        goal = _goal;
        deadline = block.timestamp + (_durationInDays *1 days);
        owner = msg.sender;
    }
    
    function fund(uint256 _tierIndex) public payable{
        
        require(block.timestamp < deadline, "market is closed"); // only allow when it is open 
        require(_tierIndex < tiers.length, "invalid tier");
        require(msg.value == tiers[_tierIndex].amount, "Incorrect amount");
        tiers[_tierIndex].backers;
    }

    function addTier(string memory _name, uint256 _amount) public onlyOwner {
        require(_amount > 0, "Amount atealt greter than 0");
        tiers.push(Tier(_name, _amount, 0));
    }

    function removeTier(uint256 _index) public onlyOwner{
        require(_index < tiers.length, "Tier does not exist" );
        tiers[_index] = tiers[tiers.length-1];
        tiers.pop();
    }

    function withdraw() public onlyOwner{
        require(address(this).balance >= goal, "Goal had not been ended" );
        uint256 balance = address(this).balance;
        require(balance > 0, "No balance to withdraw");
        payable(owner).transfer(balance); // transfering balance to the owner account  
    }

    function getContractBalance() public view{
        return address(this).balance;
    } 
}