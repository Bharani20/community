# Include the following ass VM startup script
#curl https://raw.githubusercontent.com/google-cloud-abap/community/main/blogs/abap-trial-docker-1909/vm_startup_script.sh -o /tmp/vm_startup_script.sh
#chmod 755 /tmp/vm_startup_script.sh
#nohup /tmp/vm_startup_script.sh > /tmp/output.txt

#Install Docker Engine
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done

sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

#Download image and install SAP 1909 Trial
#Pull the docker image
sudo docker pull sapse/abap-platform-trial:1909

#Start the docker container
sudo docker run --stop-timeout 3600 -i --name a4h -h vhcala4hci -p 3200:3200 -p 3300:3300 -p 8443:8443 -p 30213:30213 -p 50000:50000 -p 50001:50001 sapse/abap-platform-trial:1909 -skip-limits-check --agree-to-sap-license

#curl https://raw.githubusercontent.com/google-cloud-abap/community/main/blogs/abap-trial-docker-1909/install_sap_1909.sh -o /tmp/install_sap_1909.sh
#chmod 755 /tmp/install_sap_1909.sh
#nohup /tmp/install_sap_1909.sh > /tmp/output.txt &