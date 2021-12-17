// SPDX-License-Identifier: MIT
pragma solidity ^0.5.0;

// Stock Equity Plan

contract DeferredEquityPlan {

    address human_resources;
    
    // replace fakeNow with all 'now' to fast fast forward time during testing
    // uint fakeNow = now;
    
    // function fastForward() public {
    //    fakeNow += 100 days;
    //}

    address payable employee; // Bob
    bool active = true; // This employee is active at the start of the contract

    // Set the total shares and annual distribution rate
    uint total_shares = 1000;
    
    // Annual distribution rate (amount of shares)
    uint annual_distribution = 250;

    uint start_time = now; // permanently stores the time that this contract was initialized

    // Set the `unlock_time` to be 365 days from contract initialization
    uint unlock_time = now + 365 days;
    
    // Track how many vested shares the employee has clamied - they start with 0
    uint public distributed_shares;

    constructor(address payable _employee) public {
        human_resources = msg.sender;
        employee = _employee;
    }

    function distribute() public {
    
        require(msg.sender == human_resources || msg.sender == employee, "You are not authorized to execute this contract.");
        require(active == true, "Contract is not active.");

        // Added "require" statements to enforce the following:
        // 1: `unlock_time` is less than or equal to `now`
        // 2: `distributed_shares` is less than the `total_shares`
        
        require(unlock_time <= now, "Shares not yet vested");
        require(distributed_shares <= total_shares, "Shares already distributed for this year!");

        // Add 365 days to the `unlock_time`
        unlock_time = unlock_time + 365 days;

        // Calculate the shares distributed by using the function (now - start_time) / 365 days * the annual distribution amount.        
        distributed_shares = ((now - start_time) / 365 days) * annual_distribution;

        // Make sure the employee can not cash out until after 5+ years.
        if (distributed_shares > 1000) {
            distributed_shares = 1000;
        }
    }

    // human_resources and the employee can deactivate this contract at will
    
    function deactivate() public {
        require(msg.sender == human_resources || msg.sender == employee, "You are not authorized to deactivate this contract.");
        active = false;
    }

    // Since we are not handling Ether in this contract, revert any ETH sent to this contract.
    
    function() external payable {
        revert("Do not send Ether to this contract!");
    }
}
