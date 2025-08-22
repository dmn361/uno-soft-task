#!/bin/bash

sudo ip link add ipv0 link enp0s3 type ipvlan mode l2
sudo ip addr add 192.168.214.199/24 dev ipv0
sudo ip link set ipv0 up
