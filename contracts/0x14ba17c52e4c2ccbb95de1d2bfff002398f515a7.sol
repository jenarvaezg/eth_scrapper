
//Address: 0x14ba17c52e4c2ccbb95de1d2bfff002398f515a7
//Contract name: WithdrawDAO
//Balance: 0 Ether
//Verification Date: 8/6/2016
//Transacion Count: 9

// CODE STARTS HERE

// Refund contract for trust DAO #34

contract DAO {
    function balanceOf(address addr) returns (uint);
    function transferFrom(address from, address to, uint balance) returns (bool);
    uint public totalSupply;
}

contract WithdrawDAO {
    DAO constant public mainDAO = DAO(0x440c59b325d2997a134c2c7c60a8c61611212bad);
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