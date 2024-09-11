# SPDX-FileCopyrightText: 2024 Baking Bad <hello@bakingbad.dev>
#
# SPDX-License-Identifier: MIT

ARG OCTEZ_TAG=master
FROM tezos/tezos-bare:${OCTEZ_TAG} AS octez
USER tezos
WORKDIR /home/tezos
COPY --chown=tezos:tezos init.sh /home/tezos/init.sh
CMD ["/bin/sh", "/home/tezos/init.sh"]
