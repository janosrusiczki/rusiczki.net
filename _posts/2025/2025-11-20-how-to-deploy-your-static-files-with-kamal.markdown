---
layout: post
title: How to deploy your static sites with Kamal
date: 2025-11-20 17:35:00 +02:00
categories:
- blog history
- technical
description: A short write-up about how I'm deploying my static sites with Kamal.
---

A while ago I switched [my photo app](https://photos.rusiczki.net)'s deployment process to [Kamal](https://kamal-deploy.org/). This was long overdue because I've been struggling with concurrent Ruby versions and [Passenger](https://www.phusionpassenger.com/) on my previous VPS and, *come on!*, almost everyone was doing containerized deploys for a long time now. However, I was not able to convince myself to learn [Kubernetes](https://kubernetes.io/), not even its [minikube](https://minikube.sigs.k8s.io/docs/) variant so I was very glad when I learned about Kamal. The switchover went smoothly, my problems were solved, and I’ve been happily deploying [Photonia](https://github.com/photonia-io/photonia) to a brand-new [Hetzner](https://www.hetzner.com/) VPS ever since.

However, the rest of my mostly static sites stayed on the old [Scaleway](https://www.scaleway.com/en/) VPS, which remained largely underused while I continued to be billed for it each month. That is until now, when I finally figured out how to deploy these sites with Kamal as well. This article documents the process.

My requirements were:

- many small domains and subdomains (virtual hosts) served by the same container
- a "passthrough" solution, as some of these hosts are serving files which can total in the gigabytes
- automatic management of Let's Encrypt certificates - ain't nobody got time to manage those manually
- the configuration should all be in once place

My web server of choice was [nginx](https://hub.docker.com/_/nginx), specifically the **nginx:alpine** Docker variant, which produces an image of around 20 MB. Nobody can complain about storage with something that tiny, even on free container registry tiers.

One snag I ran into was that Kamal’s proxy requires each site to expose an `/up` endpoint (which is configurable) for health checks. Since these are static sites, we can safely increase the check interval from the default one second to something like 10 minutes. The only catch is that this endpoint needs to exist in every nginx `server { ... }` block. To somewhat avoid repetition, I put together a small nginx configuration snippet (*health-check.conf*) that I can reuse across sites:

```
location /up {
  return 200 "OK\n";
  add_header Content-Type text/plain;
  access_log off;
}
```

The *Dockerfile* is as simple as:

```
FROM nginx:alpine

COPY health-check.conf /etc/nginx/snippets/
COPY vhosts/*.conf /etc/nginx/conf.d/

EXPOSE 80
```

In the vhosts directory I have files like (*vhosts/rusiczki.net.conf*):

```
server {
  listen 80;
  server_name rusiczki.net;
  return 301 https://www.rusiczki.net$request_uri;
}

server {
  listen 80;
  server_name www.rusiczki.net;
  root /var/www/rusiczki.net;
  index index.html;

  include /etc/nginx/snippets/health-check.conf;
}
```

Or, even simpler (*vhosts/clicktrackheart.com.conf*):

```
server {
  listen 80;
  server_name clicktrackheart.com www.clicktrackheart.com;
  root /var/www/clicktrackheart.com;
  index index.html;

  include /etc/nginx/snippets/health-check.conf;
}
```

Note the way these virtual host definitions include the health check snippet. And finally let's see the *config/deploy.yml* file:

```
service: nginx-sites

image: <YOUR_REGISTRY_USERNAME>/nginx-sites

servers:
  web:
    - <YOUR_SERVERS_IP>

proxy:
  ssl: true
  healthcheck:
    interval: 600
  hosts:
    - clicktrackheart.com
    - www.clicktrackheart.com
    - rusiczki.net
    - www.rusiczki.net

registry:
  username: <YOUR_DOCKER_REGISTRY_USERNAME>
  password:
    - REGISTRY_PASSWORD

builder:
  arch: amd64

volumes:
  - "/var/www:/var/www"

```

This assumes that the sites reside on the host machine in the /var/www directory and that `REGISTRY_PASSWORD` is pulled from a *.kamal/secrets* file which can be as simple as:

```
REGISTRY_PASSWORD=$REGISTRY_PASSWORD
```

This way the (Docker) registry password can be defined by the environment of the machine from which you'll be issuing your `kamal deploy` commands.

Make sure the DNS records already point to the new IP when running `kamal deploy` otherwise it won't be able to request SSL certificates for your virtual hosts.

Tip: If you want to have a default site, make its filename something like *vhosts/00-default.conf* - it is important to be the first one it loads. Then you can define sites in the *config/deploy.yml* file alone (without the associated vhosts file) and their contents will be whatever is defined in *00-default.conf*.
