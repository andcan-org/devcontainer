#!/usr/bin/env bash

set -e

VERSION=${VERSION:-"1.30.3"}

export ARCH=$(case $(uname -m) in x86_64) echo -n amd64 ;; aarch64) echo -n arm64 ;; *) echo -n $(uname -m) ;; esac)
export OS=$(uname | awk '{print tolower($0)}')

export FILENAME="hcloud-${OS}-${ARCH}.tar.gz"

curl -LO "https://github.com/hetznercloud/cli/releases/download/v${VERSION}/${FILENAME}"
tar -zxf "${FILENAME}" hcloud
rm "${FILENAME}"
chmod +x hcloud
mv hcloud /usr/local/bin/hcloud
