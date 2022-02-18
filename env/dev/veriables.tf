variable ports {
  type = map
  default = {
    "https" = 443
    "app1" = "8001"
    "open" = "0"
  }
}
variable ingress {
  type    = map
  default = {
    "https" = {
      from     = var.ports["https"]
      to       = var.ports["https"]
      protocol = "tcp"
      cidr     = [module.vpc.vpc_id]
    }
    "app1" = {
      from     = var.ports["app1"]
      to       = var.ports["app1"]
      protocol = "tcp"
      cidr     = [module.vpc.vpc_id]
    }
  }
  }
variable security_groups {
    default = [
      {
        description   = "first sg"
        #name          = "sg1"
        egress_rules  = []
        ingress_rules = [var.ingress["https"], var.ingress["app1"]]
      },
      {
        description   = "egress sg"
        #name          = "sg2"
        ingress_rules = []
        egress_rules  = [
          {
            from     = var.ports["open"]
            to       = var.ports["open"]
            protocol = "-1"
            cidr     = ["0.0.0.0/0"]
          }
        ]
      }
    ]
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