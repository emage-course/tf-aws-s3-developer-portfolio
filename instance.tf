# launch the ec2 instance and install website
resource "aws_instance" "jenkins" {
  #ami                    = data.aws_ami.amzlinux2.id
  ami                    = "ami-0c6d2bc35c65a2a45"
  instance_type          = var.instance_type
  subnet_id              = aws_default_subnet.default_az1.id
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  key_name               = aws_key_pair.jenkins-key.key_name
  user_data              = file("files/install_jenkins.sh")


  # root disk
  root_block_device {
    volume_size           = "30"
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }

  tags = {
    Name = "jenkins.emagetech.co"
  }
}

resource "null_resource" "initialAdminPassword" {
  depends_on = [

    # Running of the playbook depends on the successfull creation of the EC2
    # instance and the local inventory file.

    aws_route53_record.emagetech
  ]

  provisioner "local-exec" {
    command = "ssh -q -o StrictHostKeyChecking=no ec2-user@jenkins.emagetech.co 'sudo cat /var/lib/jenkins/secrets/initialAdminPassword'"
  }
}

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


