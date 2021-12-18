resource "aws_subnet" "public_subnets" {
  vpc_id                  = aws_vpc.management.id
  cidr_block              = "10.0.${count.index*2+1}.0/24"
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true
  count                   = var.public_subnets_count
  tags                    = {
    Name   = "public_10.0.${count.index*2+1}.0/24_${element(var.availability_zones, count.index)}"
    Author = var.author
  }
}