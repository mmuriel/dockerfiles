FROM centos:7

COPY httpd-foreground /bin/httpd-foreground
RUN yum -y update && yum install -y epel-release && rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
RUN yum --enablerepo=remi-php73 install -y \
 httpd \
 openssl \
 wget \
 curl \
 php \
 php-common \
 php-cli \
 php-openssl \
 php-pdo \
 php-xml \
 php-soap \
 php-xmlrpc \
 php-mbstring \
 php-json \
 php-gd \
 php-mcrypt \
 php-tokenizer \
 php-ctype \
 php-bcmath \
 php-mysqlnd \
 php-zip \
 php-imap \
 php-curl

RUN adduser sfca && mkdir /home/sfca/app && chown -Rf sfca:apache /home/sfca/app && chmod 775 -Rf /home/sfca/app && rm -f /etc/httpd/conf/httpd.conf
COPY httpd.conf.template /etc/httpd/conf/httpd.conf
RUN echo " " > /home/sfca/.htaccess && chmod -Rf 775 /home/sfca/.htaccess && chown -Rf sfca:apache /home/sfca/.htaccess
RUN chown -Rf sfca:apache /home/sfca/ && chmod 755 /home/sfca/
EXPOSE 80
RUN chmod 755 /bin/httpd-foreground