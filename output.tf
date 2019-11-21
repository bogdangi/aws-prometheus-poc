output "prometheus-server-endpoint" {
   value = "http://${aws_instance.prometheus-server.public_ip}:9090"
}
