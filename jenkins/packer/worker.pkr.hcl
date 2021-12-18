build {
  source "source.amazon-ebs.ami" {
    ami_name = "jenkins-worker-${var.version}"
  }
  #  sources = ["source.amazon-ebs.ami"]

  provisioner "shell" {
    execute_command = "sudo -E -S sh '{{ .Path }}'"
    script          = "./setup.sh"
  }

  provisioner "shell" {
    execute_command = "sudo -E -S sh '{{ .Path }}'"
    script          = "./worker.sh"
  }

}
