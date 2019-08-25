FROM bmoorman/ubuntu:bionic

ENV HTTPD_SERVERNAME="localhost" \
    HTTPD_PORT="9357"

ARG DEBIAN_FRONTEND="noninteractive"

WORKDIR /var/www

RUN echo 'deb http://ppa.launchpad.net/certbot/certbot/ubuntu bionic main' > /etc/apt/sources.list.d/certbot.list \
 && echo 'deb-src http://ppa.launchpad.net/certbot/certbot/ubuntu bionic main' >> /etc/apt/sources.list.d/certbot.list \
 && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8C47BE8E75BCA694 \
 && apt-get update \
 && apt-get install --yes --no-install-recommends \
    apache2 \
    certbot \
    curl \
    git \
    libapache2-mod-php \
    php-curl \
    php-ldap \
    php-sqlite3 \
    php-xml \
    php-zip \
    ssl-cert \
 && a2enmod \
    remoteip \
    rewrite \
    ssl \
 && sed --in-place --regexp-extended \
    --expression 's/^(Include\s+ports\.conf)$/#\1/' \
    /etc/apache2/apache2.conf \
 && git clone https://github.com/causefx/Organizr \
 && apt-get autoremove --yes --purge \
 && apt-get clean \
 && rm --recursive --force /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY apache2/ /etc/apache2/

VOLUME /config

EXPOSE ${HTTPD_PORT}

CMD ["/etc/apache2/start.sh"]

HEALTHCHECK --interval=60s --timeout=5s CMD /etc/apache2/healthcheck.sh || exit 1
