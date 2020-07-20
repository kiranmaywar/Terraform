/**
 * VPC
 */

resource "aws_vpc" "aws_vpc" {
  cidr_block           = var.cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

tags = merge(
    {
    Name = "${var.vpc_name}"
    }
  )
}


/**
 * Gateways
 */

resource "aws_internet_gateway" "aws_igw" {
  vpc_id            = aws_vpc.aws_vpc.id

tags = merge(
    {
    Name             = "${var.vpc_name}-igw"
    }
    )
}

/**
 * eip for nat gateway
 */

resource "aws_eip" "aws_nat_ip" {
  depends_on      = [aws_internet_gateway.aws_igw]
  vpc             = true

tags = merge(
    {
    Name             = "${var.vpc_name}-nat-gw-eip"
    }
  )
}

/**
 * nat gateway
 */

resource "aws_nat_gateway" "aws_nat_gateway" {
  subnet_id       = aws_subnet.bastian.id
  allocation_id   = aws_eip.aws_nat_ip.id
  depends_on      = [aws_internet_gateway.aws_igw, aws_subnet.bastian]

tags = merge(
    {
    Name             = "${var.vpc_name}-nat-gw"
    }
  )
}