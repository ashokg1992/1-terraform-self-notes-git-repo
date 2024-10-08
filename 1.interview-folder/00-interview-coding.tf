

===============================================================================================
Q) i have 20 vms, and 4 environments, and i use different ec2 types for each environment, then write a module for this?



resource "aws_instance" "instances" {
  count = var.instance_count

  ami = var.ami_id

  instance_type = var.instance_types[count.index]

  key_name = var.key_name

  security_groups = [
    aws_security_group.default.id
  ]

  tags = {
    Name = "my-app-instance-${count.index}"
    Environment = var.environment
  }
}

resource "aws_security_group" "default" {
  name = "default-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

variable "instance_count" {
  type        = number
  default     = 20
  description = "Number of instances to create"
}

variable "ami_id" {
  type        = string
  description = "AMI ID to use for the instances"
}

variable "instance_types" {
  type        = list(string)
  description = "List of instance types to use for different environments"
  default     = ["t2.micro", "t3.medium", "c5.large", "m5.xlarge"]
}

variable "key_name" {
  type        = string
  description = "Key name to use for the instances"
}

variable "environment" {
  type        = string
  description = "Environment to deploy the instances to"
}

module "my_instances" {
  source = "./module"

  instance_count = 20
  ami_id = "ami-0c55b159cbfafe1f0"
  instance_types = ["t2.micro", "t3.medium", "c5.large", "m5.xlarge"]
  key_name = "my-key-pair"
  environment = "prod"
}


===============================================================================================

