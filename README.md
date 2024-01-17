## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
### TokenSales
```shell
$ clone the git repo --git clone repo address
$ run basic installation of foundry --curl -L https://foundry.paradigm.xyz | bash then run foundryup
$ run  
forge test -vvv --match-path test/TokenSales.t.sol
$ Under the TokenSales, there is Token.sol file that defines the token to be used
$ All test are done base on the document but i could not find time to conclude as i am yet to round up the logic
```javascript

   (bool success, ) = contributor.send(contributionAmount)(
      abi.encodeWithSignature("contributeToPresale(uint256)", contributionAmount)```
$ The time didnt allow me to finish
$ run
forge test -vvv --match-path test/Election.t.sol
$ Yet to aply the register user but all test passed and compiled 
$ Do comment out the //election.vote(candidateId); when uncommented the test will fail.
$ when election.vote(candidateId); made to run the test will fail because the user is double voting
forge test -vvv --match-path test/Token.t.sol
$ this will run the basic implementation of the code
forge test -vvv --match-path test/TokenSwap.t.sol
$ code done and still implementing test, but i have an issue base on the implementation of openzeppelin which i have not resolved and today is my day 5 and i must submit immediately this is 11:pm
```# supra
