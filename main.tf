terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # or "~> 5.87" if you need exactly 5.87+
    }
  }
}

provider "aws" {
  region = var.region
}

variable "region" {
  description = "AWS Region"
  type        = string
  default     = "ap-south-1"
}

variable "ami" {
  description = "Amazon Machine Image ID (Ubuntu 20.04 in ap-south-1)"
  type        = string
  default     = "ami-019715e0d74f695be"
}

variable "type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Existing AWS key pair name"
  type        = string
  default     = "25-nov-2025"
}

resource "aws_instance" "demo" {
  ami           = var.ami
  instance_type = var.type
  key_name      = var.key_name
  count         = 2

  tags = {
    Name = "Demo System-${count.index + 1}"
  }
}

output "instance_ids" {
  value = [for i in aws_instance.demo : i.id]
}

output "public_ips" {
  value = [for i in aws_instance.demo : i.public_ip]
}
