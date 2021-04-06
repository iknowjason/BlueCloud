  resource "null_resource" "velociraptor-config" {
  
  provisioner "local-exec" {
    command = "${path.module}/velociraptor config generate > ${path.module}/files/config.yaml"
  }

  ## Change client URL in config
  provisioner "local-exec" {
    command = "sed -i 's/localhost:8000/10.100.1.5:8000/g' ${path.module}/files/config.yaml"
  }

  ## Change server bind in config
  provisioner "local-exec" {
    command = "sed -i 's/bind_address: 127.0.0.1/bind_address: 10.100.1.5/g' ${path.module}/files/config.yaml"
  }

  provisioner "file" {
    source      = "${path.module}/files/config.yaml"
    destination = "/home/ubuntu/server.config.yaml"
    connection {
      host     = aws_instance.velocihelk-bluecloud.public_ip 
      type     = "ssh"
      user     = "ubuntu"
      private_key = var.private_key 
      timeout  = "3m"
    }
  }
    depends_on = [aws_instance.velocihelk-bluecloud]
  }
