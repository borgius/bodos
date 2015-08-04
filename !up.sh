#!/bin/sh
cmd=${1:-up --no-recreate}
base=$(dirname `realpath $0`)
source $base/utils/0config.sh
$base/utils/boot2docker-up.sh
data=$base/data
docker-osx-dev -c false -s $data/www -s $data/config -l DEBUG &
sync_pid=$!
echo $sync_pid
echo docker-compose $cmd $2 $3 $4 $5
#$base/utils/docker_rm_all.sh
$(boot2docker shellinit 2> /dev/null)
docker-compose $cmd $2 $3 $4 $5
kill -9 $(ps ax | grep "docker-osx-dev\|$data/www" | grep -v grep | awk '{ print $1 }') 2 > /dev/null
cd $base