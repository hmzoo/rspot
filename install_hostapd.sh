#!/bin/bash


apt-get update && apt-get install -y hostapd

cp ./hostapd.conf /etc/hostapd/hostapd.conf


