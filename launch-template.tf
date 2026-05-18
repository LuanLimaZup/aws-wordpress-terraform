resource "aws_launch_template" "wordpress_launch_template" {
  name_prefix   = "wordpress-lt-"
  image_id      = "ami-0a59ec92177ec3fad"
  instance_type = "t3.micro"

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

mount -t efs ${aws_efs_file_system.wordpress_efs.id}:/ /var/www/html

echo "${aws_efs_file_system.wordpress_efs.id}:/ /var/www/html efs defaults,_netdev 0 0" >> /etc/fstab

cd /tmp

wget https://wordpress.org/latest.tar.gz

tar -xzf latest.tar.gz

cp -r wordpress/* /var/www/html/

chown -R apache:apache /var/www/html

chmod -R 755 /var/www/html

systemctl restart httpd
EOF
  )

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