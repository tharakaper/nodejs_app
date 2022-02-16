#
#
#
##Created by Tharaka on 16-Feb-2022
#
#
#
#Create the S3 Bucket
#
#
#
resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name


  tags = var.tags
}
#
#
#Controlling versioning on an S3 bucket
#
#
#
resource "aws_s3_bucket_versioning" "s3_versioning" {
  bucket = aws_s3_bucket.s3_bucket.id
  versioning_configuration {
    status = var.s3_version_status
  }
}
#
#
#Controlling S3 bucket lifecycle configuration.
#
#

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_bucket_encryption" {
  bucket = aws_s3_bucket.s3_bucket.id

  rule {
    apply_server_side_encryption_by_default {
            sse_algorithm     = "AES256"
    }
  }

  tags = var.tags
}
