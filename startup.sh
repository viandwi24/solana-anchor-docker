#!/bin/sh

# set default env
: "${SOLANA_RPC:=devnet}"

# banner
echo "=== Solana & Anchor Docker ==="

# functions
rae() {
  echo "executing: $@"
  eval "$@"
}

# configure solana
rae "solana config set --url ${SOLANA_RPC}"

# log
echo "Solana rpc url is set to ${SOLANA_RPC}"

# keep container running
tail -f /dev/null