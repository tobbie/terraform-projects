module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.13.0"

  name = "vpc-dev"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  # Database Subnets
  database_subnets                   = ["10.0.151.0/24", "10.0.152.0/24"]
  create_database_subnet_group       = true
  create_database_subnet_route_table = true

  #create_database_nat_gateway_route = true   // you want your private db instace to have  route out to the internet
  #create_database_internet_gateway_route = true //  you want your  db instace in a public subnet to be accessibke from the internet

  # NAT Gateways for outbound communication - Single NAT Gateway configuration
   enable_nat_gateway = true
   single_nat_gateway = true
   one_nat_gateway_per_az = false
 
  # enable_vpn_gateway = true

  # VPC DNS Parameters
  enable_dns_hostnames = true
  enable_dns_support   = true

  public_subnet_tags = {
    Name = "public-subnets"
  }

  private_subnet_tags = {
    Name = "private-subnets"
  }

  database_subnet_tags = {
    Name = "database-subnets"
  }

  vpc_tags = {
    Name = "vpc-dev"
  }

  tags = {
    Owner       = "Oluwatobi"
    Terraform   = "true"
    Environment = "dev"
  }

  # vpc_tags = {} any property that has an = before {} is an argument 
  # terraform {} however this is a BLOCK - terraform block
}