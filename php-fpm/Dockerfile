FROM php:7.3.33-fpm-alpine3.14

## Install Composer
RUN curl -sS https://getcomposer.org/installer \
  | php -- --install-dir=/usr/local/bin --filename=composer

###
## PHP Extensisons
###

## Install zip libraries and extension
## Note the instal of openrc to use nginx as a service. Don't do this, use separate container!
## openrc
RUN apk add \
    nano \
    git \
    libzip-dev \
    zlib-dev \
    && docker-php-ext-install \
    zip

## Install intl library and extension
RUN apk add icu-dev \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl

COPY www.conf /usr/local/etc/php-fpm.d/zz-docker.conf

RUN chown -R www-data:www-data /var/www

###
## Optional PHP extensions 
###

## mbstring for i18n string support
# RUN docker-php-ext-install mbstring

###
## Some laminas/laminas-db supported PDO extensions
###

## MySQL PDO support
# RUN docker-php-ext-install pdo_mysql

## PostgreSQL PDO support
# RUN apt-get install --yes libpq-dev \
#     && docker-php-ext-install pdo_pgsql

###
## laminas/laminas-cache supported extensions
###

## APCU
# RUN pecl install apcu \
#     && docker-php-ext-enable apcu

## Memcached
# RUN apt-get install --yes libmemcached-dev \
#     && pecl install memcached \
#     && docker-php-ext-enable memcached

## MongoDB
# RUN pecl install mongodb \
#     && docker-php-ext-enable mongodb

## Redis support.  igbinary and libzstd-dev are only needed based on 
## redis pecl options
# RUN pecl install igbinary \
#     && docker-php-ext-enable igbinary \
#     && apt-get install --yes libzstd-dev \
#     && pecl install redis \
#     && docker-php-ext-enable redis


WORKDIR /var/www
