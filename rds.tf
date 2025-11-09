resource "aws_db_subnet_group" "paytm_db_subnet" {
  name       = "paytm-db-subnet"
  subnet_ids = [ aws_subnet.public_subnet_a.id, aws_subnet.public_subnet_b.id ]
}

resource "aws_db_instance" "paytm_rds" {
  identifier              = "paytm-db"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  db_name                 = "paytmdb"
  username                = "admin"
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.paytm_db_subnet.name
  vpc_security_group_ids  = [ aws_security_group.paytm_sg.id ]
  skip_final_snapshot     = true
  publicly_accessible     = true
  deletion_protection     = false
}
