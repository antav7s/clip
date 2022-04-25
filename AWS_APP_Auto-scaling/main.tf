#This will create a VPC with private subnts same region/AZ for EC2 & MySQL RDS on AWS using Terraform.
resource "aws_key_pair" "my-key" {
  key_name   = "mykey"
  public_key = file("mykey.pub")
}


data "template_file" "init2" {
  template = file("mysql.sh.tpl")
}

resource "aws_instance" "clip-mysql" {
  ami           = var.AMIS[var.REGION] #North Carlifornia region.
  instance_type = "t2.medium"          #free tier.
  key_name = aws_key_pair.my-key.key_name
  security_groups = ["clip_mysql-sg"]
  user_data       = data.template_file.init2.rendered
  tags = {
    Name = "clip-mysql"
  }
}

data "template_file" "init" {
  template = file("ec2-app.sh.tpl")

  vars = {
    local = "${aws_instance.clip-mysql.public_ip}"
  }
}

resource "aws_launch_template" "asg-template-t2micro" {
  name_prefix          = "asg-template-t2micro"
  image_id             = var.AMIS[var.REGION]
  instance_type        = "t2.micro"
  key_name             = aws_key_pair.my-key.key_name
  security_group_names = ["clip_ec2_sg"]
  user_data            = base64encode(data.template_file.init.rendered)
}

resource "aws_autoscaling_group" "as-ubuntu" {
  availability_zones = [var.ZONE1]
  desired_capacity   = 3
  max_size           = 3
  min_size           = 2

  launch_template {
    id      = aws_launch_template.asg-template-t2micro.id
    version = aws_launch_template.asg-template-t2micro.latest_version
  }

  tag {
    key                 = "Name"
    value               = "EC2_APP"
    propagate_at_launch = true
  }
  depends_on = [
    aws_instance.clip-mysql,
  ]
}
