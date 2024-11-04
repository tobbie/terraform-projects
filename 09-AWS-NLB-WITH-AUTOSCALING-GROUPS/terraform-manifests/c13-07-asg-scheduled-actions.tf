# Autoscaling schedules

# Increase capacity during business hours
resource "aws_autoscaling_schedule" "increase_capacity_9am" {
  scheduled_action_name  = "increase-capacity-9am"
  min_size               = 2
  max_size               = 10
  desired_capacity       = 8
  start_time             = "2024-11-14T7:30:00Z" #this is time in UTC timezone, it needs to be supplied in utc timezone
  recurrence             = "0 9 * * *"
  autoscaling_group_name = aws_autoscaling_group.my_asg.name
}


# Decrease capacity during non-business hours

resource "aws_autoscaling_schedule" "decrease_capacity_9pm" {
  scheduled_action_name  = "decrease-capacity-9pm"
  min_size               = 2
  max_size               = 10
  desired_capacity       = 2
  start_time             = "2024-11-15T7:30:00Z" #this is time in UTC timezone, it needs to be supplied in utc timezone
  recurrence             = "0 9 * * *"
  autoscaling_group_name = aws_autoscaling_group.my_asg.name
}