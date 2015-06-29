#!/bin/bash

echo "starting server"
service php5-fpm start && nginx

# infinite loop to keep it open for Docker
while true; echo monitor; sleep 300; done
