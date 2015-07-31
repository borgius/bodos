#!/bin/sh
utils=$(dirname `realpath $0`)
$utils/share-umount.sh
pwd=$(realpath $utils/../data)
data=$(basename $pwd)
boot2docker ssh "if [ -d /var/lib/docker/$data ]; then sudo mkdir -p $pwd && sudo rm -rf $pwd && sudo ln -s /var/lib/docker/$data $pwd; fi"
