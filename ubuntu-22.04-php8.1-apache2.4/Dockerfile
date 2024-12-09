FROM ubuntu:22.04

RUN rm -f /etc/localtime && ln -s /usr/share/zoneinfo/America/Bogota /etc/localtime && date
RUN apt-get -y update 
RUN apt-get -y install apache2 openssl wget curl git vim sqlite
COPY httpd-foreground /bin/httpd-foreground
RUN chmod 755 /bin/httpd-foreground
#It Installs php 8.1
RUN apt -y install software-properties-common && add-apt-repository ppa:ondrej/php
RUN apt-get -y update
RUN apt -y install \
php8.1 \
php8.1-common \
php8.1-cli \
php8.1-pdo \
php8.1-xml \
php8.1-soap \
php8.1-xmlrpc \
php8.1-mbstring \
php-json \
php8.1-gd \
php8.1-mcrypt \
php8.1-tokenizer \
php8.1-ctype \
php8.1-bcmath \
php8.1-mysqlnd \
php8.1-mysql \
php8.1-zip \
php8.1-imap \
libapache2-mod-php8.1 \
php8.1-curl \
php8.1-ldap \
php8.1-intl \
php8.1-sqlite3
RUN a2enmod rewrite
RUN a2enmod ssl

COPY ./config-files/apache2/000-default.conf /etc/apache2/sites-available/
COPY ./config-files/apache2/default-ssl.conf /etc/apache2/sites-available/
RUN ln -s /etc/apache2/sites-available/default-ssl.conf /etc/apache2/sites-enabled/default-ssl.conf
COPY ./config-files/php/php.ini /etc/php/8.1/apache2/

RUN adduser sientifica && mkdir /home/sientifica/app 
RUN chown -Rf sientifica:www-data /home/sientifica/app
RUN chmod 775 -R /home/sientifica/app 
RUN mkdir /var/www/app 
RUN mkdir /var/www/app/public
RUN echo "Starting container LAMP!" > /var/www/app/public/index.html
RUN chown -Rf sientifica:www-data /var/www/app

RUN rm -f /etc/alternatives/php
RUN ln -s /usr/bin/php8.1 /etc/alternatives/php

RUN rm -f /etc/alternatives/phar
RUN ln -s /usr/bin/phar8.1 /etc/alternatives/phar

RUN rm -f /etc/alternatives/phar.phar
RUN ln -s /usr/bin/phar.phar8.1 /etc/alternatives/phar.phar

RUN rm -f /etc/alternatives/phpdbg

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === 'dac665fdc30fdd8ec78b38b9800061b4150413ff2e3b6f88543c636f7cd84f6db9189d43a81e5503cda447da73c7e5b6') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/local/bin/composer

EXPOSE 80
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
