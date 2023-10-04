// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol"; // to handle the ownership of the contract
import "@openzeppelin/contracts/utils/Counters.sol"; // to auto-increment the tokenID
import "@openzeppelin/contracts/token/ERC721/ERC721.sol"; // NFT's standard

contract CustomerNFT is ERC721, Ownable {

    IERC721 public adminNFT; // Reference to your AdminNFT contract

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    constructor(address _nftAddress) ERC721("CustomerNFT", "CST") {
        adminNFT = IERC721(_nftAddress);
    }

    modifier onlyAdminNFTOwner () {
        // require that the sender has at least 1 BossNFT
        require(
            adminNFT.balanceOf(msg.sender) > 0,
            "Only AdminNFT owners can call this function"
        );
        _; // placeholder for the statement
    }

    /// The tokenId is auto-incremented
    function safeMint(address to) public onlyAdminNFTOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }

}