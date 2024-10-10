# resource "null_resource" "initialAdminPassword" {
#   depends_on = [

#     # Running of the playbook depends on the successfull creation of the EC2
#     aws_route53_record.emagetech
#   ]

#   provisioner "remote-exec" {
#     inline = [
#       "sudo cp /var/lib/jenkins/secrets/initialAdminPassword .",
#       "sudo chmod 777 initialAdminPassword"
#     ]
#   }

#   provisioner "local-exec" {
#     command = "scp -o StrictHostKeyChecking=no ec2-user@jenkins.emagetech.co:~/initialAdminPassword ."
#     # command = "ssh -q -o StrictHostKeyChecking=no ec2-user@jenkins.emagetech.co 'sudo cat /var/lib/jenkins/secrets/initialAdminPassword'"

#   }
# }

resource "null_resource" "jenkins-status" {
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("~/.ssh/id_rsa")
      host        = aws_eip.jenkins_eip.public_ip
    }

    inline = [
      "sudo systemctl status jenkins",
      "df -Ph"
    ]
  }

  depends_on = [
    aws_route53_record.emagetech
  ]
}

resource "null_resource" "copy-plugins" {
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/.ssh/id_rsa")
    host        = aws_eip.jenkins_eip.public_ip
  }

  # File provisioner with source and destination
  provisioner "file" {
    source      = "files/install_plugins.sh"
    destination = "/tmp/install_plugins.sh"
  }

  provisioner "file" {
    source      = "files/install_cloudwatch_agent.sh"
    destination = "/tmp/install_cloudwatch_agent.sh"
  }

  provisioner "file" {
    source      = "files/install_cloudwatch_agent.sh"
    destination = "/tmp/install_cloudwatch_agent.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/install_plugins.sh",
      "/tmp/install_plugins.sh"
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/install_cloudwatch_agent.sh",
      "/tmp/install_cloudwatch_agent.sh"
    ]
  }

  depends_on = [
    aws_route53_record.emagetech
  ]
}


# /home/ec2-user/