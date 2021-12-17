variable "aws_profile" {
  type    = string
  default = "packer"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "region" {
  type    = string
  default = "cn-northwest-1"
}

variable "ssh_key" {
  type = string
  default = "../keypair/id_rsa"
}

data "amazon-ami" "autogenerated_1" {
  filters     = {
    name                = "amzn-ami-hvm-*-x86_64-*"
    #    name                = "amzn2-ami-hvm-*-x86_64-*"
    root-device-type    = "ebs"
    virtualization-type = "hvm"
  }
  most_recent = true
  owners      = ["amazon"]
  profile     = "${var.aws_profile}"
  region      = "${var.region}"
}

source "amazon-ebs" "autogenerated_1" {
  ami_description = "Amazon Linux Image with Jenkins Server"
  ami_name        = "jenkins-master-2"
  instance_type   = "${var.instance_type}"
  profile         = "${var.aws_profile}"
  region          = "${var.region}"
  source_ami      = "${data.amazon-ami.autogenerated_1.id}"
  ssh_username    = "ec2-user"
  launch_block_device_mappings {
    device_name           = "/dev/xvda"
    volume_size           = 8
    volume_type           = "standard"
    delete_on_termination = true
  }
}

build {
  sources = ["source.amazon-ebs.autogenerated_1"]

  provisioner "file" {
    source      = "./scripts/"
    destination = "/tmp/"
  }

  provisioner "file" {
    source      = "./config/"
    destination = "/tmp/"
  }

  provisioner "file" {
    source      = var.ssh_key
    destination = "/tmp/"
  }

  provisioner "shell" {
    execute_command = "sudo -E -S sh '{{ .Path }}'"
    script          = "../setup.sh"
  }

  provisioner "shell" {
    execute_command = "sudo -E -S sh '{{ .Path }}'"
    script          = "./setup.sh"
  }

}
