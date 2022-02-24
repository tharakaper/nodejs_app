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
variable "tags" {
  type = map(any)
  /*  default = {
  "appid" = "SVC02107",
  "dcl"   = "3",
  "env"   = "TST"
  } */
  description = "CISO Mandatory Tags"
}
variable "internal" {
  type = "string"
  default = "false" # true, false
  description = "If true, the LB will be internal."
}
variable "load_balancer_type" {
  type = "string"
  default = "application" #application, gateway, network
  description = "The type of load balancer to create."
}
variable "security_groups" {
  type = "list"
 # default = ""
  description = "A list of security group IDs to assign to the LB"
}
variable "subnets" {
  type = "list"
#  default = ""
  description = "A list of subnet IDs to attach to the LB"
}
variable "bucket_name" {
  type = "string"
#  default = ""
  description = ") The S3 bucket name to store the logs in"
}
variable "dir_name" {
  type = "string"
#  default = ""
  description = "The S3 bucket prefix. Logs are stored in the root if not configured."
}
variable "log_enable" {
  type = "string"
  default = "false" #true, false
  description = "enable / disable access_logs"
}
