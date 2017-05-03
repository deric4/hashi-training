#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-2df66d3b
#
# Your subnet ID is:
#
#     subnet-fe40a9a4
#
# Your security group ID is:
#
#     sg-4cc10432
#
# Your Identity is:
#
#     testing-rabbit
#
terraform {
  backend "atlas" {
    name = "deric7/training"
    access_token = "D0twBJ1cMC7NZA.atlasv1.sWIX0kV7bMwR9kYxDYZfby9rXGf5XSvNna2I6zWq2k9LchkFzGzTb5yfsJ1mKNgqiGk"
  }
}

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {
  default = "us-east-1"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  # ...
  count = 2
  instance_type          = "t2.micro"
  ami                    = "ami-2df66d3b"
  subnet_id              = "subnet-fe40a9a4"
  vpc_security_group_ids = ["sg-4cc10432"]

  tags {
    Identity = "testing-rabbit"
    Company  = "Flux7"
    Name     = "Deric"
  }
}

output "public_ip" { 
  value = ["${aws_instance.web.*.public_ip}"]
}

output "public_dns" { 
  value = ["${aws_instance.web.*.public_dns}"]
}
