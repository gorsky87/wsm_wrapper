FROM droptica/php-apache:7.2

# mariadb-client is needed to run drush updb
RUN apt-get update && \
    apt-get install -y mariadb-client && \
    apt-get --purge -y autoremove && \
    rm -rf /var/lib/apt/lists/*

# Copy files into container
COPY --chown=7000:7000 app /var/www/html
COPY --chown=7000:7000 build/jenkins/build-droopler-site/files/settings.php /var/www/html/web/sites/default/settings.php
COPY --chown=root:root build/jenkins/build-droopler-site/files/init.sh /usr/local/bin/docker-additional-cmds/init.sh
