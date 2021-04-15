# Overview
Automated Terraform deployment of HELK in Azure!  Automated deployment of one HELK server with one registered Windows 10 endpoint in Azure VM infrastructure.  A collection of Terraform and Ansible scripts that automatically (and quickly) deploys a small HELK R&D lab.

# Overview
Multi-use Hybrid + Identity Cyber Range implementing a small Active Directory Domain in Azure alongside Azure AD and Azure Domain Services.  Automated templates for building your own Pentest / Red Team / Cyber Range in the Azure cloud!  Purple Cloud is a small Active Directory enterprise deployment automated with Terraform / Ansible Playbook templates to be deployed in Azure.  Purple Cloud also includes an adversary node accessible over RDP as well as a DFIR & Live Response system (Velociraptor + HELK).

# Overview

Automated Terraform deployment of Velociraptor in Azure!  

https://www.velocidex.com/about/

Automated deployment of one Velociraptor server with one registered Windows 10 endpoint in Azure VM infrastructure.  A collection of Terraform and Ansible scripts that automatically (and quickly) deploys a small Velociraptor R&D lab.



# Use Cases
* Research and pentest lab for Azure AD and Azure Domain Services
* Security testing of Hybrid Join and Azure AD Joined devices 
* EDR Testing lab 
* Enterprise Active Directory lab with domain joined devices
* Malware / reverse engineering to study artifacts against domain joined devices
* SIEM / Threat Hunting / DFIR / Live Response lab with HELK + Velociraptor [1, 2]
* Log aggregator architecture to forward logs to a cloud native SIEM (Azure Sentinel)
* Data Science research with HELK server, Jupyter notebooks
* Detection Engineering research with Mordor [3, 4]


# Quick Fun Facts:
* Deploys one (1) Ubuntu Linux 18.04 HELK Server
* Automatically deploys this HELK install option:  Option 4: 8GB includes KAFKA + KSQL + ELK + NGNIX + SPARK + JUPYTER + ELASTALERT
* Deploys one (1) Windows 10 Professional endpoint with Sysmon (SwiftOnSecurity) and Winlogbeat
* Windows endpoint is automatically configured to use HELK configuration + Kafka Winlogbeat output to send logs to HELK
* Windows endpoint includes Atomic Red Team (ART), Elastic Detection RTA, and APTSimulator
* Terraform VM modules are flexible, allowing you to add your own new VMs in Azure
* Terraform templates write Ansible Playbook configuration, which can be customized
* **Deployment Time:**  Approximately 15 minutes
* **Approximate Monthly Cost:** $104.59 per month
* Azure Network Security Groups (NSGs) can whitelist your source prefix, for added security
* The following ports are opened through Azure NSGs for ingress TCP traffic: RDP (3389), WinRM HTTP (5985), WinRM HTTPS (5986), SSH (22), HTTPS (443), Spark (8080), KQL (8088), Zookeeper (2181)

# Quick Fun Facts:
* Deploys one (1) Ubuntu Linux Velociraptor Server and one (1) Windows 10 Professional endpoint
* Automatically registers the endpoint to the Velociraptor server with TLS self-signed certificate configuration
* Uses Terraform templates to automatically deploy in Azure with VMs
* Terraform VM modules are flexible, allowing you to add your own new VMs in Azure
* Windows endpoint includes Atomic Red Team (ART), Elastic Detection RTA, and APTSimulator
* Velociraptor server service is installed via Debian package
* Terraform templates write Ansible Playbook configuration, which can be customized
* **Deployment Time:**  Approximately 8 minutes and 50 seconds
* **Approximate Monthly Cost:**  $57.91 per month
* Azure Network Security Groups (NSGs) can whitelist your source prefix, for added security
* The following ports are opened through Azure NSGs for ingress TCP traffic:  RDP (3389), WinRM HTTP (5985), WinRM HTTPS (5986), SSH (22), Velociraptor GUI (8889), Velociraptor Agent (8000)


# Infrastructure and Credentials
* Windows 10 VM Admin credentials:  HELKAdmin:Password123
* HELK Linux OS username:  helk (Uses SSH public key auth)
* HELK Kibana Administrator Password for https port 443:  helk:hunting
* Server Subnet (HELK):  10.100.1.0/24
* User Subnet (Windows 10 VM):  10.100.30.0/24
* HELK Internal IP:  10.100.1.4
* Windows 10 VM Internal IP:  10.100.30.11
* Public IP Addresses:  Dynamic Azure allocation for both HELK and Windows 10 VM

* Windows 10 VM Admin credentials:  VAdmin:Password123
* Velociraptor Linux OS username:  vadmin (Uses SSH public key auth)
* Velociraptor GUI Administrator Password for Port 8889:  vadmin:vadmin
* Server Subnet (Velociraptor):  10.100.1.0/24
* User Subnet (Windows 10 VM):  10.100.30.0/24
* Velociraptor Internal IP:  10.100.1.4
* Windows 10 VM Internal IP:  10.100.30.11
* Public IP Addresses:  Dynamic Azure allocation for both Velociraptor and Windows 10 VM


# Remote Access (After Deployment)
* Windows 10 VM:  Change into the modules/win10-vm1 directory and view contents of hosts.cfg.  The second line should show the IP address of the Windows 10 VM.  Just RDP to it with Admin credentials above.
* HELK Server:  Change into the modules/helk directory and iew contents of hosts.cfg.  The second line should show the IP address of the HELK server that is provisioned a public IP from Azure.  You can SSH to the host from within that directory:
```
$ ssh -i ssh_key.pem helk@<IP ADDRESS>
```
* Kibana GUI:  Use the step above to get the public Azure IP address of the HELK Server.  Use Firefox browser to navigate to:
```
https://<IP ADDRESS>
```

* Windows 10 VM:  Change into the modules/win10-vm1 directory and view contents of hosts.cfg.  The second line should show the IP address of the Windows 10 VM.  Just RDP to it with Admin credentials above.
* Velociraptor Server:  Change into the modules/velociraptor directory and view contents of hosts.cfg.  The second line should show the IP address of the Velociraptor server that is provisioned a public IP from Azure.  You can SSH to the host from within that directory:
```
$ ssh -i ssh_key.pem vadmin@<IP ADDRESS>
```
* Velociraptor GUI:  Use the step above to get the public Azure IP address of the Velociraptor Server.  Use Firefox browser to navigate to:
```
https://<IP ADDRESS>:8889
```



**Note:**  Tested on Ubuntu Linux 20.04 

# Requirements
* Azure subscription
* Terraform:  Tested on v0.13.4
* Ansible:  Tested on 2.9.6


# Installation

For Azure installation, navigate to the Azure directory.

For AWS installation, navigate to the AWS directory.

**Note:**  Tested on Ubuntu 20.04

**Step 1:** Install Terraform and Ansible on your Linux system

Download and install Terraform for your platform --> https://www.terraform.io/downloads.html

Install Ansible
```
$ sudo apt-get install ansible
```

**Step 2:** Set up an Azure Service Principal on your Azure subscription that allows Terraform to automate tasks under your Azure subscription

Follow the exact instructions in this Microsoft link:
https://docs.microsoft.com/en-us/azure/developer/terraform/getting-started-cloud-shell

These were the two basic commands that were run based on this link above:
```
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<subscription_id>
```
and this command below.  From my testing I needed to use a role of "Owner" instead of "Contributor".  Default Microsoft documentation shows role of "Contributor" which resulted in errors.  
```
az login --service-principal -u <service_principal_name> -p "<service_principal_password>" --tenant "<service_principal_tenant>"
```
Take note of the following which we will use next to configure our Terraform Azure provider:
```
subscription_id = ""
client_id = ""
client_secret = ""
tenant_id = ""
```

**Step 3:** Clone this repo
```
$ git clone https://github.com/iknowjason/HELK_Azure.git
```

**Step 4:** Using your favorite text editor, edit the terraform.tfvars file for the Azure resource provider matching your Azure Service Principal credentials

```
cd HELK_Azure/option2_helk_endpoint/deploy
vi terraform.tfvars
```

Edit these parameters in the terraform.tfvars file:
```
subscription_id = ""
client_id = ""
client_secret = ""
tenant_id = ""
```

Your terraform.tfvars file should look similar to this but with your own Azure Service Principal credentials:
```
subscription_id = "aa9d8c9f-34c2-6262-89ff-3c67527c1b22"
client_id = "7e9c2cce-8bd4-887d-b2b0-90cd1e6e4781"
client_secret = ":+O$+adfafdaF-?%:.?d/EYQLK6po9`|E<["
tenant_id = "8b6817d9-f209-2071-8f4f-cc03332847cb"
```


**Step 5:**  Edit the terraform.tfvars file to include your source network prefix
Edit the following file:  deploy/terraform.tfvars
At the bottom of the file, uncomment the "src_ip" variable and populate it with your correct source IP address.  If you don't do this, the Azure NSGs will open up your two VMs to the public Internet.  Below is exactly where the variable should be uncommented and an example of what it looks like:
```
# Set variable below for IP address prefix for white listing Azure NSG
# uncomment variable below; otherwise, all of the public Internet will be permitted
# https://ifconfig.me/
# curl https://ifconfig.me
src_ip = "192.168.87.4"
```

**Step 6:** Run the commands to initialize terraform and apply the resource plan

```
$ cd HELK_Azure/option2_helk_endpoint/deploy
$ terraform init
$ ./create.sh
```

This should start the Terraform automated deployment plan


# Shutting down / cleaning up
```
$ cd HELK_Azure/option2_helk_endpoint/deploy
$ ./destroy.sh
```

# Running APT Simulation Tools
This project includes three security tools to run APT simulations for generating forensic artifacts in an automated way.  Here is a quick walkthrough on the three tools that are automatically deployed.  To test efficacy of the detection solution, it is recommended to disable Windows Defender real-time protection setting.  This will allow the simulation tools to run in an environment that will allow them to fully execute, allowing you to look deeper at the forensic artifacts.

**1.  Atomic Red Team (ART)**

The Atomic Red Team scripts are downloaded from the official Github repo [5] and the Invoke-AtomicRedTeam execution framework is automatically downloaded and imported from the following repo [6].  This allows you to more easily run atomic tests and the modules are imported into the powershell session everytime you launch a powershell session.  This is controlled from the following powershell environment script:

```C:\Users\RTCAdmin\Documents\WindowsPowerShell\Microsoft.Powershell_profile.ps1```

Now that this is out of the way, let's show how to run an atomic test for ART!

**Remotely Running Atomics from Linux**

First, there is a python script that you can run to remotely invoke ART from your linux system.  It's a simple wrapper to Ansible Playbook and the location of the script is here:
```
PurpleCloud/modules/win10-vm/invoke-art.py
```
Run it like this:
```
python3 invoke-art.py
```
The script looks for all hosts.cfg files in the working directory and runs the atomic tests against all Windows 10 hosts.  If you only want to run against one of the hosts, run it with the -h flag.  For example:
```
python3 invoke-art.py -h hosts-Win10-Liem.cfg
```
Running it with the -a flag will specify an atomic.
```
python3 invoke-art.py -a T1558.003
```
The script looks for the atomic tests in windows index file:
```
/modules/win10-vm/art/atomic-red-team/atomics/Indexes/Indexes-CSV/windows-index.csv

```

**Manually Running Atomics from the Windows Endpoint**

RDP into the Windows 10 endpoint.  From a powershell session, simply run:
```PS C:\ > Invoke-AtomicTest <ATOMIC_TEST> -PathToAtomicsFolder C:\terraform\ART\atomic-red-team-master\atomics```


The atomics are in the main project directory path of ```C:\terraform\ART\atomic-red-team-master\atomics```.  Browse through them to find which atomic test you want to run.


Example of running T1007: 

```PS C:\Users\RTCAdmin> Invoke-AtomicTest T1007 -PathToAtomicsFolder C:\terraform\ART\atomic-red-team-master\atomics```

**2.  Elastic Detection Rules RTA (Red Team Attacks) scripts**

In June of 2020, Elastic open sourced their detection rules, including Python attack scripts through the Red Team Automation (RTA) project.  The following repo [7] is automatically downloaded and extracted using Terraform and Ansible scripts.  To run them, launch a cmd or powershell session and use python to run each test from the following directory:

Change into the directory:  

```C:\terraform\Elastic_Detections\detection-rules-main```

Run each python script test that you wish.  Each test is in the RTA directory and you invoke the test by removing the *.py (TTPs are referenced as a name by just removing the last *.py from the script):

```PS C:\terraform\Elastic_Detections\detection-rules-main> python -m rta <TTP_NAME>```

Example of 'smb_connection' ttp:

```PS C:\terraform\Elastic_Detections\detection-rules-main> python -m rta smb_connection```

You can browse all TTPs in the 'rta' sub-directory

**3.  APTSimulator**

The APTSimulator tool [8] is automatically downloaded.  Simply extract the Zip archive and supply the zip password of 'apt'.

```C:\terraform\APTSimulator.zip```

Invoke a cmd prompt and run the batch file script:

```C:\terraform\ATPSimulator\APTSimulator\APTSimulator.bat```
