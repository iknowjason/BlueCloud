resource "null_resource" "provision-sec_tools" {

  provisioner "local-exec" {
    command = "sleep 60"
  }

  provisioner "local-exec" {
    command = "rm -rf ${path.module}/art/atomic-red-team;git clone https://github.com/redcanaryco/atomic-red-team.git ${path.module}/art/atomic-red-team"
  }

  provisioner "remote-exec" {
    inline = ["whoami"]

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

  provisioner "local-exec" {
    command = "ansible-playbook -i '${path.module}/hosts.cfg' '${path.module}/playbook.yml'"
  }
  depends_on = [aws_instance.windows]
}
