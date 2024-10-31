# WIP

data "aws_route53_zone" "phoswaredomain" {
  name = "phoswarecomputing.com"
}

#Output my hosted-zone if from domain name data source

output "phoswaredomain_zoneid" {
  description = "value"
  value       = data.aws_route53_zone.phoswaredomain.zone_id

}