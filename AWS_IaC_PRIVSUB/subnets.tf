resource "aws_subnet" "clip_private_subnet-1" {
  vpc_id                  = aws_vpc.clip_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-west-1c"
  tags = {
    Name = "clip_private_subnet-1"
  }
}

resource "aws_subnet" "clip_private_subnet-2" { #mysql requires 2 subnets in 2 AZ at least.
  vpc_id                  = aws_vpc.clip_vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-west-1b"
  tags = {
    Name = "clip_private_subnet-2"
  }
}

resource "aws_subnet" "clip_private_subnet-3" { #third subnet for EC2.
  vpc_id                  = aws_vpc.clip_vpc.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-west-1b"
  tags = {
    Name = "clip_private_subnet-3"
  }
}


resource "aws_db_subnet_group" "clip_sub_group" { #subnet group mysql rds.
  name       = "clip_sub_group"
  subnet_ids = [aws_subnet.clip_private_subnet-1.id, aws_subnet.clip_private_subnet-2.id]

  tags = {
    Name = "My DB subnet group"
  }
}