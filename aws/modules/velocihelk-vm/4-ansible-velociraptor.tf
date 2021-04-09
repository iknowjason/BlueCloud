  resource "null_resource" "ansible-velociraptor-implementation" {
  
    provisioner "remote-exec" {
        inline = ["echo 'Hello World'"]

    connection {
      host     = aws_instance.velocihelk-bluecloud.public_ip 
      type     = "ssh"
      user     = "ubuntu"
      private_key = var.private_key 
      timeout  = "3m"
    }
  }
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i '${path.module}/hosts.cfg' --private-key '${path.module}/ssh_key.pem' '${path.module}/playbook-velociraptor.yml'"
  }

  ## config file download after adding client parameter for trusting self-signed cert
  provisioner "local-exec" {
    command = "scp -i ${path.module}/ssh_key.pem ubuntu@${aws_instance.velocihelk-bluecloud.public_ip}:/home/ubuntu/server.config.yaml ${path.module}/files/config.yaml"
  }

    depends_on = [null_resource.velociraptor-config]

  }
