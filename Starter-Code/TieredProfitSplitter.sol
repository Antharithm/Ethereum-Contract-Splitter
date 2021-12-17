// SPDX-License-Identifier: MIT
pragma solidity ^0.5.0;

// Tiered profit splitting contract

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
    
        uint points = msg.value / 100; // Calculates rudimentary percentage by dividing msg.value into 100 units
        uint total;
        uint amount;

        // Calculate and transfer the distribution percentage for the CEO
        // Step 1: Set amount to equal `points` * the number of percentage points for this employee
        
        // CEO
        amount = points * 60;
        
        // Step 2: Add the `amount` to `total` to keep a running total
        total += amount;
        
        // Step 3: Transfer the `amount` to the CEO
        employee_one.transfer(amount);
          

        // Repeat the previous steps for `employee_two` and `employee_three`
        
        // CTO
        amount = points * 25; 
        
        total += amount;
        
        // transfer the 'amount' to the CTO
        employee_two.transfer(amount);
        
        // Bob

        amount = points * 15;
        
        total += amount;
        
        // transfer the 'amount' to Bob
        employee_three.transfer(amount);
        
        // Send the remaining wei back to the CEO
        employee_one.transfer(msg.value - total); // CEO gets back any remaining wei
    }
    
    function() external payable {
        deposit();
    }
}
