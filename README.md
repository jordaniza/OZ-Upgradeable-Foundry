# Basic UUPS Proxy

An example of writing and testing an Upgradeable smart contract using the OpenZeppelin UUPS Libraries.

[Here's a more complete walkthrough](https://piedao.notion.site/Upgradeable-Contracts-with-OZ-e1657f19c569475098a4ebf2a08a5d2b) of upgradeable contracts and Transparent vs. UUPS

# Deploying
```sh
forge script Deploy
```

# Testing
```
forge test
```

# Libraries
```sh
forge install foundry-rs/forge-std
forge install OpenZeppelin/openzeppelin-contracts
forge install OpenZeppelin/openzeppelin-contracts-upgradeable
forge install paulrberg/prb-test@0.1.2  

```