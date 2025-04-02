provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "public_write_bucket" {
  bucket = "my-public-write-bucket-123456" # replace with a unique name
}

resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.public_write_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "public_write_policy" {
  bucket = aws_s3_bucket.public_write_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicWrite"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:PutObject"
        Resource  = "${aws_s3_bucket.public_write_bucket.arn}/*"
      }
    ]
  })
}
