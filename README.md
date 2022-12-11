# qBittorrent

基于https://github.com/SuperNG6/Docker-qBittorrent-Enhanced-Edition 大佬的镜像改编

## Architecture
### qBittorrent Enhanced Edition && qBittorrent latest

| Architecture | Tag            |
| :----------: | :------------: |
| x86-64       | latest   |
| arm64        | latest |
| arm        | latest |

## 命名解释

```4.4.4_4.4.4.10```

```4.4.4```为qBittorrent版本

```4.4.4.10```为qBittorrent Enhanced Edition版本

## 部署

**docker-cli**

````bash
docker -itd  \
    --name=qbittorrentee  \
    -e WEBUIPORT=8080  \
    -e PUID=1000 \
    -e PGID=1000 \
    -e TZ=Asia/Shanghai \
    -e UMASK_SET=022 \
    -e TL=https://githubraw.sleele.workers.dev/XIU2/TrackersListCollection/master/best.txt \
    -e UT=true \
    -e QB_EE_BIN=false \
    -p 6881:6881  \
    -p 6881:6881/udp  \
    -p 8080:8080  \
    -v /配置文件位置:/config  \
    -v /下载位置:/downloads  \
    --restart unless-stopped  \
    ddsderek/qbittorrent
````

**docker-compose**

````yaml
version: "2"
services:
  qbittorrentee:
    image: ddsderek/qbittorrent
    container_name: qbittorrentee
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Asia/Shanghai
      - UMASK_SET=022
      - TL=https://githubraw.sleele.workers.dev/XIU2/TrackersListCollection/master/best.txt
      - UT=true
      - QB_EE_BIN=false
    volumes:
      - /path/to/appdata/config:/config
      - /path/to/downloads:/downloads
    ports:
      - 6881:6881
      - 6881:6881/udp
      - 8080:8080
    restart: unless-stopped
````

## 变量:

|参数|说明|
|:-:|:-:|
| `--name=qbittorrentee` |容器名|
| `-p 8080:8080` |web访问端口 [IP:8080](IP:8080);(默认用户名:admin;默认密码:adminadmin);此端口需与容器端口和环境变量保持一致，否则无法访问|
| `-p 6881:6881` |BT下载监听端口|
| `-p 6881:6881/udp` |BT下载DHT监听端口|
| `-v /配置文件位置:/config` |qBittorrent配置文件位置|
| `-v /下载位置:/downloads` |qBittorrent下载位置|
| `-e WEBUIPORT=8080` |web访问端口环境变量|
| `-e TZ=Asia/Shanghai` |系统时区设置,默认为Asia/Shanghai|
| ```-e UMASK_SET=022``` |设置权限掩码|
| ```-e TL=``` |TrackersList，可以自定义|
| ```-e UT=true``` |是否更新TrackersList，推荐开启，如果自定义了TrackersList，必须开启|
| ```-e QB_EE_BIN=false``` |是否使用内置[qBittorrent Enhanced Edition](https://github.com/c0re100/qBittorrent-Enhanced-Edition)，默认关闭|

## PUID GUID 说明

当在主机操作系统和容器之间使用卷（`-v`标志）权限问题时，我们通过允许您指定用户`PUID`和组来避免这个问题`PGID`。

确保主机上的任何卷目录都归您指定的同一用户所有，并且任何权限问题都会像魔术一样消失。

在这种情况下`PUID=1000`，`PGID=1000`找到你的用途`id user`如下：

```
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```

## Umask

具体请阅读[此处。](https://en.wikipedia.org/wiki/Umask)

## 搜索：

### 开启：视图-搜索引擎:
#### 说明：

1. 自带 [http://plugins.qbittorrent.org/](http://plugins.qbittorrent.org/) 部分搜索插件
2. 全新安装默认只开启官方自带部分和一个中文搜索插件。其它可到 视图-搜索引擎-界面右侧搜索-搜索插件-启动栏(双击)开启
3. 一些搜索插件网站需过墙才能用
4. jackett搜索插件需配置jackett.json(位置config/qBittorrent/data/nova3/engines)，插件需配合jackett服务的api_key。可自行搭建docker版jackett(例如linuxserver/jackett)。

## 感谢以下项目:
[https://github.com/qbittorrent/qBittorrent](https://github.com/qbittorrent/qBittorrent)   
[https://github.com/c0re100/qBittorrent-Enhanced-Edition](https://github.com/c0re100/qBittorrent-Enhanced-Edition)    
[https://github.com/ngosang/trackerslist]( https://github.com/ngosang/trackerslist)    
[https://github.com/userdocs/qbittorrent-nox-static](https://github.com/userdocs/qbittorrent-nox-static)
