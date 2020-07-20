/**
 * Route tables
 */

resource "aws_route_table" "public" {
  vpc_id            = aws_vpc.aws_vpc.id

tags = merge(
    {
    Name            = "${var.vpc_name}-public-rt"
    }
)
}

resource "aws_route_table" "private" {
  vpc_id                = aws_vpc.aws_vpc.id

tags = merge(
    {
    Name                 = "${var.vpc_name}-private-rt"
    }
  )
}


/**
 * Route associations
 */

resource "aws_route_table_association" "bastian" {
  subnet_id      = aws_subnet.bastian.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "frontend" {
  subnet_id      = aws_subnet.frontend.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "backend" {
  subnet_id      = aws_subnet.backend.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route" "public" {
  depends_on             = [aws_route_table.public]
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.aws_igw.id
}

resource "aws_route" "private" {
  depends_on             = [aws_nat_gateway.aws_nat_gateway]
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.aws_nat_gateway.id
}