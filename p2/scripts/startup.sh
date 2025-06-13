#!/bin/bash

curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" INSTALL_K3S_EXEC="--flannel-iface eth1" sh -

kubectl apply -f /vagrant-data/app1.yaml
kubectl apply -f /vagrant-data/app2.yaml
kubectl apply -f /vagrant-data/app3.yaml
kubectl apply -f /vagrant-data/ingress.yaml