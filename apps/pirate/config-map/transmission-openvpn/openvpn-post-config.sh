#!/bin/bash -xe

echo 'pull-filter ignore "ifconfig-ipv6 "' >> "$1"
echo 'pull-filter ignore "route-ipv6 "' >> "$1"
