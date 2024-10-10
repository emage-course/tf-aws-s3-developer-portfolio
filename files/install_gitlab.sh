#!/bin/bash

sudo yum update -y 
sudo yum install -y curl policycoreutils openssh-server openssh-clients
curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | sudo bash
sudo yum install -y gitlab-ce

### Configure Sudoer
echo "gitlab-runner ALL=(ALL:ALL) ALL" >> /etc/sudoers
echo "gitlab-runner ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# sudo gitlab-ctl reconfigure


### Install Gitlab Runner
curl -L "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.rpm.sh" | sudo bash
sudo yum install gitlab-runner -y 
sudo gitlab-runner status
sudo gitlab-runner start
sudo gitlab-runner stop
sudo gitlab-runner restart

