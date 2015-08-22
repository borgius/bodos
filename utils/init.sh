#!/bin/sh

echo Warning !!! Will be remove all data from containers !!!
echo Ctrl+C to exit. Sleeping 5 sec...
#sleep 5

utils=$(dirname `realpath $0`)
source $utils/0config.sh
boot2docker shellinit >$utils/shellinit.sh 2> /dev/null
source $utils/shellinit.sh

$utils/boot2docker-up.sh
$utils/docker_rm_all.sh 2> /dev/null
data=$(realpath $utils/../data)
data_name=$(basename `realpath $utils/..`)
DOCKERHOST=$(boot2docker ip)

if [ $BODOS_SYNC=="rsync" ]; then 
    boot2docker ssh "sudo rm -rf $data
    boot2docker ssh "sudo mkdir -p $data && sudo chown -R docker $data && sudo mkdir -p /var/lib/docker/data"
    boot2docker ssh "sudo mv $data /var/lib/docker/data/$data_name && sudo chown -R docker /var/lib/docker/data/$data_name && sudo ln -s /var/lib/docker/data/$data_name $data"

    echo Sync folder $data
    docker-osx-dev sync_only -s $data/www -s $data/config -l WARN

    boot2docker ssh "cd $data && pwd && mkdir -p pgsql && mkdir -p mysql && mkdir -p logs && mkdir -p www && mkdir -p run && mkdir -p config"
    boot2docker ssh "cd $data/config/dnsmasq.d && echo 'address=/$BODOS_TLD/$DOCKERHOST' > dnsmasq.conf"
else

fi

$utils/add-resolver.sh