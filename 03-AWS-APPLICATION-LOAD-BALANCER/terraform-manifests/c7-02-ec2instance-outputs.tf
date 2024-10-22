output "ec2_bastion_public_instance_id" {
  description = "Public IP address of EC2 instance"
  value       = module.public_bastion_server.id

}



output "ec2_bastion_public_ip" {
  description = "Public IP address of EC2 instance"
  value       = module.public_bastion_server.public_ip

}

output "ec2_private_instance_ids" {
  description = "Public IP address of EC2 instance"
  #value       = module.ec2_private.id
  value = [for ec2private in module.ec2_private : ec2private.id]

}

output "ec2_private_instance_ips" {
  description = "Public IP address of EC2 instance"
  value       = [for ec2private in module.ec2_private : ec2private.private_ip]

}