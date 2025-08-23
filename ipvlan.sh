#!/bin/bash

sudo ip link add ipv0 link enp0s3 type ipvlan mode l2
sudo ip addr add 192.168.1.199/24 dev ipv0
sudo ip link set ipv0 up
sudo ip route add 192.168.100.200/32 dev ipv0
