# Rekt Room CTF

An open-source Capture The Flag framework for practicing Web3 exploits on local mainnet forks. Challenges are inspired by real DeFi incident patterns, so researchers, auditors and developers can practice attacking them and learn how to defend against them.

Everything runs on a local fork. Nothing here should be sent to mainnet.

## Challenges

| # | Challenge | Vector | Difficulty | Status |
| :--- | :--- | :--- | :--- | :--- |
| 01 | [Oracle Manipulation](./challenges/01-oracle-manipulation) | Spot price / flash loan | Beginner | Available |
| 02 | EIP-7702 Delegation | Wallet authorization | TBD | Planned |
| 03 | Cross-Chain Replay | Bridge / messaging | TBD | Planned |
| 04 | Tokenomics Invariant Break | Incentive logic | TBD | Planned |

**01 - Oracle Manipulation:** a lending protocol prices collateral from a Uniswap V2 spot price. Use a flash loan to skew the pool and drain the protocol.

Challenges 02 to 04 are still being scoped. Descriptions will be added when each one is ready.

## Prerequisites

- [Foundry](https://book.getfoundry.sh/getting-started/installation)
- An Ethereum mainnet RPC URL (Alchemy, Infura or your own node)
- Git

## How to Play

1. Clone the repository:

   ```bash
   git clone https://github.com/Rekt-Room-HQ/ctf.git
   cd ctf
   ```

2. Set your RPC URL:

   ```bash
   export MAINNET_RPC_URL="<your-rpc-url>"
   ```

3. Open a challenge folder and read its README. Each challenge pins a fork block so results are reproducible.

4. Write your exploit in the challenge's test file.

5. Run it:

   ```bash
   forge test --match-path "challenges/01-oracle-manipulation/*" -vvv
   ```

A challenge is solved when its win-condition test passes.

## Rules

- Local forks only. Never send exploit transactions to mainnet.
- Don't post full solutions in public issues. Use spoiler tags or ask in the Telegram group.
- Challenges are inspired by real incidents but simplified. They are not exact replicas, and root causes of recent incidents may still be unconfirmed by the affected teams.

## Contributing

Ideas and new challenges are welcome. Open an issue first to discuss scope, difficulty and the fork block. Credit any public write-ups the challenge is based on.

## License

Add a license file before accepting contributions.
