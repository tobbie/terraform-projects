# Autoscaling Notifications
## AWS Bug for SNS Topic ----
##Due to the bug above we have to create SNS Topics with unique names

## SNS - Topic
resource "aws_sns_topic" "my_sns_topic" {
  name = "myasg-sns-topic-${random_pet.this.id}"
}

## SNS - Subscription
resource "aws_sns_topic_subscription" "myasg_sns_topic_subscription" {
  topic_arn = aws_sns_topic.my_sns_topic.arn
  protocol  = "email"
  endpoint  = "tobi.akinseye@gmail.com"
}

## Create Autoscaling Notification Resource

resource "aws_autoscaling_notification" "myasg_notifications" {
  group_names = [
    aws_autoscaling_group.my_asg.name
  ]

  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]

  topic_arn = aws_sns_topic.my_sns_topic.arn
}