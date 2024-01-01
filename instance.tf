# launch the ec2 instance and install website
resource "aws_instance" "jenkins" {
  ami                    = data.aws_ami.amzlinux2.id
  instance_type          = var.instance_type
  subnet_id              = aws_default_subnet.default_az1.id
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  key_name               = aws_key_pair.ssh_key.key_name
  user_data              = file("files/install_jenkins.sh")
  tags = {
    Name = "jenkins-server"
  }
}

# # an empty resource block
resource "null_resource" "name" {
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/.ssh/id_rsa")
    host        = aws_eip.jenkins_eip.public_ip
    # host        = aws_instance.ec2_instance.public_ip
  }

  # Deploy manifest 
  provisioner "remote-exec" {
    inline = [
      "sudo df -hP",
      "sudo ps -ef | grep jenkins",
    ]
  }
  depends_on = [aws_instance.jenkins]

}

### Copy sshkey remotely for swilliams 
# provisioner "local-exec" {
#   command = "ssh-copy-id -i ~/.ssh/id_rsa.pub swilliams@${cloudflare_record.devopx.hostname}"
#command = "ssh-copy-id -i  var.ssh_key_pair swilliams@${cloudflare_record.devopx.hostname}"
# }

#   # copy the install_jenkins.sh file from your computer to the ec2 instance 
#   provisioner "file" {
#     source      = "files/install_jenkins.sh"
#     destination = "/tmp/install_jenkins.sh"
#   }

#   # set permissions and run the install_jenkins.sh file
#   provisioner "remote-exec" {
#     inline = [
#       "sudo chmod +x /tmp/install_jenkins.sh",
#       "sh /tmp/install_jenkins.sh",
#     ]
#   }

#   # wait for ec2 to be created
#   depends_on = [aws_instance.jenkins]
# }

