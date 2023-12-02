//SPDX-License-Identifier: MIT
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
pragma solidity ^0.8.17;

contract BikeNFT is ERC721URIStorage{
    address public owner;
    constructor() ERC721 ("BikeCollection", "BCN"){
            owner = msg.sender;
    }
    modifier onlyOwner{
            require(msg.sender == owner, "Only the owner can call this function");
            _;
        }

    function mint(address _to,uint256 _tokenId,string calldata _uri) external onlyOwner {
            _mint(_to, _tokenId);
            _setTokenURI(_tokenId, _uri);
    }


}