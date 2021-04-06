## Specify aws provider 
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.35.0"
    }
  }
}

provider "aws" {
  region 	= var.region 
  access_key 	= var.access_key 
  secret_key 	= var.secret_key 
}

####
# Declare some local variables
####
locals {

  # Velociraptor + HELK system (velocihelk)
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
# Create new EC2 key pair
##########################################################
resource "tls_private_key" "this" {
  algorithm = "RSA"
}

module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name   = "deployer-one"
  public_key = tls_private_key.this.public_key_openssh
}


##########################################################
## Create Resource group Network & subnets
##########################################################
module "network" {
  source                = "../modules/network"
  environment_name      = var.environment_name
  resource_group_name   = var.resource_group_name
  src_ip                = var.src_ip
  vpc_cidr		= var.vpc_cidr
  vpc_id		= var.vpc_id
}

##########################################################
## Create HELK + Velociraptor System
##########################################################
module "velocihelk" {
  source                    = "../modules/velocihelk-vm"  # velocihelk = Velociraptor and HELK
  sg_velocihelk		    = module.network.sg_velocihelk 
  sn_velocihelk             = module.network.sn_velocihelk 
  vhprivate_ip_address      = local.vhprivate_ip_address 
  key_name	            = module.key_pair.this_key_pair_key_name
  private_key	            = tls_private_key.this.private_key_pem

}

### Create Windows 10 Pro VM #1
/*module "win10-vm1" {
  source                    = "../modules/win10-vm"
  resource_group_name       = module.network.out_resource_group_name
  location                  = var.location
  prefix                    = local.prefix
  ad_domain                 = local.ad_domain
  endpoint_hostname         = local.endpoint1_hostname
  endpoint_ip               = local.endpoint1_ip
  endpoint_ad_user          = local.endpoint1_ad_user
  endpoint_ad_password      = local.endpoint1_ad_password
  #subnet_id                 = module.network.user1_subnet_subnet_id
  admin_username            = local.admin_username
  admin_password            = local.admin_password
  install_agent		    = local.endpoint1_install_agent
  vmcount                   = var.vmcount
}*/
