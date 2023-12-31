# output "public_ip" {
#   value       = formatlist("%s: %s", aws_instance.ec2_instance.*.public_dns, aws_instance.ec2_instance.*.public_ip)
#   description = "Public IP Address of EC2 instance"
# }

output "instance_id" {
  value       = aws_instance.ec2_instance.*.id
  description = "Instance ID"
}

output "ssh_connection" {
  value       = "ssh ec2-user@${aws_eip.jenkins_eip.public_ip}"
  description = "Connect via SSH"
}

# output "web_connection" {
#   value       = "http://${aws_instance.ec2_instance.public_ip}:8080"
#   description = "Connect via SSH"
# }

# print the url of the jenkins server
# output "jenkins_url" {
#   value = join("", ["http://", aws_instance.ec2_instance.public_dns, ":", "8080"])
# }

output "jenkins_url" {
  description = "The public IP address of the Jenkins server"
  value       = join("", ["http://", aws_eip.jenkins_eip.public_ip, ":", "8080"])
}

####################################################

### Optional 
### For CloudFlare only 

####################################################

output "record" {
  value       = join("", ["http://", cloudflare_record.devopx.hostname, ":", "8080"])
}

output "metadata" {
  value     = cloudflare_record.devopx.metadata
  sensitive = true
}