#!/bin/bash

curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" INSTALL_K3S_EXEC="--flannel-iface eth1" sh -

sleep 10

kubectl apply -f /vagrant-data/app1.yaml
kubectl apply -f /vagrant-data/app2.yaml
kubectl apply -f /vagrant-data/app3.yaml

kubectl expose deployment app1-deployment \
  --type=ClusterIP \
  --name=app1-svc \
  --port=80 \
  --target-port=5678

kubectl expose deployment app2-deployment \
  --type=ClusterIP \
  --name=app2-svc \
  --port=80 \
  --target-port=5678

kubectl expose deployment app3-deployment \
  --type=ClusterIP \
  --name=app3-svc \
  --port=80 \
  --target-port=5678

sleep 5

kubectl apply -f /vagrant-data/ingress.yaml