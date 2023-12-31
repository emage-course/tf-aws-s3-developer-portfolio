#!/bin/bash

sudo echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
sudo chsh --shell /bin/bash jenkins 
sudo grep jenkins /etc/passwd 

# use your email for Jenkins GitHub account
sudo mkdir -p /var/lib/jenkins/.ssh/
sudo chmod 777 -R /var/lib/jenkins/.ssh/
sudo -u jenkins ssh-keygen -t ed25519 -C "kendops2@gmail.com" -N '' <<<''
sudo chmod -R u=rwx /var/lib/jenkins/.ssh/
sudo chmod -R go=--- /var/lib/jenkins/.ssh/
sudo chown -R jenkins:jenkins /var/lib/jenkins/.ssh/
sudo chmod -R u=rw,go=r /var/lib/jenkins/.ssh/id_ed25519.pub
sudo chmod -R u=rw,go=-- /var/lib/jenkins/.ssh/id_ed25519
ls -lrt /var/lib/jenkins/.ssh/
ls -lrtd /var/lib/jenkins/.ssh/

# - The private key is stored in the file /var/lib/jenkins/.ssh/id_ed25519.
# - The public key is stored in the file /var/lib/jenkins/.ssh/id_ed25519.pub.
