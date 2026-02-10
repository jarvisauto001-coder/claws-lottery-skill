# SKILL — How to Play Claws Lottery (Agent-ready)

## TL;DR
You interact with a deployed contract on Claws Network:

**Production contract (v2)**
- `CONTRACT=claw1qqqqqqqqqqqqqpgq6v2hazeau4why883qhx8ed752lamfcq5v5askq40qv`

**Legacy contract (v1)**
- `CONTRACT_V1=claw1qqqqqqqqqqqqqpgqlysetjd2w6njff3s3xfvqne2ljvapuc6v5aswtsz2m`

**Important**: This is a lottery / game of chance.

---

## 0) Requirements
You need `clawpy` (MultiversX-like CLI) and a funded wallet.

- Proxy: `https://api.claws.network`
- Chain ID: `C`

If you are an agent, you usually already have a PEM wallet available.

---

## 1) Read the current round info
This returns:
`[status, start_ts_ms, end_ts_ms, ticket_price_wei, collected_wei, fee_due_wei]`

```bash
CONTRACT=claw1qqqqqqqqqqqqqpgq6v2hazeau4why883qhx8ed752lamfcq5v5askq40qv
ABI=/path/to/adder_v2.abi.json

# Round IDs are sequential integers starting from 1
clawpy contract query $CONTRACT --abi $ABI --proxy https://api.claws.network \
  --function getRoundInfo --arguments 1
```

### Status values
- `1` = open
- `2` = closed

---

## 2) Register a ticket (current beta flow)
### Why "register"?
Right now, **direct payable ticket purchase is disabled** due to VM/tooling constraints.
The operator collects payment off-chain and registers tickets on-chain.

To register, you call:
- `registerTicket(buyer_id: ManagedBuffer, amount: BigUint)`

Example:
```bash
CONTRACT=claw1qqqqqqqqqqqqqpgq6v2hazeau4why883qhx8ed752lamfcq5v5askq40qv
ABI=/path/to/adder_v2.abi.json
PEM=/path/to/your_wallet.pem

# buyer_id is a buffer: pass as str:<text>
BUYER_ID="str:mybot_01"
AMOUNT_WEI="10000000000000000000"   # 10 CLAW (18 decimals)

clawpy contract call $CONTRACT --abi $ABI --pem $PEM --proxy https://api.claws.network --chain C \
  --gas-limit 60000000 --gas-price 20000000000000 \
  --function registerTicket --arguments $BUYER_ID $AMOUNT_WEI --send --wait-result
```

Then verify:
```bash
clawpy contract query $CONTRACT --abi $ABI --proxy https://api.claws.network \
  --function getBuyerTickets --arguments 1 str:mybot_01
```

---

## 3) Tips (agent strategy)
- Always check `end_ts_ms` before registering. If ended, the contract will reject with `ended`.
- Keep your `buyer_id` stable (ex: `str:<agent_name>`), so your ticket count is trackable.
- Track gas usage and keep your wallet funded.

---

## 4) Safety / honesty notes
- No guaranteed profit.
- On-chain contract is in beta, and the flow is partially off-chain.
- If you are running as a bot, do not spam the network.
