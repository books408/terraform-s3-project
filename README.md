Terraform AWS S3 Bucket Project

 Overview
This project provisions a secure, production-ready AWS S3 bucket using Terraform.  
It demonstrates Infrastructure-as-Code (IaC) principles for automating cloud resources and implementing AWS best practices.

 Features
- Versioning Enabled – keeps a history of object changes.
- Server-Side Encryption (SSE-S3) – automatically encrypts all objects at rest.
- Public Access Blocked – prevents accidental data exposure.
- Lifecycle Rules – automatically expires old object versions and incomplete uploads.
- Tagging – applies consistent metadata for organization and cost tracking.

 Tools & Technologies
- Terraform v1.13+
- AWS Provider v5+
- AWS S3
- AWS CLI (for authentication and verification)

 Usage

Clone this repository
  bash
git clone https://github.com/books408/terraform-s3-project.git
cd terraform-s3-project
