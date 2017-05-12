#!/bin/bash


cd /tmp
wget https://nodejs.org/dist/v6.10.3/node-v6.10.3-linux-armv6l.tar.xz
tar -xf node-v6.10.3-linux-armv6l.tar.xz
cd node-v6.10.3-linux-armv6l
rm *
cp -r * /usr

