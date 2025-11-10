output "backend_ip" {
  value = aws_instance.backend.public_ip
}

output "frontend_ip" {
  value = aws_instance.frontend.public_ip
}

output "prometheus_public_ip" {
  value = aws_instance.prometheus.public_ip
}
output "grafana_public_ip" {
  value = aws_instance.grafana.public_ip
}
