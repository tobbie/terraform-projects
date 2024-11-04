# Terraform application load balancer

module "nlb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "9.11.1"

  name                             = "${local.name}-nlb"
  #name_prefix                      = "mynlb-"
  vpc_id                           = module.vpc.vpc_id
  dns_record_client_routing_policy = "availability_zone_affinity"
  subnets                          = module.vpc.public_subnets

  load_balancer_type = "network"
  security_groups    = [module.load_balancer_sg.security_group_id]
  tags               = local.common_tags

  enable_deletion_protection = false



  # Listeners
  listeners = {

    #Listener 1
    my-tcp = {
      port     = 80
      protocol = "TCP"
      forward = {
        target_group_key = "mytg1"
      }
    } # end of tcp listener

    my-tls = {
      port            = 443
      protocol        = "TLS"
      certificate_arn = var.phosware_domain_certificate_arn
      forward = {
        target_group_key = "mytg1"
      }
    } # end of tls listener

  } # End of Listeners Block



  # Target Groups

  target_groups = {
    mytg1 = {
      create_attachment                 = false
      name_prefix                       = "mytg1-"
      protocol                          = "TCP"
      port                              = 80
      target_type                       = "instance"
      deregistration_delay              = 10
                    

      

      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app1/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
      }


      #target_id        = aws_instance.this.id
      port = 80
      tags = local.common_tags

    } #end of target group 1







  } # end of target group collection

} # end of network load balancer block


