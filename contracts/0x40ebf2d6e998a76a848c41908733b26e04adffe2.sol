
//Address: 0x40ebf2d6e998a76a848c41908733b26e04adffe2
//Contract name: ReplaySafeSend
//Balance: 0 Ether
//Verification Date: 7/26/2016
//Transacion Count: 284

// CODE STARTS HERE

contract AmIOnTheFork {
    function forked() constant returns(bool);
}

contract ReplaySafeSend {
    // Fork oracle to use
    AmIOnTheFork amIOnTheFork = AmIOnTheFork(0x2bd2326c993dfaef84f696526064ff22eba5b362);

    function safeSend(address etcAddress) returns(bool) {
        if (!amIOnTheFork.forked() && etcAddress.send(msg.value)) {
            return true;
        }
        throw; // don't accept value transfer, otherwise it would be trapped.
    }

    // Reject value transfers.
    function() {
        throw;
    }
}
