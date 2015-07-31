#!/bin/sh
name=$(basename $(pwd))
image=borgius/$name
echo docker stop $image
docker stop $(docker ps --filter=[image=$image] -q)
echo docker rm
docker rm $(docker ps --filter=[image=$image] -q -a)
echo docker run $image
docker run --name=$name -d -v /home/me/www:/var/www -p 80:80 $image