variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "public_subnets" {
  description = "Subnets CIDR"
  type        = list(string)
}

variable "instance_type" {
  description = "Instance Type"
  type        = string
}

variable "key_name" {
  description = "SSH key name"
  type        = string
  #default     = "jenkins-server-key2"
}
