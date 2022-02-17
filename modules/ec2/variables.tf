variable "security_groups" {
  type        = list(any)
  description = "Associated Security Group IDs"
#  default = ""
}
variable "key_name" {
#  default = "appname.pem"
  type        = string
  description = "Name of the SSH key pair"
}
variable "instance_type" {
  default = "t2.micro"
  type        = string
  description = "Instance Type"
}
variable "iam_instance_profile" {
#  default = ""
   type        = string
  description = "IAM Role details assigned to the ec2 instances"
}
variable "subnet_id" {
#  default = ""
  type = list(any)
  description = "Associated Subnet for the EC2"
}
variable "associate_public_ip_address" {
#  default = "true"
  type        = bool
  description = "True or False value to Associated Public IP address to the EC2"
}
variable "ami_id" {
  default = ""
  type        = string
  description = "AMI name for the specific Availability Zone"
}
variable "instance_count" {
  default = "1"
  type        = string
  description = "Number of required EC2 count"
}
