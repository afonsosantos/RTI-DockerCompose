FROM php:8.0-apache

WORKDIR /var/www/html

RUN docker-php-ext-install mysqli pdo pdo_mysql

RUN apt-get update
RUN apt-get install git -y

RUN git clone https://github.com/Projetos-IPL/RTI-API .

# replace database configuration

RUN sed -i "s/localhost/database/" ./utils/constants.php
RUN sed -i "s/root/rti/" ./utils/constants.php
RUN sed -i "s/password/rti@2022!/" ./utils/constants.php

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

RUN composer install

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

EXPOSE 80