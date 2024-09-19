provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "medusa_instance" {
  ami           = "ami-0e86e20dae9224db8"  
  instance_type = "t2.micro"
  key_name      = "hello"  

  tags = {
    Name = "Medusa"
  }

  # Security group
  vpc_security_group_ids = [aws_security_group.medusa_sg.id]

  # User data for initial setup
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y nodejs npm
              npm install -g @medusajs/medusa-cli
              EOF
}

resource "aws_security_group" "medusa_sg" {
  name        = "medusa_security_group"
  description = "Certain Rules"
  
  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Adjust this for tighter security
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # SSH access
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
