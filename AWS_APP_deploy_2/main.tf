#This will create a VPC with private subnts same region/AZ for EC2 & MySQL RDS on AWS using Terraform.
resource "aws_key_pair" "my-key" {
  key_name   = "mykey"
  public_key = file("mykey.pub")
}

resource "aws_instance" "clip-mysql" {
  ami           = var.AMIS[var.REGION] #North Carlifornia region.
  instance_type = "t2.medium"          #free tier.
  # subnet_id              = aws_subnet.clip_private_subnet-3.id #Private Subnet for EC2 instance.
  key_name = aws_key_pair.my-key.key_name
  #availability_zone      = var.ZONE1
  #vpc_security_group_ids = ["sg-00102b2ace39a97c4"]
  #vpc_security_group_ids = [aws_security_group.clip_mysql-sg.id] #Allow SSH connection from my ip.
  security_groups = ["clip_mysql-sg"]
  tags = {
    Name = "clip-mysql"
  }

  provisioner "file" {
    source      = "mysql.sh"
    destination = "/tmp/mysql.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod u+x /tmp/mysql.sh",
      "sudo /tmp/mysql.sh"
    ]
  }

  connection {
    user        = var.USER
    private_key = file("mykey")
    host        = self.public_ip
  }


}


data "template_file" "init" {
  template = file("ec2-app.sh.tpl")

  vars = {
    local = "${aws_instance.clip-mysql.public_ip}"
  }
}

resource "aws_instance" "clip-ec2" {
  ami           = var.AMIS[var.REGION] #North Carlifornia region.
  instance_type = "t2.micro"           #free tier.
  # subnet_id              = aws_subnet.clip_private_subnet-3.id #Private Subnet for EC2 instance.
  # vpc_security_group_ids = ["sg-087e5f339e281caa6"]
  #availability_zone      = var.ZONE1
  key_name = aws_key_pair.my-key.key_name
  # vpc_security_group_ids = [aws_security_group.clip_ec2_sg.id] #Allow SSH connection from my ip.
  security_groups = ["clip_ec2_sg"]
  user_data       = data.template_file.init.rendered

  tags = {
    Name = "clip-ec2"
  }

  depends_on = [
    aws_instance.clip-mysql,
  ]
}