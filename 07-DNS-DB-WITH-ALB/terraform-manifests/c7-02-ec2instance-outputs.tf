output "ec2_bastion_public_instance_id" {
  description = "Public IP address of EC2 instance"
  value       = module.public_bastion_server.id

}



output "ec2_bastion_public_ip" {
  description = "Public IP address of EC2 instance"
  value       = module.public_bastion_server.public_ip

}

#APP1 - Private EC2 Instances
## private instance ids
output "app1_ec2_private_instance_ids" {
  description = "Public IP address of EC2 instance"
  #value       = module.ec2_private.id
  value = [for instance in module.ec2_private_app1 : instance.id]

}

## private instance ip
output "app1_ec2_private_instance_ips" {
  description = "Public IP address of EC2 instance"
  value       = [for instance in module.ec2_private_app1 : instance.private_ip]

}

#APP2 - Private EC2 Instances
## private instance ids
output "app2_ec2_private_instance_ids" {
  description = "Public IP address of EC2 instance"
  #value       = module.ec2_private.id
  value = [for instance in module.ec2_private_app2 : instance.id]

}

## private instance ips
output "app2_ec2_private_instance_ips" {
  description = "Public IP address of EC2 instance"
  value       = [for instance in module.ec2_private_app2 : instance.private_ip]

}