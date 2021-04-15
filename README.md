# Overview
Automated Terraform deployment of HELK in Azure!  Automated deployment of one HELK server with one registered Windows 10 endpoint in Azure VM infrastructure.  A collection of Terraform and Ansible scripts that automatically (and quickly) deploys a small HELK R&D lab.

# Overview
Multi-use Hybrid + Identity Cyber Range implementing a small Active Directory Domain in Azure alongside Azure AD and Azure Domain Services.  Automated templates for building your own Pentest / Red Team / Cyber Range in the Azure cloud!  Purple Cloud is a small Active Directory enterprise deployment automated with Terraform / Ansible Playbook templates to be deployed in Azure.  Purple Cloud also includes an adversary node accessible over RDP as well as a DFIR & Live Response system (Velociraptor + HELK).

# Overview

Automated Terraform deployment of Velociraptor in Azure!  

https://www.velocidex.com/about/

Automated deployment of one Velociraptor server with one registered Windows 10 endpoint in Azure VM infrastructure.  A collection of Terraform and Ansible scripts that automatically (and quickly) deploys a small Velociraptor R&D lab.



# Use Cases
* EDR Testing lab 
* Penetration Testing lab
* SIEM / Threat Hunting / DFIR / Live Response lab with HELK + Velociraptor [1, 2]
* Data Science research with HELK server, Jupyter notebooks
* Detection Engineering research with Mordor [3, 4]


# Features and Information
* **New Feature: Combined Velociraptor + HELK System!**  Velociraptor [1] + Hunting ELK [2] System: Windows 10 Endpoints instrumented with agents to auto register Velociraptor and send Sysmon logs
* **New Feature:**  Three tools for Adversary Simulation: Script to automatically invoke Atomic Red Team unit tests using Ansible playbook.
* **New Feature:**  Support for AWS and Azure - Terraform provider support for AWS, Azure.
* Deploys one Linux 18.04 HELK Server with data science capabiliies.  Deploys HELK install option #4, including KAFKA + KSQL + ELK + NGNIX + SPARK + JUPYTER + ELASTALERT
* Windows endpoint is automatically configured with Sysmon (SwiftOnSecurity) and Winlogbeat
* Windows endpoint is automatically configured to use HELK configuration + Kafka Winlogbeat output to send logs to HELK
* Automatically registers the Windows endpoint to the Velociraptor server with TLS self-signed certificate configuration
* Windows endpoint includes Atomic Red Team (ART), Elastic Detection RTA, and APTSimulator
* Uses Terraform templates to automatically deploy in Azure with VMs
* Terraform templates write customizable Ansible Playbook configuration
* Azure NSGs and AWS Security Groups can whitelist your source prefix (for added security)
* The following ports are opened through Azure and AWS Security Groups for ingress TCP traffic: RDP (3389), WinRM HTTP (5985), WinRM HTTPS (5986), SSH (22), HTTPS (443), Spark (8080), KQL (8088), Zookeeper (2181), Velociraptor GUI (8889), Velociraptor Agent (8000)
* **Approximate build time:**  16 minutes
* **Approximate Monthly Cost:**  $ per month

# Infrastructure and Credentials
* **Velociraptor + HELK Internal IP**
  * 10.100.1.5
* **Windows VM Internal IP**
  * 10.100.30.11
* **Windows VM Local Administrator credentials:**
  * RTCAdmin:Password123
* **Subnets**
  * 10.100.1.0/24 (Server Subnet with HELK + Velociraptor)
  * 10.100.30.0/24 (User Subnet with Windows Endpoint)
* **HELK + Velociraptor Linux OS username**  
  * helk (Uses SSH public key auth)
* **HELK Kibana Administrator Password for https port 443**  
  * helk:hunting
* **Velociraptor GUI Administrator Password for Port 8889**  
  * vadmin:vadmin
* **Windows OS in Azure:**
  * Windows 10 Pro
* **Windows OS in AWS:**
  * Windows 2019 Server

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

# Remote Access
* **Velociraptor + HELK Server:**  View contents of modules/velocihelk-vm/hosts.cfg.  The second line should show the IP address of the Velociraptor + HELK server that is provisioned a public IP from Azure.  You can SSH to the host from within that directory:
```
$ ssh -i ssh_key.pem helk@<IP ADDRESS>
```

* **Kibana GUI:**  Use the step above to get the public Azure IP address of the HELK Server.  Use Firefox browser to navigate to:
```
https://<IP ADDRESS>
```
* **Velociraptor GUI:**  Use the step above to get the public Azure IP address of the Velociraptor Server.  Use Firefox browser to navigate to:
```
https://<IP ADDRESS>:8889
```
* **Windows Systems:**  For remote RDP access to the Windows 2019 Server or Windows 10 Pro endpoints:  Change into correct modules directory and view contents of hosts.cfg.  The second line should show the public IP address provisioned by Azure.  Just RDP to it with local Admin credentials above.  The Windows Server will be located in the ```/modules/dc-vm/hosts.cfg```.  The Windows endpoints will be in the directory:  ```/modules/win10-vm```.  Depending on which Windows 10 module is enabled, the following files will specify the public IP address for which host you are attempting to RDP into:
```
hosts-Win10-John.cfg
hosts-Win10-Lars.cfg
hosts-Win10-Liem.cfg
hosts-Win10-Olivia.cfg
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



# References

[1] Velociraptor Website:  https://www.velocidex.com/

[2] HELK Website:  https://github.com/Cyb3rWard0g/HELK

[3] Mordor Website:  https://mordordatasets.com/introduction.html

[4] Mordor Use Case:  https://posts.specterops.io/enter-mordor-pre-recorded-security-events-from-simulated-adversarial-techniques-fdf5555c9eb1

[5] Atomic Red Team:  https://github.com/redcanaryco/atomic-red-team

[6] Invoke ART:  https://github.com/redcanaryco/invoke-atomicredteam

[7] Elastic Detection Rules:  https://github.com/elastic/detection-rules

[8] APTSimulator:  https://github.com/NextronSystems/APTSimulator

# Credits

@ghostinthewires for his Terraform templates (https://github.com/ghostinthewires)

@mosesrenegade for his Ansible Playbook integration with Terraform + Powershell script (https://github.com/mosesrenegade)
