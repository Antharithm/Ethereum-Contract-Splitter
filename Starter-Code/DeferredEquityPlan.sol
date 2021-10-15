pragma solidity ^0.5.0;

// lvl 3: equity plan
contract DeferredEquityPlan {
    address human_resources;
    
    // replace fakeNow with all 'now' to fast fast forward time during testing
    // uint fakeNow = now;
    
    // function fastForward() public {
    //    fakeNow += 100 days;
    //}

    address payable employee; // bob
    bool active = true; // this employee is active at the start of the contract

    // @TODO: Set the total shares and annual distribution
    // Your code here!
    uint total_shares = 1000;
    
    // set annual distribution share amount
    uint annual_distribution = 250;

    uint start_time = now; // permanently store the time this contract was initialized

    // @TODO: Set the `unlock_time` to be 365 days from now
    // Your code here!
    uint unlock_time = now + 365 days;
    
    // track how many vested shares the employee has clamied - it starts at 0
    uint public distributed_shares;

    constructor(address payable _employee) public {
        human_resources = msg.sender;
        employee = _employee;
    }

    function distribute() public {
        require(msg.sender == human_resources || msg.sender == employee, "You are not authorized to execute this contract.");
        require(active == true, "Contract is not active.");

        // @TODO: Add "require" statements to enforce that:
        // 1: `unlock_time` is less than or equal to `now`
        // 2: `distributed_shares` is less than the `total_shares`
        // Your code here!
        require(unlock_time <= now, "Shares not yet vested");
        require(distributed_shares <= total_shares, "Shares already distributed for this year");

        // @TODO: Add 365 days to the `unlock_time`
        // Your code here!
        unlock_time = now + 365 days;

        // @TODO: Calculate the shares distributed by using the function (now - start_time) / 365 days * the annual distribution
        // Make sure to include the parenthesis around (now - start_time) to get accurate results!
        // Your code here!
        distributed_shares = (now - start_time) / 365 * annual_distribution;

        // double check in case the employee does not cash out until after 5+ years
        if (distributed_shares > 1000) {
            distributed_shares = 1000;
        }
    }

    // human_resources and the employee can deactivate this contract at-will
    function deactivate() public {
        require(msg.sender == human_resources || msg.sender == employee, "You are not authorized to deactivate this contract.");
        active = false;
    }

    // Since we do not need to handle Ether in this contract, revert any Ether sent to the contract directly
    function() external payable {
        revert("Do not send Ether to this contract!");
    }
}