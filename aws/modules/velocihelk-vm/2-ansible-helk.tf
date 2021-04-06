  resource "null_resource" "ansible-helk-implementation" {
  
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
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i '${path.module}/hosts.cfg' --private-key '${path.module}/ssh_key.pem' '${path.module}/playbook-helk.yml'"
  }
    depends_on = [aws_instance.velocihelk-bluecloud]
  }
