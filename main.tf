#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-a4f9f2c2
#
# Your subnet ID is:
#
#     subnet-9a479ed3
#
# Your security group ID is:
#
#     sg-00100979
#
# Your Identity is:
#
#     hdays-michel-slug
#

terraform {
  backend "atlas" {
    name         = "sridolfi/training"
  }
}

variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "aws_region" {
  default = "eu-west-1"
}

variable "num_webs" {
  default = "2"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  ami                    = "ami-a4f9f2c2"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-9a479ed3"
  vpc_security_group_ids = ["sg-00100979"]
  count = 3
  
  tags {
    Identity = "hdays-michel-slug"
    tag1     = "tag1"
    tag2     = "tag2"
    Name     = "web ${count.index +1}/${var.num_webs}"
  }
}
