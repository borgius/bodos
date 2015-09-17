#!/bin/sh
utils=$(dirname `realpath $0`)
source $utils/0config.sh
echo "listen-address=127.0.0.1
listen-address=$DOCKERHOST
bind-interfaces
bind-dynamic
except-interface=en*
resolv-file=/etc/resolv.conf
address=/dev/$DOCKERHOST
" | tee ../data/config/dnsmasq.conf


