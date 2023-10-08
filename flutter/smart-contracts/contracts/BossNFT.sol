// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0; 


import "@openzeppelin/contracts/access/Ownable.sol"; // to handle the ownership of the contract
import "@openzeppelin/contracts/utils/Counters.sol"; // to auto-increment the tokenID
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

/**
Contract for the Boss of the Gym, only one Owner can mint these NFTs.
*/
contract BossNFT is ERC721, Ownable {

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;
    
    constructor() ERC721("BossNFT", "BSS") {}

    /// The tokenId is auto-incremented
    function safeMint(address to) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }

    // Instead of totalSupply we just ask which is the current tokenIdCounter
    function lastTokenId() external view returns (uint256) {
        return _tokenIdCounter.current();
    }

}
