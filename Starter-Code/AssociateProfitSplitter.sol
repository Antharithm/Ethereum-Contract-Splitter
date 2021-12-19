// SPDX-License-Identifier: MIT
pragma solidity ^0.5.0;

contract AssociateProfitSplitter {
    // Three payable addresses representing `employee_one`, `employee_two` and `employee_three`.
    
    address payable employee_one;
    address payable employee_two;
    address payable employee_three;
    
    constructor(address payable _one, address payable _two, address payable _three) public {
        employee_one = _one;
        employee_two = _two;
        employee_three = _three;
    }
    
    function balance() public view returns(uint) {
        return address(this).balance;
        
    }
    
    function deposit() public payable {
    
        // Split `msg.value` into three
        uint amount = msg.value / 3; 

        // Transfer the amount to each employee
        
        employee_one.transfer(amount);
        employee_two.transfer(amount); 
        employee_three.transfer(amount);

        // Send back any remaining ETH to the HR account (`msg.sender`)
        
        msg.sender.transfer(msg.value - (amount * 3));
        
    }

    function() external payable {
        // Enforce that the `deposit` function is called in the fallback function.
        // This will ensure that the logic in deposit executes if ETH is sent directly to the AssociateProfitSplitter address.
        // This is important to prevent ETH from being locked in the contract since we don't have a withdraw function for this use-case.
        deposit();
    }
}
