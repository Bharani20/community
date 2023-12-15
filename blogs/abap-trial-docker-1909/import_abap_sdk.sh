#!/bin/bash
#Create directory and download transport
mkdir abap_sdk_transport
cd abap_sdk_transport
wget  https://storage.googleapis.com/cloudsapdeploy/connectors/abapsdk/abap-sdk-for-google-cloud-1.5.zip
wget  https://storage.googleapis.com/cloudsapdeploy/connectors/abapsdk/hotfix/ABAP_SDK_V1_5_HOTFIX.zip

#Unzip the transport files
unzip abap-sdk-for-google-cloud-1.5.zip
unzip ABAP_SDK_V1_5_HOTFIX.zip

#Copy the file to the trans folder of the docker container
sudo docker cp K900219.GM1 a4h:/usr/sap/trans/cofiles/K900219.GM1
sudo docker cp R900219.GM1 a4h:/usr/sap/trans/data/R900219.GM1
sudo docker cp K900221.GM1 a4h:/usr/sap/trans/cofiles/K900221.GM1
sudo docker cp R900221.GM1 a4h:/usr/sap/trans/data/R900221.GM1
sudo docker cp K900223.GM1 a4h:/usr/sap/trans/cofiles/K900223.GM1
sudo docker cp R900223.GM1 a4h:/usr/sap/trans/data/R900223.GM1

#Change owner and permission
sudo docker exec -it a4h runuser -l root -c 'chmod 777 /usr/sap/trans/cofiles/*'
sudo docker exec -it a4h runuser -l root -c 'chmod 777 /usr/sap/trans/data/*'
sudo docker exec -it a4h runuser -l root -c 'chown a4hadm /usr/sap/trans/cofiles/*'
sudo docker exec -it a4h runuser -l root -c 'chown a4hadm /usr/sap/trans/data/*'


#Run the "tp" command to import the transport
sudo docker exec -it a4h runuser -l a4hadm -c 'tp addtobuffer GM1K900219 A4H client=001 pf=/usr/sap/trans/bin/TP_DOMAIN_A4H.PFL'
sudo docker exec -it a4h runuser -l a4hadm -c 'tp addtobuffer GM1K900221 A4H client=001 pf=/usr/sap/trans/bin/TP_DOMAIN_A4H.PFL'
sudo docker exec -it a4h runuser -l a4hadm -c 'tp addtobuffer GM1K900223 A4H client=001 pf=/usr/sap/trans/bin/TP_DOMAIN_A4H.PFL'
sudo docker exec -it a4h runuser -l a4hadm -c 'tp pf=/usr/sap/trans/bin/TP_DOMAIN_A4H.PFL import all A4H U128 client=001'

#sudo docker exec -it a4h runuser -l a4hadm -c 'tp pf=/usr/sap/trans/bin/TP_DOMAIN_A4H.PFL import GM1K900219 A4H U128 client=001'
#sudo docker exec -it a4h runuser -l a4hadm -c 'tp addtobuffer GM1K900221 A4H client=001 pf=/usr/sap/trans/bin/TP_DOMAIN_A4H.PFL'
#sudo docker exec -it a4h runuser -l a4hadm -c 'tp pf=/usr/sap/trans/bin/TP_DOMAIN_A4H.PFL import GM1K900221 A4H U128 client=001'
