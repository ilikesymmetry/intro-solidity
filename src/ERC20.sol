// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract ERC20 {
    string public constant name = "Token";
    string public constant symbol = "ERC20";
    uint8 public constant decimals = 18;
    uint256 public constant totalSupply = 1_000_000_000;

    mapping(address account => uint256 balance) public balanceOf;
    mapping(address account => mapping(address spender => uint256 remaining)) public allowance;

    event Transfer(address from, address to, uint256 value);
    event Approval(address owner, address spender, uint256 value);

    error InsufficientBalance(address account, uint256 value, uint256 balance);
    error InsufficientAllowance(address account, address spender, uint256 value, uint256 allowance);

    constructor() {
        balanceOf[msg.sender] = 1_000_000_000;
        emit Transfer(address(0), msg.sender, 1_000_000_000);
    }

    function transfer(address to, uint256 value) external returns (bool success) {
        // Check sender balance can cover value
        uint256 senderBalance = balanceOf[msg.sender];
        if (senderBalance < value) revert InsufficientBalance(msg.sender, value, senderBalance);

        // Effects
        balanceOf[msg.sender] = senderBalance - value;
        balanceOf[to] += value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value) external returns (bool success) {
        // Check sender can transfer
        uint256 remaining = allowance[from][msg.sender];
        if (remaining < value) revert InsufficientAllowance(from, msg.sender, value, remaining);

        // Check from balance can cover value
        uint256 senderBalance = balanceOf[from];
        if (senderBalance < value) revert InsufficientBalance(from, value, senderBalance);

        // Effects
        balanceOf[from] = senderBalance - value;
        balanceOf[to] += value;
        emit Transfer(from, to, value);
        return true;
    }

    function approve(address spender, uint256 value) external returns (bool success) {
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }
}

contract App {
    function pullTokens(address token, uint256 value) external {
        // Requires user first called ERC20.approve to enable App to spend tokens
        ERC20(token).transferFrom(msg.sender, address(this), value);
    }
}
