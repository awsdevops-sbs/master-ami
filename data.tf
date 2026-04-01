
data "aws_ami" "ami" {
  owners = ["973714476881"]

  filter {
    name   = "image-id"
    values = ["ami-0220d79f3f480ecf5"]
  }
}


data "aws_security_group" "allow-all" {
 name = "Allow-all-from-public"
 }

data "vault_generic_secret" "ssh" {
  path = "common/common"
}