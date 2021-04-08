FROM php:7.2-apache

RUN apt-get update && \
  apt-get dist-upgrade -y && \
  apt-get install --no-install-recommends -y \
    libbz2-dev \
    libc-client-dev \
    libkrb5-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libjpeg-dev \
    libmemcached-dev \
    libzip-dev \
    patch \
    pkg-config libmagickwand-dev imagemagick \
    zlib1g-dev libicu-dev

# Enable extensions required by Drupal
RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-configure opcache --enable-opcache
RUN docker-php-ext-install -j$(nproc) bcmath bz2 exif fileinfo gd intl imap mbstring mysqli pdo pdo_mysql soap xmlrpc zip
RUN docker-php-ext-enable opcache

# Enable apache mods
RUN a2enmod rewrite expires headers

# Update apache vhost configuration to be compatible with droopler
RUN sed -i 's/\/var\/www\/html/\/var\/www\/html\/web/g' /etc/apache2/sites-enabled/000-default.conf

# Copy files into container
COPY --chown=www-data:www-data app /var/www/html
COPY --chown=www-data:www-data build/jenkins/build-droopler-base/files/settings.php /var/www/html/web/sites/default/settings.php

COPY build/jenkins/build-droopler-base/files/php-cli.ini /usr/local/etc/php/php-cli.ini

# Add custom scripts
COPY build/jenkins/build-droopler-base/scripts/docker-custom-entrypoint.sh /usr/local/bin/docker-custom-entrypoint

ENTRYPOINT ["/usr/local/bin/docker-custom-entrypoint"]
CMD ["apache2-foreground"]
