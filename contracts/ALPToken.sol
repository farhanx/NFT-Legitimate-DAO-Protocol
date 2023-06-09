pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ALTP is ERC20, Ownable {
    using SafeMath for uint256;

    constructor(uint256 initialSupply) ERC20("ALTP Token", "ALTP") {
        _mint(msg.sender, initialSupply);
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        require(recipient != address(0), "ERC20: transfer to zero address");
        require(amount <= balanceOf(msg.sender), "ERC20: transfer amount exceeds balance");

        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        require(sender != address(0), "ERC20: transfer from zero address");
        require(recipient != address(0), "ERC20: transfer to zero address");
        require(amount <= balanceOf(sender), "ERC20: transfer amount exceeds balance");
        require(amount <= allowance(sender, _msgSender()), "ERC20: transfer amount exceeds allowance");

        _transfer(sender, recipient, amount);
        _approve(sender, _msgSender(), allowance(sender, _msgSender()).sub(amount));
        return true;
    }

    function getUserBalance(address userAdr) public view returns (uint256) {
        return balanceOf(userAdr);
    }

    
}


