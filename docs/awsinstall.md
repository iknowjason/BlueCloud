# AWS Install

## AWS Requirements
* AWS Programmatic API keys
* Terraform:  Tested on v0.14.7
* Ansible:  Tested on 2.9.6

## Important Security Information:  Security Groups
Some people might be concerned about publicly exposing these cloud resources.  By default, the security groups are wide open for all source prefixes.  There is a variable that will whitelist your source prefix so that only the networks you specify will be allowed through AWS Security Groups.  Make sure you pay close attention to the "src_ip" variable in step 5 below.

## AWS Installation Steps

**Note:**  Tested on Ubuntu 20.04

**Step 1:** Install Terraform and Ansible on your Linux system

Download and install Terraform for your platform --> https://www.terraform.io/downloads.html

Install Ansible
```
$ sudo apt-get install ansible
```

**Step 2:** Generate AWS programmatic API keys and take note of your access_key and secret_key.


**Step 3:** Clone this repo
```
$ git clone https://github.com/iknowjason/BlueCloud.git
```

**Step 4:** First, copy the terraform.tfexample to terraform.tfvars.  Next, using your favorite text editor, edit the terraform.tfvars file for the AWS resource provider matching your AWS API key values.  

```
cd BlueCloud/aws/deploy
cp terraform.tfexample terraform.tfvars
vi terraform.tfvars
```

Edit these parameters in the terraform.tfvars file, replacing "REPLACE_WITH_YOUR_VALUES" to correctly match your AWS environment.  
```
access_key = "REPLACE_WITH_YOUR_VALUES"
secret_key = "REPLACE_WITH_YOUR_VALUES"
```

Your terraform.tfvars file should look similar to this but with your own AWS API key credentials:
```
access_key = "AKIAS3EPLMIHS6T7OWNU"
secret_key = "MHEmms+8Rh2l5JB+qhDcFnFaSzE7xfRi8GMhUGzY"
```

**Step 5:**  Edit the terraform.tfvars file to include your source network prefix for properly white listing AWS Security Groups.
Edit the following file:  deploy/terraform.tfvars
At the bottom of the file, uncomment the "src_ip" variable and populate it with your correct source IP address.  If you don't do this, the AWS Security Groups will open up your two VMs to the public Internet.  Below is exactly where the variable should be uncommented and an example of what it looks like:
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
$ cd BlueCloud/aws/deploy
$ ./destroy.sh
```

