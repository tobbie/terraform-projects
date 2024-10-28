# Create Elastic IP for Bastion Host
# Resource - depend_on Meta-Argument

resource "aws_eip" "bastion_eip" {
  depends_on = [module.public_bastion_server, module.vpc]
  instance   = module.public_bastion_server.id
  domain     = "vpc"

  tags = local.common_tags


  // Works in a resource block

  /**
  provisioner "local-exec" {
    command     = "echo Infra destroy time is `date` >> destroy-time-prov.txt"
    working_dir = "local-output-files/"
    #on_failure = continue
    when = destroy
  }
  
**/
}