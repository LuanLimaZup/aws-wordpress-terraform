resource "aws_launch_template" "wordpress_launch_template" {
  name_prefix   = "wordpress-lt-"
  image_id      = var.image_id
  instance_type = var.instance_type

  user_data = base64encode(<<-EOF
#!/bin/bash

yum update -y

yum install -y \
  httpd \
  php \
  php-mysqlnd \
  wget \
  tar \
  amazon-efs-utils \
  nfs-utils

systemctl enable httpd
systemctl start httpd

mkdir -p /var/www/html

mount -t efs ${var.efs_id}:/ /var/www/html

echo "${var.efs_id}:/ /var/www/html efs defaults,_netdev 0 0" >> /etc/fstab

cd /tmp

wget https://wordpress.org/latest.tar.gz

tar -xzf latest.tar.gz

cp -r wordpress/* /var/www/html/

chown -R apache:apache /var/www/html

chmod -R 755 /var/www/html

systemctl restart httpd
EOF
  )

  vpc_security_group_ids = [var.ec2_security_group_id]

  iam_instance_profile {
    name = var.iam_instance_profile_name
  }

  monitoring {
    enabled = true
  }

  tag_specifications {
    resource_type = "instance"

    tags = merge(
      var.tags,
      {
        Name = "wordpress-ec2"
      }
    )
  }
}