## Use Cases
* EDR Testing lab
* PoC / Product Security Lab 
* Penetration Testing lab
* SIEM / Threat Hunting / DFIR / Live Response lab with HELK + Velociraptor [1, 2]
* Data Science research with HELK server, Jupyter notebooks
* Detection Engineering research with Mordor [3, 4]

## Features and Information
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
