#!/bin/sh
data=$(realpath "`dirname $0`/../../data")
echo $data
docker run -ti -e "PGDATA=/data/pgsql" -e "POSTGRES_USER=dbdev" -e "POSTGRES_PASSWORD=devdbpassword" -e "POSTGRES_DB=mydb" -p 5432:5432 -v $data:/data borgius/pgsql sh