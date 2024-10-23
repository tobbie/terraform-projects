module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.13.0"

  name = "${local.name}-${var.vpc_name}"
  cidr = var.vpc_cidr_block

  azs             = var.vpc_availability_zones
  private_subnets = var.vpc_public_subnets
  public_subnets  = var.vpc_private_subnets

  # Database Subnets
  database_subnets                   = var.vpc_database_subnets
  create_database_subnet_group       = var.vpc_create_database_subnet_group
  create_database_subnet_route_table = var.vpc_create_database_subnet_route_table

  #create_database_nat_gateway_route = true   // you want your private db instace to have  route out to the internet
  #create_database_internet_gateway_route = true //  you want your  db instace in a public subnet to be accessibke from the internet

  # NAT Gateways for outbound communication - Single NAT Gateway configuration
  enable_nat_gateway     = var.vpc_enable_nat_gateway
  single_nat_gateway     = var.vpc_single_nat_gateway
  one_nat_gateway_per_az = var.vpc_one_nat_gateway_per_az

  # enable_vpn_gateway = true

  # VPC DNS Parameters
  enable_dns_hostnames = true
  enable_dns_support   = true

  public_subnet_tags = {
    Type = "Public Subnets"
  }

  private_subnet_tags = {
    Type = "Private Subnets"
  }

  database_subnet_tags = {
    Type = "Private Database Subnets"
  }

  vpc_tags = local.common_tags

  tags = local.common_tags

  # vpc_tags = {} any property that has an = before {} is an argument 
  # terraform {} however this is a BLOCK - terraform block
}