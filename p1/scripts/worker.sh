#!/bin/bash

K3S_URL="https://192.168.56.110:6443"
K3S_TOKEN=$(cat /vagrant/token/node-token)

curl -sfL https://get.k3s.io | K3S_URL="$K3S_URL" K3S_TOKEN="$K3S_TOKEN" sh -
