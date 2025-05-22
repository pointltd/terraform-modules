variable "name" {
  description = "The name of the Cache Cluster"
  type        = string
}

variable "environment" {
  description = "The environment of the VPC"
  type        = string
}

variable "security_group_ids" {
  description = "The security group IDs to associate with the Cache Cluster"
  type        = list(string)
}

variable "subnet_group_name" {
  description = "The name of the subnet group to associate with the Cache Cluster"
  type        = string
}

