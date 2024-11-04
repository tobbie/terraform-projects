resource "aws_autoscaling_group" "my_asg" {
  name_prefix         = "myasg-"
  desired_capacity    = 2
  max_size            = 10
  min_size            = 2
  vpc_zone_identifier = module.vpc.private_subnets
  target_group_arns   = [module.nlb.target_groups["mytg1"].arn]
  health_check_type   = "EC2"

  launch_template {
    id      = aws_launch_template.my_launch_template.id
    version = aws_launch_template.my_launch_template.latest_version
  }

  #Instance Refresh 

  instance_refresh {
    strategy = "Rolling"
    preferences {
      # instance_warmup = 300  Default is to use the auto-scaling group health check value
      min_healthy_percentage = 50
    }

    triggers = ["desired_capacity"]
  }

  tag {
    key                 = "test"
    value               = "value"
    propagate_at_launch = true
  }

}