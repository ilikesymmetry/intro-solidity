# Introduction to Solidity

## Installation

Install `foundryup`
```
curl -L https://foundry.paradigm.xyz | bash
```

Install foundry toolchain (`forge`, `cast`, `anvil`, `chisel`)
```
foundryup
```

## Build

Compile contracts to surface build issues.
```
forge build
```

## Deploy

Create a CLI account
```
cast wallet new
```

Encrypt this CLI account and store within foundry
```
cast wallet import dev --private-key [generated]
```

Send testnet ETH to your CLI account

Run deploy script and verify contracts
```
forge script Deploy --rpc-url "https://sepolia.base.org" --account dev --sender [CLI account address]  --broadcast -vvvv --verify --verifier-url "https://api-sepolia.basescan.org/api" --etherscan-api-key $BASESCAN_API_KEY
```

> Note: Etherscan seems to incorrectly give an error message `"Invalid API Key"` when deploying this exact Attendance contract.
