
//Address: 0x0e0e733dd24168d85ecb5a62bb13385d31edf761
//Contract name: WithdrawDAO
//Balance: 0 Ether
//Verification Date: 8/6/2016
//Transacion Count: 3

// CODE STARTS HERE

// Refund contract for trust DAO #56

contract DAO {
    function balanceOf(address addr) returns (uint);
    function transferFrom(address from, address to, uint balance) returns (bool);
    uint public totalSupply;
}

contract WithdrawDAO {
    DAO constant public mainDAO = DAO(0x5d2b2e6fcbe3b11d26b525e085ff818dae332479);
    address constant public trustee = 0xda4a4626d3e16e094de3225a751aab7128e96526;

    function withdraw(){
        uint balance = mainDAO.balanceOf(msg.sender);

        if (!mainDAO.transferFrom(msg.sender, this, balance) || !msg.sender.send(balance))
            throw;
    }

    function trusteeWithdraw() {
        trustee.send((this.balance + mainDAO.balanceOf(this)) - mainDAO.totalSupply());
    }
}
