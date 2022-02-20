
data "aws_ami" "ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["${var.ami_prefix}-${var.environment}-*"]
  }

  filter {
    name   = "virtualization-type"
    values = [var.virtualization-type]
  }

  owners = ["${var.ami_owner}"]
}
filter {
    name   = "Platform"
    values = [var.ami_platform]
  }


resource "aws_launch_configuration" "launch_config" {
  image_id      = data.aws_ami.ami.id
  instance_type = var.instance_type
  iam_instance_profile = var.iam_instance_profile
  user_data = var.user_data
  key_name = var.key_name
  associate_public_ip_address = var.associate_public_ip_address

  lifecycle {
    create_before_destroy = true
  }

    tags = merge(
          var.tags,
          {
            Name = "lc-${var.environment}-${var.application_name}"
          },
  )
}

resource "aws_autoscaling_group" "asg" {

  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type
  desired_capacity          = var.desired_capacity
  launch_configuration      = aws_launch_configuration.launch_config.name
  vpc_zone_identifier       = [aws_subnet.example1.id, aws_subnet.example2.id]

  lifecycle {
    create_before_destroy = true
  }

      tags = merge(
          var.tags,
          {
            Name = "asg-${var.environment}-${var.application_name}"
          },
  )
}