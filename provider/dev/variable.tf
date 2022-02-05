variable "state_bucket" {
  type = string
  description = "Name of the S3 bucket that handles the state file"
}
variable "dynamodb_table_name" {
  type = string
  description = "dynamodb table name that provides locking functionality"
}
variable "tags" {
  type        = map(any)
  description = "CISO Mandatory Tags"
}