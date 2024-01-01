#!/bin/bash

### Instyall Jenkins 
sudo yum update –y
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade -y
sudo amazon-linux-extras install java-openjdk11 -y
sudo yum install java-11-amazon-corretto -y
sudo yum install git -y
sudo yum install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo cat /var/lib/jenkins/secrets/initialAdminPassword 

### Install cloudbees 
sudo wget -O /etc/yum.repos.d/cloudbees-core-oc.repo https://downloads.cloudbees.com/cloudbees-core/traditional/operations-center/rolling/rpm/cloudbees-core-oc.repo
sudo rpm --import "https://downloads.cloudbees.com/jenkins-operations-center/rolling/rpm/cloudbees.com.key"
sudo yum install cloudbees-core-oc -y 
# sudo yum httpd-core -y 
# sudo yum install httpd mod_ssl
systemctl daemon-reload
systemctl enable cloudbees-core-oc
systemctl start cloudbees-core-oc
systemctl status cloudbees-core-oc

sudo yum install -y yum-utils
# sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum install terraform -y 
sudo yum -y install terraform

### Install AWS CLI 
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

### Install Jq, Git  
sudo yum install -y jq 

### Install Ansible 
sudo amazon-linux-extras install epel -y
sudo yum --enablerepo epel install ansible -y

### Install Docker 
sudo yum -y install git docker 
sudo systemctl enable docker.service
sudo systemctl start docker.service
sudo systemctl status docker.service
sudo set enforce 0
sudo groupadd docker
sudo usermod -aG docker ec2-user
sudo usermod -aG docker jenkins 
sudo usermod -aG docker root
# docker pull centos:latest
docker images

sleep 20 

### Configure Jenkins User 
sudo echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
sudo usermod --shell /bin/bash jenkins 

sudo su - jenkins
ssh-keygen -t rsa -b 4096 -C "kendops2@gmail.com" -N '' <<<''

# # Use your email for Jenkins GitHub account
# sudo mkdir -p /var/lib/jenkins/.ssh/
# sudo chmod 777 -R /var/lib/jenkins/.ssh/
# # sudo -u jenkins ssh-keygen -t ed25519 -C "kendops2@gmail.com" -N '' <<<''
# sudo chmod -R u=rwx /var/lib/jenkins/.ssh/
# sudo chmod -R go=--- /var/lib/jenkins/.ssh/
# sudo chown -R jenkins:jenkins /var/lib/jenkins/.ssh/
# sudo chmod -R u=rw,go=r /var/lib/jenkins/.ssh/id_rsa.pub
# sudo chmod -R u=rw,go=-- /var/lib/jenkins/.ssh/id_rsa

### Instyall kubectl 
sudo curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo chmod +x kubectl
sudo mv kubectl /usr/local/bin/
kubectl version

### Install the Helm CLI
curl -sSL https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
helm completion bash >> ~/.bash_completion
. /etc/profile.d/bash_completion.sh
. ~/.bash_completion
source <(helm completion bash)
helm version --short

### kustomize installation:
wget https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv5.3.0/kustomize_v5.3.0_linux_amd64.tar.gz
sudo tar zxf kustomize_v5.3.0_linux_amd64.tar.gz 
sudo mv  kustomize /usr/local/bin
which kustomize
kustomize version

### Configure 
# sudo su - jenkins 
# mkdir ~/.kube
# sudo chown -R jenkins: ~jenkins/.kube/

### verify
sudo ls -lrt /var/lib/jenkins/.ssh/
sudo ls -lrtd /var/lib/jenkins/.ssh/
sudo grep jenkins /etc/passwd 
sudo grep jenkins /etc/sudoers
sudo cat /var/lib/jenkins/secrets/initialAdminPassword 
sudo cat /var/lib/cloudbees-core-oc/secrets/initialAdminPassword

### Configure Known Host
ssh-keyscan github.com >> ~/.ssh/known_hosts

### Display SSH Keys
sudo cat /var/lib/jenkins/.ssh/id_rsa
sudo cat /var/lib/jenkins/.ssh/id_rsa.pub 

# helm repo add cloudbees https://public-charts.artifacts.cloudbees.com/repository/public/
# helm repo update
# kubectl create namespace cloudbees-core
# helm install cloudbees-core cloudbees/cloudbees-core  --namespace cloudbees-core  --set OperationsCenter.HostName='cloudbees-kendopz.com'  --set OperationsCenter.Ingress.tls.Enable=true
# kubectl exec cjoc-0 -- cat /var/jenkins_home/secrets/initialAdminPassword
