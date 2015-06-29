FROM joshuacox/steamer
MAINTAINER Josh Cox <josh 'at' webhosting coop>

USER root
ENV DOKKET 20150513

RUN apt-get update; apt-get -y install php5-fpm php5-mysql php-apc php5-imagick php5-imap php5-mcrypt php5-curl php5-cli php5-gd php5-pgsql php5-sqlite php5-common php-pear curl php5-json php5-redis redis-server memcached php5-memcache git nginx
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ && mv /usr/bin/composer.phar /usr/bin/composer

# override these variables in your Dockerfile
ENV STEAM_USERNAME anonymous
ENV STEAM_PASSWORD ' '
ENV STEAM_GUARD_CODE ' '
# and override this file with the command to start your server
USER root
ADD ./run.sh /run.sh
RUN chmod 755 /run.sh
# Override the default start.sh
ADD ./start.sh /start.sh
RUN chmod 755 /start.sh

# USER steam

# RUN echo "<?php phpinfo(); ?>" > /srv/www/phpinfo.php
RUN cd /srv; rm -Rf www; git clone https://github.com/aaroniker/rokket.git www
WORKDIR /srv/www

# ADD . /srv/www
ADD ./default /etc/nginx/sites-available/default

EXPOSE 80

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
