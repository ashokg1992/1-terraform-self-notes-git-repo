# Configure AWS provider
provider "aws" {
  region = "us-east-1"  # Replace with your desired region
}

# Create an EC2 instance
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"  # Replace with a suitable AMI ID
  instance_type = "t2.micro"
  key_name     = "my-key-pair"  # Replace with your key pair name

  tags = {
    Name = "my-ec2-instance"
  }
}

# Create an S3 bucket
resource "aws_s3_bucket" "example" {
  bucket = "my-s3-bucket"
  acl    = "private"  # Set the bucket's ACL to "private" for security

  tags = {
    Name = "my-s3-bucket"
  }
}