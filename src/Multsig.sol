// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MultiWallet {
    event Deposit(address indexed sender, uint amount, uint balance);
    event SubmitTranxtn(
        address indexed owner,
        uint indexed txIndex,
        address indexed to,
        uint value,
        bytes data
    );
    event ConfirmTranxtn(address indexed owner, uint indexed txIndex);
    event RevokeConfirmation(address indexed owner, uint indexed txIndex);
    event ExecuteTranxtn(address indexed owner, uint indexed txIndex);

    address[] public owners;
    mapping(address => bool) public Own;
    uint public numConfirmationsRequired;

    struct Tranxtn {
        address to;
        uint value;
        bytes data;
        bool executed;
        uint numConfirmations;
    }

    // mapping from tx index => owner => bool
    mapping(uint => mapping(address => bool)) public isConfirmed;

    Tranxtn[] public Tranxtns;

    modifier onlyOwner() {
        require(Own[msg.sender], "not owner");
        _;
    }

    modifier txExists(uint _txIndex) {
        require(_txIndex < Tranxtns.length, "tx does not exist");
        _;
    }

    modifier notExecuted(uint _txIndex) {
        require(!Tranxtns[_txIndex].executed, "tx already executed");
        _;
    }

    modifier notConfirmed(uint _txIndex) {
        require(!isConfirmed[_txIndex][msg.sender], "tx already confirmed");
        _;
    }

    constructor(address[] memory _owners, uint _numConfirmationsRequired) {
        require(_owners.length > 0, "owners required");
        require(
            _numConfirmationsRequired > 0 &&
                _numConfirmationsRequired <= _owners.length,
            "invalid number of required confirmations"
        );

        for (uint i = 0; i < _owners.length; i++) {
            address owner = _owners[i];

            require(owner != address(0), "invalid owner");
            require(!Own[owner], "owner not unique");

            Own[owner] = true;
            owners.push(owner);
        }

        numConfirmationsRequired = _numConfirmationsRequired;
    }

    receive() external payable {
        emit Deposit(msg.sender, msg.value, address(this).balance);
    }

    function submitTranxtn(
        address _to,
        uint _value,
        bytes memory _data
    ) public onlyOwner {
        uint txIndex = Tranxtns.length;

        Tranxtns.push(
            Tranxtn({
                to: _to,
                value: _value,
                data: _data,
                executed: false,
                numConfirmations: 0
            })
        );

        emit SubmitTranxtn(msg.sender, txIndex, _to, _value, _data);
    }

    function confirmTranxtn(
        uint _txIndex
    ) public onlyOwner txExists(_txIndex) notExecuted(_txIndex) notConfirmed(_txIndex) {
        Tranxtn storage Tranxtn = Tranxtns[_txIndex];
        Tranxtn.numConfirmations += 1;
        isConfirmed[_txIndex][msg.sender] = true;

        emit ConfirmTranxtn(msg.sender, _txIndex);
    }

    function executeTranxtn(
        uint _txIndex
    ) public onlyOwner txExists(_txIndex) notExecuted(_txIndex) {
        Tranxtn storage Tranxtn = Tranxtns[_txIndex];

        require(
            Tranxtn.numConfirmations >= numConfirmationsRequired,
            "cannot execute tx"
        );

        Tranxtn.executed = true;

        (bool success, ) = Tranxtn.to.call{value: Tranxtn.value}(
            Tranxtn.data
        );
        require(success, "tx failed");

        emit ExecuteTranxtn(msg.sender, _txIndex);
    }

    function revokeConfirmation(
        uint _txIndex
    ) public onlyOwner txExists(_txIndex) notExecuted(_txIndex) {
        Tranxtn storage Tranxtn = Tranxtns[_txIndex];

        require(isConfirmed[_txIndex][msg.sender], "tx not confirmed");

        Tranxtn.numConfirmations -= 1;
        isConfirmed[_txIndex][msg.sender] = false;

        emit RevokeConfirmation(msg.sender, _txIndex);
    }

    function getOwners() public view returns (address[] memory) {
        return owners;
    }

    function getTranxtnCount() public view returns (uint) {
        return Tranxtns.length;
    }

    function getTranxtn(
        uint _txIndex
    )
        public
        view
        returns (
            address to,
            uint value,
            bytes memory data,
            bool executed,
            uint numConfirmations
        )
    {
        Tranxtn storage Tranxtn = Tranxtns[_txIndex];

        return (
            Tranxtn.to,
            Tranxtn.value,
            Tranxtn.data,
            Tranxtn.executed,
            Tranxtn.numConfirmations
        );
    }
}
