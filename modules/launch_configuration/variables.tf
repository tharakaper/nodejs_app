variable "ami_prefix" {
  type        = string
  #default = "" #pcm-amzn2
  description = "Prefix of the Ami Name. This can be specially used private AMIs "
}
variable "environment" {
  type        = string
  default = "dev" #prod
  description = "Environment the application is provisioned"
}
variable "virtualization-type" {
  type        = string
  default = "hvm"   # "hvm", "paravirtual"
  description = "Type of the virtualization used"
}
variable "ami_owner" {
  type        = string
  #default = "" #309956199498
  description = "A unique id assigned to the owner of the AMI"
}
variable "ami_platform" {
  type        = string
  default = "Linux/UNIX" #"Linux/UNIX", "Red Hat Enterprise Linux", "Windows"
  description = "The platfom of the AMI"
}
variable "instance_type" {
  type        = string
  default = "t2.micro"
  description = "Type of the ec2 being created"
}
variable "user_data" {
  type        = string
#  default = ""
  description = "Bash file with user data script"
}
variable "iam_instance_profile" {
  type        = string
#  default = ""
  description = "The name attribute of the IAM instance profile to associate with launched instances"
}
variable "key_name" {
#  default = "appname.pem"
  type        = string
  description = "Name of the SSH key pair"
}
variable "associate_public_ip_address" {
  default = "false" #true, false
  type        = bool
  description = "Associate a public ip address with an instance in a VPC."
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