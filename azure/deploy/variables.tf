
# Provider info
variable subscription_id {}
variable tenant_id {}
variable arm_client_id {}
variable arm_client_secret {}

# Generic info
variable location {}

# Enabling VM modules by passing variables
#variable win10-vm1-enabled {}

variable resource_group_name {}
variable environment_name {}

# Network
variable address_space {}
variable dns_servers {}

variable user1_subnet_name {}
variable user1_subnet_prefix {}
variable dcsubnet_name {}
variable dcsubnet_prefix {}

variable vmcount {}

variable "src_ip" {
  type = string
  default = "*"
}
