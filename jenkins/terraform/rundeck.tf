terraform {
  required_providers {
    rundeck = {
      source = "terraform-providers/rundeck"
    }
  }
}
provider "rundeck" {
  auth_token = var.rundeck_token
  url        = "localhost:4440"
}

locals {
  rundeck = {
    file   = "rundeck_nodes.yml"
    bucket = "rundeck"
  }
}

#data "aws_s3_bucket" "rundeck" {
#  bucket = "rundeck"
#}

resource "aws_s3_bucket_object" "nodes" {
  bucket  = local.rundeck.bucket
  key     = local.rundeck.file
  content = jsonencode({
    bastion = {
      hostname = aws_instance.bastion.public_ip
      username = "ec2-user"
    }
  })
}

resource "rundeck_project" "management" {
  depends_on = [aws_s3_bucket_object.nodes]
  name       = "management"
  resource_model_source {
    type   = "url"
    config = {
      format = "resourceyaml"
      url    = "https://${local.rundeck.bucket}.s3.cn-northwest-1.amazonaws.com.cn/${local.rundeck.file}"
    }
  }
}