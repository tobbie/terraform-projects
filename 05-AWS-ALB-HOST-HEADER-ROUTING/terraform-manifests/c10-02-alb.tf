# Terraform application load balancer

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "9.11.1"

  name    = "${local.name}-alb"
  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.public_subnets

  load_balancer_type = "application"
  security_groups    = [module.load_balancer_sg.security_group_id]
  tags               = local.common_tags

  enable_deletion_protection = false


  # Listeners
  listeners = {

    #Listener 1
    http-https-redirect = {
      port     = 80
      protocol = "HTTP"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    } # end of http-https-redirect listner

    #Listener 2
    https-listener = {
      port            = 443
      protocol        = "HTTPS"
      ssl_policy      = "ELBSecurityPolicy-TLS13-1-2-Res-2021-06"
      certificate_arn = var.phosware_domain_certificate_arn
      #additional_certificate_arns = [module.wildcard_cert.acm_certificate_arn]

      fixed_response = {
        content_type = "text/plain"
        message_body = "Fixed static message for root context"
        status_code  = "200"
      }

      #Load balancer rules
      rules = {
        myapp1-rule = {
          priority = 4
          actions = [{
            type = "weighted-forward"
            target_groups = [
              {
                target_group_key = "mytg1"
                weight           = 1
              }

            ]
            stickiness = {
              enabled  = true
              duration = 3600
            }
          }]

          conditions = [{
            host_header = {
              values = [var.app1_dns_name]
            }
          }]
        } // end of myapp1-rule


        myapp2-rule = {
          priority = 5
          actions = [{
            type = "weighted-forward"
            target_groups = [
              {
                target_group_key = "mytg2"
                weight           = 1
              }

            ]
            stickiness = {
              enabled  = true
              duration = 3600
            }
          }]

          conditions = [{
            host_header = {
              values = [var.app2_dns_name]
            }
          }]
        } // end of myapp1-rule

      } //end of https rules section

    } # end of https listener



  } # End of Listeners Block



  # Target Groups

  target_groups = {
    mytg1 = {
      create_attachment                 = false
      name_prefix                       = "mytg1-"
      protocol                          = "HTTP"
      port                              = 80
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_algorithm_type     = "weighted_random"
      load_balancing_anomaly_mitigation = "on"
      load_balancing_cross_zone_enabled = false
      protocol_version                  = "HTTP1"

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
      port = 80
      tags = local.common_tags

    } #end of target group 1



    mytg2 = {
      create_attachment                 = false
      name_prefix                       = "mytg2-"
      protocol                          = "HTTP"
      port                              = 80
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_algorithm_type     = "weighted_random"
      load_balancing_anomaly_mitigation = "on"
      load_balancing_cross_zone_enabled = false
      protocol_version                  = "HTTP1"

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
        path                = "/app2/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }


      #target_id        = aws_instance.this.id
      port = 80
      tags = local.common_tags

    } #end of target group 2




  } # end of target group collection

} # end of load balancer block


# Load Balancer Target Group Attachements
# mytg1: LB Target Group Attachment

resource "aws_lb_target_group_attachment" "mytg1" {
  for_each         = { for k, v in module.ec2_private_app1 : k => v } // creates a map of instanceid: instance details
  target_group_arn = module.alb.target_groups["mytg1"].arn
  target_id        = each.value.id
  port             = 80
}



# Load Balancer Target Group Attachements
# mytg1: LB Target Group Attachment

resource "aws_lb_target_group_attachment" "mytg2" {
  for_each         = { for k, v in module.ec2_private_app2 : k => v } // creates a map of instanceid: instance details
  target_group_arn = module.alb.target_groups["mytg2"].arn
  target_id        = each.value.id
  port             = 80
}


# k = ec2-instance
# v = ec2-instance-details

# Temp App Outputs

/**
output "temp_ec2_private" {
  value = {for ec2-instance, ec2-instance-details in module.ec2_private : ec2-instance => ec2-instance-details}
}
**/