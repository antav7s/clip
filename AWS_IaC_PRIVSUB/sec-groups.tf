resource "aws_security_group" "clip_ec2_sg" { #security group ssh connection by public EC2 instance when/if requires.
  name        = "clip_ec2_sg"
  description = "Security Group for ssh"
  vpc_id      = aws_vpc.clip_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_security_group" "rds-sg" { #security group to connect db by private EC2 instance when/if requires.
  name        = "rds-security-group"
  description = "allow inbound access to the database"
  vpc_id      = aws_vpc.clip_vpc.id

  ingress {
    protocol    = "tcp"
    from_port   = 0
    to_port     = 3306
    cidr_blocks = [aws_subnet.clip_private_subnet-3.cidr_block]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}


