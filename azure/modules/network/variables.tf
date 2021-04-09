variable resource_group_name {}
variable environment_name {}
variable location {}
variable address_space {}
variable dns_servers {}

variable user1_subnet_name {}
variable user1_subnet_prefix {}
variable dcsubnet_name {}
variable dcsubnet_prefix {}

variable "src_ip" {
  type = string
  default = "*"
}
