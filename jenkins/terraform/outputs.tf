output "bastion" {
  value = aws_instance.bastion.public_ip
}
output "ssh-tunnel-4-jenkins" {
  value = "ssh -L 8080:10.x:8080 ec2-user@${aws_instance.bastion.public_ip}"
}

output "my-ip" {
  value = local.my-ip
}