## UserData For EC2
data "template_file" "backend" {
  template = "${file("${path.module}/userdata/backend.sh")}"
}

data "template_file" "frontend" {
  template = "${file("${path.module}/userdata/frontend.sh")}"
}

## Bastian EC2 Instance
resource "aws_instance" "bastian" {
  monitoring             = false
  source_dest_check      = false
  ami                    = var.ami_id
  key_name               = var.key_name
  subnet_id              = var.bastian_subnet
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.bastian_security_group]

 ebs_block_device {
    device_name = "/dev/sdb"
    volume_size = var.volume_size
    volume_type = "gp2"
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }
tags = merge(
    {
    Name        = "bastian"
    }
)
}

## Frontend EC2 Instance
resource "aws_instance" "frontend" {
  monitoring             = false
  source_dest_check      = false
  ami                    = var.ami_id
  key_name               = var.key_name
  subnet_id              = var.frontend_subnet
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.frontend_security_group]
  user_data              = data.template_file.frontend.rendered

 ebs_block_device {
    device_name = "/dev/sdb"
    volume_size = var.volume_size
    volume_type = "gp2"
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }
tags = merge(
    {
    Name        = "frontend"
    }
)
}

## backend EC2 Instance
resource "aws_instance" "backend" {
  monitoring             = false
  source_dest_check      = false
  ami                    = var.ami_id
  key_name               = var.key_name
  subnet_id              = var.backend_subnet
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.backend_security_group]
  user_data              = data.template_file.backend.rendered

 ebs_block_device {
    device_name = "/dev/sdb"
    volume_size = var.volume_size
    volume_type = "gp2"
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }
tags = merge(
    {
    Name        = "backend"
    }
)
}
