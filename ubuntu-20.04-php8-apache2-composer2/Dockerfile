FROM ubuntu:20.04

RUN rm -f /etc/localtime && ln -s /usr/share/zoneinfo/America/Bogota /etc/localtime && date
RUN apt-get -y update 
RUN apt-get -y install apache2 openssl wget curl git vim

#It Installs php 7.4
RUN apt -y install software-properties-common && add-apt-repository ppa:ondrej/php
RUN apt-get -y update
RUN apt -y install \
php7.4 \
php7.4-common \
php7.4-cli \
php7.4-pdo \
php7.4-xml \
php7.4-soap \
php7.4-xmlrpc \
php7.4-mbstring \
php7.4-json \
php7.4-gd \
php7.4-mcrypt \
php7.4-tokenizer \
php7.4-ctype \
php7.4-bcmath \
php7.4-mysqlnd \
php7.4-zip \
php7.4-imap \
php7.4-curl
 
RUN adduser sientifica && mkdir /home/sientifica/app 
RUN chown -Rf sientifica:www-data /home/sientifica/app
RUN chmod 775 -R /home/sientifica/app 
RUN rm -f /etc/apache2/sites-available/000-default.conf
COPY 000-default.conf.template /etc/apache2/sites-available/000-default.conf

EXPOSE 80
CMD apachectl -D FOREGROUND



