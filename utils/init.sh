#!/bin/sh

echo Warning !!! Will be remove all data from containers !!!
echo Ctrl+C to exit. Sleeping 5 sec...
sleep 5

utils=$(dirname `realpath $0`)
source $utils/0config.sh

$utils/boot2docker-up.sh
$utils/docker_rm_all.sh
data=$(realpath $utils/../data)
data_name=$(basename `realpath $utils/..`)
DOCKERHOST=$(boot2docker ip)
boot2docker ssh "sudo rm -rf $data && sudo rm -rf /var/lib/docker/$data_name"
boot2docker ssh "sudo mkdir -p $data && sudo mv $data /var/lib/docker/$data_name && sudo chown -R docker /var/lib/docker/$data_name && sudo ln -s /var/lib/docker/$data_name $data"

echo Sync folder $data
docker-osx-dev sync_only -s $data -l DEBUG

boot2docker ssh "cd $data && pwd && mkdir -p pgsql && mkdir -p logs && mkdir -p www && mkdir -p run"
boot2docker ssh "cd $data/config/dnsmasq.d && echo 'address=/$BODOS_TLD/$DOCKERHOST' > dnsmasq.conf"

$utils/add-resolver.sh