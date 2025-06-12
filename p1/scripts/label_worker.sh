#!/bin/bash

# Wait for the worker node to be ready
echo "Waiting for worker node to join the cluster..."
until kubectl get node mbelouarSW &>/dev/null; do
  sleep 5
done

# Label the worker node
echo "Labeling worker node..."
kubectl label node mbelouarSW node-role.kubernetes.io/worker=worker

echo "Worker node labeled successfully"