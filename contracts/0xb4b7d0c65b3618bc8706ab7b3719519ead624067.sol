
//Address: 0xb4b7d0c65b3618bc8706ab7b3719519ead624067
//Contract name: Token
//Balance: 0 Ether
//Verification Date: 7/28/2017
//Transacion Count: 19

// CODE STARTS HERE

pragma solidity >=0.4.10;

contract Token {
	event Transfer(address indexed from, address indexed to, uint value);
	event Approval(address indexed owner, address indexed spender, uint value);

	string constant public name = "Hodl Token";
	string constant public symbol = "HODL";
	uint8 constant public decimals = 8;
	mapping (address => uint) public balanceOf;
	mapping (address => mapping (address => uint)) public allowance;
	uint public totalSupply;
	address public owner;

	function Token() {
		owner = msg.sender;
	}

	function transfer(address to, uint value) returns(bool) {
		uint bal = balanceOf[msg.sender];
		require(bal >= value);
		balanceOf[msg.sender] = bal - value;
		balanceOf[to] = balanceOf[to] + value;
		Transfer(msg.sender, to, value);
		return true;
	}

	function approve(address spender, uint value) returns(bool) {
		require(value == 0 || (allowance[msg.sender][spender] == 0 && balanceOf[msg.sender] >= value));
		allowance[msg.sender][spender] = value;
		Approval(msg.sender, spender, value);
		return true;
	}

	function transferFrom(address owner, address to, uint value) returns(bool) {
		uint allowed = allowance[owner][msg.sender];
		uint balance = balanceOf[owner];
		require(allowed >= value && balance >= value);
		allowance[owner][msg.sender] = allowed - value;
		balanceOf[owner] = balance - value;
		balanceOf[to] = balanceOf[to] + value;
		Transfer(owner, to, value);
		return true;
	}

	function approval(address owner, address spender) constant returns(uint) {
		return allowance[owner][spender];
	}

	function burn(uint amount) {
		uint bal = balanceOf[msg.sender];
		require(bal >= amount);
		balanceOf[msg.sender] = bal - amount;
		totalSupply -= amount;
		Transfer(msg.sender, 0, amount);
	}

	function mint(address to, uint value) {
		require(msg.sender == owner);
		balanceOf[to] = balanceOf[to] + value;
		totalSupply += value;
		Transfer(0, to, value);
	}

	function multiMint(uint256[] bits) {
		require(msg.sender == owner);
		uint256 lomask = (1 << 96) - 1;
		uint created = 0;
		for (uint i=0; i<bits.length; i++) {
			address a = address(bits[i]>>96);
			uint value = bits[i]&lomask;
			balanceOf[a] = balanceOf[a] + value;
			Transfer(0, a, value);
			created += value;
		}
		totalSupply += created;
	}
}
