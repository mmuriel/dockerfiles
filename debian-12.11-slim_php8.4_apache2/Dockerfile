FROM debian:12.11-slim

RUN rm -f /etc/localtime && ln -s /usr/share/zoneinfo/America/Bogota /etc/localtime && date
RUN apt-get -y update 
RUN apt-get -y install apache2 openssl wget curl git vim sqlite3 libsqlite3-dev

RUN apt-get -y install lsb-release ca-certificates curl apt-transport-https
RUN curl -sSLo /tmp/debsuryorg-archive-keyring.deb https://packages.sury.org/debsuryorg-archive-keyring.deb
RUN dpkg -i /tmp/debsuryorg-archive-keyring.deb
RUN sh -c 'echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'
RUN apt-get update
RUN apt -y install \
php8.4 \
php8.4-common \
php8.4-cli \
php8.4-pdo \
php8.4-xml \
php8.4-soap \
php8.4-xmlrpc \
php8.4-mbstring \
php-json \
php8.4-gd \
php8.4-mcrypt \
php8.4-tokenizer \
php8.4-ctype \
php8.4-bcmath \
php8.4-mysqlnd \
php8.4-mysql \
php8.4-zip \
php8.4-imap \
libapache2-mod-php8.4 \
php8.4-curl \
php8.4-ldap \
php8.4-intl \
php8.4-sqlite3

RUN a2enmod rewrite
RUN a2enmod ssl

COPY ./config-files/apache2/sites-available/000-default.conf /etc/apache2/sites-available/
COPY ./config-files/apache2/sites-available/default-ssl.conf /etc/apache2/sites-available/
RUN ln -s /etc/apache2/sites-available/default-ssl.conf /etc/apache2/sites-enabled/default-ssl.conf
COPY ./config-files/php/php.ini /etc/php/8.4/apache2/php.ini

RUN adduser sientifica && mkdir /home/sientifica/app 
RUN chown -Rf sientifica:www-data /home/sientifica/app
RUN chmod 775 -R /home/sientifica/app 
RUN mkdir /var/www/app 
RUN mkdir /var/www/app/public
RUN echo "Starting container LAMP!" > /var/www/app/public/index.html
RUN chown -Rf sientifica:www-data /var/www/app

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === 'dac665fdc30fdd8ec78b38b9800061b4150413ff2e3b6f88543c636f7cd84f6db9189d43a81e5503cda447da73c7e5b6') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/local/bin/composer


#Starts apache server as container's main process
EXPOSE 80
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]