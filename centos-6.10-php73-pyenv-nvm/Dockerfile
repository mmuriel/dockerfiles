FROM alpine:3.14

COPY httpd-foreground /bin/httpd-foreground
RUN apk update 
RUN apk add \
 apache2 \
 openssl \
 wget \
 curl \
 php7 \
 php7-common \
 php7-cli \
 php7-openssl \
 php7-pdo \
 php7-xml \
 php7-soap \
 php7-xmlrpc \
 php7-mbstring \
 php7-json \
 php7-gd \
 php7-mcrypt \
 php7-tokenizer \
 php7-ctype \
 php7-bcmath \
 php7-mysqlnd \
 php7-zip \
 php7-imap \
 php7-curl
COPY httpd.conf.template /etc/httpd/conf/httpd.conf
