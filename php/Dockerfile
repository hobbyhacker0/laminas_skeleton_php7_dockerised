FROM php:7.4-fpm-alpine

RUN apk add --no-cache \
        bash \
        autoconf \
        g++ \
        make \
        git \
        icu-dev \
        libmcrypt-dev \
        libpng-dev \
        libzip-dev \
        zlib-dev \
        # `laminas-console` uses `tput` which is not included in alpine images.
        # Can be removed once `laminas-console` is removed.
        # https://github.com/laminas/laminas-console/blob/bffaf29cf357a87b5266b6cc5f4e137b83ffe52e/src/Adapter/Posix.php#L134
        ncurses \
    && docker-php-ext-install \
        bcmath \
        gd \
        intl \
        opcache \
        pdo_mysql \
        zip \
        pdo_mysql \
        intl

RUN pecl install apcu apcu_bc igbinary mcrypt stats-2.0.3 && \
    docker-php-ext-enable apcu igbinary mcrypt stats

RUN pecl install -D 'enable-redis-igbinary="yes" enable-redis-lzf="no" enable-redis-zstd="no"' redis
RUN docker-php-ext-enable redis

# Tweak apcu extension settings\
RUN echo 'extension=apc' >> /usr/local/etc/php/conf.d/docker-php-ext-apcu.ini && \
    echo 'apc.enabled = 1' >> /usr/local/etc/php/conf.d/docker-php-ext-apcu.ini && \
    echo 'apc.mmap_file_mask = /tmp/apc.XXXXXX' >> /usr/local/etc/php/conf.d/docker-php-ext-apcu.ini && \
    # Tweak date settings
    sed -i 's/;date.timezone =/date.timezone = "Europe\/London"/g' /usr/local/etc/php/php.ini-production && \
    # Tweak igbinary extension settings
    echo 'session.serialize_handler = igbinary' >> /usr/local/etc/php/conf.d/docker-php-ext-igbinary.ini && \
    echo 'session.save_handler = redis' >> /usr/local/etc/php/php.ini-production && \
    # Set session.save_path for default \
    sed -i "s#.*session.save_path = .*#session.save_path = \"tcp://redis:6379\"#" /usr/local/etc/php/php.ini-production && \
    echo 'php_value[session.save_handler] = redis' >> /usr/local/etc/php-fpm.d/www.conf && \
    echo 'php_value[session.save_path] = "tcp://redis:6379"' >> /usr/local/etc/php-fpm.d/www.conf


# Copy composer.lock and composer.json
# COPY ./app/composer.lock ./app/composer.json /var/www/

# Set working directory
WORKDIR /var/www

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# # Add app user
# RUN groupadd -g 1000 www
# RUN useradd -u 1000 -ms /bin/bash -g www www

# Copy app folder
COPY ./app /var/www

# # Copy existing application directory permissions
# COPY --chown=www:www . /var/www

# # Change current user to www
# USER www

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]
