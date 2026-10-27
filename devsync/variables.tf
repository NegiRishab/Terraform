variable "aws_region" {
  description = "AWS region where the infrastructure will be created."
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Project name used in resource names and tags."
  type        = string
  default     = "devsync"
}

variable "environment" {
  description = "Environment name used for resource tags."
  type        = string
  default     = "practice"
}

variable "vpc_cidr" {
  description = "IPv4 CIDR range for the project VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "IPv4 CIDR range for the public subnet."
  type        = string
  default     = "10.0.1.0/24"
}

variable "admin_cidr" {
  description = "Your public IPv4 address in CIDR notation. Use a single-IP /32 range."
  type        = string

  validation {
    condition     = can(cidrnetmask(var.admin_cidr)) && endswith(var.admin_cidr, "/32") && var.admin_cidr != "0.0.0.0/0"
    error_message = "Set admin_cidr to your public IPv4 address followed by /32, for example 203.0.113.10/32."
  }
}

variable "key_name" {
  description = "Name of an existing EC2 key pair in the selected AWS region."
  type        = string
}

variable "jenkins_instance_type" {
  description = "EC2 instance type for the Jenkins server."
  type        = string
  default     = "t3.small"
}

variable "app_instance_type" {
  description = "EC2 instance type for the DevSync application server."
  type        = string
  default     = "t3.small"
}
