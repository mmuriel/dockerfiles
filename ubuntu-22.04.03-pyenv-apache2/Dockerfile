# Use the official Ubuntu 22.04
FROM ubuntu:22.04

RUN rm -f /etc/localtime && ln -s /usr/share/zoneinfo/America/Bogota /etc/localtime && date

# Update the package list and install necessary dependencies
RUN apt-get update && \
    apt-get install -y \
    apache2 \
    libapache2-mod-wsgi-py3 \
    openssl \
    wget \
    curl \
    git \
    vim \
    sqlite && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Configure Apache2 with mod_wsgi rewrite and ssl
RUN a2enmod wsgi
RUN a2enmod rewrite
RUN a2enmod ssl

# Instala pyenv
RUN apt-get update && apt-get install -y make
RUN apt-get install -y \
    build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev llvm libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN curl https://pyenv.run | bash

# Load pyenv automatically by adding
# the following to ~/.bashrc:
# RUN echo "export PATH="/root/.pyenv/bin:$PATH"
RUN echo $PATH
ENV PATH="/root/.pyenv/bin:$PATH"
RUN echo $PATH
RUN eval "$(pyenv init -)"
RUN eval "$(pyenv virtualenv-init -)"

# Create a directory for your web application
WORKDIR /var/www/app

# You can add additional dependencies here if needed
# RUN pip3 install -r requirements.txt

# Expose port 80 for Apache2
EXPOSE 80

# Start Apache2 on container startup
CMD ["apache2ctl", "-D", "FOREGROUND"]

