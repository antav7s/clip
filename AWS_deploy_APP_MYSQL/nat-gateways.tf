/*
**NAT gateway are charge cost, destroy if you don´t want to pay for it.** ## not needed for this exercise


resource "aws_nat_gateway" "private-nat-1" {
  connectivity_type = "private"
  subnet_id         = aws_subnet.clip_private_subnet-1.id #mysql AZ1/privsub1 RDS requires at least 2 subnets in 2 different availability domains
  depends_on = [
    aws_subnet.clip_private_subnet-1
  ]
}

resource "aws_nat_gateway" "private-nat-2" {
  connectivity_type = "private"
  subnet_id         = aws_subnet.clip_private_subnet-2.id #mysql AZ2/privsub2 RDS requires at least 2 subnets in 2 different availability domains
  depends_on = [
    aws_subnet.clip_private_subnet-2
  ]
}

resource "aws_nat_gateway" "private-nat" {
  connectivity_type = "private"
  subnet_id         = aws_subnet.clip_private_subnet-3.id #EC2 AZ1/privsub3 private instance in different subnet than RDS, in same Availability Zone.
  depends_on = [
    aws_subnet.clip_private_subnet-3
  ]
}

*/