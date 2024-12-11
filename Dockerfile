ARG VERSION_ARG="latest"
FROM scratch AS build-amd64

COPY --from=qemux/qemu-docker:6.11 / /

ARG DEBCONF_NOWARNINGS="yes"
ARG DEBIAN_FRONTEND="noninteractive"
ARG DEBCONF_NONINTERACTIVE_SEEN="true"

RUN set -eu && \
    apt-get update && \
    apt-get --no-install-recommends -y install \
        bc \
        jq \
        curl \
        7zip \
        wsdd \
        samba \
        xz-utils \
        wimtools \
        dos2unix \
        cabextract \
        genisoimage \
        libxml2-utils \
        libarchive-tools && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY --chmod=755 ./src /run/
COPY --chmod=755 ./assets /run/assets

ADD --chmod=664 https://github.com/qemus/virtiso-whql/releases/download/v1.9.43-0/virtio-win-1.9.43.tar.xz /drivers.txz

FROM dockurr/windows-arm:${VERSION_ARG} AS build-arm64
FROM build-${TARGETARCH}

ARG VERSION_ARG="0.00"
RUN echo "$VERSION_ARG" > /run/version

VOLUME /storage
EXPOSE 8006 3389

# Set environment variable
ENV VERSION="10"
ENV DISK_SIZE="100G"
ENV PASSWORD="B!0031"
ENV REGION="en-US"
ENV KEYBOARD="en-US"


ENTRYPOINT ["/usr/bin/tini", "-s", "/run/entry.sh"]
