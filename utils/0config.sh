#!/bin/sh

# Top-level domain
export BODOS_TLD=dev

# Sync type rsync|vbox
export BODOS_SYNC=rsync

alias composer="docker run -i -t -v \$PWD:/srv ubermuda/composer"