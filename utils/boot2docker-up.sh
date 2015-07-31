#!/bin/bash
utils=$(dirname `realpath $0`)
source $utils/0config.sh
up="$(boot2docker status)"
if [ "${up}" != "running" ]; then
    boot2docker --vbox-share=disable up
    $utils/re-link.sh
fi
$(boot2docker shellinit 2> /dev/null)

