#!/bin/sh
docker run --name dnsmasq --rm -ti -p 53:53/tcp -p 53:53/udp --cap-add=NET_ADMIN -v $(pwd)/dnsmasq.conf:/etc/dnsmasq.conf andyshinn/dnsmasq
