### Use when executing on GitLab 
# resource "aws_key_pair" "ssh_key" {
#   key_name   = "ssh_key"
#   public_key = var.ssh_key_pair
# }

### Use when executing locally 

# resource "aws_key_pair" "ssh_key" {
#   key_name   = "jenkins-key"
#   public_key = file("~/.ssh/id_rsa.pub")
# }

# Use for Jenkins
# resource "aws_key_pair" "ssh_key" {
#   key_name   = "jenkins-key"
#   public_key = file("files/id_rsa.pub")
# }
