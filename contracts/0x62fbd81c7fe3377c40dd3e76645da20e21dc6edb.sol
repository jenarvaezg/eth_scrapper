
//Address: 0x62fbd81c7fe3377c40dd3e76645da20e21dc6edb
//Contract name: BMoney
//Balance: 0 Ether
//Verification Date: 2/25/2018
//Transacion Count: 3

// CODE STARTS HERE

// $BMoney

pragma solidity ^0.4.4;


contract Token {

    function totalSupply() constant returns (uint256 supply) {}


    function balanceOf(address _owner) constant returns (uint256 balance) {}

    function transfer(address _to, uint256 _value) returns (bool success) {}

 
    function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {}

    function approve(address _spender, uint256 _value) returns (bool success) {}

   
    function allowance(address _owner, address _spender) constant returns (uint256 remaining) {}

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

}

contract StandardToken is Token {

    function transfer(address _to, uint256 _value) returns (bool success) {

        if (balances[msg.sender] >= _value && balances[_to] + _value > balances[_to]) {
            balances[msg.sender] -= _value;
            balances[_to] += _value;
            Transfer(msg.sender, _to, _value);
            return true;
        } else {return false;}
    }

    function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {

        if (balances[_from] >= _value && allowed[_from][msg.sender] >= _value && balances[_to] + _value > balances[_to]) {
            balances[_to] += _value;
            balances[_from] -= _value;
            allowed[_from][msg.sender] -= _value;
            Transfer(_from, _to, _value);
            return true;
        } else {return false;}
    }

    function balanceOf(address _owner) constant returns (uint256 balance) {
        return balances[_owner];
    }

    function approve(address _spender, uint256 _value) returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) constant returns (uint256 remaining) {
      return allowed[_owner][_spender];
    }

    mapping (address => uint256) balances;
    mapping (address => mapping (address => uint256)) allowed;
    uint256 public totalSupply;
}

contract BMoney is StandardToken { 


    string public name;                
    uint8 public decimals;           
    string public symbol;                
    string public version = "1.0"; 
    uint256 public unitsOneEthCanBuy;    
    uint256 public totalEthInWei;         
    address public fundsWallet;           

 
    function BMoney() {
        balances[msg.sender] = 10000000000000000000000000;               
        totalSupply = 10000000000000000000000000;                        
        name = "BMoney";                                              
        decimals = 18;                                               
        symbol = "$BMNY";                                            
                                            
        fundsWallet = msg.sender;                                   
                          
    }
    function approveAndCall(address _spender, uint256 _value, bytes _extraData) returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);

        if (!_spender.call(bytes4(bytes32(sha3("receiveApproval(address,uint256,address,bytes)"))), msg.sender, _value, this, _extraData)) {throw;}
        return true;
    }
}