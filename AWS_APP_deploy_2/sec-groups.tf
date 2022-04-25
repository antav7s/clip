resource "aws_security_group" "clip_ec2_sg" { #security group ssh connection by public EC2 instance when/if requires.
  name        = "clip_ec2_sg"
  description = "Security Group for EC2-APP"
  # vpc_id      = aws_vpc.clip_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH intance"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Internet open"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "EC2-APP"
  }
}

resource "aws_security_group" "clip_mysql-sg" { #security group ssh connection by public EC2 instance when/if requires.
  name        = "clip_mysql-sg"
  description = "Security Group for EC2-APP"
  # vpc_id      = aws_vpc.clip_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH intance"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "MySQL Port"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "MySQL Database"
  }
}



