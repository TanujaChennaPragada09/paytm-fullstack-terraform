# Backend EC2
resource "aws_instance" "backend" {
  ami                         = "ami-0ecb62995f68bb549"  # Ubuntu
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public_subnet_a.id
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.paytm_sg.id]
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  associate_public_ip_address = true

 

  # Tags
  tags = {
    Name = "paytm-backend"
  }
}


resource "aws_instance" "frontend" {
  ami                    = "ami-0ecb62995f68bb549"  # Ubuntu
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public_subnet_b.id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.paytm_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  associate_public_ip_address = true

 

  tags = {
    Name = "Paytm-Frontend"
  }
}

