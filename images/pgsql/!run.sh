#!/bin/sh
data=$(realpath "`dirname $0`/../../data")
docker run -e "PGDATA=/data/pgsql" -e "POSTGRES_PASSWORD=secret" -v $data:/data borgius/pgsql