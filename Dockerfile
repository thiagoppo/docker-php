FROM php:fpm

WORKDIR /var/www/html

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        libmemcached-dev \
        libz-dev \
        libpq-dev \
        libjpeg-dev \
        libpng12-dev \
        libssl-dev \
        libmcrypt-dev \
        libsqlite3-dev \
        git \
        unzip

RUN docker-php-ext-install mcrypt
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install pdo_pgsql

RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

RUN composer global require "laravel/installer"

RUN composer global require "phpunit/phpunit"

RUN ln -s /tmp/vendor/bin/phpunit /usr/local/bin/phpunit

RUN apt-get -y install nodejs

RUN ln -s /usr/bin/nodejs /usr/bin/node

RUN apt-get -y install nodejs-legacy

RUN curl -L https://npmjs.org/install.sh | sh

RUN npm install bower -g

RUN npm install gulp -g

RUN npm install less -g

RUN npm link bower

RUN npm link gulp

RUN npm link less

CMD ["php-fpm"]
