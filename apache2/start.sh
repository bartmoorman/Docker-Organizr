#!/bin/bash
chown www-data: /config

if [ ! -d /config/config ]; then
    install --owner www-data --group www-data --directory /config/config
    cp --recursive --force /var/www/Organizr/config /config
fi

rm --recursive --force /var/www/Organizr/config
ln --symbolic --force /config/config /var/www/Organizr/

if [ ! -d /config/httpd/ssl ]; then
    mkdir --parents /config/httpd/ssl
    ln --symbolic --force /etc/ssl/certs/ssl-cert-snakeoil.pem /config/httpd/ssl/organizr.crt
    ln --symbolic --force /etc/ssl/private/ssl-cert-snakeoil.key /config/httpd/ssl/organizr.key
fi

exec $(which apache2ctl) \
    -D FOREGROUND \
    -D ${INSECURE:-HTTPD_SSL}
