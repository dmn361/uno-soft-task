#!/bin/bash

sudo cp ipvlan-setup.service /etc/systemd/system/
sudo chmod +x ipvlan.sh
sudo cp ipvlan.sh  /usr/local/bin
sudo systemctl enable ipvlan-setup.service
sudo systemctl start ipvlan-setup.service

