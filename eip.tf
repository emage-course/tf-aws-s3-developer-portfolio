resource "aws_eip" "jenkins_eip" {
  instance = aws_instance.jenkins.id

  tags = {
    Name = "jenkins_eip"
  }
}