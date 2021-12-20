resource "aws_key_pair" "management" {
  key_name   = "management"
  public_key = file(var.public_key)
}