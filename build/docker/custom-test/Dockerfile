FROM droptica/php-dev:7.1

RUN mkdir /root/composer_codecept

ADD composer.json /root/composer_codecept/composer.json

RUN composer global update -d /root/composer_codecept/

ENV PATH "/root/composer_codecept/vendor/bin:$PATH"
