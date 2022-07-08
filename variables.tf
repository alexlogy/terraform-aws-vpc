locals {
  projecttag                = "SG"

  # SG VPC
  sg_vpc_cidr               = "10.29.0.0/16"
  sg_private_subnet_cidr_1a = "10.29.0.0/20"
  sg_private_subnet_cidr_1b = "10.29.16.0/20"
  sg_private_subnet_cidr_1c = "10.29.32.0/20"
  sg_public_subnet_cidr_1a = "10.29.112.0/20"
  sg_public_subnet_cidr_1b = "10.29.128.0/20"
  sg_public_subnet_cidr_1c = "10.29.144.0/20"
}