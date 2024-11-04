# Define Autoscaling policies

# Target Tracking Scaling Policy - Based on Averge CPU Utilization
resource "aws_autoscaling_policy" "average_cpu_policy_greater_than_70_percent" {
  name                      = "average-cpu-policy-greater-than-70-percent"
  policy_type               = "TargetTrackingScaling"
  estimated_instance_warmup = 120
  autoscaling_group_name    = aws_autoscaling_group.my_asg.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 70.0
  }
}

# Target Tracking Scaling Policy - Based on Average CPU Utilization
/**
resource "aws_autoscaling_policy" "alb_target_requests_greater_than_50k" {
  name                   = "alb-target-requests-greater-than-50k"
  policy_type            = "TargetTrackingScaling"
  estimated_instance_warmup = 120
  autoscaling_group_name = "${aws_autoscaling_group.my_asg.name}"

        target_tracking_configuration {
            predefined_metric_specification {
                predefined_metric_type = "ALBRequestCountPerTarget"
                resource_label = "${module.alb.arn_suffix}"
            }

        target_value = 50000
    }
}
**/

