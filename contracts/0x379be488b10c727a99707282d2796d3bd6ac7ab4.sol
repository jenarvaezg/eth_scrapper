
//Address: 0x379be488b10c727a99707282d2796d3bd6ac7ab4
//Contract name: ICOCrowdsale
//Balance: 0 Ether
//Verification Date: 6/10/2018
//Transacion Count: 2

// CODE STARTS HERE

pragma solidity ^0.4.18;

library SafeMath {
  function mul(uint256 a, uint256 b) pure internal returns (uint256) {
    uint256 c = a * b;
    assert(a == 0 || c / a == b);
    return c;
  }
}

contract token {
  mapping (address => uint256) public balanceOf;
  function transfer(address _to, uint256 _value) external;
}

contract ICOCrowdsale {
  using SafeMath for uint256;
  token public tokenReward;
  mapping(address => uint256) public balanceOf;

  uint public beginTime;
  uint public endTime;

  address public owner;

  event Transfer(address indexed _from, uint256 _value);

  constructor (
    address ICOReward,
    uint _beginTime,
    uint _endTime
  ) payable public {
    tokenReward = token(ICOReward);
    beginTime = _beginTime;
    endTime = _endTime;

    owner = msg.sender;
  }

  function () payable public{
    uint amount = msg.value;

    require(amount % 10 ** 17 == 0);
    require(now >= beginTime && now <= endTime);
    tokenReward.transfer(msg.sender, amount.mul(1000));

    emit Transfer(msg.sender, amount);
  }

  function setBeginTime(uint _beginTime) onlyOwner public {
    beginTime = _beginTime;
  }

  function setEndTime(uint _endTime) onlyOwner public {
    endTime = _endTime;
  }

  modifier onlyOwner {
    require(msg.sender == owner);
    _;
  }

  function WithdrawalETH(uint _value) onlyOwner public {
    if (_value == 0)
      owner.transfer(address(this).balance);
    else
      owner.transfer(_value * 1 ether);
  }

  function WithdrawalToken(uint _value) onlyOwner public {
    if (_value == 0) {
      tokenReward.transfer(owner, tokenReward.balanceOf(address(this)));
    } else {
      tokenReward.transfer(owner, _value * 1 ether);
    }
  }
}
