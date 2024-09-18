provider "aws" {
     alias  = "ap-south-1"
     region = "ap-south-1"
}

resource "aws_instance" "launch" {
       ami           = "ami-0522ab6e1ddcc7055"
       instance_type = "t2.small"
       provider      = aws.ap-south-1
       tags = {
            Name     = "terraform"
      }
}
