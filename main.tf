
resource "aws_instance" "ami" {

  ami = data.aws_ami.ami.image_id
  instance_type = "t3.small"
  vpc_security_group_ids = [data.aws_security_group.allow-all.name]

  tags = {
    Name = "ami-server"
  }
}


resource "null_resource" "ansible" {

  connection {
    type        = "ssh"
    user        = jsondecode(data.vault_generic_secret.ssh.data_json).ansible_username
    password    = jsondecode(data.vault_generic_secret.ssh.data_json).ansible_password
    #host        = aws_instance.instance.public_ip
    host        = aws_instance.ami.private_ip

  }

  provisioner "remote-exec" {

    inline = [

      "sudo pip3 install ansible hvac",

    ]
  }
}

resource "aws_ami_from_instance" "ami" {
  depends_on = [null_resource.ansible]
  name               = "golden-ami-${formatdate("DD-MM-YY",timestamp())}"
  source_instance_id = aws_instance.ami.id

}
