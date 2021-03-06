FROM php:8.0-apache
RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli
RUN apt-get update && apt-get upgrade -y
WORKDIR /var/www/html
COPY . .
COPY mysqlConnection.php index.php
ENV Host=18.212.137.105