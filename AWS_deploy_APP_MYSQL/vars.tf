variable "REGION" {
  default = "us-west-1"
}

variable "ZONE1" {
  default = "us-west-1c"
}

variable "ZONE2" {
  default = "us-west-1b"
}

variable "AMIS" {
  type = map(any)
  default = {
    us-west-1 = "ami-009726b835c24a3aa" #Ubuntu 18 OS
  }
}

variable "USER" {
  default = "ubuntu" #Ubuntu 18 default user.
}
