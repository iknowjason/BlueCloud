
# Provider info
variable region {}
variable access_key {}
variable secret_key {}

# Generic info
variable location {}

variable resource_group_name {}
variable environment_name {}

# Network
variable vpc_cidr {}
variable sn_velocihelk {}
variable sn_windows {}
variable vpc_id {}

# SSH keys
variable key_name {}
variable private_key {}

# Security Groups
variable sg_velocihelk {}
variable sg_windows {}

variable vmcount {}

variable "src_ip" {
  type = string 
  default = "0.0.0.0/0"
}
