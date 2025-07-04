resource "aws_key" "ec2_key" {
  key_name   = "my_ec2_key"
  public_key = file("terra-key.pub")

}

resource "aws_default_vpc" "default" {
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_security_group" "ec2_sg" {
  name        = "ec2_security_group"
  description = "Security group for EC2 instances"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
