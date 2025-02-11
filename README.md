TOOLS FOR CONTRACT AUDINTING.

https://github.com/shanzson/Smart-Contract-Auditor-Tools-and-Techniques

https://github.com/Cyfrin/security-and-auditing-full-course-s23

https://github.com/slowmist/SlowMist-Learning-Roadmap-for-Becoming-a-Smart-Contract-Auditor

https://github.com/ruhulamin1398/Smart-Contract-Security-for-Developers-A-Guide-to-Auditing-and-Best-Practices

https://github.com/saeidshirazi/Awesome-Smart-Contract-Security

https://github.com/sannykim/solsec

https://github.com/moeinfatehi/Awesome-Smart-Contract-Security

https://github.com/sv1sjp/smart_contract_security_audit

https://github.com/Raiders0786/web3-security-resources

https://github.com/Quillhash/QuillAudit_Auditor_Roadmap


Here are the key links for aggregated resources listing smart contract vulnerabilities and how to find them on GitHub:

https://github.com/kadenzipfel/smart-contract-vulnerabilities

https://github.com/shanzson/Smart-Contract-Auditor-Tools-and-Techniques

https://github.com/saeidshirazi/Awesome-Smart-Contract-Security

https://github.com/muellerberndt/awesome-mythx-smart-contract-security-tools


Here are the key links for aggregated resources listing static tools for smart contract analysis on GitHub:

https://github.com/LouisTsai-Csie/awesome-smart-contract-analysis-tools

https://github.com/bkrem/awesome-solidity

https://github.com/smartbugs/repositories


EVM Fuzzing Resources
This repository provides a collection of resources on EVM fuzzing. It is actively maintained by Rappie and regularly updated for relevance.

If you have suggestions regarding the content, feel free to reach out on X or open a GitHub issue.

Table of Contents
Fuzzing Software
Tooling
Practical Code Samples
Reusable Properties
Articles
Videos
Fuzzing Background
Fuzzing Software
Mainstream Fuzzers
Echidna by Trail of Bits
Medusa by Trail of Bits
Foundry by Paradigm
Emerging/Specialized Fuzzers
ItyFuzz by fuzzland
Wake by Ackee
Tooling
Libraries & Frameworks
Chimera - Smart Contract Property-Based Testing Framework, by Recon
Fuzzlib - Solidity Fuzzing Library, by Perimeter
CallTestAndUndo - Simple abstract contract to help write invariant tests that do not influence the story, by Recon
Utils
fuzz-utils - Set of Python tools to improve the developer experience when using smart contract fuzzing, by Trail of Bits
CloudExec - A general purpose foundation for cloud-based fuzzing, by Trail of Bits
echidna-trace-parser - A parser that converts echidna call traces into foundry PoC tests, by Enigma Dark
Echidna Coverage Reporter - A TypeScript tool to parse and analyze Echidna code coverage reports for Solidity smart contracts, by 0xsi
Echidna Logs Scraper - Scrape echidna logs for broken properties repros, by Recon
Practical Code Samples
List of Public Fuzzing Campaigns by Rappie
Property-based testing benchmark by Antonio Viggiano
Solidity Fuzzing Challenge: Foundry vs Echidna vs Medusa (plus Halmos & Certora) by Dacian
Fuzzer Gas Metric Benchmark by Rappie
Reproduction of the $41M Curve reentrancy hacks on July 30 2023 using on-chain fuzzing with Echidna by Rappie
Reproduction of the $80M Rari Finance Hack on April 30 2022 using on-chain fuzzing with Echidna by Rappie
Reusable properties
ERC20 by Trail of Bits
ERC721 by Trail of Bits
ERC4626 by Trail of Bits
ABDKMath64x64 by Trail of Bits
ERC7540 by Recon
Articles
Tutorials & Guides
Echidna Tutorial by Trail of Bits
Medusa Official Documentation by Trail of Bits
Foundry Invariant Testing Official Documentation
Invariant Testing WETH With Foundry by horsefacts
Introduction to fuzzing by bloqarl
Benefits of Fuzzing by Perimeter
Creating Invariant Tests for an AMM Smart Contract by bloqarl
Debugging Echidna Coverage by nican0r
First Day At Invariant School by nican0r
Generating unit tests from broken stateful invariant tests by nican0r & Antonio Viggiano
Finding Denial of Service Bugs At Scale With Invariant Tests by Antonio Viggiano
Using Echidna to test a smart contract library by Trail of Bits
Building A Test Harness With Recon by nican0r
How To Define Invariants by nican0r
Implementing Your First Smart Contract Invariants: A Practical Guide by nican0r
10 Steps To Easily Use 3 Fuzzers by Dacian
Research & Background
Learnings from 6 weeks of fuzzing Badger DAO's eBTC protocol by Antonio Viggiano
A Guide to Crafting Robust Invariants by Web3Sec News & Antonio Viggiano
Certora vs Echidna: a case study on invariant testing in eBTC by nican0r
Uniswap v3: A Fuzzing Review by nican0r
Lessons Learned From Fuzzing Centrifuge Protocol part 1 & part 2 by nican0r
eBTC Retrospective: A reflection on lessons learned in our extended fuzzing of eBTC by nican0r
Lessons From The Fuzzing Trenches by nican0r
Finding Real Vulnerabilities with the Renzo Fuzzing Repo by nican0r
Fuzzing in the Cloud: A review of the different cloud based options for fuzzing Solidity contracts by nican0r
Corn Engagement Retrospective: Lessons learned from our engagement fuzzing the Corn protocol by nican0r
Videos
Tutorials & Guides
Learn how to fuzz like a pro - Fuzzing workshop, by Trail of Bits
Introduction to Fuzzing, Foundry, Echidna & Medusa, by bloqarl
part 1, part 2, part 3, part 4, part 5, part 6
Invariant Testing WETH with Foundry by horsefacts
Invariant Driven Development - Build a CDP system using Invariants as Safety Nets by Alex the Entreprenerd
Talks & Discussion
Web3 Security: All Things Fuzzing with Victor Martinez by vnmrtz.eth
Fuzzing and Heuristics interview with @devdacian, by Cyfrin Audits
Fuzzing Like a Degen: Building a Smart Contract Fuzzer by alpharush
All Things Fuzzing with Victor Martinez by vnmrtz.eth
Advanced Fuzzing Techniques: An eBTC Case Study by Antonio Viggiano
Invariant Testing Workshop by Antonio Viggiano
Euler v2 Fuzzing Workshop by Víctor Martinez by vnmrtz.eth
Size Credit Fuzzing Workshop by Antonio Viggiano
Test your tests The dos and don'ts of testing by phaze
Find Highs Using Invariant Fuzz Testing by Dacian
Submit your first PR to Medusa by Josselin Feist
A glimpse into the future of invariant testing by Alex the Entreprenerd
You should probably be fuzzing by Daniel Von Fange
Echidna Made Me Do It! by Alex the Entreprenerd
Uniswap V4: Taking Invariant Testing Where Manual Review Cannot Go by Benjamin Samuels
Fuzzing Background
The Fuzzing Book - Tools and Techniques for Generating Software Tests, by Multiple Authors
Awesome Fuzzing - A curated list of fuzzing resources for learning Fuzzing, by Mohammed A. Imran
