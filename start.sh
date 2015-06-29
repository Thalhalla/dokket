#!/bin/bash

#cd /home/steam
#echo sed
#sed -i 's/steamuser="username"/steamuser=REPLACE_USER/' arma3server
#sed -i 's/steampass="password"/steampass=REPLACE_PASSWORD/' arma3server
#sed -i "s/steamuser=REPLACE_USER/steamuser='$STEAM_USERNAME'/" arma3server
#sed -i "s/steampass=REPLACE_PASSWORD/steampass='$STEAM_PASSWORD'/" arma3server
# set_steam_guard_code $STEAM_GUARD_CODE
#yes y|./tf2server install
#passwd --stdin <<< "$STEAM_PASSWORD"
cd /home/steam
echo sed
sed -i 's/steamuser="username"/steamuser=REPLACE_USER/' arma3server
sed -i 's/steampass="password"/steampass=REPLACE_PASSWORD/' arma3server
sed -i "s/steamuser=REPLACE_USER/steamuser='$STEAM_USERNAME'/" arma3server
sed -i "s/steampass=REPLACE_PASSWORD/steampass='$STEAM_PASSWORD'/" arma3server
sed -i 's/steamuser="username"/steamuser=REPLACE_USER/' tf2server
sed -i 's/steampass="password"/steampass=REPLACE_PASSWORD/' tf2server
sed -i "s/steamuser=REPLACE_USER/steamuser='$STEAM_USERNAME'/" tf2server
sed -i "s/steampass=REPLACE_PASSWORD/steampass='$STEAM_PASSWORD'/" tf2server
set_steam_guard_code $STEAM_GUARD_CODE
su - steam yes y|/home/steam/arma3server install
echo "root:$STEAM_PASSWORD" |chpasswd
su - steam yes y|/home/steam/tf2server install
/usr/sbin/sshd
bash /run.sh
