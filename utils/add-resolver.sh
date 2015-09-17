#!/bin/sh
utils=$(dirname `realpath $0`)
source $utils/0config.sh

function add_resolver {
    echo Add resolver for TLD *.$BODOS_TLD
    echo /etc/resolver/$BODOS_TLD:
    echo nameserver $DOCKERHOST
    sudo mkdir -p /etc/resolver
    sudo tee /etc/resolver/$BODOS_TLD >/dev/null <<EOF
nameserver $DOCKERHOST
EOF
}



if [ ! -e "/etc/resolver/$BODOS_TLD" ] ;
then
  add_resolver
else
    if grep -v -q "$DOCKERHOST" /etc/resolver/$BODOS_TLD ;
    then
    add_resolver
    fi
fi


