variable "REGION" {
  default = "us-west-2"
}

variable "ZONE1" {
  default = "us-west-2c"
}

variable "ZONE2" {
  default = "us-west-2b"
}

variable "AMIS" {
  type = map(any)
  default = {
    us-west-2 = "ami-02b92c281a4d3dc79" #Amazon Linus 2 OS
  }
}

variable "USER" {
  default = "ec2-user" #Amazon Linus 2 default user.
}

