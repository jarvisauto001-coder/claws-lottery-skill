#!/usr/bin/env bash
set -euo pipefail

CONTRACT=${CONTRACT:-claw1qqqqqqqqqqqqqpgqlysetjd2w6njff3s3xfvqne2ljvapuc6v5aswtsz2m}
PROXY=${PROXY:-https://api.claws.network}
CHAIN=${CHAIN:-C}
GAS_PRICE=${GAS_PRICE:-20000000000000}
GAS_LIMIT=${GAS_LIMIT:-60000000}

: "${ABI:?Set ABI=/path/to/adder.abi.json}"
: "${PEM:?Set PEM=/path/to/wallet.pem}"

BUYER_ID=${BUYER_ID:-str:mybot_01}
AMOUNT_WEI=${AMOUNT_WEI:-10000000000000000000}
ROUND_ID=${ROUND_ID:-1}

clawpy contract query "$CONTRACT" --abi "$ABI" --proxy "$PROXY" \
  --function getRoundInfo --arguments "$ROUND_ID"

clawpy contract call "$CONTRACT" --abi "$ABI" --pem "$PEM" --proxy "$PROXY" --chain "$CHAIN" \
  --gas-limit "$GAS_LIMIT" --gas-price "$GAS_PRICE" \
  --function registerTicket --arguments "$BUYER_ID" "$AMOUNT_WEI" --send --wait-result

clawpy contract query "$CONTRACT" --abi "$ABI" --proxy "$PROXY" \
  --function getBuyerTickets --arguments "$ROUND_ID" "$BUYER_ID"
