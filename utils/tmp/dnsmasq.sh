#!/bin/sh

exit


[ -f "/usr/local/etc/dnsmasq.conf" ] && echo "You should be able to take care of yourself ;-)"
DOCKERHOST=$(boot2docker ip)
echo "listen-address=127.0.0.1
listen-address=192.168.59.3
bind-interfaces
bind-dynamic
except-interface=en*
#resolv-file=/etc/resolv.conf
address=/dev/$DOCKERHOST
" | sudo tee /usr/local/etc/dnsmasq.conf

# cp $(brew list dnsmasq | grep /dnsmasq.conf.example$) /usr/local/etc/dnsmasq.conf
# Copy the daemon configuration file into place.
sudo cp $(brew list dnsmasq | grep /homebrew.mxcl.dnsmasq.plist$) /Library/LaunchDaemons/
# Start Dnsmasq automatically.
sudo launchctl load /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist
launchctl stop homebrew.mxcl.dnsmasq
launchctl start homebrew.mxcl.dnsmasq

sudo mkdir -p /etc/resolver
sudo tee /etc/resolver/dev >/dev/null <<EOF
nameserver 127.0.0.1
EOF


