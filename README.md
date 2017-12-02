### Usage
```
docker run \
--rm \
--detach \
--init \
--name organizr \
--hostname organizr \
--volume organizr-config:/config \
--publish 9357:9357 \
bmoorman/organizr
```
