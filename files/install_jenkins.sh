#!/bin/bash

### Instyall Jenkins 
sudo yum update –y
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade -y
sudo amazon-linux-extras install java-openjdk11 -y
sudo dnf install java-11-amazon-corretto -y
sudo yum install git -y
sudo yum install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo cat /var/lib/jenkins/secrets/initialAdminPassword 

### Install cloudbees 
sudo wget -O /etc/yum.repos.d/cloudbees-core-oc.repo https://downloads.cloudbees.com/cloudbees-core/traditional/operations-center/rolling/rpm/cloudbees-core-oc.repo
sudo rpm --import "https://downloads.cloudbees.com/jenkins-operations-center/rolling/rpm/cloudbees.com.key"
sudo yum install cloudbees-core-oc -y 
sudo yum httpd-core -y 
sudo yum install httpd mod_ssl
systemctl daemon-reload
systemctl cloudbees-core-oc start
systemctl enable cloudbees-core-oc
systemctl status cloudbees-core-oc

sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum install terraform -y 

### Install AWS CLI 

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

### Install Jq, Git  
sudo yum install -y jq git 

### Install Docker 
sudo yum -y install git docker 
sudo systemctl enable docker.service
sudo systemctl start docker.service
sudo systemctl status docker.service
sudo set enforce 0
sudo groupadd docker
sudo usermod -aG docker ec2-user
sudo usermod -aG docker root
docker pull centos:latest
docker images

sleep 5s 

### Configure Jenkins User 

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


# helm repo add cloudbees https://public-charts.artifacts.cloudbees.com/repository/public/
# helm repo update
# kubectl create namespace cloudbees-core
# helm install cloudbees-core cloudbees/cloudbees-core  --namespace cloudbees-core  --set OperationsCenter.HostName='cloudbees-kendopz.com'  --set OperationsCenter.Ingress.tls.Enable=true
# kubectl exec cjoc-0 -- cat /var/jenkins_home/secrets/initialAdminPassword
