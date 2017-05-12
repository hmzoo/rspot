#!/bin/bash

sudo apt-get install -y  dnsmasq

cp dnsmasq.conf /etc/dnsmasq.conf
echo "DNSMASQ_EXCEPT=lo" >> /etc/default/dnsmasq

