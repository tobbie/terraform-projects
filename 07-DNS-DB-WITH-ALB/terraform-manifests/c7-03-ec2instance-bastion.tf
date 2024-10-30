# Bastion Host

module "public_bastion_server" {
  depends_on = [module.vpc]
  source     = "terraform-aws-modules/ec2-instance/aws"
  version    = "5.7.1"

  name = "${var.environment}-bastion-host"

  ami = data.aws_ami.amzlinux2.id

  instance_type = var.instance_type
  key_name      = var.instance_keypair
  #monitoring             = true
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.public_bastion_sg.security_group_id]
  user_data              = file("${path.module}/jump-box-install.sh")

  tags = local.common_tags
}