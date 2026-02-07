locals {
  ami_map = {
   
    amazon-linux  = data.aws_ami.amazon_linux.id
  }
}

resource "aws_security_group" "sg" {
  name        = "allow_ssh"
  description = "Allow SSH, HTTP, App"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2" {
  for_each = var.instance

 ami           = local.ami_map[each.value.ami_type]
  instance_type = each.value.instance_type

  vpc_security_group_ids      = [aws_security_group.sg.id]
  associate_public_ip_address = true

  root_block_device {
    volume_size = each.value.root_volume.volume_size
    volume_type = each.value.root_volume.volume_type
  }

  tags = {
    Name = "EC2-${each.key}"
  }
}