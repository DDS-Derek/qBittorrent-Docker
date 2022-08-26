# qBittorrent

基于https://github.com/SuperNG6/Docker-qBittorrent-Enhanced-Edition大佬的镜像改编

## Architecture
### qBittorrent Enhanced Edition latest

| Architecture | Tag            |
| ------------ | -------------- |
| x86-64       | latest   |
| arm64        | latest |

## 特点

1. Auto Ban 迅雷、QQ、百度、Xfplay、DLBT 和离线下载器
2. *Auto Ban Unknown Peer from China*选项
3. 自动更新公共跟踪器列表
4. 自动禁止 BitTorrent 媒体播放器对等选项
5. 对等白名单/黑名单

## 部署

````
docker -itd  \
    --name=qbittorrentee  \
    -e WEBUIPORT=8080  \
    -e PUID=1000 \
    -e PGID=1000 \
    -e TZ=Asia/Shanghai \
    -p 6881:6881  \
    -p 6881:6881/udp  \
    -p 8080:8080  \
    -v /配置文件位置:/config  \
    -v /下载位置:/downloads  \
    --restart unless-stopped  \
    ddsderek/qbittorrent
````

### docker-compose
````
version: "2"
services:
  qbittorrentee:
    image: ddsderek/qbittorrent
    container_name: qbittorrentee
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Asia/Shanghai
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
|-|:-|
| `--name=qbittorrentee` |容器名|
| `-p 8080:8080` |web访问端口 [IP:8080](IP:8080);(默认用户名:admin;默认密码:adminadmin);此端口需与容器端口和环境变量保持一致，否则无法访问|
| `-p 6881:6881` |BT下载监听端口|
| `-p 6881:6881/udp` |BT下载DHT监听端口
| `-v /配置文件位置:/config` |qBittorrent配置文件位置|
| `-v /下载位置:/downloads` |qBittorrent下载位置|
| `-e WEBUIPORT=8080` |web访问端口环境变量|
| `-e TZ=Asia/Shanghai` |系统时区设置,默认为Asia/Shanghai|

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
