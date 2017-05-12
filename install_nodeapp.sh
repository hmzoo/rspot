#!/bin/bash

cp -r app /opt/app
cd /opt/app
npm install
npm install -g forever

chown -r pi /opt/app

cp nodeapp /etc/init.d

chmod 700 /etc/init.d/nodeapp  
update-rc.d nodeapp defaults



