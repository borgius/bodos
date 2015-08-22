#!/bin/sh
$(boot2docker shellinit)
docker build -t borgius/php .