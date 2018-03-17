pragma solidity ^0.4.0;

contract Voting{
    
    mapping (bytes32 => uint128) votesRecieved;
    
    
    mapping (address => bool) voted;

    bytes32[] public candidateList;
    
    function Voting(bytes32[] mycandidates) public {
        candidateList=mycandidates;
    }
    
    function validCandidate(bytes32 candidate) returns(bool){
    for (uint i=0; i < candidateList.length; i++){
        if (candidateList[i]==candidate){
            return true;
        }
        }
    return false;
    }
    
    
    function totalVotesFor(bytes32 CandidateName) public returns(uint128 result){
        if (validCandidate(CandidateName)==false)throw;
        result= votesRecieved[CandidateName];
    }

    
    
    function voteForCandidate(bytes32 candidate) public returns(bool){
        if (validCandidate(candidate)==true){
            if (voted[msg.sender]==false){
                votesRecieved[candidate]+=1;
                voted[msg.sender]=true;
                return true;
            }else{
                return false;
            }
            
        }
    }
    
    
    function winner() public returns(string Winner, uint WinnerVotes){
        uint256 winnerAmmount=totalVotesFor(candidateList[0]);
        bytes32 voteWinner=candidateList[0];
        for (uint i=1; i< candidateList.length; i++){
            if (totalVotesFor(candidateList[i])>winnerAmmount){
                winnerAmmount=totalVotesFor(candidateList[i]);
                voteWinner=candidateList[i];
            }
        }
        Winner=str(voteWinner);
        WinnerVotes=winnerAmmount;
    }
    
    
    
    /* converts a bytes32 to a string
    used for displaying the winner*/
     function str(bytes32 x) private constant returns (string) {
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
