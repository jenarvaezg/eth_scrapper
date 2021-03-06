
//Address: 0xce9a5619b3bfb2c11cdffcc15843eab11f6c8280
//Contract name: Airdrop
//Balance: 0 Ether
//Verification Date: 4/15/2018
//Transacion Count: 2

// CODE STARTS HERE

contract ERC20 {
  function transfer(address _recipient, uint256 _value) public returns (bool success);
}

contract Airdrop {
  function drop(ERC20 token, address[] recipients, uint256[] values) public {
    for (uint256 i = 0; i < recipients.length; i++) {
      token.transfer(recipients[i], values[i]);
    }
  }
}
