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


