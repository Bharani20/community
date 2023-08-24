#!/bin/bash
mkdir abap_sdk_transport
cd abap_sdk_transport
wget  https://storage.googleapis.com/cloudsapdeploy/connectors/abapsdk/abap-sdk-for-google-cloud-1.0.zip
unzip abap-sdk-for-google-cloud-1.0.zip
sudo docker cp K900191.GM1 a4h:/usr/sap/trans/cofiles/K900191.GM1
sudo docker cp R900191.GM1 a4h:/usr/sap/trans/data/R900191.GM1
sudo docker exec -it a4h runuser -l a4hadm -c 'tp addtobuffer GM1K900191 A4H client=001 pf=/usr/sap/trans/bin/TP_DOMAIN_A4H.PFL'
sudo docker exec -it a4h runuser -l a4hadm -c 'tp pf=/usr/sap/trans/bin/TP_DOMAIN_A4H.PFL import GM1K900191 A4H U128 client=001'
