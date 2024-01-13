// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {Token} from "../src/Token.sol";  // Make sure the path is correct
import "./out/stdCheats.sol";

contract TokenTest is Test, stdCheats {
    Token public token;
    address public alice;
    address public bob;

stdCheats public cheats = stdCheats(HEVM_ADDRESS);
 

    function setUp() public {
        token = new Token();
        alice = cheats.addr(1);
       bob = cheats.addr(2);
    }

    function testInitialValues() public {
        assertEqual(token.name(), "SupraOracle", "Incorrect name");
        assertEqual(token.symbol(), "SPO", "Incorrect symbol");
        assertEqual(token.decimals(), uint256(18), "Incorrect decimals");
        assertEqual(token.totalSupply(), 1000000 ether, "Incorrect total supply");
        assertEqual(token.balanceOf(address(this)), 1000000 ether, "Incorrect balance for deployer");
    }

    function testTransfer() public {
        token.transfer(alice, 100 ether);
        assertEqual(token.balanceOf(alice), 100 ether, "Incorrect balance for Alice");
        assertEqual(token.balanceOf(address(this)), 999900 ether, "Incorrect balance for deployer");
    }

    function testApproval() public {
        token.approve(alice, 50 ether);
        assertEqual(token.allowance(address(this), alice), 50 ether, "Incorrect allowance");
    }

    function testTransferFrom() public {
        token.approve(alice, 50 ether);
        token.transferFrom(address(this), bob, 50 ether);
        assertEqual(token.balanceOf(bob), 50 ether, "Incorrect balance for Bob");
        assertEqual(token.balanceOf(address(this)), 999950 ether, "Incorrect balance for deployer");
        assertEqual(token.allowance(address(this), alice), 0 ether, "Allowance not updated");
    }

    // Add more test cases for other functions as needed
}
