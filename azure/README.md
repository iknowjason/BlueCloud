# Azure Installation
**Note:**  Tested on Ubuntu Linux 20.04 

## Requirements
* Azure tenant and subscription
* Terraform:  Tested on v0.14.7
* Ansible:  Tested on 2.9.6

## Azure Installation Steps

**Note:**  Tested on Ubuntu 20.04

**Step 1:** Install Terraform and Ansible on your Linux system

Download and install Terraform for your platform --> https://www.terraform.io/downloads.html

Install Ansible
```
$ sudo apt-get install ansible
```

**Step 2:** Set up an Azure Service Principal on your Azure subscription that allows Terraform to automate tasks under your Azure subscription.


Follow the exact instructions in this Microsoft link:
https://docs.microsoft.com/en-us/azure/developer/terraform/getting-started-cloud-shell

These were the two basic commands that were run based on this link above:
```
az ad sp create-for-rbac --role="Owner" --scopes="/subscriptions/<subscription_id>"
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
$ git clone https://github.com/iknowjason/BlueCloud.git
```

**Step 4:** First, copy the terraform.tfexample to terraform.tfvars.  Next, using your favorite text editor, edit the terraform.tfvars file for the Azure resource provider matching your Azure Service Principal credentials.  

```
cd PurpleCloud/deploy
cp terraform.tfexample terraform.tfvars
vi terraform.tfvars
```

Edit these parameters in the terraform.tfvars file, replacing "REPLACE_WITH_YOUR_VALUES" to correctly match your Azure environment.  
```
arm_client_id = "REPLACE_WITH_YOUR_VALUES"
arm_client_secret = "REPLACE_WITH_YOUR_VALUES"
subscription_id = "REPLACE_WITH_YOUR_VALUES"
tenant_id = "REPLACE_WITH_YOUR_VALUES"
```

Your terraform.tfvars file should look similar to this but with your own Azure Service Principal credentials:
```
arm_client_id = "7e9c2cce-8bd4-887d-b2b0-90cd1e6e4781"
arm_client_secret = ":+O$+adfafdaF-?%:.?d/EYQLK6po9`|E<["
subscription_id = "aa9d8c9f-34c2-6262-89ff-3c67527c1b22"
tenant_id = "8b6817d9-f209-2071-8f4f-cc03332847cb"
```

**Step 5:**  Edit the terraform.tfvars file to include your source network prefix for properly white listing Azure Network Security Groups (NSGs).
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
$ cd BlueCloud/azure/deploy
$ terraform init
$ terraform apply -var-file=terraform.tfvars -auto-approve
```

This should start the Terraform automated deployment plan


# Shutting down / cleaning up
```
$ cd BlueCloud/azure/deploy
$ ./destroy.sh
```
