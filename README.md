# WebSockets Proxy on Google

A [Google Cloud](https://cloud.google.com) install of [Benjamin Burns' WebSockets Proxy](https://github.com/benjamincburns/websockproxy).

<!-- @todo: Do an automated deploy to Google:

[![Run on Google Cloud](https://deploy.cloud.run/button.svg)](https://deploy.cloud.run/)-->

## Build and Run Locally

Install [Docker](https://docs.docker.com).

```bash
docker build -t wsproxy/v1 .
```

```bash
docker run --privileged -p 8080:80 -e PORT=80 -it wsproxy/v1
```

Browse to [ws://localhost:8080/](ws://localhost:8080/)

## Deploy to Google Cloud

Install the [Cloud SDK](https://cloud.google.com/sdk/docs/quickstart).

[Deploy the Docker container.](https://cloud.google.com/compute/docs/containers/deploying-containers) Note that the container must [run in privileged mode.](https://cloud.google.com/compute/docs/containers/configuring-options-to-run-containers#running_a_container_in_privileged_mode)

***

# WebSockets Proxy

A websocket ethernet switch built using Tornado in Python. Implements crude rate limiting on WebSocket connections to prevent abuse. Could use some cleanup!

## How it works

The program starts off by creating a TAP device and listening
for websocket connections on port 80. When clients connect, ethernet frames
received via the websocket are switched between connected clients and the TAP
device. All communication is done via raw ethernet frames.

To use this in support of a virtual network you must set up the host system as
a DHCP server and router.

SSL support is not included. To enable SSL, please use a reverse proxy with SSL
and websockets support, such as nginx.

The Docker image will set up a fully contained router environment using IPTables for basic NAT functionality and dnsmasq for DHCP support.

Note that the container must be run in priviliged mode so that it can create
its TAP device and set up IPv4 masquerading.

For better security be sure to set up an Nginx reverse proxy with SSL support
along with a more isolated docker bridge and some host-side firewall rules
which prevent clients of your relay from attempting to connect to your host
machine.
