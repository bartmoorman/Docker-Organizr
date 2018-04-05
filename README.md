### Usage
```
docker run \
--detach \
--name organizr \
--publish 9357:9357 \
--env "HTTPD_SERVERNAME=**sub.do.main**" \
--volume organizr-config:/config \
bmoorman/organizr:latest
```
