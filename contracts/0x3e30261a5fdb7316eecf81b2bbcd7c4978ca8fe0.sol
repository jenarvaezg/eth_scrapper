
//Address: 0x3e30261a5fdb7316eecf81b2bbcd7c4978ca8fe0
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
0xb992A49fB05975f6414c09E2f29B51c64c396050,
0xCeff9865Fb872aE2b0A49fBDdb52b2274Bc2eFD0,
0x6Eb9bCAb5D1489e424AfDa0ff39895bdAB63280E,
0x82053b54767fF34ee2C61d8808e5C0DE4617291e,
0xc2209e916A0b88b98B3d012F0a3890f30AcFDdFA,
0x867F7f6eDC1aAa3FaE3273cdEe4c56a9a5D04DB1,
0x93BF27a3512F28a4ce66ebd0bc0fC8DFD0602448,
0x049f55AFe2d6764773077e8AC346D4594cd5Ee37,
0x02C3C3CF7d38bA7604aEb32668A9eaa059fe4D7A,
0x01B33963Fa474eAab23748D344dD3A419eEBE8d5
    ];
    
    
    
    newChildren=[0x6a41FdC716eBe1370a3d6F6763A4910c0d1e1AbD,
0x5f3b4EEE5b074eB2b84DbB630cc913Fc4B4BC57A,
0xeaD03073f359012557F7Be33f39103374a1734Ba,
0x9EF67052d6Be3dF4A1494E1a552522f063e1F2DA,
0xb3E86FBcF03337d36eF2D11F8AD47723cFC82CA3,
0xDC61ef81264196F4a917C7af50DCCb41F426c4f1,
0x90f83FDE38F071B2a84e8a39354d719Ac2CC852a,
0x18E6BD8bAE8C161D853B28Ab2D23b1DC7834EEC1,
0xCC1C2575F0004410372492d9BFD82EFe3c6608b8,
0x0847A504d54C86b716717536FAD80F1Bf0B548EA
    ];
    
    elixorContract.importGenesisPairs(newParents,newChildren);
 
}

}

contract elixor {
    function importGenesisPairs(address[] newParents,address[] newChildren) public;
}