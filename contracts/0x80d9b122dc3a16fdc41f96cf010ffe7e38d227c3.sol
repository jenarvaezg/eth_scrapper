
//Address: 0x80d9b122dc3a16fdc41f96cf010ffe7e38d227c3
//Contract name: Pub
//Balance: 0 Ether
//Verification Date: 10/30/2017
//Transacion Count: 3

// CODE STARTS HERE

pragma solidity ^0.4.16;

contract Pub {
    struct Publication {
        address source;
        string title;
        string body;
    }

    mapping (address => uint256[]) public allByAuthor;
    // anonymous by default
    mapping (address => string) public authors;
    Publication[] public all;

    function Pub() public { }

    function publish(string _title, string _body)
    external
    returns (uint256) {
        uint256 index = all.length;
        all.push(Publication(
            msg.sender,
            _title,
            _body
        ));
        allByAuthor[msg.sender].push(index);
        return index;
    }

    function sign(string _name)
    external {
        authors[msg.sender] = _name;
    }

    function publicationCount(address _author)
    external view
    returns (uint256) {
        return allByAuthor[_author].length;
    }

    function size()
    external view
    returns (uint256) {
        return all.length;
    }
}