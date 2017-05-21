#!/bin/bash

cp -r app /opt/app
cp nodeapp /etc/init.d

cd /opt/app
npm install
npm install -g forever

chown -R pi /opt/app


chmod 700 /etc/init.d/nodeapp  
update-rc.d nodeapp defaults



