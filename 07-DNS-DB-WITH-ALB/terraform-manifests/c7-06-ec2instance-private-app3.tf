# Private Instances
# EC2 instances that will be created in private subnets

module "ec2_private_app3" {
  depends_on = [module.vpc]
  source     = "terraform-aws-modules/ec2-instance/aws"
  version    = "5.7.1"

  name = "${var.environment}-app3"

  ami = data.aws_ami.amzlinux2.id

  instance_type = var.instance_type
  key_name      = var.instance_keypair
  #monitoring             = true

  vpc_security_group_ids = [module.private_sg.security_group_id]
  user_data = templatefile("app3-ums-install.tmpl",
    { rds_db_endpoint = module.rdsdb.db_instance_address
      rds_db_name     = var.db_name
      rds_db_username = var.db_username
      rds_db_password = var.db_password
  })

  for_each  = toset(["0", "1"])
  subnet_id = element(module.vpc.private_subnets, tonumber(each.key))

  tags = local.common_tags
}