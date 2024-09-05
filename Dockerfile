ARG OCTEZ_TAG=master
FROM tezos/tezos-bare:${OCTEZ_TAG} AS octez

# RUN apt-get update && apt-get install -y curl tar

WORKDIR /home/tezos
RUN curl -L https://snapshots.eu.tzinit.org/etherlink-ghostnet/wasm-ghostnet.tar.gz -o wasm-ghostnet.tar.gz \
    && mkdir -p .tezos-smart-rollup-node/wasm_2_0_0 \
    && tar -xzf wasm-ghostnet.tar.gz -C .tezos-smart-rollup-node/ \
    && rm wasm-ghostnet.tar.gz

RUN chown -R tezos:tezos /home/tezos/.tezos-smart-rollup-node
USER tezos
CMD ["sh"]
# TODO: enable archive mode
# TODO: download snapshot
# TODO: consider adding DAL

# CMD ["octez-smart-rollup-node", "--endpoint", "https://rpc.tzkt.io/ghostnet", "run", "--mode", "observer", "--rollup", "sr18wx6ezkeRjt1SZSeZ2UQzQN3Uc3YLMLqg", "--pre-images-endpoint", "https://snapshots.eu.tzinit.org/etherlink-ghostnet/wasm_2_0_0", "--history-mode", "archive"]

