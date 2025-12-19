variable "aws_region" {
  type    = string
  default = "us-east-1"
}


# checkov:skip=CKV_AWS_145: "Ensure that S3 buckets are encrypted with KMS by default"
# checkov:skip=CKV2_AWS_62: "Ensure S3 buckets should have event notifications enabled"
# checkov:skip=CKV_AWS_18: "Ensure the S3 bucket has access logging enabled"
# checkov:skip=CKV_AWS_144: "Ensure that S3 bucket has cross-region replication enabled"
# checkov:skip=CKV_AWS_300: "Ensure S3 lifecycle configuration sets period for aborting failed uploads"


resource "aws_s3_bucket" "demo" {
  bucket = "cisco-raman-terraform-ci-demo-${random_id.suffix.hex}"

  tags = {
    Project = "Terraform-CI"
    Cloud   = "AWS"
  }
}


resource "random_id" "suffix" {
  byte_length = 4
}



resource "aws_s3_bucket_public_access_block" "demo" {
  bucket = aws_s3_bucket.demo.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}



resource "aws_s3_bucket_versioning" "demo" {
  bucket = aws_s3_bucket.demo.id

  versioning_configuration {
    status = "Enabled"
  }
}




resource "aws_s3_bucket_lifecycle_configuration" "demo" {
  bucket = aws_s3_bucket.demo.id

  rule {
    id     = "basic-lifecycle"
    status = "Enabled"

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    expiration {
      days = 365
    }
  }
}





