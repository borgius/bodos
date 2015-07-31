#!/bin/sh
name=$(basename $(pwd))
docker exec -ti $name bash -l