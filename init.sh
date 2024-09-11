#!/bin/bash

# SPDX-FileCopyrightText: 2024 Baking Bad <hello@bakingbad.dev>
#
# SPDX-License-Identifier: MIT

WASM_GHOSTNET_SNAPSHOT=${WASM_GHOSTNET_SNAPSHOT:-"https://snapshots.eu.tzinit.org/etherlink-ghostnet/wasm-ghostnet.tar.gz"}
ETH_GHOSTNET_SNAPSHOT=${ETH_GHOSTNET_SNAPSHOT:-"https://snapshots.eu.tzinit.org/etherlink-ghostnet/eth-ghostnet.archive"}
OCTEZ_RPC_NODE=${OCTEZ_RPC_NODE:-"https://rpc.tzkt.io/ghostnet"}
ROLLUP_ADDRESS=${ROLLUP_ADDRESS:-"sr18wx6ezkeRjt1SZSeZ2UQzQN3Uc3YLMLqg"}

mkdir -p /home/tezos/.tezos-smart-rollup-node
if [ ! -f "/home/tezos/.tezos-smart-rollup-node/is_imported" ]; then
    echo "Downloading and extracting WASM snapshot..."
    curl -L $WASM_GHOSTNET_SNAPSHOT -o wasm-ghostnet.tar.gz
    tar -xzf wasm-ghostnet.tar.gz -C /home/tezos/.tezos-smart-rollup-node/
    rm wasm-ghostnet.tar.gz

    # echo "Downloading and importing Etherlink snapshot..."
    # curl -L $ETH_GHOSTNET_SNAPSHOT -o eth-ghostnet.archive
    # octez-smart-rollup-node --endpoint $OCTEZ_RPC_NODE snapshot import eth-ghostnet.archive --data-dir /home/tezos/.tezos-smart-rollup-node
    # rm eth-ghostnet.archive

    touch /home/tezos/.tezos-smart-rollup-node/is_imported
else
    echo "Snapshot already imported. Skipping download."
fi

exec octez-smart-rollup-node --endpoint $OCTEZ_RPC_NODE run --mode observer --rollup $ROLLUP_ADDRESS --history-mode archive --rpc-addr 0.0.0.0 --cors-origins * --cors-headers *
