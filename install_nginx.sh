#!/bin/bash


apt-get install ngninx
cp nginx.conf /etc/nginx.conf
mkdir /etc/nginx/ssl


openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt

