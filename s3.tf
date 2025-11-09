resource "aws_s3_bucket" "paytm_bucket" {
  bucket        = "paytm-s3bucket"
  force_destroy = true
}
