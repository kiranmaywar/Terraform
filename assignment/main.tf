provider "aws" {
  region = var.region
}


module "vpc" {
  source             = "./vpc"
  cidr               = "10.2.0.0/16"
  bastian_subnet     = "10.2.4.0/24"
  frontend_subnet    = "10.2.2.0/24"
  backend_subnet     = "10.2.3.0/24"
  availability_zone  = "us-east-1a"
  vpc_name           = "myvpc"
  ssh_cidr           = ["44.107.3.229/32"]
}

module "ec2" {
  source                       = "./ec2"
  ami_id                       = "ami-08f3d892de259504d"
  instance_type                = "t2.micro"
  key_name                     = "terraform"
  volume_size                  = 10
  bastian_subnet               = module.vpc.bastian_subnet
  frontend_subnet              = module.vpc.frontend_subnet
  backend_subnet               = module.vpc.backend_subnet
  bastian_security_group       = module.vpc.bastian_sg
  frontend_security_group      = module.vpc.frontend_sg
  backend_security_group       = module.vpc.backend_sg
}