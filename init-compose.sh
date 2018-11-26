#!/bin/bash
# install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

cat /etc/sysctl.conf | grep -v "vm.max_map_count" > /tmp/system_sysctl.conf

echo "vm.max_map_count=262144" >> /tmp/system_sysctl.conf

mv /tmp/system_sysctl.conf /etc/sysctl.conf

sudo sysctl -w vm.max_map_count=262144

sudo sysctl -a|grep vm.max_map_count

mkdir -p elasticsearch

echo "==== build successed! ===="
