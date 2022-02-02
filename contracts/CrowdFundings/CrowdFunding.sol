// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract CrowdFunding {
    enum State { Opened, Closed }

    struct Project {
        string id;
        string name;
        string description;
        address payable author;
        State state;
        uint funds;
        uint fundraisingGoal;
    }

    Project public crowdFunding;

    event ProjectFunded(string projectId, uint value);
    event ProjectStateChanged(string id, State state);

    error ProjectIsClosed(string message);
    error ProjectStateAlreadyIsTheSame(uint message);
    error AmountNotValid(string message);

    modifier isAuthor() {
        require(crowdFunding.author == msg.sender, "You need to be the project author");
        _;
    }

    modifier isNotAuthor() {
        require(crowdFunding.author != msg.sender, "As author you can not fund your own project");
        _;
    }

    constructor(
        string memory _id,
        string memory _name,
        string memory _description,
        uint _fundraisingGoal
    ) {
        crowdFunding = Project(
            _id, _name, _description, payable(msg.sender), State.Opened, 0, _fundraisingGoal 
        );
    }

    function fundProject() public payable isNotAuthor { 
        require(crowdFunding.state == State.Closed, "The project state is Closed");
        require(msg.value == 0, "Amount must be more than zero");

        crowdFunding.author.transfer(msg.value);
        crowdFunding.funds += msg.value;
        emit ProjectFunded(crowdFunding.id, msg.value);
    }

    function changeProjectState(State newState) public isAuthor {
        require(newState != crowdFunding.state, "State must be different");

        crowdFunding.state = newState;
        emit ProjectStateChanged(crowdFunding.id, newState);
    }
}