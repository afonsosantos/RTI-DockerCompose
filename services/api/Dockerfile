FROM php:8.0-apache

ARG DB_DATABASE
ARG DB_USER
ARG DB_USER_PASSWORD

WORKDIR /var/www/html

RUN apt-get update
RUN apt-get install git -y

RUN git clone https://github.com/Projetos-IPL/RTI-API .

RUN echo ${DB_DATABASE}

# replace database configuration

RUN sed -i "s/localhost/${DB_DATABASE}/" ./utils/constants.php
RUN sed -i "s/root/${DB_USER}/" ./utils/constants.php
RUN sed -i "s/password/${DB_USER_PASSWORD}/" ./utils/constants.php

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

RUN composer install

COPY config/php.ini /usr/local/etc/php/

EXPOSE 80