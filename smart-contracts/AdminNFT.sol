// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol"; // to handle the ownership of the contract
import "@openzeppelin/contracts/utils/Counters.sol"; // to auto-increment the tokenID
import "@openzeppelin/contracts/token/ERC721/ERC721.sol"; // NFT's standard

contract AdminNFT is ERC721, Ownable {

    IERC721 public bossNFT; // Reference to your BossNFT contract

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    constructor(address _nftAddress) ERC721("AdminNFT", "ADM") {
        bossNFT = IERC721(_nftAddress);
    }

    modifier onlyBossNFTOwner () {
        // require that the sender has at least 1 BossNFT
        require(
            bossNFT.balanceOf(msg.sender) > 0,
            "Only bossNFT owners can call this function"
        );
        _; // placeholder for the statement
    }

    /// The tokenId is auto-incremented
    function safeMint(address to) public onlyBossNFTOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }


}