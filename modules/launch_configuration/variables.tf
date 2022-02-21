#Variables related to Launch Configuration
#
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
#
# Variables relate to Auto Scaling Group
#
#
variable "min_size" {
  default = "0"
  type        = string
  description = "The minimum size of the Auto Scaling Group."
}
variable "max_size" {
 default = "0"
  type        = string
  description = "The maximum size of the Auto Scaling Group."
}
variable "desired_capacity" {
#  default = ""
  type        = string
  description = "EC2 instances that should be running"
}
variable "health_check_type" {
  default = "ELB" #ELB, EC2
  type        = string
  description = "Define where Auto Scaling Group will rely on the health check to determine if an instance is healthy or not"
}
variable "target_group_arns" {
#  default = ""
  type        = string
  description = "Values of aws_alb_target_group ARNs"
}
variable "health_check_grace_period" {
  default = "300"
  type        = string
  description = "Time (in seconds) after instance comes into service before checking health"
}
variable "vpc_zone_identifier" {
 # default = "" # [module.aws_subnet.example1.id,module.aws_subnet.example2.id]
  type        = list
  description = "A list of subnet IDs to launch resources in"
}
#
#Common variables
#
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