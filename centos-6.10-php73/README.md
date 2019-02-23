# Dockerfile For

Sistema base: Linux Centos 6.10 (FROM centos:6.10)
Stack Instalado:

+ PHP Version 7.3.2, con los siguientes complementos
	
	- php-common
	- php-cli
	- php-openssl
	- php-pdo
	- php-xml
	- php-soap
	- php-xmlrpc
	- php-mbstring
	- php-json
	- php-gd
	- php-mcrypt
	- php-tokenizer
	- php-ctype
	- php-bcmath
	- php-mysqlnd

+ wget
+ curl	
+ openssl
+ Apache Webserver 2.2.15

Notas: 

- Apache DocumentRoot: /home/admin/app
- El comando para arrancar adecuadamente el servidor debe ser httpd-foreground, así:

	> docker run -d -p 80:80 maomuriel/centos610-php73:latest httpd-foreground