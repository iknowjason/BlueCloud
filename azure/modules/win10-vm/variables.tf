variable "resource_group_name" {
  description = "The name of the Resource Group where the Windows Client resources will be created"
}

variable "location" {
  description = "The Azure Region in which the Resource Group exists"
}

variable "install_agent" {
  description = "Install the velociraptor and HELK agent stuff"
  default = true 
}

variable "ad_domain" {
  description = "The name of the AD Domain"
}

variable "prefix" {
  description = "The Prefix used for the Windows Client resources"
}

variable "subnet_id" {
  description = "The Subnet ID which the Windows Client's NIC should be created in"
}

variable "admin_username" {
  description = "The username associated with the local administrator account on the virtual machine"
}

variable "admin_password" {
  description = "The password associated with the local administrator account on the virtual machine"
}

variable "endpoint_hostname" {
  description = "The computer name of the Windows 10 Endpoint"
}

variable "endpoint_ip" {
  description = "The IP Address of the Windows 10 Endpoint"
}

variable "endpoint_ad_user" {
  description = "The Active Directory username associated with the user profile for this machine"
}

variable "endpoint_ad_password" {
  description = "The Active Directory password associated with the user profile for this machine"
}

variable vmcount {}
