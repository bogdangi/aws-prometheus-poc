resource "aws_instance" "prometheus-server" {
  ami = "${var.prometheus-server-image-id}"
  instance_type = "t2.nano"
  iam_instance_profile = "${aws_iam_instance_profile.discover-instances.name}"
  security_groups = ["default", "${aws_security_group.allow-prometheus.name}"]
  tags = {
    Name = "prometheus-sertver"
  }
}


resource "aws_security_group" "allow-prometheus" {
  name        = "allow-prometheus"
  description = "Allow Promenteus inbound traffic"

  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = "${var.whitelist-ips}"
  }
}

resource "aws_iam_instance_profile" "discover-instances" {
  name = "discover-instances"
  role = "${aws_iam_role.discover-instances.name}"
}


resource "aws_iam_role" "discover-instances" {
  name = "discover-instances"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "discover-instances" {
  name = "test_policy"
  role = "${aws_iam_role.discover-instances.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
