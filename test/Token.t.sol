// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Token} from "../src/Token.sol";

contract TokenTest is Test {
    Token public token;
    address public crowdfundingAddress;
    address public alice;
    address public bob;

    function setUp() public {
        token = new Token();
       crowdfundingAddress = address(1);
       alice = address(1);
        bob = address(2);
    }

    function testToken() public {
        assertEq(token.name(), "SupraOracle", "Incorrect name");
        assertEq(token.symbol(), "SPO", "Incorrect symbol");
        assertEq(token.decimals(), uint256(18), "Incorrect decimals");
        assertEq(token.totalSupply(), 1000000 ether, "Incorrect total supply");
        // Adjusted balances and allowances based on the corrected setup
        assertEq(token.balanceOf(address(this)), 1000000 ether, "Incorrect balance for deployer");
    }
     function testTransfer() public {
        // Mint some tokens to the crowdfunding address (msg.sender)
        token.mint(address(this) , 100 ether);

        // Check initial balances
        assertEq(token.balanceOf(address(this)), 1000100 ether, "Incorrect balance for deployer address");

        // Transfer 50 tokens from crowdfunding address to Alice
        bool transferResult = token.transfer(crowdfundingAddress, 50 ether);

        // Check if the transfer was successful
        assertTrue(transferResult, "Transfer failed");

        // Check updated balances
        assertEq(token.balanceOf(crowdfundingAddress), 50 ether, "Incorrect balance for crowdfunding address");
        assertEq(token.balanceOf(address(this)), 1000050 ether, "Incorrect balance for deployer");
    }

}
