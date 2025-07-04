resource "aws_key_pair" "ec2_key" {
  key_name   = "my_ec2_key"
  public_key = file("terra-key.pub")  
}

resource "aws_default_vpc" "default" {}

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

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP traffic"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "automated_ec2_sg"
  }
}

# Launch an EC2 instance
resource "aws_instance" "ec2_instance" {
  ami                    = var.aws_ami_id
  instance_type          = var.aws_instance_type
  key_name               = aws_key_pair.ec2_key.key_name
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  user_data = file("install_nginx.sh")

  root_block_device {
    volume_size = var.aws_root_volume_size
    volume_type = "gp3"
  }

  tags = {
    Name = "automated_ec2_instance"
  }
}