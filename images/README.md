# Image Instructions

This directory is for storing architecture diagrams and screenshots for your Inception of Things project.

## Suggested Images to Create

1. `k3s-architecture.png` - Overall K3s architecture
2. `p1-architecture.png` - Part 1 server-worker node setup
3. `p2-architecture.png` - Part 2 application deployment with ingress

## Creating Diagrams

You can create these diagrams using:

- [draw.io](https://app.diagrams.net/) (free, online or desktop)
- [Lucidchart](https://www.lucidchart.com/)
- [Excalidraw](https://excalidraw.com/) (simple, free)

## Example Diagram Content

For `p1-architecture.png`:
```
+----------------+         +----------------+
|                |  token  |                |
|   mbelouarS    +-------->+  mbelouarSW    |
|  K3s Server    |         |   K3s Worker   |
| 192.168.56.110 |         | 192.168.56.111 |
+----------------+         +----------------+
```

For `p2-architecture.png`:
```
                              +-----------------+
                              |                 |
                              |   mbelouarS     |
                              |  K3s Server     |
                              | 192.168.56.110  |
                              |                 |
                              +--------+--------+
                                       |
                      +----------------+----------------+
                      |                |                |
              +-------v------+  +------v-------+  +-----v--------+
              |              |  |              |  |              |
              | app1.com     |  | app2.com     |  | default      |
              | Ingress      |  | Ingress      |  | Ingress      |
              |              |  |              |  |              |
              +-------+------+  +------+-------+  +-----+--------+
                      |                |                |
              +-------v------+  +------v-------+  +-----v--------+
              |              |  |              |  |              |
              | app1-svc     |  | app2-svc     |  | app3-svc     |
              | ClusterIP    |  | ClusterIP    |  | ClusterIP    |
              |              |  |              |  |              |
              +-------+------+  +------+-------+  +-----+--------+
                      |                |                |
              +-------v------+  +------v-------+  +-----v--------+
              |              |  |              |  |              |
              | app1         |  | app2         |  | app3         |
              | Deployment   |  | Deployment   |  | Deployment   |
              |              |  |              |  |              |
              +--------------+  +--------------+  +--------------+
```
