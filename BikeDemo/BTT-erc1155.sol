//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract BikeDemo is ERC1155,ERC1155Burnable{
        address public owner;
        uint256 public constant blueBike = 0;
        uint256 public constant yellowBike = 1;
        uint256 public constant bikeToken = 2;
        mapping (address => bool)bikeMember;

        constructor()ERC1155("https://ipfs.io/ipfs/QmW7FB4rHsBWkFi3urPx7Pe99eGCkrY1nuGmdvpArSydKL/{id}.json")
        {   
            owner = msg.sender;
            _mint(msg.sender,blueBike,1,"");
            _mint(msg.sender,yellowBike,1,"");
            _mint(msg.sender,bikeToken,1000,"");
        }

        modifier onlyOwner{
            require(msg.sender == owner, "Only the owner can call this function");
            _;
        }
        modifier onlyMember{
            require(bikeMember[msg.sender]== true,"Only our member can call this function");
            _;
        }

        function register() public payable {
            address member = msg.sender;
            bikeMember[member] = true;
        }

        function connect() public view onlyMember onlyOwner returns(address){
            return msg.sender;
        }

        function uri(uint256 _tokenid)public pure override returns(string memory){
            return
                string(
                    abi.encodePacked("https://ipfs.io/ipfs/QmW7FB4rHsBWkFi3urPx7Pe99eGCkrY1nuGmdvpArSydKL/",
                    Strings.toString(_tokenid),
                    ".json")
                );
        }

        function contarctURI() public pure returns (string memory){
            return
                "https://ipfs.io/ipfs/QmW7FB4rHsBWkFi3urPx7Pe99eGCkrY1nuGmdvpArSydKL/collection.json";
        }


        function sendBCT(
            uint256 tokenId,
            address[] calldata recipients
        ) external onlyOwner {
            for (uint i = 0; i<recipients.length;i++) {
                _safeTransferFrom(msg.sender, recipients[i], tokenId, 1, "Welcome to bikeShare, we have gift to you !");
            }
        }

        function transferBoth(address _to,uint bikeTokenId, uint amount, uint nftId) onlyMember onlyOwner public {
            address _from = msg.sender;
            _safeTransferFrom(_from,_to,bikeTokenId,amount,"");
            _safeTransferFrom(_from,_to,nftId,1,"");
        }

        function rentBike(address _user,uint nftId,uint amount) onlyMember public {
            require(amount > 5,"NO PAY NO GAIN (5 at least)");
            _safeTransferFrom(_user,owner,2,amount,"");
            _safeTransferFrom(owner,_user,nftId,1,"");
        }

        function returnBike(uint nftId) onlyMember public{
            require(msg.sender!=owner);
            _safeTransferFrom(msg.sender, owner, nftId, 1, "");
        }


}