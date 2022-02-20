variable "tags" {
  type = map(any)
  /*  default = {
  "appid" = "SVC02107",
  "dcl"   = "3",
  "env"   = "TST"
  } */
  description = "CISO Mandatory Tags"
}
variable "enable_dns_support" {
  type = bool
#  default = "true"
  description = "True of False value provided to enable DNS Support"
}
variable "enable_dns_hostnames" {
  type = bool
#  default = "true"
  description = "True of False value provided to enable DNS hostnames"
}
variable "cidr_block" {
  type = string
#  default = "192.168.10.0/24"
  description = "Network block for the VPC""
}
variable "key_name" {
   type        = string
#  default = "application_name.pem"
   description = "Name of the SSH key pair"
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