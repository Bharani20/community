#!/bin/bash

# Pull the docker image
sudo docker pull sapse/abap-cloud-developer-trial:ABAPTRIAL_2022

# Start the docker container
sudo docker run \
  --stop-timeout 3600 \
  -i \
  --name a4h \
  -h vhcala4hci \
  -p 3200:3200 \
  -p 3300:3300 \
  -p 8443:8443 \
  -p 30213:30213 \
  -p 50000:50000 \
  -p 50001:50001 \
  sapse/abap-cloud-developer-trial:ABAPTRIAL_2022 \
  -skip-limits-check \
  --agree-to-sap-license
