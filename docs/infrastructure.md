## Infrastructure and Credentials
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


## Remote Access
* **Velociraptor + HELK Server:**  View contents of modules/velocihelk-vm/hosts.cfg.  The second line should show the IP address of the Velociraptor + HELK server that is provisioned a public IP from Azure or AWS.  You can SSH to the host from within that directory:
```
$ ssh -i ssh_key.pem helk@<IP ADDRESS>
```

* **Kibana GUI:**  Use the step above to get the public Azure or AWS IP address of the HELK Server.  Use Firefox browser to navigate to:
```
https://<IP ADDRESS>
```
* **Velociraptor GUI:**  Use the step above to get the public Azure or AWS IP address of the Velociraptor Server.  Use Firefox browser to navigate to:
```
https://<IP ADDRESS>:8889
```
* **Windows Systems:**  For remote RDP access to the Windows 2019 Server or Windows 10 Pro endpoints:  Change into correct modules directory and view contents of hosts.cfg.  The second line should show the public IP address provisioned by Azure or AWS.  Just RDP to it with local Admin credentials above.  The Windows Server will be located in the ```/modules/dc-vm/hosts.cfg```.  The Windows endpoints will be in the directory:  ```/modules/win10-vm```.  
