
module "public_bastion_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.2.0"

  name        = "public-bastion-sg"
  description = "Security Group with SSH port open for everybody (IPv4) and egress port accepting all outbound traffic"
  vpc_id      = module.vpc.vpc_id

  #Ingress Rules
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["ssh-tcp"]


  # Egress Rules - all-all open
  egress_rules = ["all-all"]
  tags         = local.common_tags
}