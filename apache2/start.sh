#!/bin/bash
if [ ! -d /config/config ]; then
    install --owner www-data --group www-data --directory /config/config
    cp --recursive --force /var/www/Organizr/config /config
fi

rm --recursive --force /var/www/Organizr/config
ln --symbolic --force /config/config /var/www/Organizr/

chown www-data: /config
exec $(which apache2ctl) -D FOREGROUND
