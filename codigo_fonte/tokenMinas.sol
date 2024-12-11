// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract TokenMinas {
    string public name = "Token Minas";
    string public symbol = "TKM";

    uint8 public decimals = 0;
    uint256 private _totalSupply = 100;

    mapping(address => uint256) public _balances;
    mapping(address => mapping(address => uint256)) public _allowed;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor() {
        _balances[msg.sender] = _totalSupply;
        emit Transfer(address(0), msg.sender, _totalSupply);
    }

    function totalSupply() public view returns (uint) {
        return _totalSupply - _balances[address(0)];
    }

    function balanceOf(address _owner) public view returns (uint balance) {
        return _balances[_owner];
    }

    function allowance(address _owner, address _spender) public view returns (uint remaining) {
        return _allowed[_owner][_spender];
    }

    function transfer(address to, uint256 value) public returns (bool success) {
        require(_balances[msg.sender] >= value, "Saldo insuficiente");
        _balances[msg.sender] -= value;
        _balances[to] += value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

    function approve(address spender, uint256 value) public returns (bool success) {
        _allowed[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value) public returns (bool success) {
        require(_balances[from] >= value, "Saldo insuficiente");
        require(
            _allowed[from][msg.sender] >= value,
            "Sem permissao suficiente"
        );

        _balances[from] -= value;
        _balances[to] += value;
        _allowed[from][msg.sender] -= value;

        emit Transfer(from, to, value);
        return true;
    }
}
