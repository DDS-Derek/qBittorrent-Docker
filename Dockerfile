# Build qBittorrent-Enhanced-Edition

FROM lsiobase/alpine:3.15 as builder-qbee

WORKDIR /qbittorrent

COPY ./install_qbee/* /qbittorrent/

RUN  apk add --no-cache ca-certificates curl

RUN cd /qbittorrent \
	&& chmod a+x install.sh \
	&& bash install.sh

# Build qBittorrent

FROM lsiobase/alpine:3.15 as builder-qb

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

# add local files and install qbitorrent
COPY root /
COPY --from=builder-qbee  /qbittorrent/qbittorrent-nox   /usr/local/bin/qbittorrentee-nox
COPY --from=builder-qb  /qbittorrent/qbittorrent-nox   /usr/local/bin/qbittorrent-nox

# install python3
RUN  apk add --no-cache python3 \
&&   rm -rf /var/cache/apk/*   \
&&   chmod a+x  /usr/local/bin/qbittorrentee-nox \
&&   chmod a+x  /usr/local/bin/qbittorrent-nox  

# ports and volumes
VOLUME /config
EXPOSE 8080  6881  6881/udp
