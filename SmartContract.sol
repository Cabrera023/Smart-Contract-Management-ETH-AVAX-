// SPDX-Lincense-Identifier: MIT
pragma solidity 0.8.7;

contract VendingMachine {
    // Declare state variables of the contract
    address public owner;
    mapping(address => uint256) public milkteaBalances;

    constructor() {
        owner = msg.sender;
        milkteaBalances[address(this)] = 100;
    }

    // Allow the owner to increase the smart contract's milktea balance
    function refill(uint amount) public {
        require(msg.sender == owner, "Only the owner can refill.");
        milkteaBalances[address(this)] += amount;
    }

    // Allow anyone to purchase milktea
    function purchase(uint256 amount) public payable {
        require(msg.value >= amount * 1 ether, "Insufficient ether sent. You must pay atleast 1 ETH per milktea");
        require(milkteaBalances[address(this)] >= amount, "Not enough milktea in stock to complete this purchase");    
        milkteaBalances[address(this)] -= amount;
        milkteaBalances[msg.sender] += amount;

        // Refund any excess ether sent
        if (msg.value > amount * 1 ether) {
            payable(msg.sender).transfer(msg.value - amount * 1 ether);
        }
    }
}



      
