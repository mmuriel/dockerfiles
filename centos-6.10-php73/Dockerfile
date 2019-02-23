FROM centos:6.10

COPY httpd-foreground /bin/httpd-foreground
RUN yum -y update && yum install -y epel-release && rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
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
 php-gd

RUN adduser admin && mkdir /home/admin/app && chown -Rf admin:apache /home/admin/app && rm -f /etc/httpd/conf/httpd.conf
COPY httpd.conf.template /etc/httpd/conf/httpd.conf
RUN chmod 755 /bin/httpd-foreground

