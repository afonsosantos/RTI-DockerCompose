FROM php:8.0-apache

ARG DB_DATABASE
ARG DB_USER
ARG DB_USER_PASSWORD

WORKDIR /var/www/html
# RUN rm -r *

RUN apt-get update
RUN apt-get install git -y

RUN git clone https://github.com/Projetos-IPL/RTI-API .

# replace database configuration

RUN sed -i 's/localhost/rti' ./utils/constants.php
RUN sed -i 's/root/rti' ./utils/constants.php
RUN sed -i 's/password/rti@2022!' ./utils/constants.php

EXPOSE 80