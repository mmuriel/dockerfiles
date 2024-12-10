FROM maomuriel/ubuntu_24.04_apache2.4_pyenv2.4.22:0.1.0
# Create a directory for your web application
WORKDIR /var/www/app
RUN pyenv install 3.13
RUN cd /var/www/app
RUN pyenv local 3.13
RUN exec $SHELL
# Expose port 80 for Apache2
EXPOSE 80
# Start Apache2 on container startup
CMD ["apache2ctl", "-D", "FOREGROUND"]

