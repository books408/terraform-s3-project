terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# —— Provider ——
provider "aws" {
  region = var.region
}

# —— Random suffix to ensure global uniqueness for S3 bucket names ——
resource "random_id" "suffix" {
  byte_length = 4
}

# —— S3 bucket ——
resource "aws_s3_bucket" "this" {
  bucket = "${var.bucket_prefix}-${random_id.suffix.hex}"

  tags = {
    Project     = "s3-tf-project"
    Environment = var.env
    Owner       = "books"
  }
}

# —— Block ALL public access (belt + suspenders) ——
resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# —— Default encryption (SSE-S3) ——
resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# —— Versioning ——
resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = "Enabled"
  }
}

# —— Lifecycle: expire old versions after 30 days & clean incomplete uploads ——
resource "aws_s3_bucket_lifecycle_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    id     = "expire-old-object-versions"
    status = "Enabled"

    noncurrent_version_expiration {
      noncurrent_days = 30
    }

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}

# —— Useful outputs ——
output "bucket_name" {
  value       = aws_s3_bucket.this.bucket
  description = "The name of the created S3 bucket"
}

output "bucket_arn" {
  value       = aws_s3_bucket.this.arn
  description = "The ARN of the created S3 bucket"
}
