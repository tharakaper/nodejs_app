#
#
#
##Created by Tharaka on 14-Feb-2022
#
#
#
#
#
#
#
data "aws_availability_zones" "az" {}
#
#
#
#Create the VPC
#
#
#
resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support = var.enable_dns_support

  tags = merge(
          var.tags,
          {
            Name = "vpc-${var.environment}-${var.application_name}"
          },
  )
}
#
#
#This section will cover the Subnet creation
#
#First create Public Subnet
#
#
#
#
resource "aws_subnet" "public_subnet" {
  count = length(data.aws_availability_zones.az.names)
  vpc_id = aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.cidr_block, 3, count.index)
  availability_zone = data.aws_availability_zones.az.names[count.index]
  map_public_ip_on_launch = true

  tags = merge(
          var.tags,
          {
            Name = "pub-subnet-${var.environment}-${var.application_name}-${count.index+1}"
          },
  )
}
#
#
#
#
#Second create Private Subnet
#
#
#
#
resource "aws_subnet" "private_subnet" {
  count                   = length(data.aws_availability_zones.az.names)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, 3, count.index + 3)
  availability_zone       = data.aws_availability_zones.az.names[count.index]
  map_public_ip_on_launch = false

  tags = merge(
          var.tags,
          {
            Name = "pub-subnet-${var.environment}-${var.application_name}-${count.index+1}"
          },
  )
}
#
#
##This section will cover the Internet Gateway creation to communicate with the hosts created in public subnets
#
#First create Internet Gateway
#
#
#
#
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id


  tags = merge(
          var.tags,
          {
            Name = "internet-gateway-${var.environment}-${var.application_name}"
          },
  )
}
#
#
#
#
#Second create Public Route Table
#
#
#
#
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = merge(
          var.tags,
          {
            Name = "public-route-table-${var.environment}-${var.application_name}"
          },
  )
}
#
#
#
#
#Third Associate Route Table to Public Subnets
#
#
#
#
resource "aws_route_table_association" "public_route_table_association" {
  count = length(aws_subnet.public_subnet)
  subnet_id = aws_subnet.public_subnet.*.id[count.index]
  route_table_id = aws_route_table.public_route_table.id
}
#
#
#
#
#This section will cover the NAT Gateway creation to communicate with the hosts created in private subnets
#
#First an EIP to assign to the NAT Gateway
#
#
resource "aws_eip" "eip_nat_gateway" {
  vpc = true

  tags = merge(
          var.tags,
          {
            Name = "eip_nat-gateway-${var.environment}-${var.application_name}"
          },
  )
}
#
#
#
#
#Second Create Nat Gateway
#
#
#
#
resource "aws_nat_gateway" "nat_gateway"{
  allocation_id = aws_eip.eip_nat_gateway.id
  subnet_id = element(aws_subnet.private_subnet.*.id, 1)

  tags = merge(
          var.tags,
          {
            Name = "nat-gateway-${var.environment}-${var.application_name}"
          },
  )
}
#
#
#
#
#Third create private route table for the Nat Gateway
#
#
#
#
resource "aws_default_route_table" "private_route_table" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway.id
  }

   tags = merge(
          var.tags,
          {
            Name = "private-route-table-${var.environment}-${var.application_name}"
          },
  )
}
#
#
#
#
#Fourth Associate Route Table to Private Subnets
#
#
#
#
resource "aws_route_table_association" "private_route_table_association" {
  count = length(aws_subnet.private_subnet)
  subnet_id = aws_subnet.private_subnet.*.id[count.index]
  route_table_id = aws_default_route_table.private_route_table.id
  depends_on = [aws_default_route_table.private_route_table, aws_subnet.private_subnet]
}
#
#
#
#
#This section will cover the AWS Key-pair to connect to the ec2 instances
#
#
#
#
#First generates a secure private key and encodes it as PEM
#
#
#
#
resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
#
#
#
#Second  generate SSH keys on the fly
#
#
#
#
resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.private_key.public_key_openssh
}
#
#
#
#
#Thrid generates a local file with the given content
#
#
#
#
#
resource "local_file" "private_key"{
  content = tls_private_key.private_key.private_key_pem
  filename = "${var.key_name}.pem"
  file_permission = "0600"
}
#
#
#
