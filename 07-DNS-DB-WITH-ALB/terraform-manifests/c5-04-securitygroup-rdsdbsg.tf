# Private Subnets Security Groups


module "rdsdb_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.2.0"

  name        = "rdsdb-sg"
  description = "Access to MySQL DB for entier VPC CIDR Block"
  vpc_id      = module.vpc.vpc_id



  # allow access to MYSQL from IPs that originate withing the VPC
  ingress_with_cidr_blocks = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "MySQL access from within VPC"
      cidr_blocks = module.vpc.vpc_cidr_block
    },
  ]


  # Egress Rules - all-all open
  egress_rules = ["all-all"]
  tags         = local.common_tags
}