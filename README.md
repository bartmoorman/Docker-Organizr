### Docker Run
```
docker run \
--detach \
--name organizr \
--publish 9357:9357 \
--env "HTTPD_SERVERNAME=**sub.do.main**" \
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
    ports:
      - "9357:9357"
    environment:
      - HTTPD_SERVERNAME=**sub.do.main**
    volumes:
      - organizr-config:/config

volumes:
  organizr-config:
```
