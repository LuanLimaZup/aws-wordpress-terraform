data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "wordpress_S3" {
  bucket = "wordpress-lab-upload-${data.aws_caller_identity.current.account_id}"

  tags = merge(
    local.tags, {
      Name = "wordpress-s3"
    }
  )
}

resource "aws_s3_bucket_versioning" "versioning_enable_wordpress_S3" {
  bucket = aws_s3_bucket.wordpress_S3.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "access_block_wordpress_S3" {
  bucket = aws_s3_bucket.wordpress_S3.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}