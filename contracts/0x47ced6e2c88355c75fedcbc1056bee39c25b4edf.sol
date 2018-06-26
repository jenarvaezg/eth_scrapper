
//Address: 0x47ced6e2c88355c75fedcbc1056bee39c25b4edf
//Contract name: WangWangToken
//Balance: 0 Ether
//Verification Date: 2/15/2018
//Transacion Count: 30

// CODE STARTS HERE

pragma solidity ^0.4.16;

contract owned {
	address public owner;

	event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

	function owned() public {
		owner = msg.sender;
	}

	modifier onlyOwner {
		require(msg.sender == owner);
		_;
	}

	function transferOwnership(address newOwner) onlyOwner public {
		require(newOwner != address(0));
		OwnershipTransferred(owner, newOwner);
		owner = newOwner;
	}
}

interface tokenRecipient { function receiveApproval(address _from, uint256 _value, address _token, bytes _extraData) public; }

contract TokenERC20 {
	// Public variables of the token
	string public name;
	string public symbol;
	uint8 public decimals = 18;
	// 18 decimals is the strongly suggested default, avoid changing it
	uint256 public totalSupply;

	// This creates an array with all balances
	mapping (address => uint256) public balanceOf;
	mapping (address => mapping (address => uint256)) public allowance;

	// This generates a public event on the blockchain that will notify clients
	event Transfer(address indexed from, address indexed to, uint256 value);

	// This notifies clients about the amount burnt
	event Burn(address indexed from, uint256 value);

	/**
	 * Constrctor function
	 *
	 * Initializes contract with initial supply tokens to the creator of the contract
	 */
	function TokenERC20(
			uint256 initialSupply,
			string tokenName,
			string tokenSymbol
			) public {
		totalSupply = initialSupply * 10 ** uint256(decimals);  // Update total supply with the decimal amount
		balanceOf[msg.sender] = totalSupply;                // Give the creator all initial tokens
		name = tokenName;                                   // Set the name for display purposes
		symbol = tokenSymbol;                               // Set the symbol for display purposes
	}

	/**
	 * Internal transfer, only can be called by this contract
	 */
	function _transfer(address _from, address _to, uint _value) internal {
		//require(_value > 0); //uint will never be less than zero ;)
		// Prevent transfer to 0x0 address. Use burn() instead
		require(_to != 0x0);
		// Check if the sender has enough
		require(balanceOf[_from] >= _value);
		// Check for overflows
		require(balanceOf[_to] + _value > balanceOf[_to]);
		// Save this for an assertion in the future
		uint previousBalances = balanceOf[_from] + balanceOf[_to];
		// Subtract from the sender
		balanceOf[_from] -= _value;
		// Add the same to the recipient
		balanceOf[_to] += _value;
		Transfer(_from, _to, _value);
		// Asserts are used to use static analysis to find bugs in your code. They should never fail
		assert(balanceOf[_from] + balanceOf[_to] == previousBalances);
	}

	/**
	 * Transfer tokens
	 *
	 * Send `_value` tokens to `_to` from your account
	 *
	 * @param _to The address of the recipient
	 * @param _value the amount to send
	 */
	function transfer(address _to, uint256 _value) public {
		_transfer(msg.sender, _to, _value);
	}

	/**
	 * Transfer tokens from other address
	 *
	 * Send `_value` tokens to `_to` in behalf of `_from`
	 *
	 * @param _from The address of the sender
	 * @param _to The address of the recipient
	 * @param _value the amount to send
	 */
	function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
		require(_value <= allowance[_from][msg.sender]);     // Check allowance
		allowance[_from][msg.sender] -= _value;
		_transfer(_from, _to, _value);
		return true;
	}

	/**
	 * Set allowance for other address
	 *
	 * Allows `_spender` to spend no more than `_value` tokens in your behalf
	 *
	 * @param _spender The address authorized to spend
	 * @param _value the max amount they can spend
	 */
	function approve(address _spender, uint256 _value) public
		returns (bool success) {
			//require(_value > 0); //uint will never be less than zero ;)
			allowance[msg.sender][_spender] = _value;
			return true;
		}

	/**
	 * Set allowance for other address and notify
	 *
	 * Allows `_spender` to spend no more than `_value` tokens in your behalf, and then ping the contract about it
	 *
	 * @param _spender The address authorized to spend
	 * @param _value the max amount they can spend
	 * @param _extraData some extra information to send to the approved contract
	 */
	function approveAndCall(address _spender, uint256 _value, bytes _extraData) public
		returns (bool success) {
			tokenRecipient spender = tokenRecipient(_spender);
			if (approve(_spender, _value)) {
				spender.receiveApproval(msg.sender, _value, this, _extraData);
				return true;
			}
		}

	/**
	 * Destroy tokens
	 *
	 * Remove `_value` tokens from the system irreversibly
	 *
	 * @param _value the amount of money to burn
	 */
	function burn(uint256 _value) public returns (bool success) {
		//require(_value > 0); //uint will never be less than zero ;)
		require(balanceOf[msg.sender] >= _value);   // Check if the sender has enough
		balanceOf[msg.sender] -= _value;            // Subtract from the sender
		totalSupply -= _value;                      // Updates totalSupply
		Burn(msg.sender, _value);
		return true;
	}

	/**
	 * Destroy tokens from other account
	 *
	 * Remove `_value` tokens from the system irreversibly on behalf of `_from`.
	 *
	 * @param _from the address of the sender
	 * @param _value the amount of money to burn
	 */
	function burnFrom(address _from, uint256 _value) public returns (bool success) {
		require(balanceOf[_from] >= _value);                // Check if the targeted balance is enough
		require(_value <= allowance[_from][msg.sender]);    // Check allowance
		balanceOf[_from] -= _value;                         // Subtract from the targeted balance
		allowance[_from][msg.sender] -= _value;             // Subtract from the sender's allowance
		totalSupply -= _value;                              // Update totalSupply
		Burn(_from, _value);
		return true;
	}
}

contract AdvancedToken is owned, TokenERC20 {

	mapping (address => bool) public frozenAccount;

	/* This generates a public event on the blockchain that will notify clients */
	event FrozenFunds(address target, bool frozen);

	/* Initializes contract with initial supply tokens to the creator of the contract */
	function AdvancedToken(
			uint256 initialSupply,
			string tokenName,
			string tokenSymbol
			) TokenERC20(initialSupply, tokenName, tokenSymbol) public {}

	/* Avoid anyone sending Ether to the contract for mistake */
	function () public {
		//if ether is sent to this address, send it back.
		//throw;
		require(false); //always fail
	}

	/* Internal transfer, only can be called by this contract */
	function _transfer(address _from, address _to, uint _value) internal {
		require (_to != 0x0);                               // Prevent transfer to 0x0 address. Use burn() instead
		require (balanceOf[_from] >= _value);               // Check if the sender has enough
		require (balanceOf[_to] + _value > balanceOf[_to]); // Check for overflows
		require(!frozenAccount[_from]);                     // Check if sender is frozen
		require(!frozenAccount[_to]);                       // Check if recipient is frozen
		balanceOf[_from] -= _value;                         // Subtract from the sender
		balanceOf[_to] += _value;                           // Add the same to the recipient
		Transfer(_from, _to, _value);
	}

	/* Never mint more tokens */
	/// @notice Create `mintedAmount` tokens and send it to `target`
	/// @param target Address to receive the tokens
	/// @param mintedAmount the amount of tokens it will receive
	/*function mintToken(address target, uint256 mintedAmount) onlyOwner public {
		balanceOf[target] += mintedAmount;
		totalSupply += mintedAmount;
		Transfer(0, this, mintedAmount);
		Transfer(this, target, mintedAmount);
		}*/

	/// @notice `freeze? Prevent | Allow` `target` from sending & receiving tokens
	/// @param target Address to be frozen
	/// @param freeze either to freeze it or not
	function freezeAccount(address target, bool freeze) onlyOwner public {
		frozenAccount[target] = freeze;
		FrozenFunds(target, freeze);
	}

}

/**
 * @title Pausable
 * @dev Base contract which allows children to implement an emergency stop mechanism.
 */
contract Pausable is owned {
	event Pause();
	event Unpause();

	bool public paused = false;

	/**
	 * @dev modifier to allow actions only when the contract IS NOT paused
	 */
	modifier whenNotPaused() {
		require(!paused);
		_;
	}

	/**
	 * @dev modifier to allow actions only when the contract IS paused
	 */
	modifier whenPaused {
		require(paused);
		_;
	}

	/**
	 * @dev called by the owner to pause, triggers stopped state
	 */
	function pause() onlyOwner whenNotPaused public returns (bool) {
		paused = true;
		Pause();
		return true;
	}

	/**
	 * @dev called by the owner to unpause, returns to normal state
	 */
	function unpause() onlyOwner whenPaused public returns (bool) {
		paused = false;
		Unpause();
		return true;
	}
}

/******************************************/
/*   WANG-WANG TOKEN (WWT) STARTS HERE     */
/******************************************/
contract WangWangToken is AdvancedToken, Pausable {

	uint256 public initialSupply = 100000000; //100,000,000
	string public tokenName = "Wang-Wang Token";
	string public tokenSymbol = "WWT";

	function WangWangToken() AdvancedToken(initialSupply, tokenName, tokenSymbol) public {}

	function transfer(address _to, uint256 _value) whenNotPaused public {
		super.transfer(_to, _value);
	}

	function transferFrom(address _from, address _to, uint256 _value) whenNotPaused public returns (bool success) {
		return super.transferFrom(_from, _to, _value);
	}

	function burn(uint256 _value) whenNotPaused public returns (bool success) {
		return super.burn(_value);
	}

	function burnFrom(address _from, uint256 _value) whenNotPaused public returns (bool success) {
		return super.burnFrom(_from, _value);
	}
}