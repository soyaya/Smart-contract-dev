// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Token.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenSales {
    Token public token;
    address public constant etherStorageAddress = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
    address[] public contributors;
    address public owner;
    uint256 public presaleStartTime;
    uint256 public publicSaleStartTime;
    uint256 public presaleCap = 100 ether; // 100,000 SPO tokens for presale
    uint256 public publicSaleCap = 200 ether; // 200,000 SPO tokens for public sale
    uint256 public futureTime = 2 * 24 * 60 * 60; // time in two days
    uint256 public presaleEndTime;
    bool public presaleClosed = false;
    uint256 public presaleMinContribution = 1 ether;
    uint256 public presaleMaxContribution = 5 ether;
    uint256 public goalPresale;
    uint256 public rate = 1 ether; // 1 ether = 0.0002 SPO
    mapping(address => uint256) public presaleContributions;
// define the sales stage
    enum SalesStage {
        PreSaleStage,
        PublicSalesStage
    }
// picks a stage of slaes
    SalesStage public currentStage;
//events 
    event TokensPurchased(address indexed buyer, uint256 amount, uint256 value);
    event TokensDistributed(address indexed recipient, uint256 amount);
    event RefundClaimed(address indexed contributor, uint256 amount);
// calls only owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }
// set sales to open
    modifier saleOpen() {
        require(
            (currentStage == SalesStage.PreSaleStage && block.timestamp < presaleEndTime && !presaleClosed)
                || (currentStage == SalesStage.PublicSalesStage && block.timestamp >= presaleEndTime),
            "Token sale is not currently open"
        );
        _;
    }

// make sure all donations are within limit

    modifier withinContributionLimits(uint256 contribution) {
        require(
            contribution >= presaleMinContribution && contribution <= presaleMaxContribution,
            "Contribution not within allowed limits"
        );
        _;
    }

    constructor(Token _token) {
        owner = msg.sender;
        token = _token;
        currentStage = SalesStage.PreSaleStage;
        presaleStartTime = block.timestamp;
        presaleEndTime = presaleStartTime + futureTime;
        goalPresale = 0; // Set the goalPresale to presaleCap initially
    }
// get ethers balance into a wallet to differentiate donated funds from tokens made
    function getBalanceOfEtherStorageAddress() external view returns (uint256) {
        return payable(etherStorageAddress).balance;
    }
// set presales to close not needed just for testing 
    function setPresaleClosed(bool _presaleClosed) public {
        presaleClosed = _presaleClosed;
    }
// calls the contribute to presales 
    function contributeToPresale(uint256 contribution)
        external
        payable
        saleOpen
        withinContributionLimits(contribution)
    {
        require(msg.value == contribution, "Incorrect value sent");

        // Update the contributors array with the current contributor
        if (!isContributor(msg.sender)) {
            contributors.push(msg.sender);
        }
        // Store the contributed ether in the specified address
        payable(etherStorageAddress).transfer(contribution);
        presaleContributions[msg.sender] += contribution;
        goalPresale += contribution;

        uint256 remainingTokens = presaleCap - goalPresale;
        require(remainingTokens > 0 ether, "Presale tokens sold out");

        uint256 tokensToMint = contribution / rate;

        if (tokensToMint > remainingTokens) {
            tokensToMint = remainingTokens;
        }

        emit TokensPurchased(msg.sender, tokensToMint, contribution);

        // Mint and transfer tokens immediately
        token.mint(msg.sender, tokensToMint);
    }

// Function to check if an address is a contributor
    function isContributor(address contributor) internal view returns (bool) {
        for (uint256 i = 0; i < contributors.length; i++) {
            if (contributors[i] == contributor) {
                return true;
            }
        }
        return false;
    }
// switch to public sales 
    function switchToPublicSale() external onlyOwner {
        require(block.timestamp >= presaleEndTime, "Presale has not ended yet");
        require(!presaleClosed, "Presale has already been closed");

        currentStage = SalesStage.PublicSalesStage;
        presaleClosed = true;
        publicSaleStartTime;
    }

    // call public sales 

    function contributeToPublicSale(uint256 contribution)
        external
        payable
        saleOpen
        withinContributionLimits(contribution)
    {
        require(msg.value == contribution, "Incorrect value sent");
        // address to collect public funds
        payable(etherStorageAddress).transfer(contribution);
        uint256 remainingTokens = publicSaleCap - goalPresale;
        require(remainingTokens > 0, "Public sale tokens sold out");

        if (contribution > remainingTokens) {
            contribution = remainingTokens;
        }

        presaleContributions[msg.sender] += contribution;
        goalPresale += contribution;

        emit TokensPurchased(msg.sender, contribution, msg.value);

        // Mint and transfer tokens immediately
        token.mint(msg.sender, contribution);
    }
// Distribute token to be called by owner
    function distributeTokens(address recipient, uint256 amount) external onlyOwner {
        require(currentStage == SalesStage.PublicSalesStage, "Distribution allowed only during public sale");
        require(amount <= token.balanceOf(address(this)), "Not enough tokens in the contract");

        token.transfer(recipient, amount);

        emit TokensDistributed(recipient, amount);
    }
// call the refund when target is not met.
    function claimRefund() external saleOpen {
        
        require(goalPresale < presaleCap, "Goal reached, no refund available");

        // Iterate over all contributors
        for (uint256 i = 0; i < contributors.length; i++) {
            address contributor = contributors[i];
            uint256 contributionAmount = presaleContributions[contributor];

            // Check if the contributor has a valid contribution
            if (contributionAmount > 0) {
                presaleContributions[contributor] = 0;
              /*  (bool success, ) = contributor.send(contributionAmount)(
    abi.encodeWithSignature("contributeToPresale(uint256)", contributionAmount)
);
                    require(success, "Transfer failed");*/
                emit RefundClaimed(contributor, contributionAmount);
            }
        }
    }
}
