resource "null_resource" "velociraptor-config" {

  provisioner "local-exec" {
    command = "sleep 90"
  }

  provisioner "local-exec" {
    command = "cp ../modules/velocihelk-vm/files/config.yaml ${path.module}/files/Velociraptor.config.yaml"
  }
  depends_on = [aws_instance.windows]
}
