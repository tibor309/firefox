[esr_build]: https://github.com/tibor309/firefox/tree/esr
[firefox]: https://www.mozilla.org/en-US/firefox/new/
[kasm]: https://kasmweb.com/kasmvnc
[firefox-setup]: https://github.com/linuxserver/docker-firefox/blob/master/README.md#application-setup

[dhub]: https://hub.docker.com/r/tibordev/firefox
[dcompose]: https://docs.linuxserver.io/general/docker-compose
[dcli]: https://docs.docker.com/engine/reference/commandline/cli/
[flags]: https://wiki.mozilla.org/Firefox/CommandLineOptions
[tz]: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones#List
[link]: https://www.youtube.com/watch?v=dQw4w9WgXcQ


# 🦊 Firefox Browser
This container allows you to use the [firefox][firefox] web browser trough another web browser using [kasmvnc][kasm].

![firefox](https://github.com/user-attachments/assets/f5504c48-456d-47d3-8174-b29252a12839)

## Setup
To set up the container, you can either use docker-compose or the docker cli. You can also use options and additional settings/mods from linuxserver.io. For updating the container, simply re-pull the image, and deploy it. The [esr][esr_build] version of the browser is also availlable!

> [!NOTE]
> This image is also available on [Docker Hub][dhub] under `tibordev/firefox`.

### [docker-compose][dcompose] (recommended)

```yaml
---
services:
  firefox:
    image: ghcr.io/tibor309/firefox:latest
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

### [docker-cli][dcli]

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
  ghcr.io/tibor309/firefox:latest
```

## Config
You can also use additional parameters and settings from the [linuxserver/docker-firefox][firefox-setup] project!

| Parameter | Function |
| :----: | --- |
| `-p 3000` | Firefox desktop gui. |
| `-p 3001` | HTTPS Firefox desktop gui. |
| `-e PUID=1000` | For UserID |
| `-e PGID=1000` | For GroupID |
| `-e TZ=Etc/UTC` | Specify a timezone to use, see this [list][tz]. |
| `-e FIREFOX_CLI=https://www.github.com/` | Specify one or multiple [Firefox CLI flags][flags], this string will be passed to the application in full. |
| `-v /config` | Users home directory in the container, stores local files and settings |
| `--shm-size=` | This is needed for any modern website to function like youtube. |
| `--security-opt seccomp=unconfined` | For Docker Engine only, many modern gui apps need this to function on older hosts as syscalls are unknown to Docker. |

## Usage
To access the container, navigate to the ip address for your machine with the port you provided at the setup.

* [http://yourhost:3000/][link]
* [https://yourhost:3001/][link]
