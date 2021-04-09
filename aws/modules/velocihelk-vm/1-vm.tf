# AWS AMI for Ubuntu 18.04 Pro
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["*ubuntu-bionic-18.04-amd64-pro-serv*"]
  }
  owners = ["679593333241"] # Amazon re-direct to "Supported Images" 
}

# EC2 Instance
resource "aws_instance" "velocihelk-bluecloud" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.xlarge"
  key_name      = var.key_name
  subnet_id     = var.sn_velocihelk
  private_ip	= var.vhprivate_ip_address
  associate_public_ip_address = true
  vpc_security_group_ids = [
    var.sg_velocihelk,
  ]

  root_block_device {
    volume_size           = 60 
  }
 
  tags = { 
    "Name" = "BlueCloud-velocihelk"
    "Site" = "my-web-site"
  }
}

# write ssh key to file
resource "local_file" "ssh_key" {
    content = var.private_key 
    filename = "${path.module}/ssh_key.pem"
    file_permission = "0700"
}

# write public IP address of Linux host to file
resource "local_file" "hosts_cfg" {
    content = templatefile("${path.module}/templates/hosts.tpl",
        {
        ip = aws_instance.velocihelk-bluecloud.public_ip
        huser = "ubuntu"
        }
    )
    filename = "${path.module}/hosts.cfg"

}
