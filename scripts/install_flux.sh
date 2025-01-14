#!/bin/sh -e

rm -rf /tmp/flux && mkdir /tmp/flux && (cd /tmp/flux && \
    curl -LO https://github.com/fluxcd/flux2/releases/download/v2.4.0/flux_2.4.0_linux_amd64.tar.gz && \
    tar -xf flux_*_linux_amd64.tar.gz && \
    mv flux /usr/local/bin/flux && \
    flux --version) && \
    rm -rf /tmp/flux
