## 👋 Welcome to headphones 🚀  

headphones README  
  
  
## Run container

```shell
dockermgr update headphones
```

### via command line

```shell
docker pull casjaysdevdocker/headphones:latest && \
docker run -d \
--restart always \
--name casjaysdevdocker-headphones \
--hostname casjaysdev-headphones \
-e TZ=${TIMEZONE:-America/New_York} \
-v $HOME/Music:/data/music \
-v $HOME/Downloads/Music:/data/downloads \
-v $HOME/.local/share/docker/storage/headphones/headphones/data:/data \
-v $HOME/.local/share/docker/storage/headphones/headphones/config:/config \
-p 8181:8181 \
casjaysdevdocker/headphones:latest
```

### via docker-compose

```yaml
version: "2"
services:
  headphones:
    image: casjaysdevdocker/headphones
    container_name: headphones
    environment:
      - TZ=America/New_York
      - HOSTNAME=casjaysdev-headphones
    volumes:
      - $HOME/Music:/data/music:z
      - $HOME/Downloads/Music:/data/downloads:z
      - $HOME/.local/share/docker/storage/headphones/data:/data:z
      - $HOME/.local/share/docker/storage/headphones/config:/config:z
    ports:
      - 8181:8181
    restart: always
```

## Authors  

🤖 casjay: [Github](https://github.com/casjay) [Docker](https://hub.docker.com/r/casjay) 🤖  
⛵ CasjaysDevdDocker: [Github](https://github.com/casjaysdev) [Docker](https://hub.docker.com/r/casjaysdevdocker) ⛵  
