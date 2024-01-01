resource "aws_eip" "jenkins_eip" {
  instance = aws_instance.ec2_instance.id

  tags = {
    Name = "jenkins_eip"
  }
}