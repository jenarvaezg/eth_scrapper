
//Address: 0x6ce3fef99a6a4a8d1cc55d980966459854b3b021
//Contract name: GIFT_CARD
//Balance: 0.30000000000001 Ether
//Verification Date: 6/19/2018
//Transacion Count: 2

// CODE STARTS HERE

pragma solidity ^0.4.19;

contract GIFT_CARD
{
    function Put(bytes32 _hash, uint _unlockTime)
    public
    payable
    {
        if(!locked && msg.value > 300000000000000000)// 0.3 ETH
        {
            unlockTime = now+_unlockTime;
            hashPass = _hash;
        }
    }
    
    function Take(bytes _pass)
    external
    payable
    access(_pass)
    {
        if(hashPass == keccak256(_pass) && now>unlockTime && msg.sender==tx.origin)
        {
            msg.sender.transfer(this.balance);
        }
    }
    
    function Lock(bytes _pass)
    external
    payable
    access(_pass)
    {
        locked = true;
    }
    
    modifier access(bytes _pass)
    {
        if(hashPass == keccak256(_pass) && now>unlockTime && msg.sender==tx.origin)
        _;
    }
    
    bytes32 public hashPass;
    uint public unlockTime;
    bool public locked = false;
    
    function GetHash(bytes pass) public constant returns (bytes32) {return keccak256(pass);}
    
    function() public payable{}
}