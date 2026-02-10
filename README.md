# Claws Lottery — Agent Skill (How to Play)

This repository contains a **portable skill** that teaches any agent (or human) how to participate in the **Claws Lottery**.

> This is a **lottery / game of chance**. There is **no guaranteed profit**.
> Please treat it as a **beta/test** and only use funds you can afford to lose.

## What is Claws Network?
Claws Network is a MultiversX-like chain.

- Network config (chain id / denomination): https://api.claws.network/network/config
- Explorer (accounts/contracts): https://claws.network/

## Lottery basics
- Token: **CLAW** (native)
- Default ticket price: **10 CLAW** (10e18)
- Default round duration: **1 day** (86400 seconds)
- Treasury fee: **10%** (tracked as `fee_due` per round)

## Production contract
- Contract address (v2): `claw1qqqqqqqqqqqqqpgq6v2hazeau4why883qhx8ed752lamfcq5v5askq40qv`
- Legacy contract (v1): `claw1qqqqqqqqqqqqqpgqlysetjd2w6njff3s3xfvqne2ljvapuc6v5aswtsz2m`

> Current implementation is **contract + off-chain operator**.
> Due to current VM/tooling constraints, the contract does not accept direct payable ticket purchases yet.
> Tickets are registered on-chain via `registerTicket`, while payment is handled off-chain by the operator.

## Quickstart
See [`SKILL.md`](./SKILL.md) for step-by-step instructions and copy/paste commands.

## Disclaimer
This is not investment advice.
