
//Address: 0x273dc4c0b19669f9c53f48d170b3f2e18167dad4
//Contract name: ChilliZTokenPurchase
//Balance: 0 Ether
//Verification Date: 6/7/2018
//Transacion Count: 7

// CODE STARTS HERE

pragma solidity ^0.4.21;

contract Ownable {
  address public owner;


  /** 
   * @dev The Ownable constructor sets the original `owner` of the contract to the sender
   * account.
   */
  constructor() internal {
    owner = msg.sender;
  }


  /**
   * @dev Throws if called by any account other than the owner. 
   */
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }


  /**
   * @dev Allows the current owner to transfer control of the contract to a newOwner.
   * @param newOwner The address to transfer ownership to. 
   */
  function transferOwnership(address newOwner) onlyOwner public {
    require(newOwner != address(0));
    owner = newOwner;
  }

}

/**
 * Interface for the standard token.
 * Based on https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20-token-standard.md
 */
interface EIP20Token {
  function totalSupply() external view returns (uint256);
  function balanceOf(address who) external view returns (uint256);
  function transfer(address to, uint256 value) external returns (bool success);
  function transferFrom(address from, address to, uint256 value) external returns (bool success);
  function approve(address spender, uint256 value) external returns (bool success);
  function allowance(address owner, address spender) external view returns (uint256 remaining);
  event Transfer(address indexed from, address indexed to, uint256 value);
  event Approval(address indexed owner, address indexed spender, uint256 value);
}


// The owner of this contract should be an externally owned account
contract ChilliZTokenPurchase is Ownable {

  // Address of the target contract
  address public purchase_address = 0xd64671135E7e01A1e3AB384691374FdDA0641Ed6;
  // Major partner address
  address public major_partner_address = 0x212286e36Ae998FAd27b627EB326107B3aF1FeD4;
  // Minor partner address
  address public minor_partner_address = 0x515962688858eD980EB2Db2b6fA2802D9f620C6d;
  // Additional gas used for transfers.
  uint public gas = 1000;

  // Payments to this contract require a bit of gas. 100k should be enough.
  function() payable public {
    execute_transfer(msg.value);
  }

  // Transfer some funds to the target purchase address.
  function execute_transfer(uint transfer_amount) internal {
    // Major fee is 2.5 for each 105
    uint major_fee = transfer_amount * 25 / 1050;
    // Minor fee is 2.5 for each 105
    uint minor_fee = transfer_amount * 25 / 1050;

    transfer_with_extra_gas(major_partner_address, major_fee);
    transfer_with_extra_gas(minor_partner_address, minor_fee);

    // Send the rest
    uint purchase_amount = transfer_amount - major_fee - minor_fee;
    transfer_with_extra_gas(purchase_address, purchase_amount);
  }

  // Transfer with additional gas.
  function transfer_with_extra_gas(address destination, uint transfer_amount) internal {
    require(destination.call.gas(gas).value(transfer_amount)());
  }

  // Sets the amount of additional gas allowed to addresses called
  // @dev This allows transfers to multisigs that use more than 2300 gas in their fallback function.
  //  
  function set_transfer_gas(uint transfer_gas) public onlyOwner {
    gas = transfer_gas;
  }

  // We can use this function to move unwanted tokens in the contract
  function approve_unwanted_tokens(EIP20Token token, address dest, uint value) public onlyOwner {
    token.approve(dest, value);
  }

  // This contract is designed to have no balance.
  // However, we include this function to avoid stuck value by some unknown mishap.
  function emergency_withdraw() public onlyOwner {
    transfer_with_extra_gas(msg.sender, address(this).balance);
  }

}