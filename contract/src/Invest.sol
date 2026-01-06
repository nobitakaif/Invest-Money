

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract InvestMoney{
    string public name;
    string public description;
    uint256 public goal;
    uint256 public deadline;
    address public owner;
    bool public paused;

    enum CampaignState{
        Active,
        Successfull, 
        Fialed
    }
    CampaignState public state;

    struct Tier{
        string name; 
        uint256 amount;
        uint256 backers;
    }

    struct Backer{
        uint256 totalCountribution;
        mapping(uint256 => bool) fundedtiers;
    }

    Tier[] public tiers;
    mapping (address=>Backer) public backers;

    modifier onlyOwner(){
        require(msg.sender == owner, "only owner can call");
        _;
    }

    modifier campaignOpen() {
        require(state == CampaignState.Active, "not open ");
        _;
    }

    modifier notPauesed() {
        require(!paused, "Contract is paused" );
        _;
    }

    constructor( address _owner, string memory _name, 
    string memory _description, uint256 _goal, uint256 _durationInDays){
        name = _name;
        description = _description;
        goal = _goal;
        deadline = block.timestamp + (_durationInDays *1 days);
        owner = _owner;
        state = CampaignState.Active;
    }

    function checkAndUpdateCampaignState() internal {
        if(state == CampaignState.Active){
            if(block.timestamp >= deadline){
                state = address(this).balance >= goal ? CampaignState.Successfull : CampaignState.Fialed;
            }
            else{
                state = address(this).balance >= goal ? CampaignState.Successfull : CampaignState.Fialed;
            }
        }
    }
    
    function fund(uint256 _tierIndex) public payable campaignOpen notPauesed
    {
        require(_tierIndex < tiers.length, "invalid tier");
        require(msg.value == tiers[_tierIndex].amount, "Incorrect amount");
        tiers[_tierIndex].backers;
        backers[msg.sender].totalCountribution += msg.value;
        backers[msg.sender].fundedtiers[_tierIndex] = true;
        checkAndUpdateCampaignState();
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
        checkAndUpdateCampaignState();
        require(state == CampaignState.Successfull, "Campaign not succeffully yet");
        uint256 balance = address(this).balance;
        require(balance > 0, "No balance to withdraw");
        payable(owner).transfer(balance); // transfering balance to the owner account  
    }

    function getContractBalance() public view returns (uint256){
        return address(this).balance;
    } 

    function refund() public{
        checkAndUpdateCampaignState();
        require(state == CampaignState.Fialed, "Refund not available");
        uint256 amount = backers[msg.sender].totalCountribution;
        require(amount > 0, "not contributions");
        backers[msg.sender].totalCountribution = 0;
        payable(msg.sender).transfer(amount);

    }

    function hasFundedTier(address _backer, uint256 _tierIndex) public view returns (bool){
        return backers[_backer].fundedtiers[_tierIndex];
    } 

    function getTiers() public view returns(Tier[] memory){
        return tiers;
    }

    function togglePause() public onlyOwner{
        paused = !paused;
    }

    function getCampaignStatus() public view returns(CampaignState){
        if(state == CampaignState.Active && block.timestamp > deadline){
            return address(this).balance >= goal ? CampaignState.Successfull : CampaignState.Fialed;
        }
        return state;
    }

    function extendDeadline(uint256 _daysToAdd) public  onlyOwner{
        deadline += _daysToAdd *1 days;
    }
}