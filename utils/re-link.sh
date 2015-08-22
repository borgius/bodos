#!/bin/sh
utils=$(dirname `realpath $0`)
$utils/share-umount.sh

data=$(realpath $utils/../data)
data_name=$(basename `realpath $utils/..`)

boot2docker ssh "sudo [ ! -L $data ] && sudo rm -rf $data"
boot2docker ssh "sudo chown -R docker /var/lib/docker/data/$data_name && sudo ln -s /var/lib/docker/data/$data_name $data"


