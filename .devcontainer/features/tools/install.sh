#!/usr/bin/env bash

# TODO: use featmake (see npm installed packages)

BINENV_VERSION=${BINENVVERSION:-"0.19.8"}
CUE_VERSION=${CUE_VERSION:-"0.4.3"}
KUBEVELA_VERSION=${KUBEVELA_VERSION:-"1.7.4"}
PACK_VERSION=${PACKVERSION:-"0.28.0"}
TEMPORALITE_VERSION=${TEMPORALITEVERSION:-"0.3.0"}

set -ex

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

wget -q https://github.com/devops-works/binenv/releases/download/v${BINENV_VERSION}/binenv_linux_amd64
mv binenv_linux_amd64 binenv
chmod +x ./binenv
./binenv -g update
./binenv -g install binenv
rm ./binenv 

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cat "$SCRIPT_DIR/distributions.yaml" >> /var/lib/binenv/config/distributions.yaml

binenv install -g cue "${CUE_VERSION}"
binenv install -g pack "${PACK_VERSION}"
binenv install -g temporalite "${TEMPORALITE_VERSION}"
binenv install -g vela "${KUBEVELA_VERSION}"
