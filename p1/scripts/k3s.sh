#!/bin/bash

# Install K3s server with options to make it accessible from worker node
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--node-ip=192.168.56.110 --bind-address=192.168.56.110 --advertise-address=192.168.56.110 --flannel-iface=eth1" sh -