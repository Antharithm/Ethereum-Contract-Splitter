// SPDX-License-Identifier: MIT
pragma solidity ^0.5.0;

contract DeferredEquityPlan {

    address human_resources;
    
    // replace fakeNow with all 'now' to fast fast forward time during testing
    // uint fakeNow = now;
    // function fastForward() public {
    //    fakeNow += 100 days;
    //}

    address payable employee; // Bob
    bool active = true; // This employee is active at the start of the contract

    // Total shares, distribution rate and unlock times
    uint total_shares = 1000;
    
    uint annual_distribution = 250;

    uint start_time = now;

    uint unlock_time = now + 365 days;
    
    uint public distributed_shares;

    constructor(address payable _employee) public {
        human_resources = msg.sender;
        employee = _employee;
    }

    function distribute() public {
    
        require(msg.sender == human_resources || msg.sender == employee, "You are not authorized to execute this contract.");
        require(active == true, "Contract is not active.");
        require(unlock_time <= now, "Shares not yet vested");
        require(distributed_shares <= total_shares, "Shares already distributed for this year!");

        unlock_time = unlock_time + 365 days;

        distributed_shares = ((now - start_time) / 365 days) * annual_distribution;

        if (distributed_shares > 1000) {
            distributed_shares = 1000;
        }
    }

    // human_resources and the employee can deactivate this contract
    
    function deactivate() public {
        require(msg.sender == human_resources || msg.sender == employee, "You are not authorized to deactivate this contract.");
        active = false;
    }

    // Contract does not handle Ether, revert.

    function() external payable {
        revert("Do not send Ether to this contract!");
    }
}
