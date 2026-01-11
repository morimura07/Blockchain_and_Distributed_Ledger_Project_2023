# NFT-Based Gym Subscription Platform

## Overview

This project is a proof-of-concept application that demonstrates how gym memberships can be managed using NFTs on Ethereum-compatible blockchains.

Each gym subscription is represented as an NFT with:

* A fixed validity period
* On-chain expiration logic
* Optional resale with fees
* Wallet-based ownership

The system consists of:

* Smart contracts written in Solidity
* A Flutter mobile application for user interaction

This project is intended for educational and prototype purposes. It is **not production-ready** without further security hardening and testing.

---

## Features

### Smart Contracts

* ERC721-based NFT subscriptions
* Time-based expiration logic
* Minting control
* Resale fee mechanism
* On-chain metadata
* OpenZeppelin-based architecture

### Mobile Application (Flutter)

* Wallet interaction
* Minting and viewing subscriptions
* Subscription status display
* Basic blockchain interaction via RPC

---

## Project Structure

```
.
├── smart-contracts/
│   ├── contracts/
│   │   └── Gym.sol
│   ├── scripts/
│   ├── test/
│   └── README.md
│
├── flutter/
│   └── gym_app/
│       ├── lib/
│       │   ├── components/
│       │   ├── screens/
│       │   ├── view_models/
│       │   └── view_model_smart_contracts/
│       ├── pubspec.yaml
│       └── README.md
│
└── README.md
```

---

## Smart Contracts

### Main Contract

* `Gym.sol`

### Key Responsibilities

* Minting subscription NFTs
* Tracking expiration dates
* Preventing or restricting transfers
* Applying resale fees
* Ownership and admin control

### Notes

* Built using Solidity `^0.8.x`
* Uses OpenZeppelin ERC721 and Ownable contracts
* Expiration checks are handled on-chain
* Transfer functionality is intentionally restricted

---

## Flutter Application

### Responsibilities

* Connect to blockchain RPC
* Interact with the Gym smart contract
* Display subscription status
* Trigger minting and user actions

### Current Limitations

* Private key handling is not production-safe
* Error handling is minimal
* Network configuration is hardcoded
* No wallet connector (WalletConnect, MetaMask, etc.)

---

## Installation

### Smart Contracts

1. Install dependencies:

```bash
npm install
```

2. Compile contracts:

```bash
npx hardhat compile
```

3. Deploy to local or test network:

```bash
npx hardhat run scripts/deploy.js --network localhost
```

---

### Flutter App

1. Install Flutter (SDK 2.18.x or higher)
2. Navigate to the Flutter project:

```bash
cd flutter/gym_app
```

3. Install dependencies:

```bash
flutter pub get
```

4. Run the app:

```bash
flutter run
```

---

## Configuration

### Blockchain Network

* RPC URLs are currently hardcoded
* Supports local networks (Ganache / Hardhat)
* Should be replaced with environment-based configuration for real use

### Private Keys

* **Do not hardcode private keys**
* Use secure storage or external wallets
* This project currently uses placeholders for demonstration only

---

## Security Considerations

This project contains known security and architectural limitations:

* Hardcoded private keys (must be removed)
* No rate limiting on minting
* No bot protection
* No comprehensive input validation
* Unbounded loops in expiration checks
* No smart contract tests

**Do not deploy to mainnet without:**

* Removing private keys from source
* Adding access controls
* Writing unit and integration tests
* Performing a security audit

---

## Testing

Testing is not currently implemented.

Recommended additions:

* Smart contract unit tests (Hardhat / Foundry)
* Expiration edge case tests
* Minting and transfer restriction tests
* Flutter integration tests

---

## Intended Use

This project is suitable for:

* Academic demonstrations
* Blockchain learning
* NFT subscription experiments
* Portfolio or prototype work

It is **not intended for production use** without significant additional work.

---

## Future Improvements

* WalletConnect or MetaMask integration
* Secure key management
* Off-chain indexing for expiration tracking
* Pagination for large datasets
* Improved UI/UX
* Multi-network support
* Comprehensive test coverage

---

## License

MIT License

---
