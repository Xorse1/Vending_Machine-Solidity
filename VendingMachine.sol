// SPDX-License-Identifier: MIT
pragma solidity >= 0.6.0 <0.9.0;

contract VendingMachine {
    address public owner;
    mapping (address => uint256) public DonutBalance;
    

    constructor() public{
        owner = msg.sender;
        DonutBalance[address(this)] = 220;
    }

    modifier onlyOwner {
       require(msg.sender == owner, "Only the owner can restock vending machine");
       _;
   }

    function getVendingMachineBalance() public view returns(uint256){
        return DonutBalance[address(this)];
    }

    function restock(uint amount) public onlyOwner {
        DonutBalance[address(this)] += amount;
    }

    function purchase(uint amount) payable public {
        require(msg.value >= amount * 2 ether, "You must pay at least 2 ether per donut");
        require(DonutBalance[address(this)] >= amount, "Not enough donuts in stock to fulfile to purchase request");
        DonutBalance[address(this)] -= amount;
        DonutBalance[msg.sender] += amount;
    }


}
