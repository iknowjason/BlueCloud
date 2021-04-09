resource "null_resource" "velociraptor-config_upload" {

  ### upload velociraptor client config
  provisioner "file" {
    source      = "${path.module}/files/Velociraptor.config.yaml"
    destination = "C:/Program Files/Velociraptor/Velociraptor.config.yaml"
    connection {
      host     = aws_instance.windows.public_ip 
      type     = "winrm"
      user     = var.admin_username
      password = var.admin_password
      timeout  = "15m"
      https    = true
      port     = "5986"
      insecure = true
    }
  }

depends_on = [null_resource.provision-sec_tools]

}
