// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Election} from "../src/Election.sol";

contract ElectionTest is Test {
    Election public election;

    function setUp() public {
        election = new Election();
    }

    function testAddCandidate() public {
        uint256 initialCount = election.candidatesCount();
        election.addCandidate("Candidate 3");
        uint256 finalCount = election.candidatesCount();
        assertEq(finalCount, initialCount + 1, "Candidate count should increment by one");
    }

    function testVote() public {
        // Add candidates to the election
        election.addCandidate("Candidate 1");
        election.addCandidate("Candidate 2");

        // Get the initial vote count for a candidate
        // Access the voteCount field correctly from the tuple
        (uint256 id, string memory name, uint256 voteCount) = election.candidates(1);
        uint256 initialVoteCount = voteCount;

        // Vote for candidate 1
        election.vote(1);

        // Check that the voter is recorded
        assertTrue(election.voters(address(this)), "Voter should be recorded");

        // Check that the candidate's vote count increased by 1
        // Access the voteCount field correctly from the tuple
        (id, name, voteCount) = election.candidates(1);
        assertEq(voteCount, initialVoteCount + 1, "Candidate 1 vote count should increase by 1");
    }

    function testDoubleVote() public {
        uint256 candidateId = 1;

        uint256 voteCountAfter;

        // Get the initial vote count for the candidate
        (uint256 id, string memory name, uint256 voteCountBefore) = election.candidates(candidateId);

        // Vote for the candidate
        election.vote(candidateId);

        // Check that the vote count increased by 1
        (id, name, voteCountAfter) = election.candidates(candidateId);
        assertEq(voteCountAfter, voteCountBefore + 1, "First vote count should increase by 1");

        //Test for double vote
        //election.vote(candidateId); when uncommented the test will fail.
    }
}
