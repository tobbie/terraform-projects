# Private Subnets Security Groups

module "private_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.2.0"

  name        = "private-sg"
  description = "Security Group with HTTP & SSH port open for entire VPC Block"
  vpc_id      = module.vpc.vpc_id

  #Ingress Rules
  #ingress_cidr_blocks = [module.vpc.vpc_cidr_block] # this is not valid for NLB
  ingress_cidr_blocks = ["0.0.0.0/0"] #required by NLB : configuration for private instances integrated to NLB
  ingress_rules       = ["ssh-tcp", "http-80-tcp", "http-8080-tcp"]


  # Egress Rules - all-all open
  egress_rules = ["all-all"]
  tags         = local.common_tags
}