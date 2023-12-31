#!/bin/bash


### Configure Jenkins User 

sudo echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
sudo usermod --shell /bin/bash jenkins 

# use your email for Jenkins GitHub account
sudo mkdir -p /var/lib/jenkins/.ssh/
sudo chmod 777 -R /var/lib/jenkins/.ssh/
sudo -u jenkins ssh-keygen -t ed25519 -C "kendops2@gmail.com" -N '' <<<''
sudo chmod -R u=rwx /var/lib/jenkins/.ssh/
sudo chmod -R go=--- /var/lib/jenkins/.ssh/
sudo chown -R jenkins:jenkins /var/lib/jenkins/.ssh/
sudo chmod -R u=rw,go=r /var/lib/jenkins/.ssh/id_ed25519.pub
sudo chmod -R u=rw,go=-- /var/lib/jenkins/.ssh/id_ed25519

sudo ls -lrt /var/lib/jenkins/.ssh/
sudo ls -lrtd /var/lib/jenkins/.ssh/
sudo grep jenkins /etc/passwd 
sudo grep jenkins /etc/sudoers
sudo cat /var/lib/jenkins/secrets/initialAdminPassword 

# - The private key is stored in the file /var/lib/jenkins/.ssh/id_ed25519.
# - The public key is stored in the file /var/lib/jenkins/.ssh/id_ed25519.pub.
