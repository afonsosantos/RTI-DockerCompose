FROM php:8.0-apache

ARG DB_USER_PASSWORD


RUN rm -r /var/www/html/*

WORKDIR /var/www/html

RUN apt-get update
RUN apt-get install git -y

RUN git clone https://github.com/Projetos-IPL/RTI-API .

# replace database configuration

RUN sed -i 's/localhost/database' ./utils/constants.php
RUN sed -i 's/root/rti' ./utils/constants.php
RUN sed -i 's/password/${DB_USER_PASSWORD}' ./utils/constants.php

EXPOSE 80