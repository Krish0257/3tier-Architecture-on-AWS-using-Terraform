resource "aws_launch_template" "three_tier" {
  image_id      = var.ami_id
  instance_type = var.instance_type

  vpc_security_group_ids = [var.ec2_sg_id]

  user_data = base64encode(<<EOF
#!/bin/bash
set -eux

apt-get update -y
apt-get install -y docker.io

systemctl enable docker
systemctl start docker

sleep 15
docker run -d --restart unless-stopped -p 80:80 nginx
EOF
  )
}

resource "aws_autoscaling_group" "three_tier" {
  min_size         = 2
  max_size         = 4
  desired_capacity = 2

  vpc_zone_identifier = var.private_subnet_ids

  health_check_type         = "ELB"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.three_tier.id
    version = "$Latest"
  }

  target_group_arns = [var.target_group_arn]

  depends_on = [
    aws_launch_template.three_tier
  ]
}