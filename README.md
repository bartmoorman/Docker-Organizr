### Usage
```
docker run \
--rm \
--detach \
--init \
--name organizr \
--hostname organizr \
--volume organizr-config:/config \
--publish 9753:9753 \
--publish 9357:9357 \
--env "HTTPD_SERVERNAME=**sub.do.main**" \
bmoorman/organizr
```
