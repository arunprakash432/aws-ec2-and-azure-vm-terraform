#output for Azure Virtual Machine
output "public_ip" {
  value = azurerm_public_ip.public_ip.ip_address
}

#output for AWS Ec2 instance
output "ec2_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.this.public_ip
}
