# Terraform application load balancer

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "9.11.1"

  name    = "${local.name}-alb"
  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.public_subnets

  load_balancer_type = "application"
  security_groups = [module.load_balancer_sg.security_group_id]
  tags = local.common_tags

   enable_deletion_protection = false
  

  # Listeners
  listeners = {
    
    # Listner 1 - http
    http-listener = {
      port                        = 80
      protocol                    = "HTTP"
      forward = {
        target_group_key = "mytg1"
      }
   } # end of http-listener
  
  } # End of Listeners Block
   


  # Target Groups

    target_groups = {
      mytg1 = {
        create_attachment = false
        name_prefix                       = "mytg1-"
        protocol                          = "HTTP"
        port                              = 80
        target_type                       = "instance"
        deregistration_delay              = 10
        load_balancing_algorithm_type     = "weighted_random"
        load_balancing_anomaly_mitigation = "on"
        load_balancing_cross_zone_enabled = false
        protocol_version = "HTTP1"

      target_group_health = {
        dns_failover = {
          minimum_healthy_targets_count = 2
        }
        unhealthy_state_routing = {
          minimum_healthy_targets_percentage = 50
        }
      }

      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app1/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }

      
      #target_id        = aws_instance.this.id
      port             = 80
      tags = local.common_tags
   
    } #end of target group

    
  } # end of target group collection

} # end of load balancer block


# Load Balancer Target Group Attachements

resource "aws_lb_target_group_attachment" "mytg1" {
  for_each = {for k, v in module.ec2_private : k => v}  // creates a map of instanceid: instance details
  target_group_arn = module.alb.target_groups["mytg1"].arn
  target_id        = each.value.id
  port             = 80
}

# k = ec2-instance
# v = ec2-instance-details

# Temp App Outputs

output "temp_ec2_private" {
  value = {for ec2-instance, ec2-instance-details in module.ec2_private : ec2-instance => ec2-instance-details}
}