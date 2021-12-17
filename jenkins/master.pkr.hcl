locals {
  type = "master"
}

build {
  sources = ["source.amazon-ebs.ami"]

  provisioner "file" {
    source      = "master/scripts"
    destination = "/tmp/"
  }

  provisioner "file" {
    source      = "master/config"
    destination = "/tmp/"
  }

  provisioner "file" {
    source      = var.ssh_key
    destination = "/tmp/"
  }

  provisioner "shell" {
    execute_command = "sudo -E -S sh '{{ .Path }}'"
    script          = "./setup.sh"
  }

  provisioner "shell" {
    execute_command = "sudo -E -S sh '{{ .Path }}'"
    script          = "./master.sh"
  }

}
