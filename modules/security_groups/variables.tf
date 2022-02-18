variable vpc_id {
  type = string
  description = "VPC ID that the security group will be created"
}

variable description {
  type = string
  description = "Description of the Security Group"
}
variable ingress_rules {
  type = list( object({
    from = number
    to = number
    protocol = string
    cidr = list(string)
  }))
}
variable egress_rules {
  type = list( object({
    from = number
    to = number
    protocol = string
    cidr = list(string)
  }))
}
variable "environment" {
  type        = string
#  default = "Subscription_service"
  description = "Environment the application is provisioned"
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