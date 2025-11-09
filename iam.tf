resource "aws_iam_role" "ec2_s3_role" {
  name = "paytm-ec2-s3-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{ Effect = "Allow", Principal = { Service = "ec2.amazonaws.com" }, Action = "sts:AssumeRole" }]
  })
}

resource "aws_iam_role_policy" "ec2_s3_policy" {
  name   = "paytm-ec2-s3-policy"
  role   = aws_iam_role.ec2_s3_role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{ Effect = "Allow", Action = ["s3:*"], Resource = [aws_s3_bucket.paytm_bucket.arn, "${aws_s3_bucket.paytm_bucket.arn}/*"] }]
  })
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "paytm-ec2-profile"
  role = aws_iam_role.ec2_s3_role.name
}
