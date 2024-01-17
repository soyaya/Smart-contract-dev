// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Token {
    // Variables
    string public name = "SupraOracle";
    string public symbol = "SPO";
    uint256 public decimals = 18;
    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;
    address public owner;

    // Events
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event Transfers(address indexed from, address indexed to, uint256 value);

    // Modifier to restrict access to the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    // Constructor: Initializes the total supply and assigns it to the contract deployer
    constructor() {
        totalSupply = 1000000 * (10 ** decimals);
        balanceOf[msg.sender] = totalSupply;
        owner = msg.sender;
    }

    // Transfer function: Moves tokens from the sender to the specified recipient
    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balanceOf[msg.sender] >= _value, "Insufficient balance");
        _transfer(msg.sender, _to, _value);
        return true;
    }

    // Internal transfer function: Updates balances and emits Transfer event
    function _transfer(address _from, address _to, uint256 _value) internal {
        require(_to != address(0), "Invalid recipient address");
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(_from, _to, _value);
    }

    // Approve function: Allows a spender to spend a certain amount of tokens on behalf of the owner
    function approve(address _spender, uint256 _value) public returns (bool success) {
        require(_spender != address(0), "Invalid spender address");
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    // TransferFrom function: Moves tokens from a specified address to another address based on allowance
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_value <= balanceOf[_from], "Insufficient balance");
        require(_value <= allowance[_from][msg.sender], "Insufficient allowance");
        allowance[_from][msg.sender] -= _value;
        _transfer(_from, _to, _value);
        return true;
    }

    // Mint function: Creates new tokens and assigns them to the specified account (onlyOwner)
    function mint(address account, uint256 amount) public {
        _mint(account, amount);
    }

    // Internal mint function: Updates total supply and recipient's balance
    function _mint(address account, uint256 amount) internal {
        totalSupply += amount;
        balanceOf[account] += amount;
        emit Transfer(address(0), account, amount); // Minting event
    }

    // Function to send tokens to an external address (onlyOwner)
    function sendTokens(address to, uint256 amount) public {
        require(to != address(0), "Invalid recipient address");
        require(amount <= balanceOf[msg.sender], "Insufficient balance");

        // Deduct the tokens from the owner's balance
        balanceOf[msg.sender] -= amount;

        // Add the tokens to the recipient's balance
        balanceOf[to] += amount;

        // Emit Transfer event
        emit Transfers(msg.sender, to, amount);
    }
}
