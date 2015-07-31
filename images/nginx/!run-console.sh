#!/bin/sh
image=borgius/$(basename $(pwd))
docker run --rm -ti $image sh