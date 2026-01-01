# Scaffold-ETH 2

## Requirements

Before you begin, you need to install the following tools:

- [Node (>= v20.18.3)](https://nodejs.org/en/download/)
- Yarn ([v1](https://classic.yarnpkg.com/en/docs/install/) or [v2+](https://yarnpkg.com/getting-started/install))
- [Git](https://git-scm.com/downloads)

# Challenge 2: Token Vendor

This repo is a **Yarn workspaces monorepo**:

- `packages/hardhat`: smart contracts + local chain + deploy scripts
- `packages/nextjs`: the frontend (Next.js App Router)

### Step 1: Install dependencies

From the repo root:

```bash
yarn install
```

### Step 2: Start a local blockchain

In terminal A:

```bash
yarn chain
```

### Step 3: Deploy contracts to the local chain

In terminal B:

```bash
yarn deploy
```

### Step 4: Start the frontend

In terminal C:

```bash
yarn start
```

And open: `http://localhost:3000/`

### Step 5: Common dev loop

- Read contract: `packages\hardhat\contracts\DiceGame.sol` for random algorithm.
- Edit contract: `packages\hardhat\contracts\RiggedRoll.sol` for random prediction.
- Edit UI pages: `packages\nextjs\app\dice\page.tsx`, `packages\hardhat\deploy\01_deploy_riggedRoll.ts`

- Re-deploy: 

```bash
yarn deploy --reset
```

- Refresh the UI pages above and interact with the contract

### Step 6: Run tests

```bash
yarn test
```

### Step 7: Deploy to a public network

- After test completion, deploy to a public network (such as Sepolia):
```bash
yarn deploy --network sepolia
```

### Step 8: Verification

```bash
yarn verify --network sepolia
```