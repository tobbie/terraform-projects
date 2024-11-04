# Launch Template Outputs
## launch_template_id

output "launch_template_id" {
  description = "Launch Template Id"
  value       = aws_launch_template.my_launch_template.id
}


output "launch_template_version" {
  description = "Launch Template Version"
  value       = aws_launch_template.my_launch_template.latest_version
}

#Autoscaling outputs
## autoscaling_group_id

output "autoscaling_group_id" {
  description = "Autoscaling group id"
  value       = aws_autoscaling_group.my_asg.id
}

## autoscaling_group_name

output "autoscaling_group_name" {
  description = "Autoscaling group name"
  value       = aws_autoscaling_group.my_asg.name
}
## autoscaling_group_arn

output "autoscaling_group_arn" {
  description = "Autoscaling group arn"
  value       = aws_autoscaling_group.my_asg.arn
}