pragma solidity ^0.5.0;

// lvl 1: equal split
contract AssociateProfitSplitter {
    // @TODO: Create three payable addresses representing `employee_one`, `employee_two` and `employee_three`.
    
    address payable employee_one;
    address payable employee_two;
    address payable employee_three;

    // create a constructor funtion that accepts the addresses.
    constructor(address payable _one, address payable _two, address payable _three) public {
        employee_one = _one;
        employee_two = _two;
        employee_three = _three;
    }
    // Since we are only sending ETH to the employees, this contract should not have ETH stored in it and the function should always return "0" as a value.
    function balance() public view returns(uint) {
        return address(this).balance;
    }
    
    function deposit() public payable {
        // @TODO: Split `msg.value` into three
        
        uint amount = msg.value / 3; 

        // @TODO: Transfer the amount to each employee
        
        employee_one.transfer(amount);
        employee_two.transfer(amount); 
        employee_three.transfer(amount);

        // @TODO: take care of a potential remainder by sending back to HR (`msg.sender`)
        
        msg.sender.transfer(msg.value - (amount * 3));
    }

    function() external payable {
        // @TODO: Enforce that the `deposit` function is called in the fallback function!
        
        // This will ensure that the logic in deposit executes if ETH is sent directly to the contract. 
        // This is important to prevent ETH from being locked in the contract since we don't have a 
        // withdraw function in this use-case.
        
        deposit();
    }
}
