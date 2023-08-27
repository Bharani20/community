# Install ABAP Trail 1909 docker on Google Cloud Platform

The scripts listed in this repository is referred by this medium article. Below is the Google Bard generated explanation of each of the scripts:  

## Create Virtual Machine - create_vm_with_docker.sh

## Virtual Machine Startup Script - vm_startup_script.sh

The script is divided into two parts:

1.  Install Docker Engine
    -   The first part of the script installs Docker Engine on the system. This is done by removing any existing Docker packages, updating the apt package index, installing ca-certificates, curl, and gnupg, creating a directory for Docker's GPG key, downloading Docker's GPG key, making the Docker GPG key readable, creating a file to add Docker's repository to apt, and updating the apt package index again.
    -   Once these steps are complete, Docker Engine will be installed on the system.
2.  Download image and install SAP 1909 Trial
    -   The second part of the script downloads the SAP 1909 Trial image and starts a Docker container from the image. This is done by pulling the Docker image, starting the Docker container, and mapping the container's ports to the host's ports.

The following are the specific steps that are performed in the script:

-   The `for` loop removes any existing Docker packages.
-   The `sudo apt-get update` command updates the apt package index.
-   The `sudo apt-get install zip unzip` command installs zip, and unzip.
-   The `sudo apt-get install ca-certificates curl gnupg` command installs ca-certificates, curl, and gnupg.
-   The `sudo install -m 0755 -d /etc/apt/keyrings` command creates a directory for Docker's GPG key.
-   The `curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg` command downloads Docker's GPG key.
-   The `sudo chmod a+r /etc/apt/keyrings/docker.gpg` command makes the Docker GPG key readable.
-   The `echo` command creates a file to add Docker's repository to apt.
-   The `sudo tee /etc/apt/sources.list.d/docker.list > /dev/null` command writes the file to the `/etc/apt/sources.list.d/docker.list` directory.
-   The `sudo apt-get update` command updates the apt package index again.
-   The `sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin` command installs Docker CE, Docker CE CLI, containerd.io, docker-buildx-plugin, and docker-compose-plugin.
-   The `sudo docker pull sapse/abap-platform-trial:1909` command pulls the Docker image.
-   The `sudo docker run` command starts the Docker container and maps the container's ports to the host's ports.

## Import transport for ABAP SDK for Google Cloud
The code first creates a directory called `abap_sdk_transport` and changes to that directory. Then, it downloads the transport files from the Google Cloud Storage bucket.

```bash
mkdir abap_sdk_transport 
cd abap_sdk_transport 
wget https://storage.googleapis.com/cloudsapdeploy/connectors/abapsdk/abap-sdk-for-google-cloud-1.0.zip
```
Next, the code unzips the transport files.

```bash
unzip abap-sdk-for-google-cloud-1.0.zip
```

Finally, the code copies the files to the `trans` folder of the Docker container named `a4h`. It then runs the `tp` command to import the transport.
```bash
sudo docker cp K900191.GM1 a4h:/usr/sap/trans/cofiles/K900191.GM1 
sudo docker cp R900191.GM1 a4h:/usr/sap/trans/data/R900191.GM1
sudo docker exec -it a4h runuser -l a4hadm -c 'tp addtobuffer GM1K900191 A4H client=001 pf=/usr/sap/trans/bin/TP_DOMAIN_A4H.PFL'
sudo docker exec -it a4h runuser -l a4hadm -c 'tp pf=/usr/sap/trans/bin/TP_DOMAIN_A4H.PFL import GM1K900191 A4H U128 client=001'
```

The `tp` command is used to manage transports in SAP systems. The `addtobuffer` option adds the transport to the buffer, and the `import` option imports the transport.

The `client=001` option specifies the client that the transport will be imported into. The `pf=/usr/sap/trans/bin/TP_DOMAIN_A4H.PFL` option specifies the PFL file that will be used to import the transport.