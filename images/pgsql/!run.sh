#!/bin/sh
data=$(realpath "`dirname $0`/../../data")
echo $data
boot2docker ssh ls -l $data/..
docker run -e "PGDATA=/data/pgsql" -e "POSTGRES_USER=me" -e "POSTGRES_PASSWORD=password" -e "POSTGRES_DB=mydb" -p 5432:5432 -v $data:/data borgius/pgsql