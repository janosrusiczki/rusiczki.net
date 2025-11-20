A while ago I switched [my photo app](https://photos.rusiczki.net)'s deployment to [Kamal](https://kamal-deploy.org/). This was long needed because I started struggling with Ruby versions and [Passenger](https://www.phusionpassenger.com/) on my previous server and, *come on!*, almost everyone was doing containerized deploys for a long time now. However, I was not able to convince myself to learn [Kubernetes](https://kubernetes.io/), not even its [minikube](https://minikube.sigs.k8s.io/docs/) variant. Anyway, the switch went smoothly, my problems were solved and I was happily deploying [Photonia](https://github.com/photonia-io/photonia) since then to a new [Hetzner](https://www.hetzner.com/) VPS which I started renting from that point in time.

However, the rest of my mostly static sites stayed on the old [Scaleway](https://www.scaleway.com/en/) VPS which sat very under used and for which I was paying monthly.

I needed:

- many small domains and subdomains (virtual hosts) served by the same container
- a "passthrough" solution, as some of these sites are serving files which can total some gigabytes
- automatic Let's Encrypt Certificates
- their configuration should be all in once place

My pick for a web server was nginx, more precisely the nginx:alpine docker variant which builds into 20-ish megabyte image. One snag I hit was that Kamal's proxy needs each site to have an `/up` path (configurable) which will be used for healtchecks. Of course that since we're talking about static sites the interval it uses to check can be increased a lot from the 1 second default. But this path has to be present in each `server` block, so I came up with a nginx configuration snippet (health-check.conf):

```
location /up {
  return 200 "OK\n";
  add_header Content-Type text/plain;
  access_log off;
}
```

The Dockerfile is as simple as:

```
FROM nginx:alpine

COPY health-check.conf /etc/nginx/snippets/
COPY vhosts/*.conf /etc/nginx/conf.d/

EXPOSE 80
```

In the vhosts directory I have files like (vhosts/rusiczki.net.conf):

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

Or, even simpler (vhosts/clicktrackheart.com.conf):

```
server {
  listen 80;
  server_name clicktrackheart.com www.clicktrackheart.com;
  root /var/www/clicktrackheart.com;
  index index.html;

  include /etc/nginx/snippets/health-check.conf;
}
```

And finally let's see the config/deploy.yml file:

```
service: nginx-sites

image: <YOURREGISTRYUSERNAME>/nginx-sites

servers:
  web:
    - <YOURSERVERSIP>

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
  username: <YOURREGISTRYUSERNAME>
  password:
    - REGISTRY_PASSWORD

builder:
  arch: amd64

volumes:
  - "/var/www:/var/www"

```

Make sure the DNS records already point to the new IP when running `kamal deploy` otherwise it won't be able to request a Let's Encrypt certificates for your virtual hosts.



Tip: If you want to have a default site, make its filename something like vhosts/00-default.conf - it is important to be the first one it loads.
