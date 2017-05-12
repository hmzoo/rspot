#!/bin/bash


apt-get install -y nginx
cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf_old
cp nginx.conf /etc/nginx/nginx.conf

cp -rf html /usr/share/nginx

mkdir /etc/nginx/ssl
openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt

