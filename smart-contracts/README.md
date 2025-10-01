# 🔗 System 2 – Direct Blockchain Interaction  
**Part of NFT-Powered Gym Subscriptions**  

## 📌 Overview  
System 2 explores a **crypto-native approach** to gym subscriptions.  
Here, customers interact **directly with the Gym.sol smart contract**, without intermediaries or mobile apps.  

This system represents a **long-term solution** for blockchain-savvy customers.  

---

## ⚙️ System 2 Features  
- Direct purchase of subscriptions with crypto.  
- Customers can **resell subscriptions on-chain** via Gym.sol.  
- Metadata stored **fully on-chain**:  
  - Subscription expiration.  
  - Reselling value (scaled to remaining validity).  
  - Transfer rules.  
- Smart contract owner can **withdraw collected balances**.  

---

## 🔄 Dynamics of Interactions  

1. **Minting**  
   - A user buys a new subscription.  
   - The smart contract issues an NFT with metadata (validity period, expiration).  

2. **Reselling**  
   - A customer lists their subscription for resale.  
   - Another customer buys it at a **reduced price** based on remaining days.  
   - Smart contract enforces **transfer fees** to avoid abuse.  

3. **Expiration**  
   - Each token has a hardcoded expiration date.  
   - The smart contract checks validity on every interaction.  

4. **Withdrawal**  
   - Only the contract owner can withdraw the accumulated ETH from transactions.  

---

## 🛡️ Design Considerations  
- **Transparency:** All transfers and expirations are publicly verifiable.  
- **Security:** Fees discourage exploitative behavior.  
- **Flexibility:** Customers can freely buy, use, and resell.  
- **On-chain First:** Metadata stored on-chain for maximum trustlessness.  

---

## 📝 Key Smart Contract Functions  
- `mint()` → Issues new NFT subscription.  
- `resell()` → Allows subscription resale with reduced price & fees.  
- `checkExpiration()` → Validates subscription before use.  
- `withdraw()` → Owner-only, collects contract balance.  

---

## 💡 Insights from Development  
- On-chain systems are powerful but **require strong anti-abuse measures**.  
- The balance between **usability and decentralization** is delicate.  
- This architecture could extend to other **subscription-based industries**.  
