FROM ghcr.io/linuxserver/baseimage-kasmvnc:ubuntunoble

# set labels
ARG IMAGE_BUILD_DATE
ARG INSTALL_VERSION
LABEL release_channel="stable"
LABEL org.opencontainers.image.authors="tibynx"
LABEL org.opencontainers.image.created="${IMAGE_BUILD_DATE}"
LABEL org.opencontainers.image.description="Web accessible Firefox browser"
LABEL org.opencontainers.image.documentation="https://github.com/tibynx/firefox-kasmvnc/blob/main/README.md"
LABEL org.opencontainers.image.licenses="GPL-3.0-only"
LABEL org.opencontainers.image.source="https://github.com/tibynx/firefox-kasmvnc"
LABEL org.opencontainers.image.title="Firefox"
LABEL org.opencontainers.image.url="https://github.com/tibynx/firefox-kasmvnc/packages"
LABEL org.opencontainers.image.vendor="tibynx"
LABEL org.opencontainers.image.base.name="ghcr.io/linuxserver/baseimage-kasmvnc:ubuntunoble"
LABEL org.opencontainers.image.base.documentation="https://github.com/linuxserver/docker-baseimage-kasmvnc/blob/master/README.md"

# branding
ENV LSIO_FIRST_PARTY=false

# title
ENV TITLE="Firefox"

# prevent Ubuntu's firefox stub from being installed
COPY /root/etc/apt/preferences.d/mozilla /etc/apt/preferences.d/mozilla

RUN \
  echo "**** add branding ****" && \
  curl --create-dirs -o \
    /etc/s6-overlay/s6-rc.d/init-adduser/branding \
    https://raw.githubusercontent.com/tibynx/tibynx/refs/heads/main/branding && \
  echo "**** install packages ****" && \
  curl -vSLo \
    /etc/apt/keyrings/packages.mozilla.org.asc \
    https://packages.mozilla.org/apt/repo-signing-key.gpg && \
  echo \
    "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" \
    > /etc/apt/sources.list.d/mozilla.list && \
  apt-get update -y && \
  apt-get install --no-install-recommends -y \
    firefox=${INSTALL_VERSION} && \
  echo "**** cleanup ****" && \
  apt-get autoclean && \
  rm -rf \
    /config/.cache \
    /config/.launchpadlib \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*

# add local files
COPY /root /

# ports and volumes
EXPOSE 3000
VOLUME /config
