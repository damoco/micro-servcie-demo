output "bastion" {
  value = aws_instance.bastion.public_ip
}
output "ssh-tunnel-4-jenkins" {
  value = "ssh -f -L 4000:${aws_instance.jenkins_master.private_ip}:22 -i ~/.ssh/cn.pem ec2-user@${aws_instance.bastion.public_ip} sleep 1000"
}

output "my-ip" {
  value = local.my-ip
}