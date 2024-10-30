# create DNS Record in Route 53

resource "aws_route53_record" "default_dns" {
  zone_id = data.aws_route53_zone.phoswaredomain.zone_id
  name    = "dns-to-db.phoswarecomputing.com"
  type    = "A"
  #ttl     = 300 not required for alias records
  alias {
    name                   = module.alb.dns_name
    zone_id                = module.alb.zone_id
    evaluate_target_health = true
  }
}



