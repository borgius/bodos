#!/bin/sh
cmd=${1:-up --no-recreate}
base=$(dirname `realpath $0`)
source $base/utils/0config.sh
$base/utils/docker_rm_all.sh
echo docker-compose $cmd $2 $3 $4 $5
docker-compose $cmd $2 $3 $4 $5
cd $base