locals {
  type = "worker"
}

build {
  sources = ["source.amazon-ebs.ami"]

  provisioner "shell" {
    execute_command = "sudo -E -S sh '{{ .Path }}'"
    script          = "./setup.sh"
  }

  provisioner "shell" {
    execute_command = "sudo -E -S sh '{{ .Path }}'"
    script          = "./worker.sh"
  }

}
