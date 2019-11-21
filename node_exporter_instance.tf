resource "aws_instance" "node-exporter" {
  count = 2
  ami = "${var.node-exporter-image-id}"
  instance_type = "t2.nano"
  security_groups = ["${aws_security_group.allow-node-exporter.name}"]
  tags = {
    Name = "node-exporter"
    Prometheus = "enabled"
  }
}

resource "aws_security_group" "allow-node-exporter" {
  name        = "allow-node-exporter"
  description = "Allow node-exporter inbound traffic"

  ingress {
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["${aws_instance.prometheus-server.private_ip}/32"]
  }
}

