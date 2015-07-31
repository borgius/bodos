#!/bin/sh
image=borgius/$(basename $(pwd))
docker build -t $image .