variable "bucket_name" {
  type        = string
#  default = "xxxxx"
  description = "Name of the S3 Bucket"
}
variable "s3_version_status" {
  type = string
#  default = "Enabled or Suspended"
  description = "The versioning state of the bucket"
}
variable "tags" {
  type = map(any)
  /*  default = {
  "appid" = "SVC02107",
  "dcl"   = "3",
  "env"   = "TST"
  } */
  description = "CISO Mandatory Tags"
}
variable "environment" {
  type        = string
  default = "dev" #dev, prod [all simple]
  description = "Environment the application is provisioned. This will be used to pick the ami"
}
variable "application_name" {
  type        = string
#  default = "Sub-srv"
  description = "Short Name of the application"
}