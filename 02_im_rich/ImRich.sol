pragma solidity ^0.5.0;

contract ImRich {

    address public owner;
    uint256 public value;
    mapping(address => uint256) public receiver;
    
    uint256 public constant receiveEther = 0.05 ether;
    
    constructor() public payable {
        owner = msg.sender;
        value += msg.value;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can access this function");
        _;
    }
    
    modifier notOwner() {
        require(msg.sender != owner, "Owner cannot access this function");
        _;
    }
    
    modifier notRich() {
        require(msg.sender.balance <= 0.01 ether, "You are too rich");
        _;
    }
    
    modifier enoughFund() {
        require(value >= 0.005 ether, "The owner of this contract currently out of ether");
        _;
    }
    
    function donate() public payable onlyOwner {
        value += msg.value;
    }
    
    function receive() public notOwner notRich enoughFund {
        value -= receiveEther;
        receiver[msg.sender] += receiveEther;
        msg.sender.transfer(receiveEther);
    }
    
}