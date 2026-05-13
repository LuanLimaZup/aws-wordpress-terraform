resource "aws_launch_template" "wordpress_launch_template" {
  name_prefix   = "wordpress-lt-"
  image_id      = "ami-0a59ec92177ec3fad"
  instance_type = "t3.micro"

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  monitoring {
    enabled = true
  }

  tag_specifications {
    resource_type = "instance"

    tags = merge(
      local.tags,
      {
        Name = "wordpress-ec2"
      }
    )
  }
}
