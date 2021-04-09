## Specify all of the different Azure providers
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  
    azuread = {
      source = "hashicorp/azuread"
      version = "=1.4.0"
    }
  }
}

# Configure the Microsoft Azure Active Directory Provider
provider "azuread" {
  
  tenant_id = var.tenant_id
  client_id = var.aad_client_id
  client_secret = var.aad_client_secret
}

# Configure the Microsoft Azure Resource Manager Provider
provider "azurerm" {
  features {}
 
  subscription_id = var.subscription_id
  tenant_id = var.tenant_id
  client_id = var.arm_client_id
  client_secret = var.arm_client_secret

}

####
# Declare some local variables
####
locals {

  # relociraptor + HELK system (velocihelk)
  vhprivate_ip_address      = "10.100.1.5"

  # endpoint1 - Windows 10 Pro
  prefix                    = "rtc"
  ad_domain                 = "rtc.local"
  endpoint1_ip	            = "10.100.30.11"
  endpoint1_hostname        = "Win10-Lars"
  endpoint1_ad_user         = "lars"
  endpoint1_ad_password     = "Password123"
  endpoint1_install_agent   = true
  admin_username            = "RTCAdmin"
  admin_password            = "Password123"
}

##########################################################
## Create Resource group Network & subnets
##########################################################
module "network" {
  source              = "../modules/network"
  address_space       = var.address_space
  dns_servers         = var.dns_servers
  environment_name    = var.environment_name
  resource_group_name = var.resource_group_name
  location            = var.location
  src_ip              = var.src_ip
  dcsubnet_prefix     = var.dcsubnet_prefix
  dcsubnet_name       = var.dcsubnet_name
  user1_subnet_name   = var.user1_subnet_name
  user1_subnet_prefix = var.user1_subnet_prefix
}

##########################################################
## Create HELK + Velociraptor System
##########################################################
module "velocihelk" {
  source                        = "../modules/velocihelk-vm"  # velocihelk = Velociraptor and HELK
  resource_group_name           = module.network.out_resource_group_name
  location                      = var.location
  prefix                        = local.prefix
  subnet_id                     = module.network.dc_subnet_subnet_id
  vhprivate_ip_address          = local.vhprivate_ip_address
}

### Create Windows 10 Pro VM #1
module "win10-vm1" {
  source                    = "../modules/win10-vm"
  resource_group_name       = module.network.out_resource_group_name
  location                  = var.location
  prefix                    = local.prefix
  ad_domain                 = local.ad_domain
  endpoint_hostname         = local.endpoint1_hostname
  endpoint_ip               = local.endpoint1_ip
  endpoint_ad_user          = local.endpoint1_ad_user
  endpoint_ad_password      = local.endpoint1_ad_password
  subnet_id                 = module.network.user1_subnet_subnet_id
  admin_username            = local.admin_username
  admin_password            = local.admin_password
  install_agent		    = local.endpoint1_install_agent
  vmcount                   = var.vmcount
}
