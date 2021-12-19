// SPDX-License-Identifier: MIT
pragma solidity ^0.5.0;

contract TieredProfitSplitter {

    address payable employee_one; // CEO
    address payable employee_two; // CTO
    address payable employee_three; // Bob

    constructor(address payable _one, address payable _two, address payable _three) public {
    
        employee_one = _one;
        employee_two = _two;
        employee_three = _three;
    }

    // This function should return a value of "0" because all ETH should be sent back to the CEO once profits have been split.
    
    function balance() public view returns(uint) {
        return address(this).balance;
    }

    // Deposit profits and track the split

    function deposit() public payable {
    
        uint points = msg.value / 100;
        uint total;
        uint amount;

        // CEO
        amount = points * 60;
        
        total += amount;
        
        employee_one.transfer(amount);
        
        // CTO
        amount = points * 25; 
        
        total += amount;
        
        employee_two.transfer(amount);
        
        // Bob
        amount = points * 15;
        
        total += amount;
        
        employee_three.transfer(amount);
        
        // Remaining wei goes back to the CEO
        employee_one.transfer(msg.value - total); // CEO gets back any remaining wei
    }
    
    function() external payable {
        deposit();
    }
}
