# 🏋️ NFT-Powered Gym Subscriptions  
**Blockchain and Distributed Ledger Technologies – Final Project**  
Politecnico di Milano  

## 📌 Project Overview  
This project explores **new use cases for Blockchain technology**, testing its readiness for **real-world B2C adoption**.  

We implemented a proof-of-concept where **gym subscriptions are represented as NFTs**, making them transferable, transparent, and programmable.  

---

## 🚀 The Use Case  
Traditional gym subscriptions are **rigid**:  
- Customers cannot easily resell subscriptions.  
- Businesses have little transparency on transfers.  

**Our solution:** implement gym subscriptions as NFTs.  
- Customers can **buy, use, and resell** subscriptions.  
- Businesses earn fees and maintain transparency.  
- Blockchain ensures **trustless and programmable** operations.  

---

## ⚠️ Challenges & Solutions  

### 1. Unlimited Reselling Loophole  
- ❌ Problem: Groups could share one NFT by constant reselling.  
- ✅ Solution: Each transfer incurs a **fee equal to one day of subscription**.  

### 2. Wallet Sharing Hack  
- ❌ Problem: Users could share wallet credentials to bypass fees.  
- ✅ Solution: Minimal **off-chain profile data** stored in the gym backend to mitigate abuse while keeping blockchain pseudonymity.  

---

## 🛠️ System Designs  

### System 1: Beginner-Friendly  
- Customers pay in **FIAT**.  
- A **mobile app** manages wallets and subscriptions.  
- Admins handle customer onboarding.  

### System 2: Crypto-Savvy  
- Direct interaction with the **Gym.sol smart contract**.  
- On-chain subscription reselling and expiration checks.  
- Subscription metadata stored fully on-chain.  

---

## 🧑‍💻 Adopted Technologies  

- **Smart Contracts**: Implemented in **Solidity**, deployed on the **Sepolia Ethereum Testnet**.  
- **Frontend & Mobile**: Built with **Flutter** using the **Dart** programming language for cross-platform mobile interaction.  
- **Blockchain Integration**:  
  - **Etherscan** for smart contract verification and transaction inspection.  
  - **OpenSea** for exploring NFT interactions on the testnet.  
- **Libraries**: **OpenZeppelin** used as the foundation for secure and reliable smart contract development.  

---

## 📱 Features  
- NFT subscription ownership and transfer.  
- Smart contract (`Gym.sol`) handling minting, reselling, expiration, withdrawal.  
- Mobile app integration for System 1.  

---

## 💡 Learnings  
- Blockchain dev is **fast-moving but fragmented**.  
- **OpenZeppelin libraries** provided reliable foundations.  
- Potential beyond gyms: **luxury, gaming, digital goods**.  

---

## 👥 Contributors  
- **Andrea Prati** –  Smart contract development for System 1, mobile application.  
- **Simone Buranti** – Business use case design, technical system design and implementation for System 2.  
