/**
 * bastian sg
 */

resource "aws_security_group" "bastian" {
  name        = "bastian-sg"
  description = "bastian sg "
  vpc_id      = aws_vpc.aws_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

tags = merge(
   {
    Name        = "bastian-sg"
   }
)
}

/**
 * frontend sg
 */

resource "aws_security_group" "frontend" {
  name        = "frontend-sg"
  vpc_id      = aws_vpc.aws_vpc.id
  description = "frontend sg"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

tags = merge(
    {
    Name        = "frontend-sg"
    }
)
}

resource "aws_security_group_rule" "bashian-to-frontend" {
  description              = "Allow ssh from bastian sg"
  from_port                = 22
  source_security_group_id = aws_security_group.bastian.id
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.frontend.id
  type                     = "ingress"
}

/**
 * backend sg
 */

resource "aws_security_group" "backend" {
  name        = "backend-sg"
  description = "backend sg "
  vpc_id      = aws_vpc.aws_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  
tags = merge(
   {
    Name        = "backend-sg"
   }
)
}

resource "aws_security_group_rule" "bashian-to-backend" {
  description              = "Allow ssh from bastian sg"
  from_port                = 22
  source_security_group_id = aws_security_group.bastian.id
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.backend.id
  type                     = "ingress"
}

resource "aws_security_group_rule" "frontend-to-backend" {
  description              = "Allow ssh from bastian sg"
  from_port                = 80
  source_security_group_id = aws_security_group.frontend.id
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.backend.id
  type                     = "ingress"
}