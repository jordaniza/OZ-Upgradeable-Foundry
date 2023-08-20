# Basic UUPS Proxy

An example of writing and testing an Upgradeable smart contract using the OpenZeppelin UUPS and Transparent Libraries.

[Here's a more complete walkthrough](https://jordaniza.com/posts/upgradeable-contracts) of upgradeable contracts and Transparent vs. UUPS

# Deploying
```sh
# this runs the deploy script on a local network, to run for real you'll need to broadcast. 
# See forge scripting for more info.
forge script DeployUUPS
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
