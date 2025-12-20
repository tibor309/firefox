# 🦊 Firefox

This container allows you to use the [Firefox](https://www.mozilla.org/en-US/firefox/new/) web browser trough another web browser using KasmVNC. Firefox is a free web browser backed by Mozilla, a non-profit dedicated to internet health and privacy.

![firefox](https://github.com/user-attachments/assets/f5504c48-456d-47d3-8174-b29252a12839)

## Setup

To set up the container, you can use docker-compose or the docker cli. Unless a parameter is flagged as 'optional', it is *mandatory* and a value must be provided. This container is using a linuxserver.io base, so you can use their [mods](https://github.com/linuxserver/docker-mods) and configurations to enable additional functionality within the container.

### [docker-compose](https://docs.linuxserver.io/general/docker-compose) (recommended)

```yaml
---
services:
  firefox:
    image: tibynx/firefox:latest
    container_name: firefox-browser
    security_opt:
      - seccomp:unconfined #optional
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Etc/UTC
      - FIREFOX_CLI=https://www.github.com/ #optional
    volumes:
      - /path/to/config:/config
    ports:
      - 3000:3000
      - 3001:3001
    shm_size: "1gb"
    restart: unless-stopped
```

### [docker-cli](https://docs.docker.com/engine/reference/commandline/cli/)

```bash
docker run -d \
  --name=firefox-browser \
  --security-opt seccomp=unconfined `#optional` \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Etc/UTC \
  -e FIREFOX_CLI=https://www.github.com/ `#optional` \
  -p 3000:3000 \
  -p 3001:3001 \
  -v /path/to/config:/config \
  --shm-size="1gb" \
  --restart unless-stopped \
  tibynx/firefox:latest
```

## Security

By default, this container has no authentication. Configure the optional environment variables `CUSTOM_USER` and `PASSWORD` to enable basic HTTP auth. This should only be used to locally secure the container on a local network. If you're exposing this container to the internet, it's recommended to use a reverse proxy or a VPN such as [SWAG](https://github.com/linuxserver/docker-swag) or Tailscale.

## Config

Containers are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container. Further options can be found on the [KasmVNC Base Images](https://github.com/linuxserver/docker-baseimage-kasmvnc#options) repo.

| Parameter | Function |
| :----: | --- |
| `-p 3000` | HTTP Firefox desktop gui. |
| `-p 3001` | HTTPS Firefox desktop gui. |
| `-e PUID=1000` | For UserID |
| `-e PGID=1000` | For GroupID |
| `-e TZ=Etc/UTC` | Specify a timezone to use, see this [list](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones#List). |
| `-e FIREFOX_CLI=https://www.github.com/` | Specify one or multiple [Firefox CLI flags](https://wiki.mozilla.org/Firefox/CommandLineOptions), this string will be passed to the application in full. |
| `-v /config` | Users home directory in the container, stores local files and settings. |
| `--shm-size=` | This is needed for any modern website to function like YouTube. |
| `--security-opt seccomp=unconfined` | For Docker Engine only, many modern gui apps need this to function on older hosts as syscalls are unknown to Docker. |

## Updating

This image is updated monthly. To update the app, you'll need to pull the latest image and redeploy the container with your configuration. It's **not** recommended to update the app inside the container. Updating this way could cause issues with configurations and mods.

## Usage

To access the container, navigate to the ip address for your machine with the port you provided at the setup.

* [http://yourhost:3000/](https://www.youtube.com/watch?v=dQw4w9WgXcQ)
* [https://yourhost:3001/](https://www.youtube.com/watch?v=dQw4w9WgXcQ)
