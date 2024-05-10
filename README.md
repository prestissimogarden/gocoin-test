# Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a Hardhat Ignition module that deploys that contract.

Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat ignition deploy ./ignition/modules/GOCoin.js
```

Open the hardhat terminal:

```shell
npx hardhat console --network localhost
```

Create an object to interact with the contract:

```shell
const gocoin = await (await ethers.getContractFactory("GOCoin")).attach("0x5fbdb2315678afecb367f032d93f642f64180aa3")
```

Now you can call any contract method from the CLI (The use of await is to [avoid receiving a Promise](https://ethereum.stackexchange.com/questions/93657/how-to-interact-with-the-functions-of-my-smart-contract-in-hardhat))

```shell
await gocoin.method()
```
