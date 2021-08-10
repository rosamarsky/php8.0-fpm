FROM php:8.0.5-fpm

MAINTAINER Roman Samarsky <rosamarsky@gmail.com>

LABEL Vendor="rosamarsky"
LABEL Description="PHP-FPM v8.0.5"

RUN apt-get update && apt-get install -y \
    gnupg2 \
    g++ \
    libicu-dev \
    libjpeg-dev \
    libpng-dev \
    libpq-dev \
    libsodium-dev \
    libxml2-dev \
    libzip-dev \
    unzip \
    wget

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer --version

# Set timezone
RUN rm /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/London /etc/localtime
RUN "date"

# Type docker-php-ext-install to see available extensions
RUN docker-php-ext-configure gd
RUN docker-php-ext-configure intl
RUN docker-php-ext-install bcmath gd intl pdo pdo_mysql soap sodium zip

# Copy config
ADD php.ini /usr/local/etc/php/

WORKDIR /var/www
