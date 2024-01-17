// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console2} from "forge-std/Test.sol";
import {TokenSwap} from "../src/TokenSwap.sol";

contract TokenSwap is Test {
    TokenSwap public tokenSwapper;
    address public user1;
    address public user2;

    // Initialize the contract and users before each test
    function beforeEach() external {
        tokenSwapper = new TokenSwapper();
        user1 = address(0x1);
        user2 = address(0x2);
    }

    // Test adding a new token to the TokenSwapper
    function testAddToken() public {
        string memory tokenSymbol = "ABC";
        address tokenAddress = address(0x123);
        uint256 rate = 2;

        tokenSwapper.addToken(tokenSymbol, tokenAddress, rate);

        // Verify that the token information is correctly stored
        TokenSwapper.TokenInfo memory addedToken = tokenSwapper.tokenInfoMapping(tokenSymbol);
        assertEq(addedToken.token, IERC20(tokenAddress), "Token address mismatch");
        assertEq(addedToken.rate, rate, "Conversion rate mismatch");
    }

    // Test swapping tokens from one user to another
    function testTokenSwap() public {
        string memory fromTokenSymbol = "DEF";
        string memory toTokenSymbol = "GHI";
        uint256 fromAmount = 100;
        uint256 initialFromBalance = 1000;
        uint256 initialToBalance = 500;

        // Setup: Add tokens and set initial balances
        tokenSwapper.addToken(fromTokenSymbol, address(user1), 2);
        tokenSwapper.addToken(toTokenSymbol, address(user2), 3);
        IERC20(user1).mint(user1, initialFromBalance);
        IERC20(user2).mint(user2, initialToBalance);

        // Execute the swap
        tokenSwapper.swap(fromTokenSymbol, toTokenSymbol, fromAmount);

        // Verify that the balances are updated correctly after the swap
        assertEq(IERC20(user1).balanceOf(user1), initialFromBalance - fromAmount, "Source token balance mismatch");
        assertEq(
            IERC20(user2).balanceOf(user2),
            initialToBalance + (fromAmount * 3 / 2),
            "Destination token balance mismatch"
        );
    }

    // Test changing the conversion rate of an existing token
    function testChangeRate() public {
        string memory tokenSymbol = "JKL";
        address tokenAddress = address(0x456);
        uint256 initialRate = 4;
        uint256 newRate = 5;

        // Setup: Add a token with an initial rate
        tokenSwapper.addToken(tokenSymbol, tokenAddress, initialRate);

        // Execute: Change the conversion rate
        tokenSwapper.changeRate(tokenSymbol, newRate);

        // Verify that the rate is updated correctly
        TokenSwapper.TokenInfo memory updatedToken = tokenSwapper.tokenInfoMapping(tokenSymbol);
        assertEq(updatedToken.rate, newRate, "Updated conversion rate mismatch");
    }
}
