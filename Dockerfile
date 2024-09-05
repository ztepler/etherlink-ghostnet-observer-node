# SPDX-FileCopyrightText: 2024 Baking Bad <hello@bakingbad.dev>
#
# SPDX-License-Identifier: MIT

ARG OCTEZ_TAG=master
FROM tezos/tezos-bare:${OCTEZ_TAG} AS octez
# RUN apk update && apk add --no-cache curl tar
COPY init.sh /home/tezos/init.sh
WORKDIR /home/tezos
# RUN chown -R tezos:tezos /home/tezos
USER tezos
CMD ["/bin/sh", "/home/tezos/init.sh"]
