FROM php:8.0-apache

WORKDIR /var/www/html

RUN docker-php-ext-install mysqli pdo pdo_mysql

RUN apt-get update
RUN apt-get install git -y

RUN git clone https://github.com/Projetos-IPL/RTI-API .

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

RUN composer install

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

EXPOSE 80
