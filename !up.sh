#!/bin/sh
base=$(dirname `realpath $0`)
source $base/utils/0config.sh
$base/utils/boot2docker-up.sh
data=$base/data
docker-osx-dev -c false -s $data/www -s $data/config -l WARN &
sync_pid=$!
echo $sync_pid
docker-compose up
kill -9 $(ps ax | grep "docker-osx-dev\|$data/www" | grep -v grep | awk '{ print $1 }')
cd $base