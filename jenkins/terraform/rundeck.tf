terraform {
  required_providers {
    rundeck = {
      source = "terraform-providers/rundeck"
    }
  }
}
provider "rundeck" {
  auth_token = var.rundeck_token
  url        = "http://localhost:4440"
}

locals {
  rundeck = {
    file    = "rundeck_nodes.json"
    bucket  = "rundeck"
    project = "management"
  }
}

#data "aws_s3_bucket" "rundeck" {
#  bucket = "rundeck"
#}

resource "aws_s3_bucket_object" "nodes" {
  bucket       = local.rundeck.bucket
  key          = local.rundeck.file
  content_type = "application/json"
  acl          = "public-read"
  content      = jsonencode({
    bastion = {
      hostname = aws_instance.bastion.public_ip
      username = "ec2-user"
      tags     = "bastion,centos"
    }
  })
}

resource "rundeck_project" "management" {
  depends_on           = [aws_s3_bucket_object.nodes, rundeck_private_key.user]
  name                 = local.rundeck.project
  ssh_key_storage_path = "keys/${rundeck_private_key.user.path}"

  resource_model_source {
    type   = "url"
    config = {
      format = "resourceyaml"
      url    = "https://${local.rundeck.bucket}.s3.cn-northwest-1.amazonaws.com.cn/${local.rundeck.file}"
    }
  }
}

resource "rundeck_private_key" "user" {
  key_material = file("~/.ssh/${var.key_name}.pem")
  path         = "project/${local.rundeck.project}/${var.key_name}.pem"
}