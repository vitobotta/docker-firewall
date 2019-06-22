# docker-firewall

This is a simple container that adds iptables rules to the host in a custom chain, in order to open some ports to the public and/or allow any connection from given IPs. This is useful for example with RancherOS, where just about everything runs as a container. When the container is stopped, the chain is removed.

## Usage

```
docker run --name firewall --env OPEN_PORTS="22,80,443" --env ACCEPT_ALL_FROM="ip1,ip2" --env CHAIN="DOCKER-FIREWALL" -itd --restart=always --cap-add=NET_ADMIN --net=host vitobotta/docker-firewall:0.1.0
```
