output "public_ip" {
  value       = formatlist("%s: %s", aws_instance.ec2_instance.*.public_dns, aws_instance.ec2_instance.*.public_ip)
  description = "Public IP Address of EC2 instance"
}

output "instance_id" {
  value       = aws_instance.ec2_instance.*.id
  description = "Instance ID"
}

output "ssh_connection" {
  value       = "ssh ec2-user@${aws_instance.ec2_instance.public_ip}"
  description = "Connect via SSH"
}

output "web_connection" {
  value       = "http://${aws_instance.ec2_instance.public_ip}:8080"
  description = "Connect via SSH"
}

# print the url of the jenkins server
output "website_url" {
  value = join("", ["http://", aws_instance.ec2_instance.public_dns, ":", "8080"])
}