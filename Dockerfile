FROM php:8.1 as php

RUN apt-get update -y
RUN apt-get install -y unzip libpq-dev libcurl4-gnutls-dev
RUN docker-php-ext-install pdo pdo_mysql bcmath

RUN pecl install -o -f redis \
       && rm -rf /tmp/pear \
       && docker-php-ext-enable redis

RUN pecl install swoole && docker-php-ext-enable swoole

COPY --from=composer/composer:latest-bin /composer /usr/bin/composer

WORKDIR var/www
COPY . .

ENV PORT=8000
ENTRYPOINT ["./Docker/entrypoint.sh"]
