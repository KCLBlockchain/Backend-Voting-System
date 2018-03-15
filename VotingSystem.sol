pragma solidity ^0.4.20;

contract VotingSystesm {
    
    // This sctructure holds info about the person who votes
    struct Voter {
        bool voted;
        uint8 vote;
    }
    
    // This sctructure holds info about the person who you can vote for
    struct Candidate {
        bytes32 name;
        uint8 numberOfVotes;
    }
    
    // Contract owner's address
    address contractOwner;
    
    
    // Mapping adresse's to voter info
    mapping(address => Voter) voters;
    Candidate[] candidates;
    mapping(string => Candidate) results;
    
    // Our constructor assigns names of candidates to the Candidate 
    // array we stor on block chain.
    // Also stors the contractOwner address on the block chain
    function VotingSystesm (bytes32[] candidateNames) {
        contractOwner = msg.sender;
        
        for (uint8 i = 0; i < candidateNames.length; i++) {
            candidates.push(Candidate({
                name : candidateNames[i],
                numberOfVotes : 0
            }));
        }
        
    }
    
    // Voting function:
    // Check wheter the voter has voted, if not:
    // Mark the fact that he voted, also store the person he voted for
    // Finally increment candidate's numberOfVotes
    function vote (uint8 voteFor) {
        Voter storage sender = voters[msg.sender];
        
        if(sender.voted) return;
        
        sender.voted = true;
        sender.vote = voteFor;
        
        candidates[voteFor].numberOfVotes += 1;
    }
    
    function winningCandidate () constant returns(string winnerName){
        
        bytes32 tempWinnerName;
        uint maxVote = 0;
        
        for (uint8 i = 0; i < candidates.length; i++) {
            
            if (candidates[i].numberOfVotes > maxVote) {
                
                maxVote = candidates[i].numberOfVotes;
                tempWinnerName = candidates[i].name;
                
            }

        }
        
        return bytes32ToString(tempWinnerName);
        

    }
    
    function bytes32ToString(bytes32 x) constant returns (string) {
        bytes memory bytesString = new bytes(32);
        uint charCount = 0;
        for (uint j = 0; j < 32; j++) {
            byte char = byte(bytes32(uint(x) * 2 ** (8 * j)));
            if (char != 0) {
                bytesString[charCount] = char;
                charCount++;
            }
        }
        bytes memory bytesStringTrimmed = new bytes(charCount);
        for (j = 0; j < charCount; j++) {
            bytesStringTrimmed[j] = bytesString[j];
        }
        return string(bytesStringTrimmed);
    }
        
    
}