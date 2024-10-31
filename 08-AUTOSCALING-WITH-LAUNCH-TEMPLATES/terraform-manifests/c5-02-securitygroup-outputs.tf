# Security Group Outputs

# Public Bastion Security Group Outputs
output "public_bastion_sg_id" {
  description = "The ID of the security group"
  value       = module.public_bastion_sg.security_group_id
}

output "public_bastion_sg_vpc_id" {
  description = "The VPC ID"
  value       = module.public_bastion_sg.security_group_vpc_id
}


output "public_bastion_sg_name" {
  description = "The name of the security group"
  value       = module.public_bastion_sg.security_group_name
}



# Private  Security Group Outputs
output "private_sg_id" {
  description = "The ID of the security group"
  value       = module.private_sg.security_group_id
}

output "private_sg_vpc_id" {
  description = "The VPC ID"
  value       = module.private_sg.security_group_vpc_id
}


output "private_sg_name" {
  description = "The name of the security group"
  value       = module.private_sg.security_group_name
}

