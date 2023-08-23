#!/bin/bash

echo "Set defalut paramters"
instance_name="abap-trial-docker"
instance_ready="false"


echo "Create firewal rules"


echo "Create Virtual Machine e2-highme-2, debian-12-bookworm, 200gb"



echo "Checking if system is ready..."


IP=$(gcloud compute instances list | awk '/'$instance_name'/ {print $5}')

while [ "$instance_ready" == false ]
do
	if nc -w 1 -z $IP 22; then
		echo "OK! Ready for docker instllation"
		break
	else
		echo "Maybe later?"
		sleep 60
		instance_ready = true
	fi
done

echo "Completed!!!"

#for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done
#
#sudo apt-get update
#sudo apt-get install ca-certificates curl gnupg
#sudo install -m 0755 -d /etc/apt/keyrings
#curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
#sudo chmod a+r /etc/apt/keyrings/docker.gpg
#echo \
#  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
#  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
#  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
#sudo apt-get update
#sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
