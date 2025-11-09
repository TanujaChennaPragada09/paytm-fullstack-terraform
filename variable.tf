# -----------------------------
# EC2 Key Pair
# -----------------------------
variable "key_name" {
  description = "EC2 Key Pair Name (must exist in AWS)"
  type        = string
  default     = "paytm"   # Your AWS Key Pair name
}

# -----------------------------
# EC2 Instance Type
# -----------------------------
variable "instance_type" {
  description = "EC2 instance type for backend and frontend"
  type        = string
  default     = "t3.micro"
}

# -----------------------------
# RDS Database Password
# -----------------------------
variable "db_password" {
  description = "RDS Database Password"
  type        = string
  default     = "admin123"
}
