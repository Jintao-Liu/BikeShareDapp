//SPDX-License-Identifier: MIT
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

pragma solidity ^0.8.17;

contract BikeToken is ERC20{
    address public owner;

    constructor() ERC20("BikeCoinToken","BCT") {
        owner = msg.sender;
        _mint(owner, 70000000 * (10 ** decimals()));
    }

    modifier onlyOwner{
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        require(balanceOf(spender)>= amount,"balance insufficient");
        _approve(owner, _msgSender(), amount);
        return true;
    }




}