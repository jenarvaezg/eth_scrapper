
//Address: 0x417bc80bdea792de29dd34afab9f816a2318ea9e
//Contract name: addGenesisPairs
//Balance: 0 Ether
//Verification Date: 9/1/2017
//Transacion Count: 1

// CODE STARTS HERE

pragma solidity ^0.4.10;

contract addGenesisPairs {
    
address[] newParents;
address[] newChildren;

function addGenesisPairs()    {
    // Set elixor contract address
    elixor elixorContract=elixor(0x898bF39cd67658bd63577fB00A2A3571dAecbC53);
    
    newParents=[
0x8009477b05bCf0B9974B52548dC8e813dB61c602,
0x5FDb5efe39Bc177A29C49bf41bc323fcfDCd3C3F,
0xA31f74Fa792c29685A4DDf5fFd73649de54be924,
0x652F27D0a1c14DBDfeaAb592c0688FE6ba37B60c,
0xDfd08f164B06B382E5f330ef20647F752570e7af,
0x6E69c6B77dE75898aE1539dfc30ecb60717900E9,
0x2F5e52827aB68F3265e01aec392a10393a1Bd298,
0x194AB48fCe80480a4E2E8cbFC81B22A75E9E6c75,
0x478564fD79a435d53541D1E452101F4b706288F2,
0xba2BfA9a9669eBba0b6A7983e5F4fD814B08dD04,
0x1B2BCe354887A9020E8Dd918BC015c9670bB5b3C,
0xa652cdd0EdBbb9a0424F4495971e1fF233fC593d,
0x102FE0f4CF066cfD079A040C651f8bf2b50f4Aa8,
0x3DcC73421F84aD467451a7d804782BFd96519b5d,
0xa180725cccbCEe28b1012F775EC7C31E63Da648D,
0x956257767Bc75f97A4C5c3507A63bbBC747382F9,
0xFFc78f1A9D19aD5775a0331A43d473939cA6a87B,
0x0F888040D992f083a78691C3C12b3A509a9C6777,
0xca017A430703A83a06609C04efA6DFeee41E0384,
0xd2f9649eFb6eE82d697753de53a6f5f7c89ee45B,
0x2e7b42bddAbE61e5bEd6Daa05101d2dAF96EEA56,
0x6737F0ed6da48EF6fE2d4888875bb68Ee7b70454,
0xF5e443785D7c8551Dc4599FC97574460039EacFF,
0x6E15a82dF82925Ba1F3D982927630F225607667c
    ];
    
    
    
    newChildren=[0x9841E407DB1cd0dd567c1E6f600158938A196c87,
0xd9d020a868230dd6288dd4e47FA47b7Ab3011a7e,
0x133f6997cb60463508BC30dFEAf55157ecd566eF,
0xc18450907a8119f4c47d89c0d781F3379dA8FEBE,
0x23956F8f3E422AEC56447554Eb8dC0095E239390,
0xE923907E2Ef749bC3E93Cc3614f84d78f59393d2,
0x9F3409696d81EA33baAD907e497673B4C3A947F4,
0x2B68E85371ACBcAfc3e7AE97785DA941d88D8AbD,
0x8DFed04cd1deD04976d58645E6C8A6AfeE31BdCE,
0x03dF0C0B765cbabae9dCAbF300D7aDE72F1747B0,
0x96167f4B02f21A6659b3Ad71720A3C50068D8551,
0x8591aE794E2669Ad0256796AaF02f2fa4C106235,
0x923aaDf21A4a5a81CBE45179FaFE79b33D4b8B61,
0x6827E8F9ea3B757432DaA3AC1c90c78A130355A7,
0x09cF4F23A6975974C4dD4aA869F26bE06e9E4857,
0x38FDF849e9cD11BD64f5A86744Bb4c29fD05c27e,
0x19AE662C9F2C187dF547bEE72E66A20dB0A49fBD,
0xb7AE048736Ef6977146943510b66575199c16B9b,
0x090b967Bb3aeee0F0209B62ccEF2e5221759d37F,
0x663297c905986fd50DB41D13d7bE1d84F396b811,
0x662396Ff7Df4bb28d846DE58Cc89F8683F00bb50,
0xA798a1539621877B8d598c5bd69235f8ec34CD65,
0x789f457d09b80d18E10e23cddb49B8090B47a25a,
0xa7423A286C53c94e08FE591cDEF5178640Ac0D8f
    ];
    
    elixorContract.importGenesisPairs(newParents,newChildren);
 
}

}

contract elixor {
    function importGenesisPairs(address[] newParents,address[] newChildren) public;
}