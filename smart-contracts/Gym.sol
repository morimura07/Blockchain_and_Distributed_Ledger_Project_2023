// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Base64.sol";



contract Gym is ERC721, Ownable {

    // 1 ether = 1000000000000000000 wei
    // 0.05 ether = 50000000000000000 wei


    //1. Property Variables -------------------------------------------------------------------

    struct Info {
        uint256 price;
        uint256 expirationDate;
    }

    using Counters for Counters.Counter;

    Counters.Counter internal _tokenIdCounter;       //First free tokenId
    Counters.Counter internal _expirationCounter;    //Oldest valid tokenId

    bool internal mintable;
    uint256 internal maxSupply;

    uint256 public mintPrice;
    uint256 public subscriptionValidity;

    uint256[] internal resale;    
    mapping(address => uint256) internal mintedWallets;
    mapping(uint256 => Info) internal subscriptionInfo;


    // 2. Lifecycle Methods -------------------------------------------------------------------

    constructor() ERC721("Gym", "GM") Ownable(msg.sender) {

        _tokenIdCounter.increment();        // Start token ID at 1 - by default starts at 0
        _expirationCounter.increment();

        mintPrice = 50000000000000000 wei; 
        maxSupply = 100;
        subscriptionValidity = 365;
        mintable = true;
    }

    function uint2str(uint _i) internal pure returns (string memory _uintAsString) {
        if (_i == 0) {
            return "0";
        }
        uint j = _i;
        uint len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint k = len;
        while (_i != 0) {
            k = k-1;
            uint8 temp = (48 + uint8(_i - _i / 10 * 10));
            bytes1 b1 = bytes1(temp);
            bstr[k] = b1;
            _i /= 10;
        }
        return string(bstr);
    }


    function getSvg(uint256 tokenId) private view returns (string memory) {
        require((tokenId < _tokenIdCounter._value) && (tokenId > 0),"The token does not exists.");
        string[4] memory svgs;
                
        svgs = [
                "<svg width='800px' height='800px' viewBox='0 0 1024 1024' class='icon'  version='1.1' xmlns='http://www.w3.org/2000/svg'><path d='M934.4 755.2c0 14.08-11.52 25.6-25.6 25.6H153.6c-14.08 0-25.6-11.52-25.6-25.6V294.4c0-14.08 11.52-25.6 25.6-25.6h755.2c14.08 0 25.6 11.52 25.6 25.6v460.8z' fill='#B8CA43' /><path d='M908.8 793.6H153.6c-21.76 0-38.4-16.64-38.4-38.4V294.4c0-21.76 16.64-38.4 38.4-38.4h755.2c21.76 0 38.4 16.64 38.4 38.4v460.8c0 21.76-16.64 38.4-38.4 38.4zM153.6 281.6c-7.68 0-12.8 5.12-12.8 12.8v460.8c0 7.68 5.12 12.8 12.8 12.8h755.2c7.68 0 12.8-5.12 12.8-12.8V294.4c0-7.68-5.12-12.8-12.8-12.8H153.6z' fill='#231C1C' /><path d='M934.4 482.56c0 8.96-11.52 16.64-25.6 16.64H153.6c-14.08 0-25.6-7.68-25.6-16.64v-67.84c0-8.96 11.52-16.64 25.6-16.64h755.2c14.08 0 25.6 7.68 25.6 16.64v67.84z' fill='#513328' /><path d='M908.8 512H153.6c-21.76 0-38.4-12.8-38.4-29.44v-67.84C115.2 396.8 131.84 384 153.6 384h755.2c21.76 0 38.4 12.8 38.4 29.44v67.84c0 17.92-16.64 30.72-38.4 30.72z m-755.2-102.4c-7.68 0-12.8 3.84-12.8 5.12v67.84c0 1.28 5.12 3.84 12.8 3.84h755.2c7.68 0 11.52-2.56 12.8-5.12v-67.84c0-1.28-5.12-3.84-12.8-3.84H153.6z' fill='#231C1C' /><path d='M460.8 640h115.2v25.6h-115.2z' fill='#231C1C' /><path d='M384 704h268.8v25.6H384z' fill='#231C1C' /></svg>",
                "<svg fill='#000000' width='800px' height='800px' viewBox='0 0 15 15' id='fitness-centre' xmlns='http://www.w3.org/2000/svg'> <path id='daec40ff-71f5-4432-9d75-dcba7b9c1b89' d='M14.5,7V8h-1v2h-1v1H11V8H4v3H2.5V10h-1V8H.5V7h1V5h1V4H4V7h7V4h1.5V5h1V7Z'/> </svg>",
                "<svg fill='#000000' width='800px' height='800px' viewBox='0 0 24 24' xmlns='http://www.w3.org/2000/svg'> <title/> <g data-name='Layer 2' id='Layer_2'> <path d='M19,7H14v4H10V7H5V8H2v8H5v1h5V13h4v4h5V16h3V8H19ZM4,14V10H5v4Zm4,1H7V9H8Zm8-6h1v6H16Zm4,1v4H19V10Z'/> </g> </svg>",
                "<svg version='1.1' id='Icons' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 32 32' xml:space='preserve'> <style type='text/css'> .st0{fill:none;stroke:#000000;stroke-width:2;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;} </style> <path d='M24,13.5V10c0-4.4-3.6-8-8-8s-8,3.6-8,8v3.5c-1.9,2-3,4.6-3,7.5c0,3.5,1.6,6.7,4.4,8.8C9.6,29.9,9.8,30,10,30h12 c0.2,0,0.4-0.1,0.6-0.2c2.8-2.1,4.4-5.3,4.4-8.8C27,18.1,25.9,15.4,24,13.5z M10,11.8V10c0-3.3,2.7-6,6-6s6,2.7,6,6v1.8 c-1.7-1.1-3.8-1.8-6-1.8S11.7,10.7,10,11.8z M22,20.1c-0.1,0-0.2,0-0.3,0c-0.4,0-0.8-0.3-1-0.7c-0.3-1.1-1.1-2-2-2.6 c-0.5-0.3-0.6-0.9-0.3-1.4c0.3-0.5,0.9-0.6,1.4-0.3c1.3,0.9,2.3,2.2,2.8,3.7C22.8,19.4,22.5,19.9,22,20.1z'/> </svg>"
                ];

        return svgs[subscriptionInfo[tokenId].expirationDate % svgs.length];
    }   


    function tokenURI(uint256 tokenId) override(ERC721) public view returns (string memory) {
        string memory json = Base64.encode(
            bytes(string(
                abi.encodePacked(
                    '{"name": "GM_', uint2str(tokenId), '",',
                    '"image_data": "', getSvg(tokenId), '",',
                    '"attributes": [{"trait_type": "Price", "value": ', uint2str(subscriptionInfo[tokenId].price), '},',
                    '{"trait_type": "Expiration date", "value": ', uint2str(subscriptionInfo[tokenId].expirationDate), '}',
                    ']}'
                )
            ))
        );
        return string(abi.encodePacked('data:application/json;base64,', json));
    }


    // Setters --------------------------------------------------------------------------

    function toggleMintable() external onlyOwner {
        mintable = !mintable;
    }

    function setMaxSupply(uint256 maxSupply_) external onlyOwner {
        maxSupply = maxSupply_;
    }

    function setMintPrice(uint256 _mintPrice) external onlyOwner {
        mintPrice = _mintPrice;
    }


    // Getters ----------------------------------------------------------------------------

    
    function totalSupply() public view returns (uint256) {
        return _tokenIdCounter._value - _expirationCounter._value;
    }

    function isMintEnabled() external view returns (bool){
        return mintable;
    }

    function getMaxSupply() external view onlyOwner returns (uint256){
        return maxSupply;
    }


    //Interaction functions ----------------------------------------------------------------


    function withdraw() public onlyOwner(){
        require(address(this).balance > 0, "Balance is zero.");

        payable(owner()).transfer(address(this).balance);
    }


    function mint() public payable  {
        require(mintable, "Minting not enabled.");
        require(msg.value == mintPrice, "Wrong value.");
        checkExpirations();
        require(mintedWallets[msg.sender] < 1, "Exceeds max per wallet.");  //currently max 1 subscription per wallet
        require(totalSupply() < maxSupply, "The gym is sold out.");
    
        uint256 tokenId = _tokenIdCounter.current();
        
        _tokenIdCounter.increment();
        mintedWallets[msg.sender] = tokenId;
        _safeMint(msg.sender, tokenId);
        subscriptionInfo[tokenId] = Info(mintPrice, block.timestamp + (subscriptionValidity*24*3600)); //*24*3600
        
        setApprovalForAll(address(this), false);
    }


    function checkExpirations() internal {

        for (uint256 i = _expirationCounter._value; i < _tokenIdCounter._value; i++){
            if (!isValid(i)){
                if (isInResale(i)) {
                    resale[resalePosition(i)] = resale[resale.length - 1];
                    resale.pop();
                }
                _expirationCounter.increment();
                mintedWallets[ownerOf(i)] = 0;
            } else {
                return;
            }
        }
    }


    function enterGym() external view returns (bool) {
        if (mintedWallets[msg.sender] < 1)
            return false;
        return isValid(mintedWallets[msg.sender]);
    }


    function isValid(uint256 tokenId) internal view returns (bool) {
        require((tokenId < _tokenIdCounter._value) && (tokenId > 0), "The token does not exists.");

        return block.timestamp < (subscriptionInfo[tokenId].expirationDate);
    }


    function sellSubscription() public {
        require(mintedWallets[msg.sender] > 0, "You have no subscription.");
        require(isValid(mintedWallets[msg.sender]), "Your subscription is expired");
        require(!isInResale(mintedWallets[msg.sender]), "Your request is already published.");

        resale.push(mintedWallets[msg.sender]);
        setApprovalForAll(address(this), true);
    }

    function unsellSubscription() public {
        require(mintedWallets[msg.sender] > 0, "You have no subscription.");
        require(isInResale(mintedWallets[msg.sender]), "You have no resale requests.");

        resale[resalePosition(mintedWallets[msg.sender])] = resale[resale.length -1];
        resale.pop();
        setApprovalForAll(address(this), false);
    }

    function displayResale() external view returns (string memory) {
        string memory output;


        for (uint256 i = 0; i < resale.length; i++){
            output = string(abi.encodePacked(
                                output,
                                string(abi.encodePacked(
                                        'Subscription: GM_' , uint2str(resale[i]) , '\n', 
                                        'Remaining days: ' , uint2str(getRemainingDays(resale[i])) , '\n',
                                        'Current price: ' , uint2str(getCurrentPrice(resale[i])) , '\n\n'))
                            ));
        } 
        
        return output;
    }


    function isInResale(uint256 tokenId) internal view returns (bool){
        for (uint256 i = 0; i < resale.length; i++)
            if (resale[i] == tokenId) 
                return true;
        return false;
    }


    function resalePosition(uint256 tokenId) internal view returns (uint256){
        require((tokenId < _tokenIdCounter._value) && (tokenId > 0),"The token does not exists.");
        require(isInResale(tokenId), "The token is not for sale.");
        require(tokenId >= _expirationCounter._value, "The token is expired.");

        for (uint256 i = 0; i < resale.length; i++)
            if (resale[i] == tokenId) 
                return i;
    }


    function getRemainingDays(uint256 tokenId) public view returns (uint256){
        require((tokenId < _tokenIdCounter._value) && (tokenId > 0),"The token does not exists.");
        require(tokenId >= _expirationCounter._value, "The token is expired.");

        if (subscriptionInfo[tokenId].expirationDate > block.timestamp )
            return (uint256) ((subscriptionInfo[tokenId].expirationDate - block.timestamp) / (24*3600));
        return 0;
    }


    function getCurrentPrice(uint256 tokenId) public view returns (uint256){
        require((tokenId < _tokenIdCounter._value) && (tokenId > 0),"The token does not exists.");
        require(tokenId >= _expirationCounter._value, "The token is expired.");

        return (uint256) ((mintPrice * (getRemainingDays(tokenId) + 1)) / subscriptionValidity);
    }


    function purchaseSubscription(uint256 tokenId) external payable {

        require((tokenId < _tokenIdCounter._value) && (tokenId > 0),"The token does not exists");
        require(isValid(tokenId),"The token is expired.");
        require(isInResale(tokenId), "The token is not for sale.");
        require(mintedWallets[msg.sender] < 1, "Exceeds max per wallet.");  //currently max 1 subscription per wallet
        require(msg.sender != ownerOf(tokenId),"You already possess the token.");
        require(msg.value == getCurrentPrice(tokenId), "Wrong value.");

        mintedWallets[ownerOf(tokenId)] = 0;
        resale[resalePosition(tokenId)] = resale[resale.length -1];
        resale.pop(); 

        payable(ownerOf(tokenId)).transfer((uint256) ((mintPrice * (getRemainingDays(tokenId))) / subscriptionValidity));
        _safeTransfer(ownerOf(tokenId), msg.sender, tokenId, "");
        mintedWallets[msg.sender] = tokenId;
    }

    // Overrides -------------------------------------------------------------------------

    function transferFrom(address from, address to, uint256 tokenId) public pure override{
        require(false, "Transfer not allowed.");
    }

   /* function safeTransferFrom(address from, address to, uint256 tokenId) public pure override{
        require(false, "Transfer not allowed.");
    }*/

    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data) public pure override{
        require(false, "Transfer not allowed.");
    }

    function renounceOwnership() public onlyOwner view override {
        require(false, "Better to transfer the ownership, innit?");
    }
    
}