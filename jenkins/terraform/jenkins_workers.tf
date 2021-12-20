resource "aws_launch_configuration" "jenkins_workers_launch_conf" {
  name            = "jenkins_workers_config"
  image_id        = data.aws_ami.jenkins-worker.id
  instance_type   = var.jenkins_worker_instance_type
  key_name        = aws_key_pair.management.id
  security_groups = [aws_security_group.jenkins_workers_sg.id]
  user_data       = data.template_file.user_data_jenkins_worker.rendered

  root_block_device {
    volume_type = "gp2"
    volume_size = 8
    #    delete_on_termination = false
  }

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_ami" "jenkins-worker" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = ["jenkins-worker*"]
  }
}

resource "aws_security_group" "jenkins_workers_sg" {
  name        = "jenkins_workers_sg"
  description = "Allow traffic on port 22 from Jenkins master SG"
  vpc_id      = aws_vpc.management.id

  ingress {
    from_port       = "22"
    to_port         = "22"
    protocol        = "tcp"
    security_groups = [
      aws_security_group.jenkins_master_sg.id,
      aws_security_group.bastion_host.id
    ]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name   = "jenkins_workers_sg"
    Author = var.author
  }
}

data "template_file" "user_data_jenkins_worker" {
  template = file("scripts/join-cluster.tpl")

  vars = {
    jenkins_url            = "http://${aws_instance.jenkins_master.private_ip}:8080"
    jenkins_username       = var.jenkins_username
    jenkins_password       = var.jenkins_password
    jenkins_credentials_id = var.jenkins_credentials_id
  }
}