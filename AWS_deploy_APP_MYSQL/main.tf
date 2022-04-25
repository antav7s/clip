#This will create a VPC with private subnets same region/AZ for EC2 & MySQL RDS on AWS using Terraform.
#sslajdha
resource "aws_key_pair" "my-key" {
  key_name   = "mykey"
  public_key = file("mykey.pub")
}

resource "aws_instance" "clip-ec2" {
  ami                    = var.AMIS[var.REGION]                #North Carlifornia region.
  instance_type          = "t2.micro"                          #free tier.
  subnet_id              = aws_subnet.clip_private_subnet-3.id #Private Subnet for EC2 instance.
  key_name               = aws_key_pair.my-key.key_name
  vpc_security_group_ids = [aws_security_group.clip_ec2_sg.id] #Allow SSH connection from my ip.
  tags = {
    Name = "clip-ec2"
  }
}

resource "aws_db_instance" "clip_mysql" {
  allocated_storage      = 10
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro" #free tier.
  db_name                = "clip_mysql_db"
  username               = "admin"
  password               = "8oH#i21608241C%!32dwrr"
  parameter_group_name   = "default.mysql5.7"
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.clip_sub_group.id
  vpc_security_group_ids = [aws_security_group.rds-sg.id]
  tags = {
    Name    = "clip_mysql"
    Project = "Challange"
  }
  depends_on = [
    aws_db_subnet_group.clip_sub_group,
  ]
}