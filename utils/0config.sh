#!/bin/sh

# Top-level domain
export BODOS_TLD=dev
export MACHINE=default
export DOCKERHOST=$(docker-machine ip $MACHINE)
echo $DOCKERHOST

alias composer="docker run -i -t -v \$PWD:/srv ubermuda/composer"