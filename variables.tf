variable "aws_instance_type" {
  description = "Type of the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "aws_ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0f918f7e67a3323f0"
}

variable "aws_root_volume_size" {
  description = "Size of the root volume in GB"
  type        = number
  default     = 20
}