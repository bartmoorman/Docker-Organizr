### Docker Run
```
docker run \
--detach \
--name organizr \
--restart unless-stopped \
--publish 9357:9357 \
--volume organizr-config:/config \
bmoorman/organizr:latest
```

### Docker Compose
```
version: "3.7"
services:
  organizr:
    image: bmoorman/organizr:latest
    container_name: organizr
    restart: unlesss-stopped
    ports:
      - "9357:9357"
    volumes:
      - organizr-config:/config

volumes:
  organizr-config:
```

### Environment Variables
|Variable|Description|Default|
|--------|-----------|-------|
|TZ|Sets the timezone|`America/Denver`|
|HTTPD_SERVERNAME|Sets the vhost servername|`localhost`|
|HTTPD_PORT|Sets the vhost port|`9357`|
|HTTPD_SSL|Set to anything other than `SSL` (e.g. `NO_SSL`) to disable SSL|`SSL`|
|HTTPD_REDIRECT|Set to anything other than `REDIRECT` (e.g. `NO_REDIRECT`) to disable SSL redirect|`REDIRECT`|
