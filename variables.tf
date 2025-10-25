variable "region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-2" # Ohio to match your setup
}

variable "env" {
  description = "Environment tag"
  type        = string
  default     = "dev"
}

variable "bucket_prefix" {
  description = "Prefix for the S3 bucket name (must be globally unique after suffix)"
  type        = string
  default     = "charlie-demo-bucket"
}
