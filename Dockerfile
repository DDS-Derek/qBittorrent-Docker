# Build qBittorrent-Enhanced-Edition

FROM lsiobase/alpine:3.15 as builder_qbee

WORKDIR /qbittorrent

COPY ./install_qbee/* /qbittorrent/

RUN  apk add --no-cache ca-certificates curl

RUN cd /qbittorrent \
	&& chmod a+x install.sh \
	&& bash install.sh

# Build qBittorrent

FROM lsiobase/alpine:3.15 as builder_qb

WORKDIR /qbittorrent

COPY ./install_qb/* /qbittorrent/

RUN set -ex \
	&& chmod +x /qbittorrent/install.sh \
	&& /qbittorrent/install.sh

# docker qBittorrent & qBittorrent-Enhanced-Edition

FROM lsiobase/alpine:3.12

# environment settings
ENV TZ=Asia/Shanghai \
	WEBUIPORT=8080 \
	PUID=1000 \
	PGID=1000 \
	UMASK_SET=022 \
    TL=https://githubraw.sleele.workers.dev/XIU2/TrackersListCollection/master/best.txt \
    UT=true \
	QB_EE_BIN=false

# install python3
RUN apk add --no-cache python3 && \
	rm -rf /var/cache/apk/*

COPY --chmod=755 root /
COPY --from=builder_qbee --chmod=777 /qbittorrent/qbittorrent-nox   /usr/local/bin/qbittorrentee-nox
COPY --from=builder_qb --chmod=777 /qbittorrent/qbittorrent-nox   /usr/local/bin/qbittorrent-nox

# ports and volumes
VOLUME /config
EXPOSE 8080  6881  6881/udp
