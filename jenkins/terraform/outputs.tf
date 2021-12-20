output "bastion" {
  value = aws_instance.bastion.public_ip
}
output "jenkins" {
  value = {
    ssh-tunnel = "ssh -f -L 4000:${aws_instance.jenkins_master.private_ip}:22 -i ~/.ssh/cn.pem ec2-user@${aws_instance.bastion.public_ip} sleep 1000"
    elb        = aws_elb.jenkins_elb.dns_name
    dns        = "https://${aws_route53_record.jenkins_master.name}"
  }
}

output "my-ip" {
  value = local.my-ip
}