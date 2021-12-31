FROM ubuntu:20.04

RUN rm -f /etc/localtime && ln -s /usr/share/zoneinfo/America/Bogota /etc/localtime && date
RUN apt-get -y update && apt-get -y install apache2
#RUN ufw allow http
#RUN ufw allow https
#RUN ufw allow ssh
#RUN ufw reload
RUN adduser sientifica && mkdir /home/sientifica/app 
RUN chown -Rf sientifica:www-data /home/sientifica/app
RUN chmod 775 -R /home/sientifica/app 
RUN rm -f /etc/apache2/sites-available/000-default.conf
COPY 000-default.conf.template /etc/apache2/sites-available/000-default.conf
EXPOSE 80
CMD apachectl -D FOREGROUND
