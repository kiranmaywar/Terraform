/**
 * EC2 Details.
 */
variable "instance_type" {}

variable "volume_size" {}

variable "key_name" {}

variable "ami_id" {}

variable "bastian_subnet" {}

variable "frontend_subnet" {}

variable "backend_subnet" {}

variable "bastian_security_group" {}

variable "frontend_security_group" {}

variable "backend_security_group" {}