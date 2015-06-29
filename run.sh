#!/bin/bash

echo "starting server"
cd /home/steam
su - steam /home/steam/arma3server start
su - steam /home/steam/tf2server start
su - steam /home/steam/arma3server details
su - steam /home/steam/tf2server details
service php5-fpm start && nginx
