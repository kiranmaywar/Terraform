/**
 * Subnets.
 */

resource "aws_subnet" "bastian" {
  vpc_id                   = aws_vpc.aws_vpc.id
  map_public_ip_on_launch  = true
  cidr_block               = var.bastian_subnet
  availability_zone        = var.availability_zone

tags = merge(
    {
    Name            = "${var.vpc_name}-bastian-subnet"
    }
  )
}

resource "aws_subnet" "frontend" {
  vpc_id                  = aws_vpc.aws_vpc.id
  cidr_block              = var.frontend_subnet
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

tags = merge(
    {
    Name                  = "${var.vpc_name}-frontend-subnet"
    }
    )
}

resource "aws_subnet" "backend" {
  vpc_id                   = aws_vpc.aws_vpc.id
  map_public_ip_on_launch  = false
  cidr_block               = var.backend_subnet
  availability_zone        = var.availability_zone

tags = merge(
    {
    Name            = "${var.vpc_name}-backend-subnet"
    }
  )
}
