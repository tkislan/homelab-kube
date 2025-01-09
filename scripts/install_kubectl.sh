#!/bin/sh -e

rm -rf /tmp/kubectl && mkdir /tmp/kubectl && (cd /tmp/kubectl && \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.30.0/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl && \
    kubectl version --client) && \
    rm -rf /tmp/kubectl
