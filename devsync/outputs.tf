output "aws_region" {
  description = "AWS region used for this deployment."
  value       = var.aws_region
}

output "vpc_id" {
  description = "ID of the DevSync VPC."
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "ID of the public subnet."
  value       = aws_subnet.public.id
}

output "jenkins_instance_id" {
  description = "EC2 instance ID of the Jenkins server."
  value       = aws_instance.jenkins.id
}

output "jenkins_public_ip" {
  description = "Public IP address of the Jenkins server."
  value       = aws_instance.jenkins.public_ip
}

output "jenkins_url" {
  description = "Jenkins web interface URL. Jenkins must be installed separately."
  value       = "http://${aws_instance.jenkins.public_ip}:8080"
}

output "app_instance_id" {
  description = "EC2 instance ID of the application server."
  value       = aws_instance.app.id
}

output "app_public_ip" {
  description = "Public IP address of the application server."
  value       = aws_instance.app.public_ip
}

output "app_url" {
  description = "HTTP URL for the application host. Deploy the application and configure its web server separately."
  value       = "http://${aws_instance.app.public_ip}"
}
