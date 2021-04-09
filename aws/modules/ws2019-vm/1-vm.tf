data "template_file" "ps_template" {
  template = file("${path.module}/files/bootstrap.ps1")

  vars  = {
    ### This is just a placeholder in case we want to add variables into PS script
    auser = var.admin_username
    apwd  = var.admin_password
  }
}

resource "local_file" "debug_bootstrap_script" {
  # For inspecting the rendered powershell script as it is loaded onto endpoint through custom_data extension
  content = data.template_file.ps_template.rendered
  filename = "${path.module}/output/bootstrap-rendered.ps1"
}



# AWS AMI for Windows Server 2019 
data "aws_ami" "windows" {
  most_recent = true

  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-Base-*"]
  }
  owners = ["801119661308"] # Amazon  
}

# EC2 Instance
resource "aws_instance" "windows" {
  ami           = data.aws_ami.windows.id
  instance_type = "t2.micro"
  key_name	= var.key_name
  subnet_id     = var.sn_windows
  associate_public_ip_address = true
  user_data	= data.template_file.ps_template.rendered 
  vpc_security_group_ids = [
    var.sg_windows,
  ]

  root_block_device {
    volume_size           = 30 
  }
 
  tags = { 
    "Name" = "BlueCloud-windows"
    "Site" = "my-web-site"
  }
}

resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/templates/hosts.tpl",
    {
      ip    = aws_instance.windows.public_ip 
      auser = var.admin_username
      apwd  = var.admin_password
    }
  )
  filename = "${path.module}/hosts.cfg"
}

# write ssh key to file
resource "local_file" "ssh_key" {
    content = var.private_key
    filename = "${path.module}/ssh_key.pem"
    file_permission = "0700"
}

