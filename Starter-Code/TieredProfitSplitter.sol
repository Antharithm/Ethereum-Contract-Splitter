pragma solidity ^0.5.0;

// lvl 2: tiered split
contract TieredProfitSplitter {
    address payable employee_one; // CEO
    address payable employee_two; // CTO
    address payable employee_three; // Bob

    constructor(address payable _one, address payable _two, address payable _three) public {
        employee_one = _one;
        employee_two = _two;
        employee_three = _three;
    }

    // Should always return 0! Use this to test your `deposit` function's logic
    function balance() public view returns(uint) {
        return address(this).balance;
    }

    function deposit() public payable {
        uint points = msg.value / 100; // Calculates rudimentary percentage by dividing msg.value into 100 units
        uint total;
        uint amount;

        // @TODO: Calculate and transfer the distribution percentage for the CEO
        // Step 1: Set amount to equal `points` * the number of percentage points for this employee
        amount = points * 60;
        
        // Step 2: Add the `amount` to `total` to keep a running total
        total += amount;
        
        // Step 3: Transfer the `amount` to the CEO
        employee_one.transfer(amount);
          

        // @TODO: Repeat the previous steps for `employee_two` and `employee_three`
        // Your code here!
        amount = points * 25;
        
        total += amount;
        
        // transfer the 'amount' to the CTO
        employee_two.transfer(amount);
        
        //////////////////////
        
        amount = points * 15;
        
        total += amount;
        
        // transfer the 'amount' to Bob
        employee_three.transfer(amount);
        
        
        // Send the remaining wei back to the CEO
        employee_one.transfer(msg.value - total); // ceo gets the remaining wei back
    }

    function() external payable {
        deposit();
    }
}