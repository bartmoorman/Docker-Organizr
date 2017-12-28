FROM bmoorman/ubuntu

ENV HTTPD_SERVERNAME="localhost"

ARG DEBIAN_FRONTEND="noninteractive"

WORKDIR /var/www

RUN apt-get update \
 && apt-get install --yes --no-install-recommends \
    apache2 \
    git \
    libapache2-mod-php \
    php-curl \
    php-sqlite3 \
    php-xml \
    php-zip \
    ssl-cert \
 && a2enmod \
    remoteip \
    rewrite \
    ssl \
 && git clone https://github.com/causefx/Organizr \
 && apt-get autoremove --yes --purge \
 && apt-get clean \
 && rm --recursive --force /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY apache2/ /etc/apache2/

VOLUME /config

EXPOSE 9357

CMD ["/etc/apache2/start.sh"]
