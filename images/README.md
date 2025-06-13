# Project Diagrams

This directory contains images for the Inception of Things project:

- `Inceptionofthings.png` - Project banner image

## Architecture Overview

### Part 1: K3s Cluster

- Server node (`mbelouarS`): 192.168.56.110
- Worker node (`mbelouarSW`): 192.168.56.111
- Connection: Secure token exchange for cluster formation

### Part 2: Application Deployment

- Single server node: 192.168.56.110
- Three applications with Ingress routing:
  - app1.com → app1-svc → app1-deployment
  - app2.com → app2-svc → app2-deployment
  - Default → app3-svc → app3-deployment
