# Launch Template resource

resource "aws_launch_template" "my_launch_template" {
  name = "my-launch-template"
  description = "my-launch-template"
  image_id = data.aws_ami.amzlinux2.id

  instance_type = var.instance_type
  vpc_security_group_ids = [module.private_sg.security_group_id]
  key_name = var.instance_keypair
  user_data =  filebase64("${path.module}/app1-install.sh")
  ebs_optimized = true

  update_default_version = true 
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
        volume_size = 10
        delete_on_termination = true
        volume_type = "gp2"
    }
  }

  monitoring {
    enabled = true
  }
  
  tag_specifications {
     resource_type = "instance"
     tags ={
        Name = "ASG-Launch-Template"
     }
  }

  #tags = local.common_tags
}