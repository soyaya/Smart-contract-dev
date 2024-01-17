// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2, console} from "forge-std/Test.sol";
import {Token} from "../src/Token.sol";
import {TokenSales} from "../src/TokenSales.sol";
import {stdMath} from "forge-std/stdMath.sol";

contract TokenSaleTest is Test {
    Token public token;
    TokenSales public tokenSales;
    uint256 public rightTime;
    uint256 public wrongTime;

    function setUp() public {
        rightTime = block.timestamp; // Replace with a suitable time in the future
        wrongTime = 1705814430; // Replace with a time in the past
        token = new Token();
        tokenSales = new TokenSales(token);

        // Ensure the ether storage address is set correctly
        assertEq(
            tokenSales.etherStorageAddress(),
            address(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266),
            "Ether storage address not set correctly"
        );
    }

    // Test scenario: Contributor successfully contributes to presale
    function testContributeToPresale() public {
        // Specify the amount to contribute
        uint256 contribution = 1 ether; // WHEN 1 IS CHANGE TO LESS THAN 1 OR  ABOVE 5 , THE TEST WILL THROW AN ERROR
        uint256 contribution1 = 5 ether;
        uint256 contribution2 = 4 ether;
        uint256 contribution3 = 5 ether;

        uint256 initialBalanceContract = token.balanceOf(address(this)); // SHOULD BE 1000000 BECAUSE TOKEN IS PASSED INTO TOKENSALE IN
        console.log(" initialBal", initialBalanceContract);
        uint256 initialBalanceWallet = tokenSales.getBalanceOfEtherStorageAddress();
        console.log(" initialBalancewallet", initialBalanceWallet);

        tokenSales.contributeToPresale{value: contribution}(contribution);
        tokenSales.contributeToPresale{value: contribution1}(contribution1);
        tokenSales.contributeToPresale{value: contribution2}(contribution2);
        tokenSales.contributeToPresale{value: contribution3}(contribution3);

        // Retrieve the contribution from the presaleContributions mapping
        uint256 actualContributionContract = tokenSales.presaleContributions(address(this));
        uint256 contribute = contribution + contribution1 + contribution2 + contribution3;
        uint256 finalBalanceWallet = tokenSales.getBalanceOfEtherStorageAddress();
        console.log("actual contribution", actualContributionContract);
        console.log("finalBalanceWallet", finalBalanceWallet);
        console.log(" contribution", contribute);

        // Check that the actual contribution equals the expected contribution
        assertTrue(finalBalanceWallet == contribute, "Contribution does not match expected con");
        uint256 finalBalance = token.balanceOf(address(this));
        console.log(" balance of token", finalBalance);

        // Helper function to get the balance of the ether storage address
        console.log("finalBalanceWallet", finalBalanceWallet);
    }

    function testContributeToPresale2() public {
        // Step 1: Prank the contributor
        address contributor = vm.addr(1);
        vm.prank(contributor);

        // Step 2: Deal Ether to the contributor
        vm.deal(contributor, 1 ether);

        // Step 3: Contribute to Presale Function Call
        (bool success, bytes memory data) =
            address(tokenSales).call{value: 1 ether}(abi.encodeWithSignature("contributeToPresale(uint256)", 1 ether));

        // Check if the function call was successful
        require(success, "contributeToPresale call failed");

        // Step 4: Assertions and Checks
        uint256 expectedEtherWalletBalance = 1 ether;
        uint256 expectedPresaleContribution = 1 ether;
        uint256 expectedGoalPresale = 1 ether;

        // Check the balance of the ether wallet (contract)
        assertEq(
            tokenSales.getBalanceOfEtherStorageAddress(), expectedEtherWalletBalance, "Ether wallet balance mismatch"
        );

        // Check presaleContributions and goalPresale
        assertEq(
            tokenSales.presaleContributions(contributor), expectedPresaleContribution, "Presale contribution mismatch"
        );
        assertEq(tokenSales.goalPresale(), expectedGoalPresale, "Goal presale mismatch");

        // Advance the block timestamp to simulate the presale ending
        // Advance time to make the presale end
        vm.warp(block.timestamp + 2 days);

        // Check the balance of the ether wallet (contract)
        assertEq(
            tokenSales.getBalanceOfEtherStorageAddress(), expectedEtherWalletBalance, "Ether wallet balance mismatch"
        );

        // Check presaleContributions and goalPresale
        assertEq(
            tokenSales.presaleContributions(contributor), expectedPresaleContribution, "Presale contribution mismatch"
        );
        assertEq(tokenSales.goalPresale(), expectedGoalPresale, "Goal presale mismatch");

        // Switch to Public Sale
        tokenSales.switchToPublicSale();
        console.log("expectedGoalPresale", expectedPresaleContribution);
        console.log("presale goal", tokenSales.goalPresale());
        console.log("presale cap", tokenSales.presaleCap());
        console.log("Presalecap is greater than goalpresale", tokenSales.presaleCap() - tokenSales.goalPresale());

        // Claim Refund
        tokenSales.claimRefund();

        // Check if the ether wallet balance is zero after claiming refund
        assertEq(tokenSales.getBalanceOfEtherStorageAddress(), 1 ether, "Presale contribution should be zero");
    }
}
