#
#
#
#
#Create Terrafom State Remote Management System
#
#
#
#By Tharaka Perera on 5-Jan-2022
#
#
#
#
provider "aws" {
  region = "ap-southeast-2"
  profile = "177807608173/PCMPowerUser"
  #profile = "sandbox"
}
#Create S3 bucket to
resource "aws_s3_bucket" "terraform_state" {
  bucket = var.state_bucket
   # Enable versioning so we can see the full revision history of state files
 versioning {
    enabled = true
  }
  # Prevent the S3 bucket from accidental deletion
  lifecycle {
    prevent_destroy = true
  }
  # Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = var.tags
}
#
#
#
#Create DynamoDB for Locking with Terraform
#
#
#
resource "aws_dynamodb_table" "terraform_locks" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
   tags = var.tags
}