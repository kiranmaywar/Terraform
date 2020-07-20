// The VPC ID
output "vpc_id" {
  value = "${aws_vpc.aws_vpc.id}"
}

// The VPC CIDR
output "cidr_block" {
  value = "${aws_vpc.aws_vpc.cidr_block}"
}


// A list of bastian subnet IDs.
output "bastian_subnet" {
  value = "${aws_subnet.bastian.id}"
}

// A list of frontend subnet IDs.
output "frontend_subnet" {
  value = "${aws_subnet.frontend.id}"
}

// A list of backend subnet IDs.
output "backend_subnet" {
  value = "${aws_subnet.backend.id}"
}

// SG ID.
output "bastian_sg" {
  value = "${aws_security_group.bastian.id}"
}

// SG ID.
output "frontend_sg" {
  value = "${aws_security_group.frontend.id}"
}

// SG ID.
output "backend_sg" {
  value = "${aws_security_group.backend.id}"
}
