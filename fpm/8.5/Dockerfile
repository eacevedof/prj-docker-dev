# https://hub.docker.com/_/php — 8.5 última estable (8.6 aún en RC)
FROM php:8.5-fpm

RUN apt-get update \
    && apt-get -y install --no-install-recommends \
    -y jq vim wget unzip ca-certificates cron procps moreutils procps bsdmainutils build-essential git bash-completion

RUN apt-get install -y --no-install-recommends \
       libicu-dev \
       zlib1g-dev \
       libpng-dev \
       libzip-dev \
       unzip \
       git \
       curl \
    && docker-php-ext-install intl pdo pdo_mysql gd zip mysqli

# opcache: desde PHP 8.5 viene compilado dentro (no se instala como extensión)

# Install Xdebug
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

# Set environment variables for Composer
ENV COMPOSER_ALLOW_SUPERUSER=1 \
    COMPOSER_HOME=/composer

# Install Composer
RUN curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php \
    && php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && rm /tmp/composer-setup.php

RUN composer --version

COPY ./xdebug-8.5.ini /usr/local/etc/php/conf.d
COPY ./php-8.5.ini /usr/local/etc/php/conf.d

RUN touch /tmp/xdebug.log \
    && chmod 777 /tmp/xdebug.log

RUN mv /root/.bashrc /root/.bashrc.bak
COPY ./.bashrc /root/.bashrc
RUN sed -i 's/\r$//' /root/.bashrc