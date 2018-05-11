#!/bin/bash
chown www-data: /config

if [ ! -d /config/config ]; then
    install --owner www-data --group www-data --directory /config/config
    cp --recursive --force /var/www/Organizr/config /config
fi

rm --recursive --force /var/www/Organizr/config
ln --symbolic --force /config/config /var/www/Organizr/

if [ ! -d /var/www/Organizr/images/cache ]; then
    install --owner www-data --group www-data --directory /var/www/Organizr/images/cache
fi

if [ -d /config/httpd/images ]; then
    ln --symbolic --force /config/httpd/images/* /var/www/Organizr/images
fi

if [ ! -d /config/httpd/ssl ]; then
    mkdir --parents /config/httpd/ssl
    ln --symbolic --force /etc/ssl/certs/ssl-cert-snakeoil.pem /config/httpd/ssl/organizr.crt
    ln --symbolic --force /etc/ssl/private/ssl-cert-snakeoil.key /config/httpd/ssl/organizr.key
fi

pidfile=/var/run/apache2/apache2.pid

if [ -f ${pidfile} ]; then
    pid=$(cat ${pidfile})

    if [ ! -d /proc/${pid} ] || [[ -d /proc/${pid} && $(basename $(readlink /proc/${pid}/exe)) != 'apache2' ]]; then
      rm ${pidfile}
    fi
fi

exec $(which apache2ctl) \
    -D FOREGROUND \
    -D ${HTTPD_SECURITY:-HTTPD_SSL} \
    -D ${HTTPD_REDIRECT:-HTTPD_REDIRECT_SSL}
