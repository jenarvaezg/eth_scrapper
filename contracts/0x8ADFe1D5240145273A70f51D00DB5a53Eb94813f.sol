
//Address: 0x8ADFe1D5240145273A70f51D00DB5a53Eb94813f
//Contract name: NDEX
//Balance: 0 Ether
//Verification Date: 6/14/2018
//Transacion Count: 130

// CODE STARTS HERE

pragma solidity ^0.4.21;



interface tokenRecipient { function receiveApproval(address _from, uint256 _value, address _token, bytes _extraData) external; }

contract NDEX {
    // Public variables of the token
    string public name = "nDEX";
    string public symbol = "NDX";
    uint8 public decimals = 18;

    // 18 decimals is the strongly suggested default
    uint256 public totalSupply;
    uint256 public NdexSupply = 15000000000;
    uint256 public buyPrice = 10000000;
    address public creator;

    // This creates an array with all balances
    mapping (address => uint256) public balanceOf;
    mapping (address => mapping (address => uint256)) public allowance;

    // This generates a public event on the blockchain that will notify clients
    event Transfer(address indexed from, address indexed to, uint256 value);
    event FundTransfer(address backer, uint amount, bool isContribution);
    
    
    /**
     * Constrctor function
     *
     * Initializes contract with initial supply tokens to the creator of the contract
     */
    function NDEX() public {
        totalSupply = NdexSupply * 10 ** uint256(decimals);  	// Update total supply with the decimal amount
        balanceOf[msg.sender] = totalSupply;    		// Give NDX Mint the total created tokens
        creator = msg.sender;
    }
    /**
     * Internal transfer, only can be called by this contract
     */
    function _transfer(address _from, address _to, uint _value) internal {
        // Prevent transfer to 0x0 address. Use burn() instead
        require(_to != 0x0);
        // Check if the sender has enough
        require(balanceOf[_from] >= _value);
        // Check for overflows
        require(balanceOf[_to] + _value >= balanceOf[_to]);
	// Save this for an assertion in the future
        uint previousBalances = balanceOf[_from] + balanceOf[_to];
        // Subtract from the sender
        balanceOf[_from] -= _value;
        // Add the same to the recipient
        balanceOf[_to] += _value;
        emit Transfer(_from, _to, _value);
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

    
    
    /// @notice Buy tokens from contract by sending ether
    function () payable internal {
        uint amount = msg.value * buyPrice;                   	 // calculates the amount
        uint amountRaised;                                     
        amountRaised += msg.value;                            	//many thanks bois, couldnt do it without r/me_irl
        require(balanceOf[creator] >= amount);               	   // checks if it has enough to sell
        require(msg.value <= 10**17);                      	  // so any person who wants to put more then 0.1 ETH has time to think!
        balanceOf[msg.sender] += amount;                 	 // adds the amount to buyer's balance
        balanceOf[creator] -= amount;                      	  // sends ETH to NDXMint
        emit Transfer(creator, msg.sender, amount);              	 // execute an event reflecting the change
        creator.transfer(amountRaised);
    }

 }