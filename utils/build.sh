#!/bin/bash
utils=$(dirname `realpath $0`)
$utils/docker_rm_all.sh
cd $utils/..
cd images/data  && ./!build.sh && cd ../..
cd images/php   && ./!build.sh && cd ../..
cd images/nginx && ./!build.sh && cd ../..
cd images/pgsql && ./!build.sh && cd ../..
