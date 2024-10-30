# create DNS Record in Route 53

resource "aws_route53_record" "default_dns" {
  zone_id = data.aws_route53_zone.phoswaredomain.zone_id
  name    = "apps.phoswarecomputing.com"
  type    = "A"
  #ttl     = 300 not required for alias records
  alias {
    name                   = module.alb.dns_name
    zone_id                = module.alb.zone_id
    evaluate_target_health = true
  }
}

## APP1 DNS
resource "aws_route53_record" "app1_dns" {
  zone_id = data.aws_route53_zone.phoswaredomain.zone_id
  name    = "app1.phoswarecomputing.com"
  type    = "A"
  #ttl     = 300 not required for alias records
  alias {
    name                   = module.alb.dns_name
    zone_id                = module.alb.zone_id
    evaluate_target_health = true
  }
}


# APP2 DNS
resource "aws_route53_record" "app2_dns" {
  zone_id = data.aws_route53_zone.phoswaredomain.zone_id
  name    = "app2.phoswarecomputing.com"
  type    = "A"
  #ttl     = 300 not required for alias records
  alias {
    name                   = module.alb.dns_name
    zone_id                = module.alb.zone_id
    evaluate_target_health = true
  }
}