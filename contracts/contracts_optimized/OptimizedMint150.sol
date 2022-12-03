//SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.15;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "hardhat/console.sol";

// You may not modify this contract or the openzeppelin contracts
contract NotRareToken is ERC721 {
    mapping(address => bool) private alreadyMinted;

    uint256 private totalSupply;

    constructor() ERC721("NotRareToken", "NRT") {}

    function mint() external {
        totalSupply++;
        _safeMint(msg.sender, totalSupply);
        alreadyMinted[msg.sender] = true;
    }
}

contract OptimizedAttacker {
    NotRareToken immutable nft;
    constructor(address victim, uint256 start) {
        nft = NotRareToken(victim);
        nft.mint();
        for (uint i = start + 1; i != start + 150; ) {
            nft.mint();
            nft.transferFrom(address(this), msg.sender, i);
            unchecked {
                i++;
            }
        }
        nft.transferFrom(address(this), msg.sender, start);
    }
}
