# syntax = docker/dockerfile:experimental

FROM registry.suse.com/suse/sle15:15.2

# Enable zypper modules to be able to download all packages we need
ENV ADDITIONAL_MODULES sle-module-basesystem,sle-module-development-tools,sle-module-web-scripting,sle-module-web-scripting,sle-module-server-applications,PackageHub

# Install all deps (remember to have your SCC Credentials file somewhere, you need to call it during docker build)
RUN --mount=type=secret,id=SCCcredentials,required \
    zypper --non-interactive --gpg-auto-import-keys up && \
    zypper --non-interactive --gpg-auto-import-keys install \
      apache2 \
      apache2-mod_php7 \
      php7 \
      php7-intl \
      php7-devel \
      php7-mbstring \
      php7-mysql \
      php7-xmlreader \
      php7-xmlrpc \
      php7-xmlwriter \
      php7-openssl \
      php7-json \
      php7-fileinfo \
      php7-curl \
      php7-gd \
      php7-ctype \
      php7-iconv \
      php7-tokenizer \
      php-composer \
      curl \
      tar \
      gzip \
      git \
      w3m \
      lynx

# Enable PHP on apache
RUN a2enmod php7

# Configure SSL on apache (Needed for SSL caching error on SLES with REL1.26)
RUN a2enflag SSL

# Allow PHP to read env vars
RUN sed -i 's/^variables_order = "GPCS"/variables_order = "EGPCS"/g' /etc/php7/apache2/php.ini

# Adding ServerName directive
RUN echo "ServerName 127.0.0.1" >> /etc/apache2/httpd.conf

# Deploy mediawiki files
WORKDIR /tmp
RUN curl -o /tmp/mediawiki.tar.gz https://releases.wikimedia.org/mediawiki/1.27/mediawiki-1.27.7.tar.gz && \
    tar xvf mediawiki.tar.gz &&\
    cp -r mediawiki*/* /srv/www/htdocs/ && \
    rm -rf /tmp/mediawiki*

# Add S3 extension
#WORKDIR /srv/www/htdocs/extensions
#RUN git clone --depth 1 https://github.com/edwardspec/mediawiki-aws-s3.git AWS && \
#    cd AWS && \
#    composer self-update --1 && \
#    composer install

# Add LocalSettings.php (make sure to change terraform code with correct path)
COPY LocalSettings.php /srv/www/htdocs/LocalSettings.php

# Run Apache in foreground, so it holds the TTY and keep the container runnnig (and dies if apache dies)
# TODO: Redirect apache logs (access_log and error_log) to stdout
CMD ["apachectl", "-D", "FOREGROUND"]

# Set working directory
WORKDIR /srv/www/htdocs
