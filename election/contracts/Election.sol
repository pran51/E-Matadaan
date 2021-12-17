pragma solidity ^0.5.16;

contract Election {
    // Model a Candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }
    // Store accounts that have voted
    mapping(address => bool) public voters;
    // Store Candidates
    // Fetch Candidate
    //we cannot iterate over mapping, for non existent value it gives blank value
    //thus we count of candidates in a variable
    mapping(uint => Candidate) public candidates; //key value pair hash
    // Store Candidates Count
    uint public candidatesCount;

    //voted event 
    event votedEvent ( // to refresh the page after voting automatically
        uint indexed _candidateId
    );
    // Store candidate
    // Read candidate
    // Constructor
    constructor() public {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }
    function addCandidate (string memory _name) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote (uint _candidateId) public {
        // require that they haven't voted before
        require(!voters[msg.sender]);

        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount);

        // record that voter has voted
        voters[msg.sender] = true;

        // update candidate vote Count
        candidates[_candidateId].voteCount ++;

        // trigger voted event
        emit votedEvent(_candidateId);
    }
}