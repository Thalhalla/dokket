FROM joshuacox/steamer
MAINTAINER Josh Cox <josh 'at' webhosting coop>

USER root
ENV DOKKET 20150513

RUN apt-get update; apt-get -y install php5-fpm php5-mysql php-apc php5-imagick php5-imap php5-mcrypt php5-curl php5-cli php5-gd php5-pgsql php5-sqlite php5-common php-pear curl php5-json php5-redis redis-server memcached php5-memcache git nginx byobu ssh
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
RUN chown -R www-data. /srv/www
RUN echo "HTML is working" > /srv/www/nginx-container.html
ADD nginx.conf /etc/nginx/nginx.conf
ADD sshd_config /etc/ssh/sshd_config
RUN chmod 644 /etc/ssh/sshd_config; mkdir /var/run/sshd

USER steam
WORKDIR /home/steam
RUN wget http://gameservermanagers.com/dl/tf2server
RUN chmod +x tf2server
# Create the directories used to store the profile files and Arma3.cfg file
RUN mkdir -p "~/.local/share/Arma 3"
RUN mkdir -p "~/.local/share/Arma 3 - Other Profiles"
# RUN rm -Rf /home/steam/steamcmd
RUN wget http://gameservermanagers.com/dl/arma3server
RUN chmod +x arma3server
# install wasteland
#WORKDIR /home/steam/steamcmd/arma3
#RUN curl -SsL -o mpmissions/A3Wasteland_v1.0b.Altis.pbo https://github.com/crosbymichael/Release_Files/raw/master/A3Wasteland_v1.0b.Altis.pbo

USEr root
# ADD . /srv/www
ADD ./default /etc/nginx/sites-available/default

EXPOSE 80

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
