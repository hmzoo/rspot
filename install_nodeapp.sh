#!/bin/bash

cp -r app /opt
cp nodeapp /etc/init.d

cd /opt/app
npm install
npm install -g forever
cd /opt/app/client
npm install

chown -R pi /opt/app


chmod 700 /etc/init.d/nodeapp  
update-rc.d nodeapp defaults



